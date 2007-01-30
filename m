From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 0/10] ps3av/fb drivers for 2.6.21
Date: Tue, 30 Jan 2007 17:57:06 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBwIW-0007GO-OK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 08:57:33 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBwIQ-0000K2-9a
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 08:57:29 -0800
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
To: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi James, Paul,

This is the second submission of the PS3 AV Settings Driver Library and the PS3
Virtual Frame Buffer Driver. I incorporated most (all?) of the very valuable
feedback I received, except for the removal of the long delays (msleep()) in
ps3av, which is still on my todo-list.

To ease the review, I'm sending all patches to both relevant maintainers and
mailing lists.

Summaries:
[PATCH 1/10] ps3: Add shutdown to virtual uart port driver framework
[PATCH 2/10] ps3: AV Settings Driver Library
[PATCH 3/10] fbdev modedb: allow refresh rates for named video modes
[PATCH 4/10] fbdev modedb: make more pointer parameters const
[PATCH 5/10] fb_videomode_to_var: reset virtual screen parameters
[PATCH 6/10] ps3: Preallocate bootmem memory for ps3fb
[PATCH 7/10] ps3: Virtual Frame Buffer Driver
[PATCH 8/10] ps3: disable display flipping during mode changes
[PATCH 9/10] ps3: cleanup ps3fb before clearing HPTE
[PATCH 10/10] ps3: ps3av/fb defconfig updates

PowerPC-specific patches (1, 2, 6, 8, 9 and 10) apply on top of the patches
sent by Geoff Levand to linuxppc-dev recently.
Frame buffer-specific patches (3, 4, 5, and 7) apply on Linus' current tree.

Note that patch 1 is a brand new patch.

Note that the first 3 frame buffer-specific patches are not really
PS3-specific:
  - Without patch 3 you cannot select all available video modes through the
    kernel command line,
  - Patch 4 is just a cleanup while I was working on the code,
  - Without patch 5 you cannot use the ps3videomode command line tool or
    /sys/class/graphics/fb0/mode to switch to a video mode with a lower
    resolution.

Please review. All comments are welcome.
Our goal is to get these drivers integrated into 2.6.21.

Thanks in advance!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
