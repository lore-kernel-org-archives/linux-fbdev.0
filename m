From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: kernel: matrox fb - missing files,
	doesn't compile
Date: 15 Dec 2002 05:30:43 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039912121.1008.59.camel@localhost.localdomain>
References: <A31FF58755A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NJxS-0002b4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Dec 2002 13:36:26 -0800
In-Reply-To: <A31FF58755A@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Ariel <aslinux@dsgml.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-12-13 at 15:09, Petr Vandrovec wrote:
> Current interface just supports only cfb, and only very bad for my needs.
> And because of matroxfb supports also other modes (such as native text
> mode, or loading font into accelerator), bye-bye. For now I recommend you 
> either to not upgrade, or use vesafb. Besides that accel_putcs() does not 
> call fb_sync when using font width which is not multiple of 8, and that 
Can you explain why an fb_sync is needed for every character?

> with fonts greater than 16*16 pixels (I believe that such fonts are still 
> supported...) it will corrupt memory...

I agree.  To be more specific, buffer overruns will occur if (xres *
fontheight/8 > 8192).  The pixmap needs to be dynamically allocated and
resized somewhere in the fbcon layer (ideally in accel_setup(), but this
was removed).  For those concerned about this problem, you can try this
patch as a temporary measure until fbcon is fixed. It should not cause
to much slowdown:

For anyone concerned, this is a heads up:  The data in the pixmap must
be read completely by the hardware before exiting, otherwise font
corruption will occur.  If you think this will be a problem, the
function can be easily modified to do multiple buffering instead.
 
Comments?

Tony

diff -Naur linux-2.5.51/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.51/drivers/video/console/fbcon.c	2002-12-14 23:33:50.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2002-12-14 23:35:10.000000000 +0000
@@ -390,7 +390,9 @@
 	unsigned int cellsize = vc->vc_font.height * width;
 	struct fb_image image;
 	u16 c = scr_readw(s);
-	static u8 pixmap[8192];
+	static int xres = 0;
+	static int fontheight = 0;
+	static u8 *pixmap = NULL;
 	
 	image.fg_color = attr_fgcol(p, c);
 	image.bg_color = attr_bgcol(p, c);
@@ -399,9 +401,24 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-/*	pixmap = kmalloc((info->var.bits_per_pixel + 7) >> 3 *
-				vc->vc_font.height, GFP_KERNEL); 
-*/
+	/*
+	 * FIXME: This code segment has to be placed 
+	 *        somewhere else to allow freeing of 
+	 *        memory on exit and to reduce unnecessary
+	 *        processing.
+	 */
+	if (xres != info->var.xres || 
+	    fontheight != vc->vc_font.height) {
+		xres = info->var.xres;
+		fontheight = vc->vc_font.height;
+
+		if (info->fbops->fb_sync)
+			info->fbops->fb_sync(info);
+		if (pixmap != NULL)
+			kfree(pixmap);
+		pixmap = kmalloc((xres + 7)/8 *
+				 fontheight, GFP_KERNEL); 
+	}
 				
 	if (!(vc->vc_font.width & 7) && pixmap != NULL) {
 		unsigned int pitch = width * count, i, j;
@@ -432,10 +449,6 @@
 			image.dx += vc->vc_font.width;
 		}	
 	}
-	/*
-	if (pixmap);
-		kfree(pixmap);
-	*/	
 }
 
 void accel_clear_margins(struct vc_data *vc, struct display *p,






-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
