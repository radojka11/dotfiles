return {
        "L3MON4D3/LuaSnip",
        config = function()
            local ls = require("luasnip")
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

            ls.config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
                ext_opt = {
                    [require("luasnip.util.types").choiceNode] = {
                        active = {
                            virt_text = { { "●", "GruvboxOrange" } },
                        }
                    }
                }

            })
        end,
} -- just an engine that we can create snippets with. Nothing to do with cmp
-- TODO: configure lua snippets, no cmp
