From: David Narvaez <david.narvaez@computer.org>
Date: Sat, 09 Feb 2019 23:16:50 +0000
Subject: Re: The "udl" driver crashes the kernel.
Message-Id: <CACFh1D5TR6sWfudn_wto+rqXNHMFLUeVeXqnDdxwk_W5eouOtA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is referring to

https://marc.info/?l=linux-fbdev&m4318725922207&w=2

I can reproduce this in Linux 4.20.0. Is there any additional info
that would help you fix this?

David E. Narvaez

[ 1110.265232] WARNING: CPU: 2 PID: 1201 at
drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x24/0x30 [drm]
[ 1110.265233] Modules linked in: cmac fuse rfcomm bnep bcache crc64
uvcvideo iTCO_wdt iTCO_vendor_support dell_laptop videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 dell_smm_hwmon videobuf2_common
videodev media udl rtsx_usb_ms memstick intel_rapl btusb btrtl btbcm
iwldvm x86_pkg_temp_thermal btintel intel_powerclamp mac80211
snd_hda_codec_hdmi bluetooth snd_hda_codec_idt snd_hda_codec_generic
joydev iwlwifi coretemp snd_hda_intel snd_hda_codec psmouse
ecdh_generic kvm_intel snd_hda_core alx kvm snd_hwdep irqbypass
efi_pstore snd_pcm snd_timer cfg80211 pcspkr efivars input_leds
dell_wmi dell_smbios snd lpc_ich sparse_keymap dell_wmi_descriptor
i2c_i801 pcc_cpufreq xt_hl ip6t_rt ipt_REJECT nf_reject_ipv4
nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp xt_addrtype
xt_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables x_tables
sch_fq_codel efivarfs
[ 1110.265267]  sha256_ssse3 sha256_generic ipv6 crc_ccitt uas
hid_multitouch hid_generic rtsx_usb_sdmmc mmc_core rtsx_usb ext4
mbcache jbd2 fscrypto crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd
glue_helper serio_raw mxm_wmi ehci_pci ehci_hcd xhci_pci xhci_hcd i915
intel_gtt i2c_algo_bit drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops drm agpgart
[ 1110.265280] CPU: 2 PID: 1201 Comm: Xorg Tainted: G        W
4.20.0-sabayon #1
[ 1110.265281] Hardware name: Dell Inc. Inspiron 5523/, BIOS A05 05/18/2013
[ 1110.265286] RIP: 0010:drm_gem_object_put+0x24/0x30 [drm]
[ 1110.265287] Code: c3 0f 1f 44 00 00 48 85 ff 74 1b 48 8b 47 08 48
8b 40 68 48 a9 f8 ff ff ff 74 0f f0 ff 0f 0f 88 06 5d 02 00 74 02 f3
c3 eb 9c <0f> 0b eb ed 0f 1f 84 00 00 00 00 00 48 8b 47 08 48 8d 77 18
48 8b
[ 1110.265288] RSP: 0018:ffffc90001de7d08 EFLAGS: 00010246
[ 1110.265290] RAX: 0000000000000000 RBX: ffff8882268e6000 RCX: 0000000000000000
[ 1110.265290] RDX: ffffffffffffffff RSI: ffff8882220609e0 RDI: ffff8882268e6000
[ 1110.265291] RBP: ffff888224d0d820 R08: 0000000000100688 R09: 0000000000100304
[ 1110.265292] R10: 0000000000000000 R11: 00000000010ffff0 R12: 0000000000000000
[ 1110.265293] R13: ffffc90001de7dc8 R14: ffffc90001de7dc0 R15: ffffffffa003c6a8
[ 1110.265294] FS:  00007f8629edf9c0(0000) GS:ffff888227100000(0000)
knlGS:0000000000000000
[ 1110.265295] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1110.265296] CR2: 00007f8622211780 CR3: 00000002161e0006 CR4: 00000000001606e0
[ 1110.265296] Call Trace:
[ 1110.265302]  udl_gem_mmap+0x53/0x440 [udl]
[ 1110.265309]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1110.265315]  drm_ioctl_kernel+0x81/0x120 [drm]
[ 1110.265320]  drm_ioctl+0x2e6/0x3a0 [drm]
[ 1110.265326]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1110.265332]  ? ext4_llseek+0x51e/0x1800 [ext4]
[ 1110.265336]  ? pipe_write+0x281/0x3f0
[ 1110.265339]  do_vfs_ioctl+0x9f/0x630
[ 1110.265341]  ksys_ioctl+0x6b/0x80
[ 1110.265343]  __x64_sys_ioctl+0x11/0x20
[ 1110.265346]  do_syscall_64+0x50/0x110
[ 1110.265349]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1110.265351] RIP: 0033:0x7f8627616da7
[ 1110.265352] Code: 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3
e8 4e fb 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 10 2d 00 f7 d8 64 89
01 48
[ 1110.265353] RSP: 002b:00007fff061690f8 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[ 1110.265354] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8627616da7
[ 1110.265355] RDX: 00007fff06169140 RSI: 00000000c01064b3 RDI: 0000000000000012
[ 1110.265356] RBP: 00007fff06169140 R08: 000055d416ef9890 R09: 0000000000000010
[ 1110.265356] R10: 000055d416ebb010 R11: 0000000000003246 R12: 00000000c01064b3
[ 1110.265357] R13: 0000000000000012 R14: 000055d4152089e0 R15: 000055d416f06330
[ 1110.265358] ---[ end trace 8a8bbcc8dbe5d50e ]---
[ 1132.501544] WARNING: CPU: 0 PID: 1201 at
drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x24/0x30 [drm]
[ 1132.501545] Modules linked in: cmac fuse rfcomm bnep bcache crc64
uvcvideo iTCO_wdt iTCO_vendor_support dell_laptop videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 dell_smm_hwmon videobuf2_common
videodev media udl rtsx_usb_ms memstick intel_rapl btusb btrtl btbcm
iwldvm x86_pkg_temp_thermal btintel intel_powerclamp mac80211
snd_hda_codec_hdmi bluetooth snd_hda_codec_idt snd_hda_codec_generic
joydev iwlwifi coretemp snd_hda_intel snd_hda_codec psmouse
ecdh_generic kvm_intel snd_hda_core alx kvm snd_hwdep irqbypass
efi_pstore snd_pcm snd_timer cfg80211 pcspkr efivars input_leds
dell_wmi dell_smbios snd lpc_ich sparse_keymap dell_wmi_descriptor
i2c_i801 pcc_cpufreq xt_hl ip6t_rt ipt_REJECT nf_reject_ipv4
nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp xt_addrtype
xt_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables x_tables
sch_fq_codel efivarfs
[ 1132.501579]  sha256_ssse3 sha256_generic ipv6 crc_ccitt uas
hid_multitouch hid_generic rtsx_usb_sdmmc mmc_core rtsx_usb ext4
mbcache jbd2 fscrypto crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd
glue_helper serio_raw mxm_wmi ehci_pci ehci_hcd xhci_pci xhci_hcd i915
intel_gtt i2c_algo_bit drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops drm agpgart
[ 1132.501597] CPU: 0 PID: 1201 Comm: Xorg Tainted: G        W
4.20.0-sabayon #1
[ 1132.501598] Hardware name: Dell Inc. Inspiron 5523/, BIOS A05 05/18/2013
[ 1132.501605] RIP: 0010:drm_gem_object_put+0x24/0x30 [drm]
[ 1132.501606] Code: c3 0f 1f 44 00 00 48 85 ff 74 1b 48 8b 47 08 48
8b 40 68 48 a9 f8 ff ff ff 74 0f f0 ff 0f 0f 88 06 5d 02 00 74 02 f3
c3 eb 9c <0f> 0b eb ed 0f 1f 84 00 00 00 00 00 48 8b 47 08 48 8d 77 18
48 8b
[ 1132.501607] RSP: 0018:ffffc90001de7d08 EFLAGS: 00010246
[ 1132.501609] RAX: 0000000000000000 RBX: ffff8880bc16f200 RCX: 0000000000000000
[ 1132.501610] RDX: ffffffffffffffff RSI: ffff8882220609e0 RDI: ffff8880bc16f200
[ 1132.501610] RBP: ffff888224d0d820 R08: 0000000000100688 R09: 0000000000100304
[ 1132.501611] R10: 0000000000000000 R11: 00000000010ffff0 R12: 0000000000000000
[ 1132.501612] R13: ffffc90001de7dc8 R14: ffffc90001de7dc0 R15: ffffffffa003c6a8
[ 1132.501613] FS:  00007f8629edf9c0(0000) GS:ffff888227000000(0000)
knlGS:0000000000000000
[ 1132.501614] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1132.501615] CR2: 0000117048a6a8d0 CR3: 00000002161e0002 CR4: 00000000001606f0
[ 1132.501616] Call Trace:
[ 1132.501625]  udl_gem_mmap+0x53/0x440 [udl]
[ 1132.501632]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1132.501636]  drm_ioctl_kernel+0x81/0x120 [drm]
[ 1132.501642]  drm_ioctl+0x2e6/0x3a0 [drm]
[ 1132.501648]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1132.501657]  ? ep_scan_ready_list.constprop.4+0x1e0/0x200
[ 1132.501662]  do_vfs_ioctl+0x9f/0x630
[ 1132.501666]  ? __switch_to+0x290/0x370
[ 1132.501668]  ksys_ioctl+0x6b/0x80
[ 1132.501670]  __x64_sys_ioctl+0x11/0x20
[ 1132.501673]  do_syscall_64+0x50/0x110
[ 1132.501679]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1132.501681] RIP: 0033:0x7f8627616da7
[ 1132.501682] Code: 00 00 75 0c 48 c7 c0 ff ff ff ff 48 83 c4 18 c3
e8 4e fb 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 10 2d 00 f7 d8 64 89
01 48
[ 1132.501683] RSP: 002b:00007fff061690f8 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[ 1132.501685] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8627616da7
[ 1132.501686] RDX: 00007fff06169140 RSI: 00000000c01064b3 RDI: 0000000000000012
[ 1132.501687] RBP: 00007fff06169140 R08: 000055d416ef9890 R09: 0000000000000006
[ 1132.501688] R10: 000055d416ebb010 R11: 0000000000003246 R12: 00000000c01064b3
[ 1132.501690] R13: 0000000000000012 R14: 000055d4152089e0 R15: 000055d416f06330
[ 1132.501691] ---[ end trace 8a8bbcc8dbe5d50f ]---

David E. Narvaez
