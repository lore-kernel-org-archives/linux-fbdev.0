From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2 more fbcon rotation bugs
Date: Tue, 22 Nov 2005 15:48:16 +0800
Message-ID: <4382CD40.8000507@gmail.com>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <4382BBE3.9020002@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeStl-0006fd-VT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Nov 2005 23:49:05 -0800
Received: from xproxy.gmail.com ([66.249.82.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EeSth-0006UV-IW
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Nov 2005 23:49:06 -0800
Received: by xproxy.gmail.com with SMTP id s6so954179wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Nov 2005 23:48:59 -0800 (PST)
In-Reply-To: <4382BBE3.9020002@t-online.de>
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
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi Antonino,
> 
>>> Any idea where to start? Can you reproduce the odd behaviour?
>>>   
>>
>> This one I cannot reproduce. Have you tried reproducing it with vesafb?
>> Any message in the log, such as a kernel oops?  Your description sounds
>> like a corruption of cursor->mask and cursor->image.data.
>>  
>>
> I found the bug, it is specific to cyblafb.
> 
> The problem is that the 16x30 font causes the cyblafb imageblit to fall
> back to
> cfb_imageblit for rotation 1 and 3 while the accelerated copyarea
> function is
> still used. That breaks the private sync mechanism of cyblafb and causes
> the
> erroneous behaviour.

Shouldn't the accelerator be intelligent enough to handle bitmaps with
variable widths?  Will something like the one attached work?

Tony

diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
index 03fbe83..175f4d4 100644
--- a/drivers/video/cyblafb.c
+++ b/drivers/video/cyblafb.c
@@ -364,17 +364,12 @@ static void cyblafb_imageblit(struct fb_
 			      const struct fb_image *image)
 {
 
-	u32 fgcol, bgcol;
-
-	int i;
+	u32 fgcol, bgcol, *data = (u32 *) image->data;
 	int bpp = info->var.bits_per_pixel;
 	int index = 0;
-	int index_end=image->height * image->width / 8;
-	int width_dds=image->width / 32;
-	int width_dbs=image->width % 32;
 
-	if (image->depth != 1 || bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
-	    image->width % 8 != 0 || image->width == 0 || image->height == 0) {
+	if (image->depth != 1 || bpp < 8 || bpp > 32 ||
+	    image->width == 0 || image->height == 0) {
 		cfb_imageblit(info,image);
 		return;
 	}
@@ -403,32 +398,18 @@ static void cyblafb_imageblit(struct fb_
 
 	cyblafb_sync(info);
 
+	index = (image->width + 31) & ~31;
+	index *= image->height;
+	index >>= 5;
+
 	out32(GE60,fgcol);
 	out32(GE64,bgcol);
 	out32(GE44,0xa0000000 | 1<<20 | 1<<19);
 	out32(GE08,point(image->dx,image->dy));
 	out32(GE0C,point(image->dx+image->width-1,image->dy+image->height-1));
 
-	while(index < index_end) {
-		const char *p = image->data + index;
-		for(i=0;i<width_dds;i++) {
-			out32(GE9C,*(u32*)p);
-			p+=4;
-			index+=4;
-		}
-		switch(width_dbs) {
-		case 0: break;
-		case 8:	out32(GE9C,*(u8*)p);
-			index+=1;
-			break;
-		case 16: out32(GE9C,*(u16*)p);
-			index+=2;
-			break;
-		case 24: out32(GE9C,*(u16*)p | *(u8*)(p+2)<<16);
-			index+=3;
-			break;
-		}
-	}
+	while (index--)
+		out32(GE9C, *data++);
 }
 
 //==========================================================
@@ -1319,6 +1300,17 @@ static int __devinit cybla_pci_probe(str
 
 	fb_alloc_cmap(&info->cmap,256,0);
 
+	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
+	
+	if (!info->pixmap.addr)
+		goto errout_pixmap;
+
+	info->pixmap.scan_align = 4;
+	info->pixmap.buf_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.size = 8 * 1024;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	if (register_framebuffer(info)) {
 		output("Could not register CyBla framebuffer\n");
 		goto errout_register;
@@ -1333,6 +1325,8 @@ static int __devinit cybla_pci_probe(str
 	return 0;
 
  errout_register:
+	kfree(info->pixmap.addr);
+ errout_pixmap:
  errout_findmode:
 	iounmap(info->screen_base);
  errout_smem_remap:
@@ -1362,6 +1356,7 @@ static void __devexit cybla_pci_remove(s
 	release_mem_region(info->fix.smem_start,info->fix.smem_len);
 	release_mem_region(info->fix.mmio_start,info->fix.mmio_len);
 	fb_dealloc_cmap(&info->cmap);
+	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	output("CyblaFB version %s normal exit.\n",VERSION);
 }


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
