local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

-- Bullet Journal styled dates in the future
local function gen_date_snippets()
  local snippets = {}
  local target_dates = {
    "today",
    "tomorrow",
    "next monday",
    "next tuesday",
    "next wednesday",
    "next thursday",
    "next friday",
    "next week",
    "next month",
  }
  for _, target_date in pairs(target_dates) do
    table.insert(
      snippets,
      s("bj_" .. target_date:gsub(" ", "_"), {
        t "# ",
        f(function(args, snip, user_arg_1)
          return vim.fn.trim(vim.fn.system([[date -d ']] .. target_date .. [[' +'%F %a']]))
        end, {}),
      })
    )
  end

  return snippets
end

return gen_date_snippets()
