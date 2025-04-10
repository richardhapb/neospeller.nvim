local M = {}

local status = {
   full_text = nil,
   text = nil,
   offset = 0,
   buffer = nil
}
--- Gets text from the selection or buffer
--- @param range? table
--- @param buffer? number
local function get_text(range, buffer)
   if buffer and vim.api.nvim_buf_is_valid(buffer) then
      status.buffer = buffer
   else
      status.buffer = vim.api.nvim_get_current_buf()
   end

   -- Verify if there is a selection; if so, use it; otherwise, use the whole buffer
   if range and range.count > 1 then
      status.full_text = vim.api.nvim_buf_get_lines(status.buffer, range.line1 - 1, range.line2, false)
      status.text = table.concat(status.full_text, "\n")
      status.offset = range.line1 - 1
   else
      status.full_text = vim.api.nvim_buf_get_lines(status.buffer, 0, -1, false)
      status.text = table.concat(status.full_text, "\n")
   end
end

--- Checks the values of the global status
--- @return boolean
local function check_status()
   for _, value in ipairs(status) do
      if not value then
         return false
      end
   end
   return true
end

---Handle the user command
---@param range table
---@param lang? string
local function check_spell(range, lang)
   get_text(range)

   if not check_status() then
      return
   end

   if vim.fn.executable("neospeller") == 0 then
      vim.print("neospeller is not installed")
      return
   end

   if not lang then
      lang = vim.api.nvim_get_option_value('filetype', { buf = status.buffer })
   end

   local command = { "neospeller", "--lang", lang }

   local job = vim.fn.jobstart(command, {
      stdout_buffered = true,
      on_stdout = function(_, data)
         vim.api.nvim_buf_set_lines(status.buffer, status.offset, #data + status.offset, false, data)
      end,
   })

   vim.fn.chansend(job, status.text)
   vim.fn.chanclose(job, "stdin")
end

M.setup = function()
   vim.api.nvim_create_user_command('CheckSpell', function(range)
      check_spell(range)
   end, {
      range = 1,
   })

   vim.api.nvim_create_user_command('CheckSpellText', function(range)
      check_spell(range, "text")
   end, {
      range = 1,
   })
end

return M
