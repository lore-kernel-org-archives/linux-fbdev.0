From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: missing savagefb symbols
Date: Tue, 26 Oct 2004 22:05:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410262205.48026.adaplas@hotpop.com>
References: <20041026021100.0d984515.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMRqh-0005gw-4F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 06:58:55 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CMRqg-00080v-9A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 06:58:55 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 441CE932853
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Oct 2004 13:58:44 +0000 (UTC)
In-Reply-To: <20041026021100.0d984515.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tuesday 26 October 2004 17:11, Andrew Morton wrote:
> From `make allmodconfig'
>
> *** Warning: "savagefb_delete_i2c_busses"
> [drivers/video/savage/savagefb.ko] undefined! *** Warning:
> "savagefb_probe_i2c_connector" [drivers/video/savage/savagefb.ko]
> undefined! *** Warning: "savagefb_create_i2c_busses"
> [drivers/video/savage/savagefb.ko] undefined! *** Warning: "savagefb_sync"
> [drivers/video/savage/savagefb.ko] undefined! *** Warning:
> "savagefb_imageblit" [drivers/video/savage/savagefb.ko] undefined! ***
> Warning: "savagefb_copyarea" [drivers/video/savage/savagefb.ko] undefined!
> *** Warning: "savagefb_fillrect" [drivers/video/savage/savagefb.ko]
> undefined!
>
> Maybe doing an EXPORT_SYMBOL will fix this.  Or we need to link those
> objects together into a single .ko - your call.

Grr, that's poor planning on my part.  I don't use modules, so I forgot to test
the savagefb driver.

I don't think the second option will work without doing a rename (since
the object name and the module name has the same name). So I'll do the
EXPORT_SYMBOL fix.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 Kconfig                 |    4 ++--
 savage/savagefb-i2c.c   |    5 +++++
 savage/savagefb_accel.c |    5 +++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-10-22 16:37:37 +08:00
+++ b/drivers/video/Kconfig	2004-10-26 21:53:01 +08:00
@@ -811,7 +811,7 @@
 	  will be called savagefb.
 
 config FB_SAVAGE_I2C
-       bool "Enable DDC2 Support"
+       tristate "Enable DDC2 Support"
        depends on FB_SAVAGE
        help
 	  This enables I2C support for S3 Savage Chipsets.  This is used
@@ -823,7 +823,7 @@
 	  here.
        
 config FB_SAVAGE_ACCEL
-       bool "Enable Console Acceleration"
+       tristate "Enable Console Acceleration"
        depends on FB_SAVAGE
        default n
        help
diff -Nru a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
--- a/drivers/video/savage/savagefb-i2c.c	2004-10-22 16:37:37 +08:00
+++ b/drivers/video/savage/savagefb-i2c.c	2004-10-26 21:53:01 +08:00
@@ -197,6 +197,7 @@
 
 	savage_setup_i2c_bus(&par->chan, "SAVAGE DDC2");
 }
+EXPORT_SYMBOL(savagefb_create_i2c_busses);
 
 void savagefb_delete_i2c_busses(struct fb_info *info)
 {
@@ -206,6 +207,7 @@
 		i2c_bit_del_bus(&par->chan.adapter);
 	par->chan.par = NULL;
 }
+EXPORT_SYMBOL(savagefb_delete_i2c_busses);
 
 static u8 *savage_do_probe_i2c_edid(struct savagefb_i2c_chan *chan)
 {
@@ -255,3 +257,6 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(savagefb_probe_i2c_connector);
+
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/savage/savagefb_accel.c b/drivers/video/savage/savagefb_accel.c
--- a/drivers/video/savage/savagefb_accel.c	2004-10-22 16:37:38 +08:00
+++ b/drivers/video/savage/savagefb_accel.c	2004-10-26 21:53:01 +08:00
@@ -26,6 +26,7 @@
 	par->SavageWaitIdle(par);
 	return 0;
 }
+EXPORT_SYMBOL(savagefb_sync);
 
 void savagefb_copyarea(struct fb_info *info, const struct fb_copyarea *region) 
 {
@@ -60,6 +61,7 @@
 	BCI_SEND(BCI_X_Y(dx, dy));
 	BCI_SEND(BCI_W_H(region->width, region->height));
 }
+EXPORT_SYMBOL(savagefb_copyarea);
 
 void savagefb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
@@ -87,6 +89,7 @@
 	BCI_SEND( BCI_X_Y(rect->dx, rect->dy) );
 	BCI_SEND( BCI_W_H(rect->width, rect->height) );
 }
+EXPORT_SYMBOL(savagefb_fillrect);
 
 void savagefb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
@@ -132,4 +135,6 @@
 	for (i = 0; i < size; i++)
 		BCI_SEND(src[i]);
 }
+EXPORT_SYMBOL(savagefb_imageblit);
 
+MODULE_LICENSE("GPL");




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
