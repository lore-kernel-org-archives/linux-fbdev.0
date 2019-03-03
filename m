From: Wojtek Zabolotny <W.Zabolotny@elka.pw.edu.pl>
Date: Sun, 03 Mar 2019 20:39:11 +0000
Subject: Re: The "udl" driver crashes the kernel.
Message-Id: <f3c89582-c6d5-ef0b-2db3-b981ebda517c@elka.pw.edu.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
 <20181125230722.GD30242@amd>
 <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
In-Reply-To: <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Pavel Machek <pavel@ucw.cz>, "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, bernie@plugable.com, linux-fbdev@vger.kernel.org, airlied@redhat.com, sean@poorly.run, dri-devel@lists.freedesktop.org

Hi,

A few more details. In the current configuration, inspite of kernel warnings the system is working, and I was able to configure both monitors (LCD in my laptop and external LCD monitor connected to
UDL-165).

I have followed the procedure described in https://wiki.archlinux.org/index.php/DisplayLink#USB_2.0_DL-1x5,_DL-1x0_Devices

# xrandr --listproviders
Providers: number : 2
Provider 0: id: 0x43 cap: 0xf, Source Output, Sink Output, Source Offload, Sink Offload crtcs: 2 outputs: 2 associated providers: 1 name:modesetting
Provider 1: id: 0x17a cap: 0x2, Sink Output crtcs: 1 outputs: 1 associated providers: 1 name:modesetting
# xrandr --setprovideroutputsource 1 0

Afterwards I have configured screens in my Mate desktop using GUI.

However, the CPU occupancy is high and I get the following messages regarding the softmmu operation:

[  212.020300] swiotlb_tbl_map_single: 10 callbacks suppressed
[  212.020309] udl 4-1.2:1.0: swiotlb buffer is full (sz: 999424 bytes)
[  212.020315] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 999424 bytes
[  278.355981] udl 4-1.2:1.0: swiotlb buffer is full (sz: 786432 bytes)
[  278.355988] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 786432 bytes
[  298.657084] traps: mate-notificati[1944] trap int3 ip:7f1526cbdca5 sp:7fffc1f65f00 error:0 in libglib-2.0.so.0.5800.3[7f1526c85000+7e000]
[  316.132315] udl 4-1.2:1.0: swiotlb buffer is full (sz: 1019904 bytes)
[  316.132319] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 1019904 bytes

From time to time I also get the messages about the drm_get_object_put

Below are all the related messages. When I tried to disconnect the UDL-165 from USB socket, the whole system crashed immediately.

[  117.364046] usb 1-1.3: reset full-speed USB device number 3 using ehci-pci
[  134.269573] [drm] vendor descriptor length:22 data:22 5f 01 00 20 05 00 01 03 04 02
[  134.436703] udl 4-1.2:1.0: fb1: udldrmfb frame buffer device
[  134.436735] [drm] Initialized udl 0.0.1 20120220 for 4-1.2:1.0 on minor 2
[  134.436742] [drm] Initialized udl on minor 2
[  134.436849] usbcore: registered new interface driver udl
[  136.095399] WARNING: CPU: 4 PID: 920 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[  136.095403] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal intel_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cfg80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[  136.095498]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
[  136.095604] CPU: 4 PID: 920 Comm: Xorg Tainted: P           OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[  136.095607] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[  136.095639] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[  136.095644] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[  136.095647] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[  136.095652] RAX: 0000000000000000 RBX: ffff97fd7f4eb000 RCX: 0000000000000000
[  136.095654] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff97fd7f4eb000
[  136.095657] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 00000000010ffff0
[  136.095659] R10: 0000000000100004 R11: 0000000000000000 R12: 0000000000000000
[  136.095662] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff97fd8de12e00
[  136.095666] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae300000(0000) knlGS:0000000000000000
[  136.095670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  136.095672] CR2: 00007f57bdeaa630 CR3: 0000000416a9e002 CR4: 00000000000606e0
[  136.095675] Call Trace:
[  136.095695]  udl_gem_mmap+0x64/0xa0 [udl]
[  136.095743]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  136.095784]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[  136.095818]  drm_ioctl+0x206/0x3a0 [drm]
[  136.095853]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  136.095861]  ? datagram_poll+0x25/0xf0
[  136.095866]  ? sock_poll+0x83/0xb0
[  136.095872]  ? ep_item_poll.isra.16+0x40/0xc0
[  136.095877]  ? sock_poll+0x83/0xb0
[  136.095883]  do_vfs_ioctl+0xa4/0x630
[  136.095889]  ? __x64_sys_epoll_ctl+0xe7/0x550
[  136.095894]  ksys_ioctl+0x60/0x90
[  136.095900]  __x64_sys_ioctl+0x16/0x20
[  136.095908]  do_syscall_64+0x53/0x100
[  136.095914]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  136.095920] RIP: 0033:0x7f57d742b757
[  136.095924] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[  136.095927] RSP: 002b:00007fff80edf058 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[  136.095931] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57d742b757
[  136.095934] RDX: 00007fff80edf090 RSI: 00000000c01064b3 RDI: 0000000000000038
[  136.095936] RBP: 00007fff80edf090 R08: 0000000000000000 R09: 0000555ab4d09270
[  136.095939] R10: 00007fff80edf03c R11: 0000000000003246 R12: 00000000c01064b3
[  136.095941] R13: 0000000000000038 R14: 0000555ab4ae9220 R15: 0000000000000001
[  136.095947] ---[ end trace f558f2f0c6dcf780 ]---
[  136.097883] WARNING: CPU: 4 PID: 920 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[  136.097885] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal intel_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cfg80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[  136.097961]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
[  136.098045] CPU: 4 PID: 920 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[  136.098047] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[  136.098074] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[  136.098077] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[  136.098079] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[  136.098083] RAX: 0000000000000000 RBX: ffff97fd7f4e8200 RCX: 0000000000000000
[  136.098085] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff97fd7f4e8200
[  136.098088] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 00000000010ffff0
[  136.098090] R10: 0000000000100304 R11: 0000000000000000 R12: 0000000000000000
[  136.098092] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff97fd8de12e00
[  136.098096] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae300000(0000) knlGS:0000000000000000
[  136.098098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  136.098100] CR2: 00007f57bdeaa630 CR3: 0000000416a9e002 CR4: 00000000000606e0
[  136.098102] Call Trace:
[  136.098112]  udl_gem_mmap+0x64/0xa0 [udl]
[  136.098143]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  136.098171]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[  136.098200]  drm_ioctl+0x206/0x3a0 [drm]
[  136.098233]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  136.098241]  ? do_mmap+0x3c7/0x5a0
[  136.098247]  do_vfs_ioctl+0xa4/0x630
[  136.098252]  ksys_ioctl+0x60/0x90
[  136.098258]  __x64_sys_ioctl+0x16/0x20
[  136.098263]  do_syscall_64+0x53/0x100
[  136.098268]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  136.098271] RIP: 0033:0x7f57d742b757
[  136.098274] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[  136.098276] RSP: 002b:00007fff80edf058 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[  136.098280] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57d742b757
[  136.098282] RDX: 00007fff80edf090 RSI: 00000000c01064b3 RDI: 0000000000000038
[  136.098284] RBP: 00007fff80edf090 R08: 0000000000000038 R09: 0000000100000000
[  136.098287] R10: 0000000000000001 R11: 0000000000003246 R12: 00000000c01064b3
[  136.098289] R13: 0000000000000038 R14: 0000555ab4ae9220 R15: 0000000000000001
[  136.098293] ---[ end trace f558f2f0c6dcf781 ]---
[  212.020300] swiotlb_tbl_map_single: 10 callbacks suppressed
[  212.020309] udl 4-1.2:1.0: swiotlb buffer is full (sz: 999424 bytes)
[  212.020315] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 999424 bytes
[  278.355981] udl 4-1.2:1.0: swiotlb buffer is full (sz: 786432 bytes)
[  278.355988] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 786432 bytes
[  298.657084] traps: mate-notificati[1944] trap int3 ip:7f1526cbdca5 sp:7fffc1f65f00 error:0 in libglib-2.0.so.0.5800.3[7f1526c85000+7e000]
[  316.132315] udl 4-1.2:1.0: swiotlb buffer is full (sz: 1019904 bytes)
[  316.132319] udl 4-1.2:1.0: DMA: Out of SW-IOMMU space for 1019904 bytes
[  316.132436] WARNING: CPU: 4 PID: 920 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[  316.132437] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal intel_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cfg80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[  316.132475]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
[  316.132518] CPU: 4 PID: 920 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[  316.132519] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[  316.132530] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[  316.132532] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[  316.132533] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[  316.132535] RAX: 0000000000000000 RBX: ffff97fd7f4eac00 RCX: 0000000000000000
[  316.132536] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff97fd7f4eac00
[  316.132537] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 00000000010ffff0
[  316.132538] R10: 0000000000100604 R11: 0000000000000000 R12: 0000000000000000
[  316.132539] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff97fd8de12e00
[  316.132540] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae300000(0000) knlGS:0000000000000000
[  316.132541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.132543] CR2: 00007f57cd5ed00c CR3: 0000000416a9e004 CR4: 00000000000606e0
[  316.132544] Call Trace:
[  316.132550]  udl_gem_mmap+0x64/0xa0 [udl]
[  316.132564]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  316.132575]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[  316.132588]  drm_ioctl+0x206/0x3a0 [drm]
[  316.132601]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  316.132604]  ? fsnotify+0x34b/0x560
[  316.132608]  do_vfs_ioctl+0xa4/0x630
[  316.132610]  ksys_ioctl+0x60/0x90
[  316.132614]  ? ksys_write+0x9c/0xb0
[  316.132616]  __x64_sys_ioctl+0x16/0x20
[  316.132619]  do_syscall_64+0x53/0x100
[  316.132621]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  316.132623] RIP: 0033:0x7f57d742b757
[  316.132625] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[  316.132626] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[  316.132628] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57d742b757
[  316.132628] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000000000000038
[  316.132629] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000000000000006
[  316.132630] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 00000000c01064b3
[  316.132631] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000555ab4a03cc0
[  316.132633] ---[ end trace f558f2f0c6dcf782 ]---
[  335.726489] WARNING: CPU: 1 PID: 920 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[  335.726494] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal intel_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cfg80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[  335.726589]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
[  335.726697] CPU: 1 PID: 920 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[  335.726700] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[  335.726732] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[  335.726737] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[  335.726740] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[  335.726744] RAX: 0000000000000000 RBX: ffff97fda60f6e00 RCX: 0000000000000000
[  335.726747] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff97fda60f6e00
[  335.726750] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 00000000010ffff0
[  335.726752] R10: 0000000000100604 R11: 0000000000000000 R12: 0000000000000000
[  335.726755] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff97fd8de12e00
[  335.726759] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae240000(0000) knlGS:0000000000000000
[  335.726762] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  335.726765] CR2: 00007f57cd5a3004 CR3: 0000000416a9e005 CR4: 00000000000606e0
[  335.726768] Call Trace:
[  335.726786]  udl_gem_mmap+0x64/0xa0 [udl]
[  335.726823]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  335.726854]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[  335.726888]  drm_ioctl+0x206/0x3a0 [drm]
[  335.726923]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  335.726934]  ? __set_current_blocked+0x3d/0x60
[  335.726939]  ? signal_setup_done+0x94/0xb0
[  335.726947]  ? __fpu__restore_sig+0x90/0x460
[  335.726956]  do_vfs_ioctl+0xa4/0x630
[  335.726967]  ? _copy_from_user+0x37/0x60
[  335.726974]  ksys_ioctl+0x60/0x90
[  335.726981]  __x64_sys_ioctl+0x16/0x20
[  335.726991]  do_syscall_64+0x53/0x100
[  335.727000]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  335.727011] RIP: 0033:0x7f57d742b757
[  335.727015] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[  335.727017] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[  335.727022] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57d742b757
[  335.727025] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000000000000038
[  335.727028] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000000000000006
[  335.727030] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 00000000c01064b3
[  335.727033] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000555ab4a03cc0
[  335.727038] ---[ end trace f558f2f0c6dcf783 ]---
[  371.536170] WARNING: CPU: 1 PID: 920 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[  371.536172] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal intel_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cfg80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[  371.536204]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
[  371.536241] CPU: 1 PID: 920 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[  371.536242] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[  371.536251] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[  371.536253] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[  371.536254] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[  371.536255] RAX: 0000000000000000 RBX: ffff97fda60f7600 RCX: 0000000000000000
[  371.536256] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff97fda60f7600
[  371.536257] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 00000000010ffff0
[  371.536257] R10: 0000000000100604 R11: 0000000000000000 R12: 0000000000000000
[  371.536258] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff97fd8de12e00
[  371.536259] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae240000(0000) knlGS:0000000000000000
[  371.536260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  371.536261] CR2: 000056441c407000 CR3: 0000000416a9e004 CR4: 00000000000606e0
[  371.536262] Call Trace:
[  371.536269]  udl_gem_mmap+0x64/0xa0 [udl]
[  371.536279]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  371.536288]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[  371.536298]  drm_ioctl+0x206/0x3a0 [drm]
[  371.536308]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  371.536311]  ? iput+0x76/0x200
[  371.536314]  do_vfs_ioctl+0xa4/0x630
[  371.536316]  ksys_ioctl+0x60/0x90
[  371.536317]  __x64_sys_ioctl+0x16/0x20
[  371.536320]  do_syscall_64+0x53/0x100
[  371.536322]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  371.536324] RIP: 0033:0x7f57d742b757
[  371.536325] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[  371.536326] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[  371.536328] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57d742b757
[  371.536328] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000000000000038
[  371.536329] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 00007f57d74f6d20
[  371.536330] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 00000000c01064b3
[  371.536331] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000555ab4a03cc0
[  371.536332] ---[ end trace f558f2f0c6dcf784 ]---
[  388.386692] WARNING: CPU: 5 PID: 920 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[  388.386693] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btbcm snd_hda_codec_realtek videodev
snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal intel_powerclamp ecdh_generic snd_hda_intel coretemp
snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm cfg80211 snd_timer snd joydev soundcore serio_raw
sparse_keymap pcspkr
[  388.386723]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore pcc_cpufreq intel_rapl_perf
video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb algif_skcipher
af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata ehci_hcd aes_x86_64 realtek
crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
[  388.386760] CPU: 5 PID: 920 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[  388.386761] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[  388.386770] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[  388.386772] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 1f e6 dd 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[  388.386773] RSP: 0018:ffffba82c25f7d10 EFLAGS: 00010246
[  388.386774] RAX: 0000000000000000 RBX: ffff97fd71863800 RCX: 0000000000000000
[  388.386775] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff97fd71863800
[  388.386776] RBP: ffff97fda71cb820 R08: ffff97fd6893bd10 R09: 00000000010ffff0
[  388.386776] R10: 0000000000100604 R11: 0000000000000000 R12: 0000000000000000
[  388.386777] R13: ffffba82c25f7dd0 R14: ffffba82c25f7dc8 R15: ffff97fd8de12e00
[  388.386778] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae340000(0000) knlGS:0000000000000000
[  388.386779] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  388.386780] CR2: 000056441c407000 CR3: 0000000416a9e001 CR4: 00000000000606e0
[  388.386781] Call Trace:
[  388.386787]  udl_gem_mmap+0x64/0xa0 [udl]
[  388.386797]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  388.386806]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[  388.386824]  drm_ioctl+0x206/0x3a0 [drm]
[  388.386834]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[  388.386839]  ? __set_current_blocked+0x3d/0x60
[  388.386840]  ? signal_setup_done+0x94/0xb0
[  388.386844]  ? __fpu__restore_sig+0x90/0x460
[  388.386846]  do_vfs_ioctl+0xa4/0x630
[  388.386850]  ? _copy_from_user+0x37/0x60
[  388.386851]  ksys_ioctl+0x60/0x90
[  388.386853]  __x64_sys_ioctl+0x16/0x20
[  388.386855]  do_syscall_64+0x53/0x100
[  388.386858]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  388.386859] RIP: 0033:0x7f57d742b757
[  388.386860] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[  388.386861] RSP: 002b:00007fff80edfc58 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[  388.386863] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57d742b757
[  388.386863] RDX: 00007fff80edfc90 RSI: 00000000c01064b3 RDI: 0000000000000038
[  388.386864] RBP: 00007fff80edfc90 R08: 0000555ab4c906f0 R09: 0000000000000006
[  388.386865] R10: 0000555ab3ff3010 R11: 0000000000003246 R12: 00000000c01064b3
[  388.386866] R13: 0000000000000038 R14: 0000555ab4c91f80 R15: 0000555ab4a03cc0
[  388.386867] ---[ end trace f558f2f0c6dcf785 ]---

With best regards,
Wojtek

-- 
Wojciech M Zabolotny, PhD
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology
