# Generated by running
# julia --color=yes generate_buildjl.jl C/CompilerSupportLibraries/build_tarballs.jl JuliaBinaryWrappers/CompilerSupportLibraries_jll.jl CompilerSupportLibraries-v0.3.3+0
# in the root the the source tree of https://github.com/JuliaPackaging/Yggdrasil/
# by first replacing the `include` by its content, see https://github.com/JuliaPackaging/Yggdrasil/issues/858
# and commenting out `build_info = autobuild(...)`, `tarball_path, ...` and replace `sources = ...` by `sources = nothing`.
using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libgcc_s", "libgcc_s_sjlj", "libgcc_s_seh"], :libgcc_s),
    LibraryProduct(prefix, ["libstdc++"], :libstdcxx),
    LibraryProduct(prefix, ["libgfortran"], :libgfortran),
    LibraryProduct(prefix, ["libgomp"], :libgomp),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaBinaryWrappers/CompilerSupportLibraries_jll.jl/releases/download/CompilerSupportLibraries-v0.3.3+0"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.aarch64-linux-gnu-libgfortran3.tar.gz", "17132bd0c2f2c6d8426a601b57de2c4e670da64076ab7ab0f311dc3c39ed421c"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.aarch64-linux-gnu-libgfortran4.tar.gz", "c6fa95bb0873c23084bfb7e154ef546b21488777e2d352e5acf38d8e9800c14d"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.aarch64-linux-gnu-libgfortran5.tar.gz", "a3b98e7b24c580f5120ac2344d19c4884c93b17271fb296fa0b97fc562de7f2d"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.aarch64-linux-musl-libgfortran3.tar.gz", "ee0b1e57302709cf159573ec23017fec797af6b0dae7dbd2ea0904e67b4e0343"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.aarch64-linux-musl-libgfortran4.tar.gz", "b5fb9e89ed28eb3aa31397a165e583d6e860e54e24bd9af7474670335e2b2d57"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.aarch64-linux-musl-libgfortran5.tar.gz", "85cd3c8ad611c8949f7cd0fd01444650358144f576e69fa20d58e9f29f781695"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.armv7l-linux-gnueabihf-libgfortran3.tar.gz", "6964b730d3764a82252fe6144d0e9103d0d9a409027c44de224afc8f05782733"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.armv7l-linux-gnueabihf-libgfortran4.tar.gz", "6b76ac45d465413bf6bc6b45cda8f1f528ce212979d94887b80d9b975e116696"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.armv7l-linux-gnueabihf-libgfortran5.tar.gz", "e5c9854d8191f2fabe81ef1fb7974ce4c4e9261c790ec21e225fbdc57ccf3bf0"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.armv7l-linux-musleabihf-libgfortran3.tar.gz", "ead80d5f2f8ed45598fd8331da07dc3e430e42b8129d982e1209c6dc392c4595"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.armv7l-linux-musleabihf-libgfortran4.tar.gz", "713f7de6f6b79869c4818b861d9877d008ef0f9bc287a88fb6c80c5757a5f80d"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.armv7l-linux-musleabihf-libgfortran5.tar.gz", "7fcd1b6a46cf1bb89602b3ad64dc546c251ca628197a9ab3d23d2ef460f39709"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-linux-gnu-libgfortran3.tar.gz", "39f8673f0fb61a1d2c9bb3e847a0e7275bf56ad3a9f41e2c85063c1d9c4c9d5e"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-linux-gnu-libgfortran4.tar.gz", "aafe4c28b74eb3fe57e861a814bec3bf7d5d0d1ec252f558a34fd95ea3fedac8"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-linux-gnu-libgfortran5.tar.gz", "55abe3b785c179e86430616ad6309c0bde47d32517f468f064c5c69a1b506e74"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-linux-musl-libgfortran3.tar.gz", "2846df4b60cbabfc86b990c87bec8d7e58431c4ad1b250036993a899fdb29172"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-linux-musl-libgfortran4.tar.gz", "73ba40c10b825b0a5abc4fd6bd1edd9d270ff4dd37c652a6380e38da5aeab864"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-linux-musl-libgfortran5.tar.gz", "80f8df63b1137a061b30a11bc2b0a985fbde56c665601bb30ff7762e3fbace72"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-w64-mingw32-libgfortran3.tar.gz", "e53493d881c2a36d697e6abbeaeec8181488868e479bf06ea7db959d9a016763"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-w64-mingw32-libgfortran4.tar.gz", "58c25e695e7dace12db66d19575914922183a8083c353b691e16b1bf86ab9a3a"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.i686-w64-mingw32-libgfortran5.tar.gz", "c9bc14ed49945c57353fffa7d7e374fbb146218bc0345d43bbbf8182f142ca77"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.powerpc64le-linux-gnu-libgfortran3.tar.gz", "c2a29d7f514acca1f9a8f0b723098d1340f3002ab689010546afcb0f9fa5d315"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.powerpc64le-linux-gnu-libgfortran4.tar.gz", "facbe1ae766e774c9ca2782dcb5dc6544b1c025ec1cc091bae15b3f57e6b5513"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.powerpc64le-linux-gnu-libgfortran5.tar.gz", "c11ab7865a3812446c2f1b32c78d89e3af2ddd31c9c32b472706e8f20368d6ed"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-apple-darwin14-libgfortran3.tar.gz", "2739fe9184b065bf32cd1246ee12c1fd6507a9932a921dbf1bf268a3819164a0"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-apple-darwin14-libgfortran4.tar.gz", "cb2825f0eae2cf4e5b6bc7075f3ee70afb8a31711fd5220bfd85827b87625a43"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-apple-darwin14-libgfortran5.tar.gz", "e308cbb8e0b2b50635f98cf700b24743a2eb9d5c7726a99375ef31e096371642"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-linux-gnu-libgfortran3.tar.gz", "9d0223f3562e0b609595904ecab0fd55650f068da367353a38146394d8329f69"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-linux-gnu-libgfortran4.tar.gz", "adcc8519411cf0518c472d3ce47d8ac93492934a05c0276afe76eda6d91c4f4d"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-linux-gnu-libgfortran5.tar.gz", "23771ec6d2fa014db480b5cfe8e1b6f34b2d29e8bbea8cdce1edd5f1e15cb6e0"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-linux-musl-libgfortran3.tar.gz", "a04abda3002d81567e415d17b6d72c010ef6e202d47e6d8bac32c034321ddd48"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-linux-musl-libgfortran4.tar.gz", "b6911e4ece0432d74c24d47d12000179fb00912e587ddae08e0ab1b7eda4bcf5"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-linux-musl-libgfortran5.tar.gz", "269279af71f2b64c30162cfb0d2168d518fa913aade7564fa28c8928497b3e64"),
    FreeBSD(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-unknown-freebsd11.1-libgfortran3.tar.gz", "aeda35832c30df2d24f06cd061b21f573b1167c76ff57f3f20f1b5dfbe249adc"),
    FreeBSD(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-unknown-freebsd11.1-libgfortran4.tar.gz", "3476688c80d8032685c57ced39a810447fc3da1b3f3275fe3af37509ccc1252e"),
    FreeBSD(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-unknown-freebsd11.1-libgfortran5.tar.gz", "19a779b6e539b0050432684d952342b18c28587b0c27a399cb0a00da2773c381"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-w64-mingw32-libgfortran3.tar.gz", "bec6c38ec12b26b1fd3c99944af81e463a29daf52152b53f49ca15fbf633b528"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-w64-mingw32-libgfortran4.tar.gz", "aec25acb618447247e3ad5ee9aec88725cd26d7abb9b6c29ac45e7aea601331e"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/CompilerSupportLibraries.v0.3.3.x86_64-w64-mingw32-libgfortran5.tar.gz", "69957fdd4eb5d6cfd1073c3b63b63a3ff3e2db909b4f4834b102d8a96944f66c"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
dl_info = choose_download(download_info, platform_key_abi())
if dl_info === nothing && unsatisfied
    # If we don't have a compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
end

# If we have a download, and we are unsatisfied (or the version we're
# trying to install is not itself installed) then load it up!
if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
    # Download and install binaries
    install(dl_info...; prefix=prefix, force=true, verbose=verbose)
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)