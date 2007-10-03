From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: fb_ops.fp_pan_display() and locking
Date: Wed, 3 Oct 2007 18:47:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0710031733580.25940@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1037810928-1191430071=:25940"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Id7OI-0004o2-UW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 09:48:07 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Id7OH-0004Hi-ET
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 09:48:06 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Imre Deak <imre.deak@nokia.com>, Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1037810928-1191430071=:25940
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Unlike the other fb_ops, .fp_pan_display() may be called from interrupt
context.  This can happen when calling printk() from an interrupt handler=
,
while accelerating text console scrolling by using a virtual screen.

Hence one cannot use a mutex to provide locking in .fp_pan_display(), or
something like this happens (assumed CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy):

| BUG: sleeping function called from invalid context at linux/kernel/mute=
x.c:86
| in_atomic():1, irqs_disabled():1
| Call Trace:
| [c000000005f4b430] [c00000000000effc] .show_stack+0x68/0x1b0 (unreliabl=
e)
| [c000000005f4b4d0] [c000000000046ed8] .__might_sleep+0xec/0x108
| [c000000005f4b550] [c0000000003a3ce4] .mutex_lock+0x28/0x48
| [c000000005f4b5e0] [c0000000001fb1e8] .xxxfb_pan_display+0x34/0x88
| [c000000005f4b680] [c0000000001e6e10] .fb_pan_display+0x120/0x180
| [c000000005f4b710] [c0000000001f43b4] .bit_update_start+0x28/0x60
| [c000000005f4b7a0] [c0000000001f238c] .fbcon_scroll+0x6a0/0xeb8
| [c000000005f4b870] [c000000000213524] .scrup+0xa0/0x14c
| [c000000005f4b910] [c000000000213610] .lf+0x40/0x9c
| [c000000005f4b990] [c000000000218d00] .vt_console_print+0x214/0x3c8
| [c000000005f4ba40] [c00000000004f150] .__call_console_drivers+0xc8/0xf8
| [c000000005f4bad0] [c00000000004f604] .release_console_sem+0x19c/0x2bc
| [c000000005f4bb80] [c00000000004ff78] .vprintk+0x338/0x3f4
| [c000000005f4bc60] [c00000000005006c] .printk+0x38/0x48
| [c000000005f4bcf0] [c000000000053d38] .do_exit+0x3f0/0x96c
| [c000000005f4bda0] [c000000000054368] .sys_exit_group+0x0/0x8
| [c000000005f4be30] [c000000000008834] syscall_exit+0x0/0x40

Omapfb and vmlfb use a mutex in .fp_pan_display().

Probably nobody noticed this problem yet because the mere presence of a
virtual screen and panning support is not sufficient to enable panning fo=
r
accelerating text console scrolling.  One has to explicitly set
FBINFO_HWACCEL_YPAN in fb_info.flags, too, which both omapfb and vmlfb
don't do (yet).

With kind regards,
=20
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium
=20
Phone:    +32 (0)2 700 8453=09
Fax:      +32 (0)2 700 8622=09
E-mail:   Geert.Uytterhoeven@sonycom.com=09
Internet: http://www.sony-europe.com/
 =09
Sony Network and Software Technology Center Europe=09
A division of Sony Service Centre (Europe) N.V.=09
Registered office: Technologielaan 7 =C2=B7 B-1840 Londerzeel =C2=B7 Belg=
ium=09
VAT BE 0413.825.160 =C2=B7 RPR Brussels=09
Fortis Bank Zaventem =C2=B7 Swift GEBABEBB08A =C2=B7 IBAN BE3900138235861=
9
---584337861-1037810928-1191430071=:25940
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
---584337861-1037810928-1191430071=:25940
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1037810928-1191430071=:25940--
