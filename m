From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Fw: [Bugme-new] [Bug 5441] New: SVGATextMode problem on 2.6.14-rc4
Date: Sat, 15 Oct 2005 01:14:08 +0200
Message-ID: <20051014231408.GK5100@bouh.residence.ens-lyon.fr>
References: <20051014103144.16a7bb65.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQYkz-0006KM-MH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 16:14:33 -0700
Received: from mailfe10.tele2.fr ([212.247.155.44] helo=swip.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EQYkz-0001V6-2x
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 16:14:33 -0700
Content-Disposition: inline
In-Reply-To: <20051014103144.16a7bb65.akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, walt <wa1ter@myrealbox.com>

Hum, I didn't know about messy programs like svgatextmode... Couldn't
this be integrated in some linux/drivers/video/console/svgacon.c ?... So
because of the existence of the svgatextmode program, the kernel is not
supposed to touch to CRT_OVERFLOW/SYNC_END/DISP/DISP_END/OFFSET ?

Disabling the check in vgacon_resize() might help indeed, but I'm really
not sure whether it will work for any chipset: in my patch, CRT
registers are set at each console switch, since stty rows/cols apply to
consoles separately...

The attached solution is to keep the test, but if it fails, we assume
that the caller knows what it does (i.e. it is svgatextmode) and then
disable any further call to vgacon_doresize. Svgatextmode is usually
used to _expand_ the display, not to shrink it. And it is harmless in
the case of a too big stty rows/cols: the display will just be cropped.
I tested it on my laptop, and it works fine with svgatextmode.

A better solution would be that svgatextmode explicitely tells the
kernel not to care about video timing, but for this an interface needs
be defined and svgatextmode be patched.

Signed-off-by: samuel.thibault@ens-lyon.org

--- drivers/video/console/vgacon-2.4.14-pre.c	2005-10-14 22:35:14.000000000 +0200
+++ drivers/video/console/vgacon.c	2005-10-14 22:58:06.000000000 +0200
@@ -563,7 +563,11 @@
 	if (!vga_is_gfx) {
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ? vga_vram_size : c->vc_screenbuf_size);
-		vgacon_doresize(c, c->vc_cols, c->vc_rows);
+		if (!(vga_video_num_columns % 2) &&
+		    vga_video_num_columns <= ORIG_VIDEO_COLS &&
+		    vga_video_num_lines <= (ORIG_VIDEO_LINES *
+			vga_default_font_height) / c->vc_font.height)
+			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
 	return 0;		/* Redrawing not needed */
@@ -1019,7 +1023,8 @@
 	if (width % 2 || width > ORIG_VIDEO_COLS ||
 	    height > (ORIG_VIDEO_LINES * vga_default_font_height)/
 	    c->vc_font.height)
-		return -EINVAL;
+		/* let svgatextmode tinker with video timings */
+		return 0;
 
 	if (CON_IS_VISIBLE(c) && !vga_is_gfx) /* who knows */
 		vgacon_doresize(c, width, height);


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
