From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] fb: Push down the BKL in the ioctl
	handler
Date: Thu, 22 May 2008 22:50:24 +0100
Message-ID: <20080522225024.45ec9d74@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzIsC-0007ne-OK for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 15:02:56 -0700
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JzIsB-0000sd-Ie
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 15:02:56 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

Framebuffer is heavily BKL dependant at the moment so just wrap the ioctl
handler in the driver as we push down.

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 776f7fc..17719a3 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1011,103 +1011,134 @@ fb_blank(struct fb_info *info, int blank)
  	return ret;
 }
 
-static int 
-fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+static long
+fb_ioctl(struct file *file, unsigned int cmd,
 	 unsigned long arg)
 {
+	struct inode *inode = file->f_path.dentry->d_inode;
 	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
-	struct fb_ops *fb = info->fbops;
+	struct fb_info *info;
+	struct fb_ops *fb;
 	struct fb_var_screeninfo var;
 	struct fb_fix_screeninfo fix;
 	struct fb_con2fbmap con2fb;
 	struct fb_cmap_user cmap;
 	struct fb_event event;
 	void __user *argp = (void __user *)arg;
-	int i;
-	
-	if (!fb)
+	long ret = 0;
+
+	lock_kernel();
+	info = registered_fb[fbidx];
+	fb = info->fbops;
+
+	if (!fb) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 	switch (cmd) {
 	case FBIOGET_VSCREENINFO:
-		return copy_to_user(argp, &info->var,
+		ret = copy_to_user(argp, &info->var,
 				    sizeof(var)) ? -EFAULT : 0;
+		break;
 	case FBIOPUT_VSCREENINFO:
-		if (copy_from_user(&var, argp, sizeof(var)))
-			return -EFAULT;
+		if (copy_from_user(&var, argp, sizeof(var))) {
+			ret =  -EFAULT;
+			break;
+		}
 		acquire_console_sem();
 		info->flags |= FBINFO_MISC_USEREVENT;
-		i = fb_set_var(info, &var);
+		ret = fb_set_var(info, &var);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
 		release_console_sem();
-		if (i) return i;
-		if (copy_to_user(argp, &var, sizeof(var)))
-			return -EFAULT;
-		return 0;
+		if (ret == 0 && copy_to_user(argp, &var, sizeof(var)))
+			ret = -EFAULT;
+		break;
 	case FBIOGET_FSCREENINFO:
-		return copy_to_user(argp, &info->fix,
+		ret = copy_to_user(argp, &info->fix,
 				    sizeof(fix)) ? -EFAULT : 0;
+		break;
 	case FBIOPUTCMAP:
 		if (copy_from_user(&cmap, argp, sizeof(cmap)))
-			return -EFAULT;
-		return (fb_set_user_cmap(&cmap, info));
+			ret = -EFAULT;
+		else
+			ret = fb_set_user_cmap(&cmap, info);
+		break;
 	case FBIOGETCMAP:
 		if (copy_from_user(&cmap, argp, sizeof(cmap)))
-			return -EFAULT;
-		return fb_cmap_to_user(&info->cmap, &cmap);
+			ret = -EFAULT;
+		else
+			ret = fb_cmap_to_user(&info->cmap, &cmap);
+		break;
 	case FBIOPAN_DISPLAY:
-		if (copy_from_user(&var, argp, sizeof(var)))
-			return -EFAULT;
+		if (copy_from_user(&var, argp, sizeof(var))) {
+			ret = -EFAULT;
+			break;
+		}
 		acquire_console_sem();
-		i = fb_pan_display(info, &var);
+		ret = fb_pan_display(info, &var);
 		release_console_sem();
-		if (i)
-			return i;
-		if (copy_to_user(argp, &var, sizeof(var)))
-			return -EFAULT;
-		return 0;
+		if (ret == 0 && copy_to_user(argp, &var, sizeof(var)))
+			ret = -EFAULT;
+		break;
 	case FBIO_CURSOR:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	case FBIOGET_CON2FBMAP:
 		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
-			return -EFAULT;
-		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
-		    return -EINVAL;
-		con2fb.framebuffer = -1;
-		event.info = info;
-		event.data = &con2fb;
-		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
-		return copy_to_user(argp, &con2fb,
+			ret = -EFAULT;
+		else if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
+		    ret = -EINVAL;
+		else {
+			con2fb.framebuffer = -1;
+			event.info = info;
+			event.data = &con2fb;
+			fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP,
+								&event);
+			ret = copy_to_user(argp, &con2fb,
 				    sizeof(con2fb)) ? -EFAULT : 0;
+		}
+		break;
 	case FBIOPUT_CON2FBMAP:
-		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
-			return - EFAULT;
-		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
-		    return -EINVAL;
-		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
-		    return -EINVAL;
+		if (copy_from_user(&con2fb, argp, sizeof(con2fb))) {
+			ret = - EFAULT;
+			break;
+		}
+		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES) {
+			ret = -EINVAL;
+			break;
+		}
+		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX) {
+			ret = -EINVAL;
+			break;
+		}
 #ifdef CONFIG_KMOD
 		if (!registered_fb[con2fb.framebuffer])
-		    try_to_load(con2fb.framebuffer);
+			try_to_load(con2fb.framebuffer);
 #endif /* CONFIG_KMOD */
-		if (!registered_fb[con2fb.framebuffer])
-		    return -EINVAL;
+		if (!registered_fb[con2fb.framebuffer]) {
+			ret = -EINVAL;
+			break;
+		}
 		event.info = info;
 		event.data = &con2fb;
-		return fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP,
+		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP,
 					      &event);
+		break;
 	case FBIOBLANK:
 		acquire_console_sem();
 		info->flags |= FBINFO_MISC_USEREVENT;
-		i = fb_blank(info, arg);
+		ret = fb_blank(info, arg);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
 		release_console_sem();
-		return i;
+		break;;
 	default:
 		if (fb->fb_ioctl == NULL)
-			return -EINVAL;
-		return fb->fb_ioctl(info, cmd, arg);
+			ret = -ENOTTY;
+		else
+			ret = fb->fb_ioctl(info, cmd, arg);
 	}
+	unlock_kernel();
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
@@ -1161,7 +1192,7 @@ static int fb_getput_cmap(struct inode *inode, struct file *file,
 	    put_user(compat_ptr(data), &cmap->transp))
 		return -EFAULT;
 
-	err = fb_ioctl(inode, file, cmd, (unsigned long) cmap);
+	err = fb_ioctl(file, cmd, (unsigned long) cmap);
 
 	if (!err) {
 		if (copy_in_user(&cmap32->start,
@@ -1215,7 +1246,7 @@ static int fb_get_fscreeninfo(struct inode *inode, struct file *file,
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
-	err = fb_ioctl(inode, file, cmd, (unsigned long) &fix);
+	err = fb_ioctl(file, cmd, (unsigned long) &fix);
 	set_fs(old_fs);
 
 	if (!err)
@@ -1242,7 +1273,7 @@ fb_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FBIOPUT_CON2FBMAP:
 		arg = (unsigned long) compat_ptr(arg);
 	case FBIOBLANK:
-		ret = fb_ioctl(inode, file, cmd, arg);
+		ret = fb_ioctl(file, cmd, arg);
 		break;
 
 	case FBIOGET_FSCREENINFO:
@@ -1360,7 +1391,7 @@ static const struct file_operations fb_fops = {
 	.owner =	THIS_MODULE,
 	.read =		fb_read,
 	.write =	fb_write,
-	.ioctl =	fb_ioctl,
+	.unlocked_ioctl = fb_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = fb_compat_ioctl,
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
