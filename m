From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Display class
Date: Wed, 6 Dec 2006 10:14:34 -0800
Message-ID: <20061206101434.8acb229a.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
	<20061205171401.fd11160d.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gs1Hl-0005za-Sg for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 10:14:26 -0800
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gs1Hk-0008Cm-4A
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 10:14:25 -0800
In-Reply-To: <Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Miguel Ojeda <maxextreme@gmail.com>, kernel-discuss@handhelds.org, Luming Yu <Luming.yu@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Zabolotny <zap@homelink.ru>

On Wed, 6 Dec 2006 15:10:44 +0000 (GMT) James Simmons wrote:

> 
> > > of Mr. Yu for acpi. Also this class could in time replace the lcd class 
> > > located in the backlight directory since a lcd is a type of display.
> > > The final hope is that the purpose auxdisplay could fall under this 
> > > catergory.
> > > 
> > > P.S
> > >    I know the edid parsing would have to be pulled out of the fbdev layer.
> 
> That patch was rought draft for feedback. I applied your comments. This 
> patch actually works. It includes my backlight fix as well.

Glad to hear it.  I had to make the following changes
in order for it to build.
However, I still have build errors for aty.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Replace CONFIG_FB_BACKLIGHT with CONFIG_BACKLIGHT_CLASS_DEVICE
in include/linux/fb.h and drivers/video/fbsysfs.c
to match Kconfig changes.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/fbsysfs.c |    8 ++++----
 include/linux/fb.h      |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.19-git7.orig/include/linux/fb.h
+++ linux-2.6.19-git7/include/linux/fb.h
@@ -367,7 +367,7 @@ struct fb_cursor {
 	struct fb_image	image;	/* Cursor image */
 };
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
 #define FB_BACKLIGHT_MAX	0xFF
@@ -759,7 +759,7 @@ struct fb_info {
 	struct list_head modelist;      /* mode list */
 	struct fb_videomode *mode;	/* current mode */
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	/* Lock ordering:
 	 * bl_mutex (protects bl_dev and bl_curve)
 	 *   bl_dev->sem (backlight class)
--- linux-2.6.19-git7.orig/drivers/video/fbsysfs.c
+++ linux-2.6.19-git7/drivers/video/fbsysfs.c
@@ -58,7 +58,7 @@ struct fb_info *framebuffer_alloc(size_t
 
 	info->device = dev;
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	mutex_init(&info->bl_mutex);
 #endif
 
@@ -411,7 +411,7 @@ static ssize_t show_fbstate(struct devic
 	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 static ssize_t store_bl_curve(struct device *device,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
@@ -500,7 +500,7 @@ static struct device_attribute device_at
 	__ATTR(stride, S_IRUGO, show_stride, NULL),
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
 #endif
 };
@@ -541,7 +541,7 @@ void fb_cleanup_device(struct fb_info *f
 	}
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 /* This function generates a linear backlight curve
  *
  *     0: off

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
