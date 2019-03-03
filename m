From: Wojtek Zabolotny <W.Zabolotny@elka.pw.edu.pl>
Date: Sun, 03 Mar 2019 19:59:56 +0000
Subject: Re: The "udl" driver crashes the kernel.
Message-Id: <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
 <20181125230722.GD30242@amd>
In-Reply-To: <20181125230722.GD30242@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Pavel Machek <pavel@ucw.cz>, "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, bernie@plugable.com, linux-fbdev@vger.kernel.org, airlied@redhat.com, sean@poorly.run, dri-devel@lists.freedesktop.org

On 26.11.2018 00:07, Pavel Machek wrote:
> On Sun 2018-11-25 16:58:59, wzabolot@elektron.elka.pw.edu.pl wrote:
>> When I connect my Displaylink DL-165 adapter to my Debian/testing
>> machine, the "udl" driver is loaded and the following error messages
>> appears in kernel logs:
> 4.18 kernel. Might be worth testing latest stable, and latest
> mainline...
>
> Is there version that worked for you?
>
> I added udl maintainers to the Cc list.
>
> Best regards,

I have repeated the tests with my current Debian/testing setup (kernel 4.19.16), and still get warnings from kernel after loading the udl module:

[ 1208.605542] [drm] vendor descriptor length:22 data:22 5f 01 00 20 05 00 01 03 04 02
[ 1208.706718] udl 4-1.2:1.0: fb1: udldrmfb frame buffer device
[ 1208.706746] [drm] Initialized udl 0.0.1 20120220 for 4-1.2:1.0 on minor 2
[ 1208.706753] [drm] Initialized udl on minor 2
[ 1208.706876] usbcore: registered new interface driver udl
[ 1210.003149] WARNING: CPU: 0 PID: 993 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[ 1210.003153] Modules linked in: udl evdi(OE) rfcomm ctr ccm bnep cpufreq_userspace cpufreq_conservative cpufreq_powersave nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc arc4 iwldvm mac80211 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 iwlwifi videobuf2_common nvidia_drm(POE)
nvidia_modeset(POE) videodev intel_rapl media x86_pkg_temp_thermal intel_powerclamp btusb snd_hda_codec_realtek snd_hda_codec_generic btrtl btbcm btintel bluetooth snd_hda_intel i915 snd_hda_codec
snd_hda_core drbg ansi_cprng snd_hwdep snd_pcm_oss snd_mixer_oss coretemp kvm_intel snd_pcm ecdh_generic kvm snd_timer snd joydev serio_raw soundcore drm_kms_helper cfg80211 irqbypass dell_wmi
sparse_keymap pcspkr drm dell_laptop
[ 1210.003247]  dell_smbios mei_me rfkill i2c_algo_bit dcdbas intel_cstate iTCO_wdt mei iTCO_vendor_support intel_uncore dell_smm_hwmon evdev nvidia(POE) pcc_cpufreq intel_rapl_perf sg
dell_wmi_descriptor wmi_bmof wmi video ac button battery dell_smo8800 ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod ums_realtek uas usb_storage crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci xhci_pci libahci xhci_hcd
ehci_pci libata ehci_hcd realtek aesni_intel aes_x86_64 crypto_simd cryptd usbcore psmouse glue_helper scsi_mod r8169 i2c_i801 libphy lpc_ich usb_common thermal [last unloaded: udlfb]
[ 1210.003358] CPU: 0 PID: 993 Comm: Xorg Tainted: P           OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[ 1210.003360] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[ 1210.003393] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[ 1210.003397] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 7f 05 f8 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[ 1210.003400] RSP: 0018:ffffaa4cc23b3d10 EFLAGS: 00010246
[ 1210.003405] RAX: 0000000000000000 RBX: ffff9e749ad90800 RCX: 0000000000000000
[ 1210.003408] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff9e749ad90800
[ 1210.003411] RBP: ffff9e7496cbf020 R08: ffff9e74a720c910 R09: 00000000010ffff0
[ 1210.003413] R10: 0000000000100004 R11: 0000000000000000 R12: 0000000000000000
[ 1210.003416] R13: ffffaa4cc23b3dd0 R14: ffffaa4cc23b3dc8 R15: ffff9e74a2695d00
[ 1210.003420] FS:  00007ff1907cca80(0000) GS:ffff9e74ae200000(0000) knlGS:0000000000000000
[ 1210.003423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1210.003426] CR2: 00007ff18c785278 CR3: 00000004290f6002 CR4: 00000000000606f0
[ 1210.003429] Call Trace:
[ 1210.003446]  udl_gem_mmap+0x64/0xa0 [udl]
[ 1210.003484]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.003515]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[ 1210.003549]  drm_ioctl+0x206/0x3a0 [drm]
[ 1210.003584]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.003592]  ? datagram_poll+0x25/0xf0
[ 1210.003599]  ? sock_poll+0x83/0xb0
[ 1210.003605]  ? ep_item_poll.isra.16+0x40/0xc0
[ 1210.003609]  ? sock_poll+0x83/0xb0
[ 1210.003616]  do_vfs_ioctl+0xa4/0x630
[ 1210.003621]  ? __x64_sys_epoll_ctl+0xe7/0x550
[ 1210.003626]  ksys_ioctl+0x60/0x90
[ 1210.003632]  __x64_sys_ioctl+0x16/0x20
[ 1210.003639]  do_syscall_64+0x53/0x100
[ 1210.003645]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1210.003650] RIP: 0033:0x7ff190efd757
[ 1210.003654] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[ 1210.003657] RSP: 002b:00007ffd9dcaca98 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[ 1210.003662] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff190efd757
[ 1210.003664] RDX: 00007ffd9dcacad0 RSI: 00000000c01064b3 RDI: 000000000000003d
[ 1210.003667] RBP: 00007ffd9dcacad0 R08: 0000000000000000 R09: 000055718bf5d820
[ 1210.003669] R10: 00007ffd9dcaca7c R11: 0000000000003246 R12: 00000000c01064b3
[ 1210.003672] R13: 000000000000003d R14: 000055718bd84f80 R15: 0000000000000001
[ 1210.003677] ---[ end trace 115b8e77b2a2c036 ]---
[ 1210.005818] WARNING: CPU: 0 PID: 993 at drivers/gpu/drm/drm_gem.c:893 drm_gem_object_put+0x33/0x40 [drm]
[ 1210.005820] Modules linked in: udl evdi(OE) rfcomm ctr ccm bnep cpufreq_userspace cpufreq_conservative cpufreq_powersave nft_counter xt_owner xt_state xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc arc4 iwldvm mac80211 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 iwlwifi videobuf2_common nvidia_drm(POE)
nvidia_modeset(POE) videodev intel_rapl media x86_pkg_temp_thermal intel_powerclamp btusb snd_hda_codec_realtek snd_hda_codec_generic btrtl btbcm btintel bluetooth snd_hda_intel i915 snd_hda_codec
snd_hda_core drbg ansi_cprng snd_hwdep snd_pcm_oss snd_mixer_oss coretemp kvm_intel snd_pcm ecdh_generic kvm snd_timer snd joydev serio_raw soundcore drm_kms_helper cfg80211 irqbypass dell_wmi
sparse_keymap pcspkr drm dell_laptop
[ 1210.005907]  dell_smbios mei_me rfkill i2c_algo_bit dcdbas intel_cstate iTCO_wdt mei iTCO_vendor_support intel_uncore dell_smm_hwmon evdev nvidia(POE) pcc_cpufreq intel_rapl_perf sg
dell_wmi_descriptor wmi_bmof wmi video ac button battery dell_smo8800 ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod ums_realtek uas usb_storage crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci xhci_pci libahci xhci_hcd
ehci_pci libata ehci_hcd realtek aesni_intel aes_x86_64 crypto_simd cryptd usbcore psmouse glue_helper scsi_mod r8169 i2c_i801 libphy lpc_ich usb_common thermal [last unloaded: udlfb]
[ 1210.006005] CPU: 0 PID: 993 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
[ 1210.006007] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
[ 1210.006038] RIP: 0010:drm_gem_object_put+0x33/0x40 [drm]
[ 1210.006042] Code: 28 53 48 8b 47 08 48 8b 40 68 48 a9 f8 ff ff ff 74 18 48 89 fb e8 ed 7f 05 f8 84 c0 75 02 5b c3 48 89 df 5b e9 0e fc ff ff c3 <0f> 0b eb e4 66 0f 1f 84 00 00 00 00 00 66 66 66 66
90 48 85 ff 74
[ 1210.006044] RSP: 0018:ffffaa4cc23b3d10 EFLAGS: 00010246
[ 1210.006048] RAX: 0000000000000000 RBX: ffff9e749ad93800 RCX: 0000000000000000
[ 1210.006050] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff9e749ad93800
[ 1210.006053] RBP: ffff9e7496cbf020 R08: ffff9e74a720c910 R09: 00000000010ffff0
[ 1210.006055] R10: 0000000000100304 R11: 0000000000000000 R12: 0000000000000000
[ 1210.006058] R13: ffffaa4cc23b3dd0 R14: ffffaa4cc23b3dc8 R15: ffff9e74a2695d00
[ 1210.006062] FS:  00007ff1907cca80(0000) GS:ffff9e74ae200000(0000) knlGS:0000000000000000
[ 1210.006065] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1210.006067] CR2: 00007ff18c785278 CR3: 00000004290f6002 CR4: 00000000000606f0
[ 1210.006069] Call Trace:
[ 1210.006080]  udl_gem_mmap+0x64/0xa0 [udl]
[ 1210.006115]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.006146]  drm_ioctl_kernel+0xa1/0xf0 [drm]
[ 1210.006178]  drm_ioctl+0x206/0x3a0 [drm]
[ 1210.006212]  ? drm_mode_create_dumb_ioctl+0x10/0x10 [drm]
[ 1210.006220]  ? do_mmap+0x3c7/0x5a0
[ 1210.006227]  do_vfs_ioctl+0xa4/0x630
[ 1210.006234]  ksys_ioctl+0x60/0x90
[ 1210.006239]  __x64_sys_ioctl+0x16/0x20
[ 1210.006246]  do_syscall_64+0x53/0x100
[ 1210.006251]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1210.006255] RIP: 0033:0x7ff190efd757
[ 1210.006259] Code: 00 00 90 48 8b 05 39 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 a7 0c 00 f7
d8 64 89 01 48
[ 1210.006261] RSP: 002b:00007ffd9dcaca98 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[ 1210.006265] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff190efd757
[ 1210.006268] RDX: 00007ffd9dcacad0 RSI: 00000000c01064b3 RDI: 000000000000003d
[ 1210.006271] RBP: 00007ffd9dcacad0 R08: 000000000000003d R09: 0000000100000000
[ 1210.006273] R10: 0000000000000001 R11: 0000000000003246 R12: 00000000c01064b3
[ 1210.006275] R13: 000000000000003d R14: 000055718bd84f80 R15: 0000000000000001
[ 1210.006280] ---[ end trace 115b8e77b2a2c037 ]---

With best regards,
Wojtek

-- 
Wojciech M Zabolotny, PhD
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology
