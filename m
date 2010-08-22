From: "P. Christeas" <p_christ@hol.gr>
Date: Sun, 22 Aug 2010 14:14:20 +0000
Subject: PROBLEM: 2.6.36-rc1+ random i915 drm freezes, one oops
Message-Id: <201008221714.21500.p_christ@hol.gr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_9CTcMiziXuyZwhh"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--Boundary-00=_9CTcMiziXuyZwhh
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, 
I have been experiencing frequent (~1/day) freezes of by box (Acer Travelmate 
5720, intel GM965/GL960), with 2.6.36-rc1+ (vanilla, Linus' tree from git). I 
could only manage to capture one oops at one of the freezes, and traced it 
back to the i915 driver (I guess).

Can this trace help you at all? Is there a known issue or some steps I could 
take to help you tackle it? A git I could pull experimental i915 code to test 
from?

Please CC: me.

Userspace: Mandriva 2010.1, X 1.7.7, kde 4.4.3 (sucks, many display 
artifacts).

Thanks




-- 
Say NO to spam and viruses. Stop using Microsoft Windows!

--Boundary-00=_9CTcMiziXuyZwhh
Content-Type: text/plain;
  charset="us-ascii";
  name="syslog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syslog"

general protection fault: 0000 [#1] SMP=20
last sysfs file: /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:27/=
PNP0C09:00/PNP0C0A:00/power_supply/BAT0/charge_full
CPU 0=20
Modules linked in: iwlagn nls_utf8 isofs sit tunnel4 usb_storage tun snd_us=
b_audio usbhid snd_usbmidi_lib snd_rawmidi hid fuse af_packet nfsd exportfs=
 nfs lockd fscache nfs_acl auth_rpcgss sunrpc autofs4 i915 drm_kms_helper d=
rm i2c_algo_bit coretemp ipv6 binfmt_misc loop dm_mirror dm_region_hash dm_=
log dm_mod cpufreq_ondemand cpufreq_conservative cpufreq_powersave acpi_cpu=
freq freq_table mperf tifm_sd mmc_block tifm_7xx1 tifm_core nvram snd_hda_c=
odec_realtek arc4 ecb snd_hda_intel snd_hda_codec snd_hwdep btusb snd_seq_d=
ummy bluetooth iwlcore mac80211 snd_seq_oss pcmcia joydev sg evdev cfg80211=
 sr_mod snd_seq_midi_event snd_seq sdhci_pci nsc_ircc sdhci snd_seq_device =
irda mmc_core snd_pcm_oss snd_pcm crc_ccitt acer_wmi rfkill snd_timer snd_m=
ixer_oss yenta_socket snd led_class tg3 i2c_i801 video pcmcia_rsrc pcmcia_c=
ore wmi rtc_cmos i2c_core serio_raw soundcore libphy processor button ehci_=
hcd output thermal iTCO_wdt iTCO_vendor_support battery container ac snd_pa=
ge_alloc uhci_hcd usb
core sbp2 ohci1394 ieee1394 ata_piix ahci libahci libata sd_mod scsi_mod cr=
c_t10dif ext3 jbd [last unloaded: iwlagn]
Aug 22 11:23:20 xorhgos3 kernel:
Pid: 1899, comm: X Not tainted 2.6.36-rc1+ #3 Columbia                     =
  /TravelMate 5720               =20
RIP: 0010:[<ffffffffa068eea1>]  [<ffffffffa068eea1>] drm_clflush_pages+0x74=
/0xc7 [drm]
RSP: 0018:ffff8800be03dcc8  EFLAGS: 00010287
RAX: db513f0d56012000 RBX: 6db6db6db6db6db7 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 000ffff8800bac9b RDI: ffff8800aead0ee8
RBP: ffff8800be03dcd8 R08: ffff8800be03c000 R09: ffff8800be03c000
R10: db513f0d56012000 R11: ffff880000000000 R12: 0000160000000000
R13: 0000000000000001 R14: 0000000000000044 R15: 0000000000000000
=46S:  00007f19dd9f4840(0000) GS:ffff880001a00000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd73cc9c920 CR3: 00000000bdfd6000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process X (pid: 1899, threadinfo ffff8800be03c000, task ffff8800be0bb570)
Stack:
ffff880073b90c00 ffff880073b90c00 ffff8800be03dcf8 ffffffffa06bed47
<0> ffff880073b90c00 0000000000000000 ffff8800be03dd38 ffffffffa06c05f8
<0> ffff8800be03dd38 0000000000000001 ffff8800be534000 ffff8800be7f6000
Call Trace:
[<ffffffffa06bed47>] i915_gem_clflush_object+0x52/0x57 [i915]
[<ffffffffa06c05f8>] i915_gem_object_set_to_cpu_domain+0xbc/0xfb [i915]
[<ffffffffa06c0767>] i915_gem_set_domain_ioctl+0x130/0x15d [i915]
[<ffffffffa0690399>] drm_ioctl+0x250/0x347 [drm]
[<ffffffffa06c0637>] ? i915_gem_set_domain_ioctl+0x0/0x15d [i915]
[<ffffffff810ec8e6>] do_vfs_ioctl+0x4ac/0x4fb
[<ffffffff810df6d5>] ? fsnotify_access+0x61/0x69
[<ffffffff810ec986>] sys_ioctl+0x51/0x74
[<ffffffff8100ad0d>] ? do_device_not_available+0x9/0xb
[<ffffffff81009a82>] system_call_fastpath+0x16/0x1b
Code: c1 eb 46 48 8b 04 d7 48 85 c0 74 3a 41 ff 40 1c 31 c9 4c 01 e0 48 c1 =
f8 03 48 0f af c3 48 c1 e0 0c 4c 01 d8 41 89 ca 4e 8d 14 10 <41> 0f ae 3a 4=
4 0f b7 15 41 28 04 e1 44 01 d1 81 f9 ff 0f 00 00=20
RIP  [<ffffffffa068eea1>] drm_clflush_pages+0x74/0xc7 [drm]
RSP <ffff8800be03dcc8>
BUG: scheduling while atomic: X/1899/0x00000001
Modules linked in: iwlagn nls_utf8 isofs sit tunnel4 usb_storage tun snd_us=
b_audio usbhid snd_usbmidi_lib snd_rawmidi hid fuse af_packet nfsd exportfs=
 nfs lockd fscache nfs_acl auth_rpcgss sunrpc autofs4 i915 drm_kms_helper d=
rm i2c_algo_bit coretemp ipv6 binfmt_misc loop dm_mirror dm_region_hash dm_=
log dm_mod cpufreq_ondemand cpufreq_conservative cpufreq_powersave acpi_cpu=
freq freq_table mperf tifm_sd mmc_block tifm_7xx1 tifm_core nvram snd_hda_c=
odec_realtek arc4 ecb snd_hda_intel snd_hda_codec snd_hwdep btusb snd_seq_d=
ummy bluetooth iwlcore mac80211 snd_seq_oss pcmcia joydev sg evdev cfg80211=
 sr_mod snd_seq_midi_event snd_seq sdhci_pci nsc_ircc sdhci snd_seq_device =
irda mmc_core snd_pcm_oss snd_pcm crc_ccitt acer_wmi rfkill snd_timer snd_m=
ixer_oss yenta_socket snd led_class tg3 i2c_i801 video pcmcia_rsrc pcmcia_c=
ore wmi rtc_cmos i2c_core serio_raw soundcore libphy processor button ehci_=
hcd output thermal iTCO_wdt iTCO_vendor_support battery container ac snd_pa=
ge_alloc uhci_hcd usb
core sbp2 ohci1394 ieee1394 ata_piix ahci libahci libata sd_mod scsi_mod cr=
c_t10dif ext3 jbd [last unloaded: iwlagn]
Pid: 1899, comm: X Not tainted 2.6.36-rc1+ #3
Call Trace:
[<ffffffff8103f0bf>] __schedule_bug+0x5c/0x61
[<ffffffff812f0301>] schedule+0xdb/0x5e9
[<ffffffff812f0fa3>] __mutex_lock_common+0x12b/0x190
[<ffffffff812f101c>] __mutex_lock_slowpath+0x14/0x16
[<ffffffff812f10ea>] mutex_lock+0x1e/0x38
[<ffffffff811840f8>] ? vsnprintf+0x3ee/0x42a
[<ffffffffa06ccc85>] intel_pipe_set_base+0x10a/0x3bf [i915]
[<ffffffffa00f96a7>] drm_crtc_helper_set_config+0x675/0x7be [drm_kms_helper]
[<ffffffffa00f6a48>] drm_fb_helper_pan_display+0x68/0xa0 [drm_kms_helper]
[<ffffffff811a78c2>] fb_pan_display+0xb7/0xf8
[<ffffffff811b517e>] bit_update_start+0x1b/0x3e
[<ffffffff811b2349>] fbcon_switch+0x46a/0x46f
[<ffffffff812013ab>] redraw_screen+0xd0/0x192
[<ffffffff811b1e5e>] fbcon_blank+0x1c8/0x249
[<ffffffff81045a90>] ? release_console_sem+0x18c/0x1bd
[<ffffffff810512b9>] ? lock_timer_base+0x27/0x4d
[<ffffffff81051290>] ? spin_unlock_irqrestore+0x9/0xb
[<ffffffff810513fa>] ? __mod_timer+0x11b/0x12d
[<ffffffff81201c14>] do_unblank_screen+0xf5/0x15f
[<ffffffff81201c89>] unblank_screen+0xb/0xd
[<ffffffff81185f71>] bust_spinlocks+0x15/0x34
[<ffffffff8100d8b6>] oops_end+0x3c/0xc1
[<ffffffff8100db12>] die+0x55/0x5e
[<ffffffff8100b863>] do_general_protection+0x130/0x138
[<ffffffff812f2265>] general_protection+0x25/0x30
[<ffffffffa068eea1>] ? drm_clflush_pages+0x74/0xc7 [drm]
[<ffffffffa06bed47>] i915_gem_clflush_object+0x52/0x57 [i915]
[<ffffffffa06c05f8>] i915_gem_object_set_to_cpu_domain+0xbc/0xfb [i915]
[<ffffffffa06c0767>] i915_gem_set_domain_ioctl+0x130/0x15d [i915]
[<ffffffffa0690399>] drm_ioctl+0x250/0x347 [drm]
[<ffffffffa06c0637>] ? i915_gem_set_domain_ioctl+0x0/0x15d [i915]
[<ffffffff810ec8e6>] do_vfs_ioctl+0x4ac/0x4fb
[<ffffffff810df6d5>] ? fsnotify_access+0x61/0x69
[<ffffffff810ec986>] sys_ioctl+0x51/0x74
[<ffffffff8100ad0d>] ? do_device_not_available+0x9/0xb
[<ffffffff81009a82>] system_call_fastpath+0x16/0x1b


--Boundary-00=_9CTcMiziXuyZwhh--
