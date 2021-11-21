package("gnu-rm")

    set_kind("toolchain")
    set_homepage("https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm")
    set_description("GNU Arm Embedded Toolchain")

    if is_host("windows") then
        set_urls("https://developer.arm.com/-/media/Files/downloads/gnu-rm/$(version)-win32.zip", {version = function (version)
            return version .. "/gcc-arm-none-eabi-" .. version
        end})
        add_versions("10.3-2021.10", "d287439b3090843f3f4e29c7c41f81d958a5323aecefcf705c203bfd8ae3f2e7")
    elseif is_host("linux") then
        if os.arch() == "arm64" then
            set_urls("https://developer.arm.com/-/media/Files/downloads/gnu-rm/$(version)-aarch64-linux.tar.bz2", {version = function (version)
                return version .. "/gcc-arm-none-eabi-" .. version
            end})
            add_versions("10.3-2021.10", "f605b5f23ca898e9b8b665be208510a54a6e9fdd0fa5bfc9592002f6e7431208")
        else
            set_urls("https://developer.arm.com/-/media/Files/downloads/gnu-rm/$(version)-x86_64-linux.tar.bz2", {version = function (version)
                return version .. "/gcc-arm-none-eabi-" .. version
            end})
            add_versions("10.3-2021.10", "97dbb4f019ad1650b732faffcc881689cedc14e2b7ee863d390e0a41ef16c9a3")
        end
    elseif is_host("macosx") then
        set_urls("https://developer.arm.com/-/media/Files/downloads/gnu-rm/$(version)-mac.tar.bz2", {version = function (version)
            return version .. "/gcc-arm-none-eabi-" .. version
        end})
        add_versions("10.3-2021.10", "fb613dacb25149f140f73fe9ff6c380bb43328e6bf813473986e9127e2bc283b")
    end

    on_install("@windows", "@linux", "@macosx", function (package)
        os.vcp("*", package:installdir())
    end)

    on_test(function (package)
        local gcc = "arm-none-eabi-gcc"
        if gcc and is_host("windows") then
            gcc = gcc .. ".exe"
        end
        os.vrunv(gcc, {"--version"})
    end)