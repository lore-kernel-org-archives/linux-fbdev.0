From: Thiago Galesi <thiagogalesi@gmail.com>
Subject: Re: [PATCH] fb: Remove use of lock_kernel /
	unlock_kernel in fbmem
Date: Wed, 16 Apr 2008 20:00:59 -0300
Message-ID: <200804162000.59587.thiagogalesi@gmail.com>
References: <200804131150.07601.thiagogalesi@gmail.com>
	<20080415221707.82da3d42.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JmGd8-0003lW-Ac for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Apr 2008 16:01:30 -0700
Received: from yw-out-1718.google.com ([74.125.46.157])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JmGd6-0006nh-Ij
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Apr 2008 16:01:30 -0700
Received: by yw-out-1718.google.com with SMTP id 4so1451303ywq.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Apr 2008 16:01:23 -0700 (PDT)
In-Reply-To: <20080415221707.82da3d42.akpm@linux-foundation.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org





This patch removes lock_kernel(), unlock_kernel() usage in fbmem.c and replaces it with a mutex

Signed-off-by: Thiago Galesi <thiagogalesi@gmail.com>

---

Ok, 2nd try

The only thing I don't like is the name of fb_ioctl, but I don't have a better idea, so...


---

Index: linux-2.6.23.1/drivers/video/fbmem.c
===================================================================
--- linux-2.6.23.1.orig/drivers/video/fbmem.c
+++ linux-2.6.23.1/drivers/video/fbmem.c
@@ -987,7 +987,7 @@ fb_blank(struct fb_info *info, int blank
 }
 
 static int 
-fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+__fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	 unsigned long arg)
 {
 	int fbidx = iminor(inode);
@@ -1085,6 +1085,28 @@ fb_ioctl(struct inode *inode, struct fil
 	}
 }
 
+static int
+fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	 unsigned long arg)
+{
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+	int ret;
+
+	mutex_lock(&info->hwlock);
+	ret = __fb_ioctl(inode, file, cmd, arg);
+	mutex_unlock(&info->hwlock);
+	return ret;
+}
+
+static long
+fb_unlocked_ioctl(struct file *file, unsigned int cmd,
+	 unsigned long arg)
+{
+	struct inode *inode = file->f_path.dentry->d_inode;
+	return fb_ioctl(inode, file, cmd, arg);
+}
+
 #ifdef CONFIG_COMPAT
 struct fb_fix_screeninfo32 {
 	char			id[16];
@@ -1136,7 +1158,7 @@ static int fb_getput_cmap(struct inode *
 	    put_user(compat_ptr(data), &cmap->transp))
 		return -EFAULT;
 
-	err = fb_ioctl(inode, file, cmd, (unsigned long) cmap);
+	err = __fb_ioctl(inode, file, cmd, (unsigned long) cmap);
 
 	if (!err) {
 		if (copy_in_user(&cmap32->start,
@@ -1190,7 +1212,7 @@ static int fb_get_fscreeninfo(struct ino
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
-	err = fb_ioctl(inode, file, cmd, (unsigned long) &fix);
+	err = __fb_ioctl(inode, file, cmd, (unsigned long) &fix);
 	set_fs(old_fs);
 
 	if (!err)
@@ -1208,7 +1230,7 @@ fb_compat_ioctl(struct file *file, unsig
 	struct fb_ops *fb = info->fbops;
 	long ret = -ENOIOCTLCMD;
 
-	lock_kernel();
+	mutex_lock(&info->hwlock);
 	switch(cmd) {
 	case FBIOGET_VSCREENINFO:
 	case FBIOPUT_VSCREENINFO:
@@ -1217,7 +1239,7 @@ fb_compat_ioctl(struct file *file, unsig
 	case FBIOPUT_CON2FBMAP:
 		arg = (unsigned long) compat_ptr(arg);
 	case FBIOBLANK:
-		ret = fb_ioctl(inode, file, cmd, arg);
+		ret = __fb_ioctl(inode, file, cmd, arg);
 		break;
 
 	case FBIOGET_FSCREENINFO:
@@ -1234,7 +1256,7 @@ fb_compat_ioctl(struct file *file, unsig
 			ret = fb->fb_compat_ioctl(info, cmd, arg);
 		break;
 	}
-	unlock_kernel();
+	mutex_unlock(&info->hwlock);
 	return ret;
 }
 #endif
@@ -1256,13 +1278,13 @@ fb_mmap(struct file *file, struct vm_are
 		return -ENODEV;
 	if (fb->fb_mmap) {
 		int res;
-		lock_kernel();
+		mutex_lock(&info->hwlock);
 		res = fb->fb_mmap(info, vma);
-		unlock_kernel();
+		mutex_unlock(&info->hwlock);
 		return res;
 	}
 
-	lock_kernel();
+	mutex_lock(&info->hwlock);
 
 	/* frame buffer memory */
 	start = info->fix.smem_start;
@@ -1271,13 +1293,13 @@ fb_mmap(struct file *file, struct vm_are
 		/* memory mapped io */
 		off -= len;
 		if (info->var.accel_flags) {
-			unlock_kernel();
+			mutex_unlock(&info->hwlock);
 			return -EINVAL;
 		}
 		start = info->fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
 	}
-	unlock_kernel();
+	mutex_unlock(&info->hwlock);
 	start &= PAGE_MASK;
 	if ((vma->vm_end - vma->vm_start + off) > len)
 		return -EINVAL;
@@ -1323,25 +1345,25 @@ fb_release(struct inode *inode, struct f
 {
 	struct fb_info * const info = file->private_data;
 
-	lock_kernel();
+	mutex_lock(&info->hwlock);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
-	unlock_kernel();
+	mutex_unlock(&info->hwlock);
 	return 0;
 }
 
 static const struct file_operations fb_fops = {
-	.owner =	THIS_MODULE,
-	.read =		fb_read,
-	.write =	fb_write,
-	.ioctl =	fb_ioctl,
+	.owner =		THIS_MODULE,
+	.read =			fb_read,
+	.write =		fb_write,
+	.unlocked_ioctl =	fb_unlocked_ioctl,
 #ifdef CONFIG_COMPAT
-	.compat_ioctl = fb_compat_ioctl,
+	.compat_ioctl = 	fb_compat_ioctl,
 #endif
-	.mmap =		fb_mmap,
-	.open =		fb_open,
-	.release =	fb_release,
+	.mmap =			fb_mmap,
+	.open =			fb_open,
+	.release =		fb_release,
 #ifdef HAVE_ARCH_FB_UNMAPPED_AREA
 	.get_unmapped_area = get_fb_unmapped_area,
 #endif
@@ -1413,6 +1435,8 @@ register_framebuffer(struct fb_info *fb_
 
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
+
+	mutex_init(&fb_info->hwlock);
 	return 0;
 }
 
@@ -1464,6 +1488,7 @@ unregister_framebuffer(struct fb_info *f
 	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
+	mutex_destroy(&fb_info.hwlock);
 done:
 	return ret;
 }
Index: linux-2.6.23.1/include/linux/fb.h
===================================================================
--- linux-2.6.23.1.orig/include/linux/fb.h
+++ linux-2.6.23.1/include/linux/fb.h
@@ -802,6 +802,7 @@ struct fb_info {
 	struct list_head modelist;      /* mode list */
 	struct fb_videomode *mode;	/* current mode */
 
+	struct mutex hwlock;		/* mutex for protecting hw ops */
 #ifdef CONFIG_FB_BACKLIGHT
 	/* assigned backlight device */
 	/* set before framebuffer registration, 







-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
