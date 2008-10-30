From: devzero@web.de
Subject: Problem with viafb module. Bug ?
Date: Thu, 30 Oct 2008 23:10:25 +0100
Message-ID: <489355931@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <devzero@web.de>) id 1Kvfio-00025Z-11
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 22:10:30 +0000
Received: from fmmailgate05.web.de ([217.72.192.243])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kvfil-0005n1-P1 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 22:10:29 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: JosephChan@via.com.tw, ScottFang@viatech.com.cn
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi !

during module regression test (just some stupid load/unload testing) on 2.6=
.28-rc2-git3-default, i have come across an issue which i assume is caused =
by viafb.

after a while of testing, i was getting weird oopses, mostly for duplicate =
sysfs entries with i2c-core.
another oops is below - it happened on loading tvp5150. (just an example)
the oops never happen if i never load (i.e. modprobe) viafb before.
after excluding viafb from my modules list, i see no oopses or sysfs regist=
ration problems anymore.

furthermore, viafb module-init lasts around 10 seconds on my system (vmware=
 virtual machine) - 10 seconds to detect that there is no
via graphics hardware present looks weird to me, too. =

almost every other linux kernel module is much quicker with detecting that =
the appropriate hardware is missing.

maybe it`s worth taking a look at that ?

regards
Roland Kletzing


Oct 30 21:17:54 opensuse103 kernel: BUG: unable to handle kernel NULL point=
er dereference at 00000001
Oct 30 21:17:54 opensuse103 kernel: IP: [<f09ac2be>] 0xf09ac2be
Oct 30 21:17:54 opensuse103 kernel: *pde =3D 00000000
Oct 30 21:17:54 opensuse103 kernel: Oops: 0002 [#1] SMP
Oct 30 21:17:54 opensuse103 kernel: last sysfs file: /sys/firmware/edd/int1=
3_dev80/extensions
Oct 30 21:17:54 opensuse103 kernel: Modules linked in: tvp5150(+) viafb(+) =
ovcamchip ov7670 v4l2_common dvb_usb_af9005_remote fb i2c_algo_bit cfbcopya=
rea cfbimgblt cfbfillrect iptable_filter ip_tables ip6table_filter ip6_tabl=
es x_tables ipv6 af_packet microcode firmware_class fuse loop dm_mod ide_cd=
_mod cdrom pata_acpi ata_piix mousedev ahci ata_generic serio_raw libata ps=
mouse ppdev 8250_pnp ide_pci_generic 8250 shpchp rtc_cmos intel_agp parport=
_pc piix i2c_piix4 pcnet32 pci_hotplug rtc_core agpgart pcspkr parport mii =
evdev serial_core ide_core container button ac i2c_core rtc_lib floppy uhci=
_hcd usbcore edd ext3 mbcache jbd fan mptsas scsi_transport_sas mptfc scsi_=
transport_fc scsi_tgt mptspi mptscsih mptbase scsi_transport_spi sd_mod crc=
_t10dif sg scsi_mod thermal processor thermal_sys [last unloaded: cs53l32a]
Oct 30 21:17:54 opensuse103 kernel:
Oct 30 21:17:54 opensuse103 kernel: Pid: 5533, comm: modprobe Tainted: G   =
     W  (2.6.28-rc2-git3-default #4) VMware Virtual Platform
Oct 30 21:17:54 opensuse103 kernel: EIP: 0060:[<f09ac2be>] EFLAGS: 00010286=
 CPU: 0
Oct 30 21:17:54 opensuse103 kernel: EIP is at 0xf09ac2be
Oct 30 21:17:54 opensuse103 kernel: EAX: ee8bf370 EBX: ee8bf554 ECX: 000000=
01 EDX: 00000000
Oct 30 21:17:54 opensuse103 kernel: ESI: ee8bf378 EDI: 00000001 EBP: efbcfe=
10 ESP: efbcfd48
Oct 30 21:17:54 opensuse103 kernel:  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS=
: 0068
Oct 30 21:17:54 opensuse103 kernel: Process modprobe (pid: 5533, ti=3Defbce=
000 task=3Def8a70b0 task.ti=3Defbce000)
Oct 30 21:17:54 opensuse103 kernel: Stack:
Oct 30 21:17:54 opensuse103 kernel:  f087c010 efbcfe14 f087c457 c03be780 c1=
609780 082c17d3 00000e61 c0137c21
Oct 30 21:17:54 opensuse103 kernel:  00000000 00000000 ffffffe1 00000001 ee=
8bf374 00000001 ee8bf554 00000096
Oct 30 21:17:54 opensuse103 kernel:  c029ba4b c011cf66 ee88fc3c edbb53f0 f0=
87c86c ee8bf374 00000001 efbcfe10
Oct 30 21:17:54 opensuse103 kernel: Call Trace:
Oct 30 21:17:54 opensuse103 kernel:  [<f087c010>] i2c_start+0xa/0x2c [i2c_a=
lgo_bit]
Oct 30 21:17:54 opensuse103 kernel:  [<f087c457>] bit_xfer+0x20/0x3f8 [i2c_=
algo_bit]
Oct 30 21:17:54 opensuse103 kernel:  [<c0137c21>] sched_clock_cpu+0x109/0x1=
16
Oct 30 21:17:54 opensuse103 kernel:  [<c029ba4b>] _spin_lock+0x5/0x7
Oct 30 21:17:54 opensuse103 kernel:  [<c011cf66>] task_rq_lock+0x3b/0x61
Oct 30 21:17:54 opensuse103 kernel:  [<f163e325>] i2c_transfer+0x5c/0x6d [i=
2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<f163e6d5>] i2c_smbus_xfer+0x39f/0x49=
6 [i2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<c011cea5>] __wake_up+0x29/0x39
Oct 30 21:17:54 opensuse103 kernel:  [<c02502b8>] netlink_broadcast+0x275/0=
x2b6
Oct 30 21:17:54 opensuse103 kernel:  [<c029ba4b>] _spin_lock+0x5/0x7
Oct 30 21:17:54 opensuse103 kernel:  [<c028fc2d>] klist_next+0x62/0x79
Oct 30 21:17:54 opensuse103 kernel:  [<f163e9d6>] i2c_probe_address+0x5f/0x=
c5 [i2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<f163f96b>] i2c_probe+0x123/0x130 [i2=
c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<f1cd89ae>] tvp5150_detect_client+0x0=
/0x107 [tvp5150]
Oct 30 21:17:54 opensuse103 kernel:  [<f1cd89ae>] tvp5150_detect_client+0x0=
/0x107 [tvp5150]
Oct 30 21:17:54 opensuse103 kernel:  [<f163f1ca>] __attach_adapter+0x19/0x1=
e [i2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<c022004f>] class_for_each_device+0x5=
1/0x72
Oct 30 21:17:54 opensuse103 kernel:  [<f163edb6>] i2c_register_driver+0x9c/=
0xb9 [i2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<f163f1b1>] __attach_adapter+0x0/0x1e=
 [i2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<f0dc3000>] tvp5150_init+0x0/0xf [tvp=
5150]
Oct 30 21:17:54 opensuse103 kernel:  [<c010113d>] _stext+0x4d/0x148
Oct 30 21:17:54 opensuse103 kernel:  [<c0142936>] load_module+0x12cd/0x142e
Oct 30 21:17:54 opensuse103 kernel:  [<f163ea81>] i2c_master_send+0x0/0x42 =
[i2c_core]
Oct 30 21:17:54 opensuse103 kernel:  [<c0142b1e>] sys_init_module+0x87/0x176
Oct 30 21:17:54 opensuse103 kernel:  [<c01039eb>] sysenter_do_call+0x12/0x2f
Oct 30 21:17:54 opensuse103 kernel: Code: 6c 3d 25 64 0a 00 3c 33 3e 25 73 =
2f 25 64 3a 20 43 61 6e 27 74 20 67 65 74 20 4d 4d 49 4f 20 6d 65 6d 6f 72 =
79 20 40 20 30 78 25 <6c> 6c 78 2c 20 73 75 62 73 79 73 74 65 6d 3a 20 25 3=
0 34 78 3a
Oct 30 21:17:54 opensuse103 kernel: EIP: [<f09ac2be>] 0xf09ac2be SS:ESP 006=
8:efbcfd48
Oct 30 21:17:54 opensuse103 kernel: ---[ end trace 4eaa2a86a8e2da22 ]---
____________________________________________________________________
sssst! Schon vom neuen WEB.DE MultiMessenger geh=F6rt? =

Der kann`s mit allen: http://www.produkte.web.de/messenger/?did=3D3123


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
