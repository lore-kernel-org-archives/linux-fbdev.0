From: Kronos <kronos@people.it>
Subject: Re: why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Date: Tue, 30 Nov 2004 18:56:57 +0100
Message-ID: <20041130175657.GA22083@dreamland.darkstar.lan>
References: <20041128184606.GA2537@middle.of.nowhere> <20041129213510.GA9551@dreamland.darkstar.lan> <20041130065555.GA20972@middle.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZCFK-0000Xq-Fp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Nov 2004 09:57:02 -0800
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZCFI-00062k-G4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Nov 2004 09:57:02 -0800
Content-Disposition: inline
In-Reply-To: <20041130065555.GA20972@middle.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Il Tue, Nov 30, 2004 at 07:55:55AM +0100, Jurriaan ha scritto: 
> From: Kronos <kronos@people.it>
> Date: Mon, Nov 29, 2004 at 10:35:10PM +0100
> > Il Sun, Nov 28, 2004 at 07:46:06PM +0100, Jurriaan ha scritto: 
> > > The same radeonfb-setup works fine in every 2.6 kernel I can remember
> > > (last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
> > > in 2.4.29-pre1.
> > > 
> > > The card has 128 Mb of ram, and my system has 3 Mb of RAM.
> > > 
> > > Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?
> > 
> > Driver in 2.6 only ioremap()s the memory needed for the framebuffer,
> > while the one in 2.4 ioremap()s all the VRAM (and fails).
> > 
> > > Is there any way to test 2.4 with my radeonfb and all of my memory?
> > 
> > I proposed the following patch some time ago (for 2.4.28-pre2 IIRC) as a
> > quick fix:
> > 
> Thanks. I found that patch on google. Problem is: when I look through
> the radeonfb in 2.6, I don't see any assignments to rinfo->video_ram
> that indicate it maps less than the full amount.

rinfo->video_ram is the physical ram. Look at drivers/video/aty/radeon_base.c:2200

  rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video_ram);

and the following loop tries to shrink the mapped area in case of
ioremap() failure.

Can you test the following patch (against 2.2.29-pre1)? If everything is
ok I'll push to Marcelo.

--- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
+++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
@@ -126,7 +126,8 @@
 					/* (physical address) */
 	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
 	__u32 accel;			/* Type of acceleration available */
-	__u16 reserved[3];		/* Reserved for future compatibility */
+	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
+	__u16 reserved[1];		/* Reserved for future compatibility */
 };
 
 /* Interpretation of offset for color fields: All offsets are from the right,
--- a/drivers/video/fbmem.c	2004-11-30 18:30:00.000000000 +0100
+++ b/drivers/video/fbmem.c	2004-11-30 18:43:06.000000000 +0100
@@ -410,6 +410,7 @@
 	struct fb_info *info = registered_fb[fbidx];
 	struct fb_ops *fb = info->fbops;
 	struct fb_fix_screeninfo fix;
+	unsigned int size;
 
 	if (! fb || ! info->disp)
 		return -ENODEV;
@@ -418,10 +419,12 @@
 		return -EINVAL;
 
 	fb->fb_get_fix(&fix,PROC_CONSOLE(info), info);
-	if (p >= fix.smem_len)
+	size = fix.mapped_vram ? fix.mapped_vram : fix.smem_len;
+	
+	if (p >= size)
 	    return 0;
-	if (count > fix.smem_len - p)
-		count = fix.smem_len - p;
+	if (count > size - p)
+		count = size - p;
 	if (count) {
 	    char *base_addr;
 
@@ -444,6 +447,7 @@
 	struct fb_ops *fb = info->fbops;
 	struct fb_fix_screeninfo fix;
 	int err;
+	unsigned int size;
 
 	if (! fb || ! info->disp)
 		return -ENODEV;
@@ -452,11 +456,13 @@
 		return -EINVAL;
 
 	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
-	if (p > fix.smem_len)
+	size = fix.mapped_vram ? fix.mapped_vram : fix.smem_len;
+	
+	if (p > size)
 	    return -ENOSPC;
 	err = 0;
-	if (count > fix.smem_len - p) {
-	    count = fix.smem_len - p;
+	if (count > size - p) {
+	    count = size - p;
 	    err = -ENOSPC;
 	}
 	if (count) {
@@ -619,7 +625,10 @@
 
 	/* frame buffer memory */
 	start = fix.smem_start;
-	len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.smem_len);
+	if (fix.mapped_vram)
+		len = PAGE_ALIGN((start & ~PAGE_MASK) + fix.mapped_vram);
+	else
+		len = PAGE_ALIGN((start & ~PAGE_MASK) + fix.smem_len);
 	if (off >= len) {
 		/* memory mapped io */
 		off -= len;
--- a/drivers/video/radeonfb.c	2004-11-30 18:06:45.000000000 +0100
+++ b/drivers/video/radeonfb.c	2004-11-30 18:50:25.000000000 +0100
@@ -176,7 +176,8 @@
 #define RTRACE		if(0) printk
 #endif
 
-
+#define MAX_MAPPED_VRAM (2048*2048*4)
+#define MIN_MAPPED_VRAM (1024*768*1)
 
 enum radeon_chips {
 	RADEON_QD,
@@ -499,7 +500,8 @@
 
 	short chipset;
 	unsigned char arch;
-	int video_ram;
+	unsigned int video_ram;
+	unsigned int mapped_vram;
 	u8 rev;
 	int pitch, bpp, depth;
 	int xres, yres, pixclock;
@@ -1824,8 +1826,16 @@
 		}
 	}
 
-	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
-				  		  rinfo->video_ram);
+	rinfo->mapped_vram = min_t(unsigned int, MAX_MAPPED_VRAM, rinfo->video_ram);
+	do {
+		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
+				  		  rinfo->mapped_vram);
+		if (rinfo->fb_base)
+			break;
+
+		rinfo->mapped_vram /= 2;
+	} while(rinfo->mapped_vram > MIN_MAPPED_VRAM);
+	
 	if (!rinfo->fb_base) {
 		printk ("radeonfb: cannot map FB\n");
 		iounmap ((void*)rinfo->mmio_base);
@@ -1836,6 +1846,7 @@
 		kfree (rinfo);
 		return -ENODEV;
 	}
+	RTRACE(KERN_INFO "radeonfb: mapped %dk videoram\n", rinfo->mapped_vram/1024);
 
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
@@ -2205,7 +2216,7 @@
                 printk("radeonfb: using max available virtual resolution\n");
                 for (i=0; modes[i].xres != -1; i++) {
                         if (modes[i].xres * nom / den * modes[i].yres <
-                            rinfo->video_ram / 2)
+                            rinfo->mapped_vram / 2)
                                 break;
                 }
                 if (modes[i].xres == -1) {
@@ -2218,15 +2229,15 @@
                 printk("radeonfb: virtual resolution set to max of %dx%d\n",
                         v->xres_virtual, v->yres_virtual);
         } else if (v->xres_virtual == -1) {
-                v->xres_virtual = (rinfo->video_ram * den /   
+                v->xres_virtual = (rinfo->mapped_vram * den /   
                                 (nom * v->yres_virtual * 2)) & ~15;
         } else if (v->yres_virtual == -1) {
                 v->xres_virtual = (v->xres_virtual + 15) & ~15;
-                v->yres_virtual = rinfo->video_ram * den /
+                v->yres_virtual = rinfo->mapped_vram * den /
                         (nom * v->xres_virtual *2);
         } else {
                 if (v->xres_virtual * nom / den * v->yres_virtual >
-                        rinfo->video_ram) {
+                        rinfo->mapped_vram) {
                         return -EINVAL;
                 }
         }
@@ -2263,6 +2274,7 @@
         
         fix->smem_start = rinfo->fb_base_phys;
         fix->smem_len = rinfo->video_ram;
+        fix->mapped_vram = rinfo->mapped_vram;
 
         fix->type = disp->type;
         fix->type_aux = disp->type_aux;
@@ -2430,6 +2442,9 @@
                         return -EINVAL;
         }
 
+	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
+		return -EINVAL;
+
         if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
                 return -EINVAL;  
                 


Luca
-- 
Home: http://kronoz.cjb.net
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
