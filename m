From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: vesafb and *fb
Date: Wed, 21 Apr 2004 09:51:41 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404210949590.7657@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGCWI-00052N-1o
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 00:51:46 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BGCWH-0006i8-G7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 00:51:45 -0700
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i3L7pfxt005447
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Apr 2004 09:51:41 +0200 (MEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


Yesterday I noticed on a box at work that if you compile in both vesafb and
atyfb (the box has an ATI 3D RAGE PRO), you get both fb0 (atyfb) and fb1
(vesafb). That's not supposed to happen.

Vesafb did print that the frame buffer was already in use, but it just
continued, cfr. this code:

    if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
	    printk(KERN_WARNING
		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
		    vesafb_fix.smem_start);
	    /* We cannot make this fatal. Sometimes this comes from magic
	       spaces our resource handlers simply don't know about */
    }

That was on plain 2.6.5. But to my surprise the latest 2.4 behaves the same.
This seems to have been changed in 2.4.15.
Does anyone know why this was changed?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
