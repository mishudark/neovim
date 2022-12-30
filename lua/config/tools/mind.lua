require'mind'.setup {
  persistence = {
    state_path = '~/mind/mind.json',
    data_dir = '~/mind/data',
  },

  ui = {
    width = 40,

    highlight = {
      node_root = 'Number',
    }
  },

  keymaps = {
    normal = {
      T = function(args)
        require'mind.ui'.with_cursor(function(line)
          local tree = args.get_tree()
          local node = require'mind.node'.get_node_by_line(tree, line)

          if node.icon == nil or node.icon == ' ' then
            node.icon = ' '
          elseif node.icon == ' ' then
            node.icon = ' '
          end

          args.save_tree()
          require'mind.ui'.rerender(tree, args.opts)
        end)
      end,
    }
  }
}

local keybindings = {
 n = {
   {
     key = ',mc',
     lua = function()
       require'mind'.wrap_smart_project_tree_fn(function(args)
         require'mind.commands'.create_node_index(
           args.get_tree(),
           require'mind.node'.MoveDir.INSIDE_END,
           args.save_tree,
           args.opts
         )
       end)
     end
   },
   {
     key = ',Mc',
     lua = function()
       require'mind'.wrap_main_tree_fn(function(args)
         require'mind.commands'.create_node_index(
           args.get_tree(),
           require'mind.node'.MoveDir.INSIDE_END,
           args.save_tree,
           args.opts
         )
       end)
     end
   },
   {
     key = ',mi',
     lua = function()
       vim.notify('initializing project tree')
       require'mind'.wrap_smart_project_tree_fn(function(args)
         local tree = args.get_tree()
         local mind_node = require'mind.node'

         local _,tasks = mind_node.get_node_by_path(tree, '/Tasks', true)
         tasks.icon = '陼'

         local _, backlog = mind_node.get_node_by_path(tree, '/Tasks/Backlog', true)
         backlog.icon = ' '

         local _, on_going = mind_node.get_node_by_path(tree, '/Tasks/On-going', true)
         on_going.icon = ' '

         local _, done = mind_node.get_node_by_path(tree, '/Tasks/Done', true)
         done.icon = ' '

         local _, cancelled = mind_node.get_node_by_path(tree, '/Tasks/Cancelled', true)
         cancelled.icon = ' '

         local _, notes = mind_node.get_node_by_path(tree, '/Notes', true)
         notes.icon = ' '

         args.save_tree()
       end)
     end
   },
   {
     key = ',ml',
     lua = function()
       require'mind'.wrap_smart_project_tree_fn(function(args)
         require'mind.commands'.copy_node_link_index(args.get_tree(), nil, args.opts)
       end)
     end
   },
   {
     key = ',Ml',
     lua = function()
       require'mind'.wrap_main_tree_fn(function(args)
         require'mind.commands'.copy_node_link_index(args.get_tree(), nil, args.opts)
       end)
     end
   },
   {
     key = ',j',
     lua = function()
       require'mind'.wrap_main_tree_fn(function(args)
         local tree = args.get_tree()
         local path = vim.fn.strftime('/Journal/%Y/%b/%d')
         local _, node = require'mind.node'.get_node_by_path(tree, path, true)

         if node == nil then
           vim.notify('cannot open journal 🙁', vim.log.levels.WARN)
           return
         end

         require'mind.commands'.open_data(tree, node, args.data_dir, args.save_tree, args.opts)
         args.save_tree()
       end)
     end
   },
   {
     key = ',Mm',
     cmd = 'MindOpenMain',
   },
   {
     key = ',mm',
     cmd = 'MindOpenSmartProject',
   },
   {
     key = ',ms',
     lua = function()
       require'mind'.wrap_smart_project_tree_fn(function(args)
         require'mind.commands'.open_data_index(args.get_tree(), args.data_dir, args.save_tree, args.opts)
       end)
     end
   },
   {
     key = ',Ms',
     lua = function()
       require'mind'.wrap_main_tree_fn(function(args)
         require'mind.commands'.open_data_index(args.get_tree(), args.data_dir, args.save_tree, args.opts)
       end)
     end
   },
 }
}

for mode, bindings in pairs(keybindings) do
  for _, binding in ipairs(bindings) do
    local lhs = binding.key
    local rhs

    if binding.cmd ~= nil then
      rhs = '<cmd>' .. binding.cmd .. '<cr>'
    elseif binding.lua ~= nil then
      local t = type(binding.lua)
      if t == 'string' then
        rhs = ':lua ' .. binding.lua .. '<cr>'
      elseif t == 'function' then
        rhs = binding.lua
      end
    end

    vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true })
    -- vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true, noremap = true })
  end
end
