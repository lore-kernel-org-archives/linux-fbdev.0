From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: BUG: fb_imageblit called before fb_check_var
 and fb_set_par function
Date: Fri, 26 Aug 2005 10:23:26 +0200
Message-ID: <430ED17E.6000504@t-online.de>
References: <430DB8E6.8000204@t-online.de> <430DD026.2070303@gmail.com> <430DEAD0.8070403@t-online.de> <430E094A.9030603@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8ZSI-0002FT-LW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 01:20:54 -0700
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8ZSH-000712-VS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Aug 2005 01:20:54 -0700
In-Reply-To: <430E094A.9030603@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org

Hi Antonio,

> Perhaps, if you have the time, you can instrument it better so we can=20
> pinpoint
> where this unwanted calls are coming from.  Months were spent trying=20
> to fix this
> problem, mainly by BenH, and I don't want any stones left unturned.=20

So lets conclude: The problem is _not_ fixed and still present in=20
2.6.13-rc7.
I added BenH and Andrew Morton to the cc-list.

I added a printk at the start of redraw_screen() and a show_trace() in=20
cyblafb_sync().

Imho
   - there is a bug of the trident driver in X that should _never_=20
disable mmio for
     the cyberblade core if it is started with mmio enabled.  A bug Alan=20
Hourihane
     should fix.
  - there also is a serious kernel bug as no drawing function must be cal=
led
     prior to setting up the framebuffer driver by executing the=20
set_par() call.

I=B4m happy to have learned enough about the low -level framebuffer layer=
,
but I=B4m definitely not qualified to do fixed in char/vt.c,=20
char/vt_ioctl.c etc.

Read some shortened dmesg logs:
(cyblafb: Switching ... marks the start of the fb_set_par function)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
First log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1-init to runlevel 3
2-login as root on tty1
3-init 5
4-switching back to tty1 with ctrl-alt-f1

...
Detected 533.506 MHz processor.
Using tsc for high-res timesource
redraw_screen: called with is_switch 0 and vc->vc_mode 0
Console: colour dummy device 80x25
...
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
...
cyblafb: CyblaFB version 0.53 initializing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level,=20
low) -> IRQ 11
cyblafb: framebuffer size =3D 8192 Kb
cyblafb: detected startup mode: fbset -g 1280 1024 1280 ??? 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
cyblafb: Switching to new mode: fbset -g 1280 1024 1280 2662 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
redraw_screen: called with is_switch 0 and vc->vc_mode 0
Console: switching to colour frame buffer device 160x64
...
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 12 (level,=20
low) -> IRQ 12
PCI: Setting latency timer of device 0000:00:11.5 to 64
redraw_screen: called with is_switch 0 and vc->vc_mode 0
eth0: no IPv6 routers present
redraw_screen: called with is_switch 0 and vc->vc_mode 0
******** Now logged in as root on tty1
redraw_screen: called with is_switch 1 and vc->vc_mode 0
******** X has been started here, we are in xterm. Now ctrl-alt-f1:
redraw_screen: called with is_switch 1 and vc->vc_mode 0
cyblafb: Switching to new mode: fbset -g 1280 1024 1280 2662 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
******** We switched back to tty1

As you can see, redraw_screen is called prior to cyblafb_setpar, but=20
nothing bad is
triggered because the X trident buffer does not disable mmio.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Second log:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1-init to runlevel 5
2-switching to tty1 with ctrl-alt-f1

...
Detected 533.508 MHz processor.
Using tsc for high-res timesource
redraw_screen: called with is_switch 0 and vc->vc_mode 0
Console: colour dummy device 80x25
...
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
...
cyblafb: CyblaFB version 0.53 initializing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level,=20
low) -> IRQ 11
cyblafb: framebuffer size =3D 8192 Kb
cyblafb: detected startup mode: fbset -g 1280 1024 1280 ??? 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
cyblafb: Switching to new mode: fbset -g 1280 1024 1280 2662 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
redraw_screen: called with is_switch 0 and vc->vc_mode 0
Console: switching to colour frame buffer device 160x64
...
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 12 (level,=20
low) -> IRQ 12
PCI: Setting latency timer of device 0000:00:11.5 to 64
redraw_screen: called with is_switch 0 and vc->vc_mode 0
eth0: no IPv6 routers present
redraw_screen: called with is_switch 1 and vc->vc_mode 0
******** X has been started here, we are in xterm
******** ctrl-alt-f1
redraw_screen: called with is_switch 1 and vc->vc_mode 0
cyblafb: GRAPHICS ENGINE TIMED OUT!
 [<c0246abd>] cyblafb_imageblit+0xad/0x230
 [<c0241a3b>] bit_putcs+0x2eb/0x560
 [<c01138a5>] __wake_up_common+0x35/0x70
 [<c023dba8>] fbcon_putcs+0x168/0x210
 [<c028c11b>] do_update_region+0x11b/0x180
 [<c028cc13>] redraw_screen+0x143/0x1e0
 [<c0288788>] complete_change_console+0x28/0xd0
 [<c0287cbd>] vt_ioctl+0x111d/0x1aa0
 [<c014886e>] __handle_mm_fault+0x13e/0x180
 [<c011174d>] do_page_fault+0x19d/0x550
 [<c03a7dd7>] schedule+0x337/0x670
 [<c0286ba0>] vt_ioctl+0x0/0x1aa0
 [<c0281fbc>] tty_ioctl+0x17c/0x410
 [<c011364a>] scheduler_tick+0x17a/0x310
 [<c0169d98>] do_ioctl+0x48/0x80
 [<c0169f2a>] vfs_ioctl+0x5a/0x1d0
 [<c016a0e6>] sys_ioctl+0x46/0x60
 [<c0102909>] syscall_call+0x7/0xb
cyblafb: Switching to new mode: fbset -g 1280 1024 1280 2662 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
******** Now logged in as root on tty1
redraw_screen: called with is_switch 1 and vc->vc_mode 1
******** switched to xterm
redraw_screen: called with is_switch 1 and vc->vc_mode 0
cyblafb: Switching to new mode: fbset -g 1280 1024 1280 2662 8 -t 7407=20
232 16 39 0 160 3
redraw_screen: called with is_switch 0 and vc->vc_mode 0
******** switched back to tty1

cu,
 Knut



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
