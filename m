From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 0/10] ps3av/fb drivers for 2.6.21
Date: Thu, 8 Feb 2007 14:56:21 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HF9lK-0001Ym-Mj for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 05:56:35 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HF9lJ-0002a5-6p
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 05:56:34 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

	Hi Andrew,

This is the third submission of the PS3 AV Settings Driver and the PS3 Virtual
Frame Buffer Driver.

Patch summaries:
[PATCH 1/10] ps3: Add shutdown to virtual uart port driver framework
[PATCH 2/10] ps3: AV Settings Driver
[PATCH 3/10] fbdev modedb: allow refresh rates for named video modes
[PATCH 4/10] fbdev modedb: make more pointer parameters const
[PATCH 5/10] fb_videomode_to_var: reset virtual screen parameters
[PATCH 6/10] ps3: Preallocate bootmem memory for ps3fb
[PATCH 7/10] ps3: Virtual Frame Buffer Driver
[PATCH 8/10] ps3: disable display flipping during mode changes
[PATCH 9/10] ps3: cleanup ps3fb before clearing HPTE
[PATCH 10/10] ps3: ps3av/fb defconfig updates

All patches apply to current linux-2.6.git.

Note that the first 3 frame buffer-specific patches are not PS3-specific:
  - Without patch 3 you cannot select all available video modes through the
    kernel command line,
  - Patch 4 is just a cleanup while I was working on the code,
  - Without patch 5 you cannot use the ps3videomode command line tool or
    /sys/class/graphics/fb0/mode to switch to a video mode with a lower
    resolution.

Please apply, so we can have this in 2.6.21. Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
