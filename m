From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: 2.6.20: Modular fb and logo crash
Date: Wed, 7 Feb 2007 15:46:21 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702071521340.29060@pademelon.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161336AbXBGOqc@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>

If you don't have any builtin frame buffer device driver and insmod a frame
buffer device driver, the logo code will still try to display the logo (which
is __initdata). This may cause a crash.

Originally (2.1.x, is it that long ago I used a modular frame buffer device
driver?), this didn't happen because initmem_freed (which no longer exists) was
checked. BTW, there's still a comment in drivers/video/console/fbcon.c about
this.

Anyone else who's seeing this? Anyone with an idea how to fix this?
Moving the logo code to userspace is not considered a solution ;-)

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
