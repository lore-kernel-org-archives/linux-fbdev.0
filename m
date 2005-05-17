From: James Simmons <jsimmons@www.infradead.org>
Subject: [PATCH] VGA to fbcon fix.
Date: Tue, 17 May 2005 02:48:24 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505132350430.14541@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXrCj-0002m6-SS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 May 2005 18:49:05 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DXrCC-0008Bq-OP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 May 2005 18:49:05 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Currently when going from vgacon to fbcon the VT screenbuffer are 
often different sizes. In the case when they are different sizes 
a new VT screenbuffer is allocated and the contents are copied into
the new buffer. Currently the amount copied from VGA text memory to
the new screenbuf is the size of the framebuffer console. If the 
framebuffer console new VT screen buffer is greater than the VGA
text memory size then we get some of the VGA BIOS contents as well.
This patch will only allow you to copy up to the size of VGA text
memory now. The rest is filled with erase characters.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>
		Initial patch by Jordan Crouse <jordan.crouse@amd.com>

--- linus-2.6/drivers/video/console/vgacon.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/console/vgacon.c	2005-05-13 17:11:37.000000000 -0700
@@ -95,6 +95,7 @@ static unsigned long vgacon_uni_pagedir[
 /* Description of the hardware situation */
 static unsigned long	vga_vram_base;		/* Base of video memory */
 static unsigned long	vga_vram_end;		/* End of video memory */
+static int		vga_vram_size;		/* Size of video memory */
 static u16		vga_video_port_reg;	/* Video register select port */
 static u16		vga_video_port_val;	/* Video register value port */
 static unsigned int	vga_video_num_columns;	/* Number of text columns */
@@ -288,6 +289,7 @@ static const char __init *vgacon_startup
 
 	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
 	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
+	vga_vram_size = vga_vram_end - vga_vram_base;
 
 	/*
 	 *      Find out if there is a graphics card present.
@@ -504,9 +506,13 @@ static int vgacon_switch(struct vc_data 
 	 */
 	vga_video_num_columns = c->vc_cols;
 	vga_video_num_lines = c->vc_rows;
+
+	/* We can only copy out the size of the video buffer here, 
+	 * otherwise we get into VGA BIOS */
+
 	if (!vga_is_gfx)
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
-			    c->vc_screenbuf_size);
+			    c->vc_screenbuf_size > vga_vram_size ? vga_vram_size : c->vc_screenbuf_size);
 	return 0;		/* Redrawing not needed */
 }
 
@@ -961,7 +967,6 @@ static int vgacon_scrolldelta(struct vc_
 	if (!lines)		/* Turn scrollback off */
 		c->vc_visible_origin = c->vc_origin;
 	else {
-		int vram_size = vga_vram_end - vga_vram_base;
 		int margin = c->vc_size_row * 4;
 		int ul, we, p, st;
 
@@ -971,7 +976,7 @@ static int vgacon_scrolldelta(struct vc_
 			we = vga_rolled_over + c->vc_size_row;
 		} else {
 			ul = 0;
-			we = vram_size;
+			we = vga_vram_size;
 		}
 		p = (c->vc_visible_origin - vga_vram_base - ul + we) % we +
 		    lines * c->vc_size_row;
@@ -1012,9 +1017,13 @@ static void vgacon_save_screen(struct vc
 		c->vc_x = ORIG_X;
 		c->vc_y = ORIG_Y;
 	}
+	
+	/* We can't copy in more then the size of the video buffer, 
+	 * or we'll be copying in VGA BIOS */
+
 	if (!vga_is_gfx)
 		scr_memcpyw((u16 *) c->vc_screenbuf, (u16 *) c->vc_origin,
-			    c->vc_screenbuf_size);
+			    c->vc_screenbuf_size > vga_vram_size ? vga_vram_size : c->vc_screenbuf_size);
 }
 
 static int vgacon_scroll(struct vc_data *c, int t, int b, int dir,


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
