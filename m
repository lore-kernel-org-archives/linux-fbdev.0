From: Kronos <kronos@people.it>
Subject: Re: [PATCH] Re: Devices don't get linked to their class.
Date: Tue, 7 Sep 2004 21:50:55 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040907195055.GB6021@dreamland.darkstar.lan>
References: <1094187751.2979.41.camel@laptop.cunninghams> <200409042041.55199.adaplas@hotpop.com> <1094365292.6252.3.camel@laptop.cunninghams> <200409051840.27452.adaplas@hotpop.com> <1094441896.19674.24.camel@laptop.cunninghams>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4lzd-0003YU-9c
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 12:51:05 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4lzY-0002bR-Vn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 12:51:04 -0700
Content-Disposition: inline
In-Reply-To: <1094441896.19674.24.camel@laptop.cunninghams>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net

Il Mon, Sep 06, 2004 at 01:38:16PM +1000, Nigel Cunningham ha scritto: 
> On Sun, 2004-09-05 at 20:40, Antonino A. Daplas wrote:
> > Frankly, I don't know a thing about this stuff.  Just let me know what you
> > need and where you need them, and I'll see what I can do.
> 
> It did turn out to just need the dev parameter to be non null. I've gone
> through all the frame buffer drivers and done what I believe to be the
> right thing; if they're PCI based, they get the struct device pointer
> passed through, otherwise NULL is sent.
> 
> The attached patch is against 2.6.9-rc1, and (combined with other code)
> allows the driver to remain active while we're suspending to disk.

There's framebuffer_alloc for that. I forgot to re-add a struct device *
to fb_info after I added the class_simple stuff:


--- a/drivers/video/fbsysfs.c	2004-02-15 15:51:52.000000000 +0100
+++ b/drivers/video/fbsysfs.c	2004-09-07 21:47:07.000000000 +0200
@@ -47,6 +47,7 @@
 		return NULL;
 	memset(p, 0, fb_info_size + size);
 	info = (struct fb_info *) p;
+	info->device = dev;
 
 	if (size)
 		info->par = p + fb_info_size;
--- a/drivers/video/fbmem.c	2004-08-14 20:46:08.000000000 +0200
+++ b/drivers/video/fbmem.c	2004-09-07 21:48:00.000000000 +0200
@@ -1380,7 +1380,7 @@
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), fb_info->device, "fb%d", i);
 	if (IS_ERR(c)) {
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
--- a/include/linux/fb.h	2004-08-14 20:46:19.000000000 +0200
+++ b/include/linux/fb.h	2004-09-07 21:48:53.000000000 +0200
@@ -588,6 +588,7 @@
 #define FBINFO_STATE_RUNNING	0
 #define FBINFO_STATE_SUSPENDED	1
 	u32 state;			/* Hardware state i.e suspend */
+	struct device *device;
 
 	/* From here on everything is device dependent */
 	void *par;	


Luca
-- 
Home: http://kronoz.cjb.net
Recursion n.:
	See Recursion.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
