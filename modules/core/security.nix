{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    physlock = {
      enable = true;
      allowAnyUser = true;
    };
    tor = {
      enable = true;
      client.enable = true;
      torsocks.enable = true;
    };
    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        # server_names = [ ... ];
      };
    };
  };
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      librewolf = {
        executable = "${pkgs.librewolf-wayland}/bin/librewolf";
        profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
        extraArgs = [
          "--env=LD_PRELOAD='/usr/lib/libhardened_malloc.so'"
        ];
      };
      keepassxc = {
        executable = "${pkgs.keepassxc}/bin/keepassxc";
        profile = "${pkgs.firejail}/etc/firejail/keepassxc.profile";
      };
      zathura = {
        executable = "${pkgs.zathura}/bin/zathura";
        profile = "${pkgs.firejail}/etc/firejail/zathura.profile";
      };
      tor = {
        executable = "${pkgs.tor}/bin/tor";
        profile = "${pkgs.firejail}/etc/firejail/tor.profile";
      };
    };
  };
  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    polkit.enable = true;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
      services = {
        login.enableGnomeKeyring = true;
        swaylock = {
          text = ''
            auth include login
          '';
        };
      };
    };

    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          persist = true;
          keepEnv = false;
        }
        {
          groups = ["power"];
          noPass = true;
          cmd = "${pkgs.systemd}/bin/poweroff";
        }
        {
          groups = ["power"];
          noPass = true;
          cmd = "${pkgs.systemd}/bin/reboot";
        }
        {
          groups = ["nix"];
          cmd = "nix-collect-garbage";
          noPass = true;
        }
        {
          groups = ["nix"];
          cmd = "nixos-rebuild";
          keepEnv = true;
        }
      ];
    };
    sudo.enable = false;
  };

  boot.kernel.sysctl = {
    "kernel.yama.ptrace_scope" = 2;
    "kernel.kptr_restrict" = 2;
    "kernel.sysrq" = 0;
    "net.core.bpf_jit_enable" = false;
    "kernel.ftrace_enabled" = false;
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.log_martians" = true;
    "net.ipv4.conf.default.rp_filter" = "1";
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv6.conf.default.accept_ra" = 0;
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };
  boot.kernelParams = [
    # enables calls to ACPI methods through /proc/acpi/call
    "acpi_call"

    # https://en.wikipedia.org/wiki/Kernel_page-table_isolation
    # auto means kernel will automatically decide the pti state
    "pti=auto" # on | off

    # make stack-based attacks on the kernel harder
    "randomize_kstack_offset=on"

    # this has been defaulted to none back in 2016 - break really old binaries for security
    "vsyscall=none"

    # https://tails.boum.org/contribute/design/kernel_hardening/
    "slab_nomerge"

    # needs to be on for powertop
    # "debugfs=on"

    # only allow signed modules
    "module.sig_enforce=1"

    # blocks access to all kernel memory, even preventing administrators from being able to inspect and probe the kernel
    "lockdown=confidentiality"

    # enable buddy allocator free poisoning
    "page_poison=1"

    # performance improvement for direct-mapped memory-side-cache utilization, reduces the predictability of page allocations
    "page_alloc.shuffle=1"

    # WARNING: this will leak unhashed memory addresses to dmesg
    # for debugging kernel-level slab issues
    # "slub_debug=FZP"

    # always-enable sysrq keys. Useful for debugging
    "sysrq_always_enabled=0"

    # disable the intel_idle driver and use acpi_idle instead
    "idle=nomwait"

    # ignore access time (atime) updates on files, except when they coincide with updates to the ctime or mtime
    "rootflags=noatime"

    # enable IOMMU for devices used in passthrough and provide better host performance
    "iommu=pt"

    # enable usb autosuspend
    "usbcore.autosuspend=1"

    # linux security modules
    "lsm=landlock,lockdown,yama,apparmor,bpf"

    # 7 = KERN_DEBUG for debugging
    "loglevel=7"

    # disables resume and restores original swap space
    "noresume"

    # allows systemd to set and save the backlight state
    "acpi_backlight=native" # none | vendor | video | native

    # prevent the kernel from blanking plymouth out of the fb
    "fbcon=nodefer"

    # disable boot logo if any
    "logo.nologo"

    # tell the kernel to not be verbose
    # "quiet"

    # disable systemd status messages
    # rd prefix means systemd-udev will be used instead of initrd
    "rd.systemd.show_status=auto"

    # lower the udev log level to show only errors or worse
    "rd.udev.log_level=3"

    # disable the cursor in vt to get a black screen during intermissions
    # TODO turn back on in tty
    "vt.global_cursor_default=0"
  ];

  # Security
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"
    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "vivid"
    "gfs2"
    "ksmbd"
    "nfsv4"
    "nfsv3"
    "cifs"
    "nfs"
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "squashfs"
    "udf"
    "uvcvideo" # thats why your webcam not worky
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "uvcvideo"
    "qnx4"
    "qnx6"
    "sysv"
  ];
}
