From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [Linux-fbdev-users] PATCH: vga console tweak
Date: Sat, 14 May 2005 01:20:41 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505140118560.16057@pentafluge.infradead.org>
References: <20050513214055.GA3107@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWkOc-0002Xy-WA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 17:20:46 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DWkOa-0002yt-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 17:20:46 -0700
In-Reply-To: <20050513214055.GA3107@cosmic.amd.com>
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
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> The attached patch puts a hard 32k ceiling on copies to and from
> the VGA VRAM space.
> 
> This bug was discovered with a 1920x1440 framebuffer console - before
> switching from VGA, the console is expanded to 240 cols x 90 rows, equaling
> a screenbuf_size of 43200 bytes.  Since the VGA VRAM space is only 32k bytes
> big, calling vgacon_save_screen during the console transfer copied in a good
> chunk of the video BIOS living at 0xc0000 too, resulting in some very purty
> colors and characters at the bottom of the new console.

I made the patch a little more flexiable for video size. It is possible to 
use 64K or even 128K of video memory. So we ask. Could you give my patch a 
run. Its against Linus latest tree.

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
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
