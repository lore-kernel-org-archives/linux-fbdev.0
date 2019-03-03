From: Wojtek Zabolotny <W.Zabolotny@elka.pw.edu.pl>
Date: Sun, 03 Mar 2019 20:54:03 +0000
Subject: Re: The "udl" driver crashes the kernel.
Message-Id: <9ed52c22-c565-6df7-cd60-2953947c0311@elka.pw.edu.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
 <20181125230722.GD30242@amd>
 <2ed5f5c1-80a1-0790-a6f8-64d84284e9df@elka.pw.edu.pl>
 <f3c89582-c6d5-ef0b-2db3-b981ebda517c@elka.pw.edu.pl>
In-Reply-To: <f3c89582-c6d5-ef0b-2db3-b981ebda517c@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Pavel Machek <pavel@ucw.cz>, "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, bernie@plugable.com, linux-fbdev@vger.kernel.org, airlied@redhat.com, sean@poorly.run, dri-devel@lists.freedesktop.org

Hi,

It appeared that the crash was not immediate, and the messages got saved into /var/log/messages.
Below is full set of messages generated after disconnection of UDL-165.

I hope that they may help to isolate the problem.
With best regards,
Wojtek

Mar  3 21:39:35 wzdell kernel: [ 1270.474832] usb 4-1.2: USB disconnect, device number 3
Mar  3 21:39:35 wzdell kernel: [ 1270.475503] WARNING: CPU: 6 PID: 72 at drivers/gpu/drm/drm_mode_config.c:444 drm_mode_config_cleanup+0x288/0x2e0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.475505] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb
btrtl btbcm snd_hda_codec_realtek videodev snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal
intel_powerclamp ecdh_generic snd_hda_intel coretemp snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm
cfg80211 snd_timer snd joydev soundcore serio_raw sparse_keymap pcspkr
Mar  3 21:39:35 wzdell kernel: [ 1270.475561]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore
pcc_cpufreq intel_rapl_perf video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata
ehci_hcd aes_x86_64 realtek crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
Mar  3 21:39:35 wzdell kernel: [ 1270.475626] CPU: 6 PID: 72 Comm: kworker/6:1 Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
Mar  3 21:39:35 wzdell kernel: [ 1270.475627] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
Mar  3 21:39:35 wzdell kernel: [ 1270.475645] Workqueue: usb_hub_wq hub_event [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.475666] RIP: 0010:drm_mode_config_cleanup+0x288/0x2e0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.475669] Code: 17 de 48 8b 45 00 48 39 c5 75 62 48 8b 44 24 30 65 48 33 04 25 28 00 00 00 75 56 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b 48 89 e6 48 89
ef 48 c7 c3 20 de b9 c1 e8 04 8c ff ff eb 0c
Mar  3 21:39:35 wzdell kernel: [ 1270.475671] RSP: 0018:ffffba82c1df7ba8 EFLAGS: 00010216
Mar  3 21:39:35 wzdell kernel: [ 1270.475673] RAX: ffff97fda71c8818 RBX: ffff97fda71cab68 RCX: 0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.475675] RDX: ffff97fda71cab30 RSI: 0000000000000000 RDI: ffff97fda71cab48
Mar  3 21:39:35 wzdell kernel: [ 1270.475676] RBP: ffff97fda71ca800 R08: 0000000000000000 R09: ffffffffc1b7d800
Mar  3 21:39:35 wzdell kernel: [ 1270.475678] R10: ffff97fd817d6080 R11: 0000000000000001 R12: ffff97fda71cab70
Mar  3 21:39:35 wzdell kernel: [ 1270.475679] R13: ffff97fdabb91000 R14: ffff97fdabb910a0 R15: 00000000ffffffed
Mar  3 21:39:35 wzdell kernel: [ 1270.475682] FS:  0000000000000000(0000) GS:ffff97fdae380000(0000) knlGS:0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.475683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  3 21:39:35 wzdell kernel: [ 1270.475685] CR2: 0000559468f29b7c CR3: 00000001c120a003 CR4: 00000000000606e0
Mar  3 21:39:35 wzdell kernel: [ 1270.475686] Call Trace:
Mar  3 21:39:35 wzdell kernel: [ 1270.475697]  udl_driver_unload+0x2a/0x40 [udl]
Mar  3 21:39:35 wzdell kernel: [ 1270.475717]  drm_dev_unregister+0x4b/0xe0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.475737]  drm_dev_unplug+0x21/0x60 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.475751]  usb_unbind_interface+0x79/0x290 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.475758]  device_release_driver_internal+0x1af/0x270
Mar  3 21:39:35 wzdell kernel: [ 1270.475763]  bus_remove_device+0xe5/0x150
Mar  3 21:39:35 wzdell kernel: [ 1270.475767]  device_del+0x136/0x350
Mar  3 21:39:35 wzdell kernel: [ 1270.475780]  usb_disable_device+0x93/0x250 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.475793]  usb_disconnect+0xc3/0x270 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.475806]  hub_event+0xc80/0x15a0 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.475812]  process_one_work+0x1a7/0x3a0
Mar  3 21:39:35 wzdell kernel: [ 1270.475816]  worker_thread+0x30/0x390
Mar  3 21:39:35 wzdell kernel: [ 1270.475820]  ? pwq_unbound_release_workfn+0xd0/0xd0
Mar  3 21:39:35 wzdell kernel: [ 1270.475822]  kthread+0x112/0x130
Mar  3 21:39:35 wzdell kernel: [ 1270.475825]  ? kthread_bind+0x30/0x30
Mar  3 21:39:35 wzdell kernel: [ 1270.475828]  ret_from_fork+0x35/0x40
Mar  3 21:39:35 wzdell kernel: [ 1270.475831] ---[ end trace f558f2f0c6dcf788 ]---
Mar  3 21:39:35 wzdell kernel: [ 1270.475959] WARNING: CPU: 6 PID: 72 at drivers/gpu/drm/drm_mode_config.c:478 drm_mode_config_cleanup+0x2c4/0x2e0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.475959] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb
btrtl btbcm snd_hda_codec_realtek videodev snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal
intel_powerclamp ecdh_generic snd_hda_intel coretemp snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm
cfg80211 snd_timer snd joydev soundcore serio_raw sparse_keymap pcspkr
Mar  3 21:39:35 wzdell kernel: [ 1270.476008]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore
pcc_cpufreq intel_rapl_perf video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata
ehci_hcd aes_x86_64 realtek crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
Mar  3 21:39:35 wzdell kernel: [ 1270.476065] CPU: 6 PID: 72 Comm: kworker/6:1 Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
Mar  3 21:39:35 wzdell kernel: [ 1270.476067] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
Mar  3 21:39:35 wzdell kernel: [ 1270.476084] Workqueue: usb_hub_wq hub_event [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.476113] RIP: 0010:drm_mode_config_cleanup+0x2c4/0x2e0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.476116] Code: ff ff eb 0c 48 8b 70 48 48 89 df e8 e6 f4 ff ff 48 89 e7 e8 de 91 ff ff 48 85 c0 75 e7 48 89 e7 e8 61 92 ff ff e9 ef fd ff ff <0f> 0b e9 e6 fe ff ff
0f 0b eb 9a e8 4c e1 af dd 66 66 2e 0f 1f 84
Mar  3 21:39:35 wzdell kernel: [ 1270.476118] RSP: 0018:ffffba82c1df7ba8 EFLAGS: 00010206
Mar  3 21:39:35 wzdell kernel: [ 1270.476121] RAX: ffff97fd835b2608 RBX: ffff97fda71cac38 RCX: 000000008020001e
Mar  3 21:39:35 wzdell kernel: [ 1270.476123] RDX: ffff97fda71cac60 RSI: 0000000000000001 RDI: ffff97fda71cac38
Mar  3 21:39:35 wzdell kernel: [ 1270.476125] RBP: ffff97fda71ca800 R08: 0000000000000000 R09: ffffffffc1b7d900
Mar  3 21:39:35 wzdell kernel: [ 1270.476127] R10: ffff97fda9dd5b00 R11: 0000000000000001 R12: ffff97fda71cab08
Mar  3 21:39:35 wzdell kernel: [ 1270.476129] R13: ffff97fdabb91000 R14: ffff97fdabb910a0 R15: 00000000ffffffed
Mar  3 21:39:35 wzdell kernel: [ 1270.476132] FS:  0000000000000000(0000) GS:ffff97fdae380000(0000) knlGS:0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.476134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  3 21:39:35 wzdell kernel: [ 1270.476136] CR2: 0000559468f29b7c CR3: 00000001c120a003 CR4: 00000000000606e0
Mar  3 21:39:35 wzdell kernel: [ 1270.476138] Call Trace:
Mar  3 21:39:35 wzdell kernel: [ 1270.476147]  udl_driver_unload+0x2a/0x40 [udl]
Mar  3 21:39:35 wzdell kernel: [ 1270.476174]  drm_dev_unregister+0x4b/0xe0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.476201]  drm_dev_unplug+0x21/0x60 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.476220]  usb_unbind_interface+0x79/0x290 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.476225]  device_release_driver_internal+0x1af/0x270
Mar  3 21:39:35 wzdell kernel: [ 1270.476231]  bus_remove_device+0xe5/0x150
Mar  3 21:39:35 wzdell kernel: [ 1270.476235]  device_del+0x136/0x350
Mar  3 21:39:35 wzdell kernel: [ 1270.476254]  usb_disable_device+0x93/0x250 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.476271]  usb_disconnect+0xc3/0x270 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.476289]  hub_event+0xc80/0x15a0 [usbcore]
Mar  3 21:39:35 wzdell kernel: [ 1270.476296]  process_one_work+0x1a7/0x3a0
Mar  3 21:39:35 wzdell kernel: [ 1270.476301]  worker_thread+0x30/0x390
Mar  3 21:39:35 wzdell kernel: [ 1270.476306]  ? pwq_unbound_release_workfn+0xd0/0xd0
Mar  3 21:39:35 wzdell kernel: [ 1270.476308]  kthread+0x112/0x130
Mar  3 21:39:35 wzdell kernel: [ 1270.476311]  ? kthread_bind+0x30/0x30
Mar  3 21:39:35 wzdell kernel: [ 1270.476315]  ret_from_fork+0x35/0x40
Mar  3 21:39:35 wzdell kernel: [ 1270.476319] ---[ end trace f558f2f0c6dcf789 ]---
Mar  3 21:39:35 wzdell kernel: [ 1270.483330] general protection fault: 0000 [#1] SMP PTI
Mar  3 21:39:35 wzdell kernel: [ 1270.483446] CPU: 3 PID: 920 Comm: Xorg Tainted: P        W  OE     4.19.0-2-amd64 #1 Debian 4.19.16-1
Mar  3 21:39:35 wzdell kernel: [ 1270.483606] Hardware name: Dell Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
Mar  3 21:39:35 wzdell kernel: [ 1270.483757] RIP: 0010:mutex_lock+0x19/0x30
Mar  3 21:39:35 wzdell kernel: [ 1270.483835] Code: 00 66 66 66 66 90 be 02 00 00 00 e9 41 fb ff ff 90 66 66 66 66 90 53 48 89 fb e8 d2 dc ff ff 31 c0 65 48 8b 14 25 40 5c 01 00 <f0> 48 0f b1 13 74 06
48 89 df 5b eb ca 5b c3 0f 1f 84 00 00 00 00
Mar  3 21:39:35 wzdell kernel: [ 1270.484123] RSP: 0018:ffffba82c25f7d78 EFLAGS: 00010246
Mar  3 21:39:35 wzdell kernel: [ 1270.484215] RAX: 0000000000000000 RBX: a0f7807825ab4211 RCX: 0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.484332] RDX: ffff97fd9228ac40 RSI: ffff97fd8de30a18 RDI: a0f7807825ab4211
Mar  3 21:39:35 wzdell kernel: [ 1270.484450] RBP: a0f7807825ab3f81 R08: ffffba82c25f7de0 R09: 0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.484569] R10: ffffba82c25f7eb0 R11: 0000000000000000 R12: ffff97fd8de30a18
Mar  3 21:39:35 wzdell kernel: [ 1270.484685] R13: ffff97fda65f0888 R14: ffffba82c25f7de0 R15: ffffba82c25f7de0
Mar  3 21:39:35 wzdell kernel: [ 1270.484806] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae2c0000(0000) knlGS:0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.484938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  3 21:39:35 wzdell kernel: [ 1270.485034] CR2: 00007f8169eed000 CR3: 0000000416a9e005 CR4: 00000000000606e0
Mar  3 21:39:35 wzdell kernel: [ 1270.485151] Call Trace:
Mar  3 21:39:35 wzdell kernel: [ 1270.485260]  drm_mode_object_unregister+0x1e/0x60 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.485395]  drm_framebuffer_free+0x1b/0x30 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.485510]  drm_fb_release+0x107/0x180 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.485596]  ? unmap_region+0xdd/0x110
Mar  3 21:39:35 wzdell kernel: [ 1270.485704]  drm_file_free.part.5+0x296/0x2e0 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.485825]  drm_release+0xaa/0x120 [drm]
Mar  3 21:39:35 wzdell kernel: [ 1270.485906]  __fput+0xac/0x1e0
Mar  3 21:39:35 wzdell kernel: [ 1270.485972]  task_work_run+0x8a/0xb0
Mar  3 21:39:35 wzdell kernel: [ 1270.486046]  exit_to_usermode_loop+0xeb/0xf0
Mar  3 21:39:35 wzdell kernel: [ 1270.486127]  do_syscall_64+0xfd/0x100
Mar  3 21:39:35 wzdell kernel: [ 1270.486200]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Mar  3 21:39:35 wzdell kernel: [ 1270.486287] RIP: 0033:0x7f57d750f587
Mar  3 21:39:35 wzdell kernel: [ 1270.486357] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f c3 66 0f 1f 44 00 00 53 89 fb 48 83 ec 10 e8 c4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77
2b 89 d7 89 44 24 0c e8 06 fc ff ff 8b 44 24
Mar  3 21:39:35 wzdell kernel: [ 1270.486638] RSP: 002b:00007fff80edf220 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
Mar  3 21:39:35 wzdell kernel: [ 1270.486692] RAX: 0000000000000000 RBX: 0000000000000038 RCX: 00007f57d750f587
Mar  3 21:39:35 wzdell kernel: [ 1270.486742] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000038
Mar  3 21:39:35 wzdell kernel: [ 1270.486792] RBP: 0000555ab4ae91d0 R08: 000000000000052f R09: 0000555ab4731ee0
Mar  3 21:39:35 wzdell kernel: [ 1270.486844] R10: 0000000000000007 R11: 0000000000000293 R12: 0000555ab4b2d410
Mar  3 21:39:35 wzdell kernel: [ 1270.486894] R13: 0000000000000001 R14: 0000555ab4bde1b0 R15: 00007f57d6cfa6f8
Mar  3 21:39:35 wzdell kernel: [ 1270.486946] Modules linked in: udl rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave bnep nft_counter xt_owner xt_state xt_conntrack
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nft_compat nf_tables nfnetlink binfmt_misc uvcvideo arc4 iwldvm mac80211 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb
btrtl btbcm snd_hda_codec_realtek videodev snd_hda_codec_generic btintel media bluetooth nvidia_drm(POE) iwlwifi i915 drbg nvidia_modeset(POE) ansi_cprng intel_rapl x86_pkg_temp_thermal
intel_powerclamp ecdh_generic snd_hda_intel coretemp snd_hda_codec kvm_intel snd_hda_core drm_kms_helper snd_hwdep snd_pcm_oss dell_laptop snd_mixer_oss dell_wmi dell_smbios dcdbas drm snd_pcm kvm
cfg80211 snd_timer snd joydev soundcore serio_raw sparse_keymap pcspkr
Mar  3 21:39:35 wzdell kernel: [ 1270.492348]  mei_me mei i2c_algo_bit rfkill irqbypass iTCO_wdt iTCO_vendor_support wmi_bmof dell_smm_hwmon evdev dell_wmi_descriptor wmi sg intel_cstate intel_uncore
pcc_cpufreq intel_rapl_perf video dell_smo8800 button battery ac nvidia(POE) ipmi_devintf ipmi_msghandler parport_pc ppdev lp parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic
fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod cdrom sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci xhci_hcd ehci_pci libata
ehci_hcd aes_x86_64 realtek crypto_simd usbcore cryptd psmouse scsi_mod glue_helper r8169 i2c_i801 libphy lpc_ich usb_common thermal
Mar  3 21:39:35 wzdell kernel: [ 1270.504652] ---[ end trace f558f2f0c6dcf78a ]---
Mar  3 21:39:35 wzdell kernel: [ 1270.506267] RIP: 0010:mutex_lock+0x19/0x30
Mar  3 21:39:35 wzdell kernel: [ 1270.507862] Code: 00 66 66 66 66 90 be 02 00 00 00 e9 41 fb ff ff 90 66 66 66 66 90 53 48 89 fb e8 d2 dc ff ff 31 c0 65 48 8b 14 25 40 5c 01 00 <f0> 48 0f b1 13 74 06
48 89 df 5b eb ca 5b c3 0f 1f 84 00 00 00 00
Mar  3 21:39:35 wzdell kernel: [ 1270.511338] RSP: 0018:ffffba82c25f7d78 EFLAGS: 00010246
Mar  3 21:39:35 wzdell kernel: [ 1270.513025] RAX: 0000000000000000 RBX: a0f7807825ab4211 RCX: 0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.514752] RDX: ffff97fd9228ac40 RSI: ffff97fd8de30a18 RDI: a0f7807825ab4211
Mar  3 21:39:35 wzdell kernel: [ 1270.516495] RBP: a0f7807825ab3f81 R08: ffffba82c25f7de0 R09: 0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.518108] R10: ffffba82c25f7eb0 R11: 0000000000000000 R12: ffff97fd8de30a18
Mar  3 21:39:35 wzdell kernel: [ 1270.519742] R13: ffff97fda65f0888 R14: ffffba82c25f7de0 R15: ffffba82c25f7de0
Mar  3 21:39:35 wzdell kernel: [ 1270.521560] FS:  00007f57d6cfaa80(0000) GS:ffff97fdae2c0000(0000) knlGS:0000000000000000
Mar  3 21:39:35 wzdell kernel: [ 1270.523286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  3 21:39:35 wzdell kernel: [ 1270.524964] CR2: 00007f8169eed000 CR3: 0000000416a9e005 CR4: 00000000000606e0
