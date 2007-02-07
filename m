From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 0/10] ps3av/fb drivers for 2.6.21
Date: Wed, 7 Feb 2007 17:51:12 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702071743040.29060@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702051624410.18405@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702061559420.14230@pademelon.sonytel.be>
	<1170794953.2620.253.camel@localhost.localdomain>
	<Pine.LNX.4.62.0702070859050.31772@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEq13-0008Eb-QW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 08:51:29 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEq11-0004Sk-1Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 08:51:29 -0800
In-Reply-To: <Pine.LNX.4.62.0702070859050.31772@pademelon.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Wed, 7 Feb 2007, Geert Uytterhoeven wrote:
> On Wed, 7 Feb 2007, Benjamin Herrenschmidt wrote:
> > > ps3av: Use a kernel thread to handle the actual video mode setting, as this
> > > involves some quite big delays.
> > 
> > The ps3 fbdev already has it's own kernel thread no ? Why use a second
> > one ? We could just have the ps3av code keep the delays but be called by
> > a thread ?
> 
> That's another possibility.  And since the screen is blanked during mode
> change, there's no need to refresh it, and I may even get rid of the call to
> ps3fb_flip_ctl() in ps3av.
> 
> I'll look into it...

Below's a new patch (take 3).

But it doesn't work well: after each mode change, the old contents of the
screen are visible for a (noticable) fraction of a second.
Ps3fbd doesn't refresh the screen contents until ps3av_set_video_mode()
returns, which is longer than my display needs to sync to the new video mode
(this was actually the reason behind the msleep() calls).

I also could not get rid of the calls to ps3fb_flip_ctl() in ps3av, as screen
updates have to be disabled while sending other AV packets, too.

So I prefer the previous solution, using a new ps3av kernel thread.
Unless anyone has a better solution, of course :-)
----

--- ps3-linux-2.6.20.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.20/drivers/video/ps3fb.c
@@ -138,6 +138,7 @@ struct ps3fb_priv {
 	u32 num_frames;		/* num of frame buffers */
 	atomic_t ext_flip;	/* on/off flip with vsync */
 	atomic_t f_count;	/* fb_open count */
+	atomic_t change_mode;	/* tell ps3fb to change the video mode */
 	int is_blanked;
 };
 static struct ps3fb_priv ps3fb;
@@ -294,7 +295,7 @@ static const struct fb_videomode ps3fb_m
 #define VP_OFF(i)	(WIDTH(i) * Y_OFF(i) * BPP + X_OFF(i) * BPP)
 #define FB_OFF(i)	(GPU_OFFSET - VP_OFF(i) % GPU_OFFSET)
 
-static int ps3fb_mode = 0;
+static int ps3fb_mode;
 module_param(ps3fb_mode, bool, 0);
 
 static char *mode_option __initdata = NULL;
@@ -542,7 +543,6 @@ static int ps3fb_set_par(struct fb_info 
 	unsigned int mode;
 	int i;
 	unsigned long offset;
-	static int first = 1;
 
 	DPRINTK("xres:%d xv:%d yres:%d yv:%d clock:%d\n",
 		info->var.xres, info->var.xres_virtual,
@@ -565,10 +565,10 @@ static int ps3fb_set_par(struct fb_info 
 	/* Keep the special bits we cannot set using fb_var_screeninfo */
 	ps3fb_mode = (ps3fb_mode & ~PS3AV_MODE_MASK) | mode;
 
-	if (ps3av_set_video_mode(ps3fb_mode, first))
-		return -EINVAL;
+	/* Wake up ps3fbd to do the actual mode change */
+	atomic_inc(&ps3fb.change_mode);
+	up(&ps3fb.sem);
 
-	first = 0;
 	return 0;
 }
 
@@ -805,9 +805,17 @@ static int ps3fb_ioctl(struct fb_info *i
 
 static int ps3fbd(void *arg)
 {
+	int first = 1;
+
 	daemonize("ps3fbd");
 	for (;;) {
 		down(&ps3fb.sem);
+		if (atomic_dec_if_positive(&ps3fb.change_mode) >= 0) {
+			if (ps3av_set_video_mode(ps3fb_mode, first))
+				printk(KERN_ERR
+				       "ps3fbd: ps3av_set_video_mode failed\n");
+			first = 0;
+		}
 		if (atomic_read(&ps3fb.ext_flip) == 0)
 			ps3fb_sync(0);	/* single buffer */
 	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
