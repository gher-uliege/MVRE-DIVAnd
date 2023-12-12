push!(LOAD_PATH,"../src/")
using Documenter

makedocs(;
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/gher-uliege/MVRE-DIVAnd/blob/{commit}{path}#L{line}",
    sitename="MVRE DIVAnd documentation",
    authors="Charles Troupin <ctroupin@uliege.be>",
    checkdocs=:none,
)

deploydocs(;
    repo="github.com/gher-uliege/MVRE-DIVAnd",
)