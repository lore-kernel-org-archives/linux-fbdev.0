From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Fw: oops in aty128_bl_set_power in
	2.6.18-rc5
Date: Wed, 30 Aug 2006 19:34:00 +0200
Message-ID: <20060830173400.GA31006@hansmi.ch>
References: <20060829205111.19809528.akpm@osdl.org>
	<1156949990.13504.10.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GITxC-0005Oz-35 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Aug 2006 10:34:18 -0700
Received: from hansmi.home.forkbomb.ch ([213.144.146.165])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GITx8-0000vn-LT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Aug 2006 10:34:18 -0700
Content-Disposition: inline
In-Reply-To: <1156949990.13504.10.camel@daplas.org>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Aug 30, 2006 at 10:59:50PM +0800, Antonino A. Daplas wrote:
> Backlight registration can fail resulting in info->bl_dev = NULL.  This
> may be the cause of the oops.  An additional 'if (info->bl_dev)' check
> in aty128_bl_set_power() may be necessary.

Fixed in aty128fb and three other places in the patch below. I don't own
the hardware and can't test it myself. Thus I'd like you, or someone
else, to test it.

> On another note, is the call to aty128_bl_set_power() from
> aty128fb_blank() necessary? aty128_bl_set_power() will be called twice
> per call to aty128fb_blank().

Not exactly. It once checks for (blank) and once for (!blank). If you
look at the code, removing th second call would only unblank it on some
chips.

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/macintosh/via-pmu-backlight.c linux-2.6.18-rc5/drivers/macintosh/via-pmu-backlight.c
--- linux-2.6.18-rc5.orig/drivers/macintosh/via-pmu-backlight.c	2006-08-30 19:25:28.000000000 +0200
+++ linux-2.6.18-rc5/drivers/macintosh/via-pmu-backlight.c	2006-08-29 22:40:58.000000000 +0200
@@ -168,11 +168,11 @@ void __init pmu_backlight_init()
 		mutex_unlock(&info->bl_mutex);
 	}
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = level;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 	mutex_lock(&pmac_backlight_mutex);
 	if (!pmac_backlight)
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/aty/aty128fb.c linux-2.6.18-rc5/drivers/video/aty/aty128fb.c
--- linux-2.6.18-rc5.orig/drivers/video/aty/aty128fb.c	2006-08-30 19:25:28.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/aty/aty128fb.c	2006-08-30 18:59:54.000000000 +0200
@@ -1801,10 +1801,14 @@ static struct backlight_properties aty12
 static void aty128_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
-	info->bl_dev->props->power = power;
-	__aty128_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+
+	if (info->bl_dev) {
+		down(&info->bl_dev->sem);
+		info->bl_dev->props->power = power;
+		__aty128_bl_update_status(info->bl_dev);
+		up(&info->bl_dev->sem);
+	}
+
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -1839,11 +1843,11 @@ static void aty128_bl_init(struct aty128
 		219 * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = aty128_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/aty/atyfb_base.c linux-2.6.18-rc5/drivers/video/aty/atyfb_base.c
--- linux-2.6.18-rc5.orig/drivers/video/aty/atyfb_base.c	2006-08-30 19:25:28.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/aty/atyfb_base.c	2006-08-30 19:23:29.000000000 +0200
@@ -2200,10 +2200,14 @@ static struct backlight_properties aty_b
 static void aty_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
-	info->bl_dev->props->power = power;
-	__aty_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+
+	if (info->bl_dev) {
+		down(&info->bl_dev->sem);
+		info->bl_dev->props->power = power;
+		__aty_bl_update_status(info->bl_dev);
+		up(&info->bl_dev->sem);
+	}
+
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -2234,11 +2238,11 @@ static void aty_bl_init(struct atyfb_par
 		0xFF * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = aty_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/aty/radeon_backlight.c linux-2.6.18-rc5/drivers/video/aty/radeon_backlight.c
--- linux-2.6.18-rc5.orig/drivers/video/aty/radeon_backlight.c	2006-08-30 19:25:28.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/aty/radeon_backlight.c	2006-08-29 22:39:23.000000000 +0200
@@ -195,11 +195,11 @@ void radeonfb_bl_init(struct radeonfb_in
 		217 * FB_BACKLIGHT_MAX / MAX_RADEON_LEVEL);
 	mutex_unlock(&rinfo->info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = radeon_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/nvidia/nv_backlight.c linux-2.6.18-rc5/drivers/video/nvidia/nv_backlight.c
--- linux-2.6.18-rc5.orig/drivers/video/nvidia/nv_backlight.c	2006-08-30 19:25:28.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/nvidia/nv_backlight.c	2006-08-30 19:24:21.000000000 +0200
@@ -113,10 +113,14 @@ static struct backlight_properties nvidi
 void nvidia_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
-	info->bl_dev->props->power = power;
-	__nvidia_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+
+	if (info->bl_dev) {
+		down(&info->bl_dev->sem);
+		info->bl_dev->props->power = power;
+		__nvidia_bl_update_status(info->bl_dev);
+		up(&info->bl_dev->sem);
+	}
+
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -151,11 +155,11 @@ void nvidia_bl_init(struct nvidia_par *p
 		0x534 * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = nvidia_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc5.orig/drivers/video/riva/fbdev.c linux-2.6.18-rc5/drivers/video/riva/fbdev.c
--- linux-2.6.18-rc5.orig/drivers/video/riva/fbdev.c	2006-08-30 19:25:28.000000000 +0200
+++ linux-2.6.18-rc5/drivers/video/riva/fbdev.c	2006-08-30 19:24:49.000000000 +0200
@@ -355,10 +355,14 @@ static struct backlight_properties riva_
 static void riva_bl_set_power(struct fb_info *info, int power)
 {
 	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
-	info->bl_dev->props->power = power;
-	__riva_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
+
+	if (info->bl_dev) {
+		down(&info->bl_dev->sem);
+		info->bl_dev->props->power = power;
+		__riva_bl_update_status(info->bl_dev);
+		up(&info->bl_dev->sem);
+	}
+
 	mutex_unlock(&info->bl_mutex);
 }
 
@@ -393,11 +397,11 @@ static void riva_bl_init(struct riva_par
 		0x534 * FB_BACKLIGHT_MAX / MAX_LEVEL);
 	mutex_unlock(&info->bl_mutex);
 
-	up(&bd->sem);
+	down(&bd->sem);
 	bd->props->brightness = riva_bl_data.max_brightness;
 	bd->props->power = FB_BLANK_UNBLANK;
 	bd->props->update_status(bd);
-	down(&bd->sem);
+	up(&bd->sem);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	mutex_lock(&pmac_backlight_mutex);

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
