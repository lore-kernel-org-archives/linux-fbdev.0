From: Greg Stark <gsstark@mit.edu>
Subject: Re: Fw: atyfb doesn't work for me
Date: 04 Apr 2006 19:19:51 -0400
Message-ID: <87vetp9be0.fsf@stark.xeocode.com>
References: <20060404030318.3c80b12a.akpm@osdl.org>
	<20060404151655.GA28811@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQuof-0003wn-3i
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 16:20:05 -0700
Received: from stark.xeocode.com ([216.58.44.227])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FQuoc-0005Zb-9f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 16:20:05 -0700
In-Reply-To: <20060404151655.GA28811@sci.fi>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net, Greg Stark <gsstark@mit.edu>

Ville Syrj=E4l=E4 <syrjala@sci.fi> writes:

> Unfortunately atyfb relies on the BIOS to initialize the card. You seem=
=20
> to have multiple cards in your system which won't work.

Incidentally, trying to remove the atyfb device when it's in this state
appears to generate an OOPS:

Apr  4 17:46:55 stark kernel: [78869.693237] Unable to handle kernel NULL=
 pointer dereference at virtual address 0000030c
Apr  4 17:46:55 stark kernel: [78869.693246]  printing eip:
Apr  4 17:46:55 stark kernel: [78869.693250] f8861fed
Apr  4 17:46:55 stark kernel: [78869.693259] *pde =3D 00000000
Apr  4 17:46:55 stark kernel: [78869.693274] Oops: 0000 [#1]
Apr  4 17:46:55 stark kernel: [78869.693287] PREEMPT SMP=20
Apr  4 17:46:55 stark kernel: [78869.693302] Modules linked in: binfmt_mi=
sc lirc_dev sg ipv6 cx88_dvb cx88_vp3054_i2c mt352 or51132 video_buf_dvb =
dvb_core crc32 nxt200x cx24123 lgdt330x cx22702 dvb_pll cx88_blackbird cx=
8802 cx8800 cx88xx bttv video_buf compat_ioctl32 i2c_algo_bit btcx_risc i=
r_common usb_storage snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd=
_timer snd_page_alloc hw_random ehci_hcd uhci_hcd usbcore 8250 serial_cor=
e parport_pc lp parport w83627hf hwmon_vid eeprom i2c_isa i2c_i801 ivtv_f=
b msp3400 saa7127 saa7115 tda9887 tuner v4l2_common ivtv firmware_class v=
4l1_compat tveeprom i2c_core videodev atyfb fb cfbcopyarea cfbimgblt cfbf=
illrect gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd intel_agp=
 agpgart sk98lin rtc
Apr  4 17:46:55 stark kernel: [78869.693466] CPU:    1
Apr  4 17:46:55 stark kernel: [78869.693467] EIP:    0060:[pg0+943517677/=
1068938240]    Tainted: GF     VLI
Apr  4 17:46:55 stark kernel: [78869.693469] EFLAGS: 00010206   (2.6.16-f=
b #1)=20
Apr  4 17:46:55 stark kernel: [78869.693483] EIP is at aty_set_crtc+0xa/0=
x68 [atyfb]
Apr  4 17:46:55 stark kernel: [78869.693488] eax: 00000000   ebx: 0400000=
0   ecx: 00000001   edx: f88687c0
Apr  4 17:46:55 stark kernel: [78869.693494] esi: f4ff6000   edi: f8867d4=
c   ebp: f8867d9c   esp: e0135ef0
Apr  4 17:46:55 stark kernel: [78869.693499] ds: 007b   es: 007b   ss: 00=
68
Apr  4 17:46:55 stark kernel: [78869.693504] Process rmmod (pid: 10452, t=
hreadinfo=3De0134000 task=3Dc1bbca70)
Apr  4 17:46:55 stark kernel: [78869.693508] Stack: <0>00000000 f8862065 =
c1b5ac00 c1b5ac48 c0214732 c1b5acd0 c024b57c c1b5ac48=20
Apr  4 17:46:55 stark kernel: [78869.693525]        c1b5ac88 f8867d4c c02=
4b830 f8867da4 c03a07a0 f8867d4c c03a07a0 e0134000=20
Apr  4 17:46:55 stark kernel: [78869.693541]        c024b10a f8867d4c f88=
68480 e0134000 c024bae9 f8867d20 c0214678 f8864f24=20
Apr  4 17:46:55 stark kernel: [78869.693556] Call Trace:
Apr  4 17:46:55 stark kernel: [78869.693564]  [pg0+943517797/1068938240] =
atyfb_pci_remove+0x1a/0xc8 [atyfb]
Apr  4 17:46:55 stark kernel: [78869.693579]  [pci_device_remove+22/40] p=
ci_device_remove+0x16/0x28
Apr  4 17:46:55 stark kernel: [78869.693592]  [__device_release_driver+82=
/119] __device_release_driver+0x52/0x77
Apr  4 17:46:55 stark kernel: [78869.693608]  [driver_detach+163/165] dri=
ver_detach+0xa3/0xa5
Apr  4 17:46:55 stark kernel: [78869.693625]  [bus_remove_driver+97/127] =
bus_remove_driver+0x61/0x7f
Apr  4 17:46:55 stark kernel: [78869.693639]  [driver_unregister+8/19] dr=
iver_unregister+0x8/0x13
Apr  4 17:46:55 stark kernel: [78869.693649]  [pci_unregister_driver+14/1=
02] pci_unregister_driver+0xe/0x66
Apr  4 17:46:55 stark kernel: [78869.693658]  [pg0+943529764/1068938240] =
atyfb_exit+0x0/0xa [atyfb]
Apr  4 17:46:55 stark kernel: [78869.693675]  [sys_delete_module+311/427]=
 sys_delete_module+0x137/0x1ab
Apr  4 17:46:55 stark kernel: [78869.693689]  [remove_vma+49/54] remove_v=
ma+0x31/0x36
Apr  4 17:46:55 stark kernel: [78869.693702]  [do_munmap+375/462] do_munm=
ap+0x177/0x1ce
Apr  4 17:46:55 stark kernel: [78869.693740]  [syscall_call+7/11] syscall=
_call+0x7/0xb
Apr  4 17:46:55 stark kernel: [78869.693783] Code: 81 ca 44 00 00 04 89 5=
1 1c eb e5 81 ca 48 00 00 04 89 51 1c eb da 81 ca 40 00 00 04 89 51 1c eb=
 cf 53 8b 5a 2c 81 e3 ff ff ff fd <8b> 88 0c 03 00 00 89 59 1c 8b 5a 14 8=
b 88 0c 03 00 00 89 19 8b=20



--=20
greg



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
