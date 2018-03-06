-- inline=false
local cfgl =
        { indent='' -- like parentindent
        , prefixindent="" -- use indent
        , prefix="{\n"
        , suffixindent=nil -- use indent
        , suffix="}\n"
        , itemindent='\\t ' -- use indent
        , itemprefix=""
        , itemsuffix=",\n"
        , itemfirstprefix=""
        , itemlastsuffix='\n'
        }
-- inline=true
local cfgi =
        { indent='' -- like parentindent
        , prefixindent='' -- use indent
        , prefix="{"
        , suffixindent="" -- use indent
        , suffix="}"
        , itemindent='' -- use indent
        , itemprefix=""
        , itemsuffix=", "
        , itemfirstprefix=" "
        , itemlastsuffix=' '
        }

local function gen(x, cfg)
        return (cfg.prefixindent or cfg.indent or "")..(cfg.prefix or "")..
        (cfg.indent or "")..(cfg.itemindent or "")..(cfg.itemfirstprefix or cfg.itemprefix or "")..
        (table.concat(
                x,
                (cfg.itemsuffix or "")..(cfg.indent or "")..(cfg.itemindent or "")..(cfg.itemprefix or "")
        ))..(cfg.itemlastsuffix or cfg.itemsuffix or "")..
        (cfg.suffixindent or cfg.indent or "")..(cfg.suffix or "")
end

print("return "..gen({
        gen({"a1", "b1", "c1"}, cfgi),
        gen({"a2", "b2", "c2"}, cfgi),
        gen({"a3", "b3", "c3"}, cfgi),
        }, cfgl))

--[[
return {
\t { a1, b1, c1 },
\t { a2, b2, c2 },
\t { a3, b3, c3 }
}
]]--