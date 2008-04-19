From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH] fb: Remove use of lock_kernel /
 unlock_kernel in fbmem
Date: Fri, 18 Apr 2008 21:45:21 -0400
Message-ID: <20080418214521.670dd439@ephemeral>
References: <200804131150.07601.thiagogalesi@gmail.com>
	<20080415221707.82da3d42.akpm@linux-foundation.org>
	<200804182154.43834.thiagogalesi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jn26S-0002ix-NX for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Apr 2008 18:42:56 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jn26S-0004KZ-34
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Apr 2008 18:42:56 -0700
In-Reply-To: <200804182154.43834.thiagogalesi@gmail.com>
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
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 18 Apr 2008 21:54:43 -0300
Thiago Galesi <thiagogalesi@gmail.com> wrote:

> Hello
> 
> 
> >Just a minor nit; in general, I'd think you would want to completely
> >initialize the structure (including calling mutex_init) before
> >registering the structure with the rest of the system (in this case,
> >with registered_fb and *_call_notifier_chain).  Initializing after
> >registration is just asking for a race conditions.
> 
> This is better?? 

That does look better, yes.  Someone else who is familiar w/ the locking
semantics there would have to comment on the rest of it.



> 
> 
> ---
> This patch removes lock_kernel(), unlock_kernel() usage in fbmem.c and replaces it with a mutex
> 
> Signed-off-by: Thiago Galesi <thiagogalesi@gmail.com>
> 
> ---
> 
> 
> Index: linux-2.6.23.1/drivers/video/fbmem.c
> ===================================================================
> --- linux-2.6.23.1.orig/drivers/video/fbmem.c	2008-04-16 18:52:32.000000000 -0300
> +++ linux-2.6.23.1/drivers/video/fbmem.c	2008-04-18 19:25:53.000000000 -0300
> @@ -987,7 +987,7 @@
>  }
>  
>  static int 
> -fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
> +__fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
>  {
>  	int fbidx = iminor(inode);
> @@ -1085,6 +1085,28 @@
>  	}
>  }
>  
> +static int
> +fb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
> +	 unsigned long arg)
> +{
> +	int fbidx = iminor(inode);
> +	struct fb_info *info = registered_fb[fbidx];
> +	int ret;
> +
> +	mutex_lock(&info->hwlock);
> +	ret = __fb_ioctl(inode, file, cmd, arg);
> +	mutex_unlock(&info->hwlock);
> +	return ret;
> +}
> +
> +static long
> +fb_unlocked_ioctl(struct file *file, unsigned int cmd,
> +	 unsigned long arg)
> +{
> +	struct inode *inode = file->f_path.dentry->d_inode;
> +	return fb_ioctl(inode, file, cmd, arg);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  struct fb_fix_screeninfo32 {
>  	char			id[16];
> @@ -1136,7 +1158,7 @@
>  	    put_user(compat_ptr(data), &cmap->transp))
>  		return -EFAULT;
>  
> -	err = fb_ioctl(inode, file, cmd, (unsigned long) cmap);
> +	err = __fb_ioctl(inode, file, cmd, (unsigned long) cmap);
>  
>  	if (!err) {
>  		if (copy_in_user(&cmap32->start,
> @@ -1190,7 +1212,7 @@
>  
>  	old_fs = get_fs();
>  	set_fs(KERNEL_DS);
> -	err = fb_ioctl(inode, file, cmd, (unsigned long) &fix);
> +	err = __fb_ioctl(inode, file, cmd, (unsigned long) &fix);
>  	set_fs(old_fs);
>  
>  	if (!err)
> @@ -1208,7 +1230,7 @@
>  	struct fb_ops *fb = info->fbops;
>  	long ret = -ENOIOCTLCMD;
>  
> -	lock_kernel();
> +	mutex_lock(&info->hwlock);
>  	switch(cmd) {
>  	case FBIOGET_VSCREENINFO:
>  	case FBIOPUT_VSCREENINFO:
> @@ -1217,7 +1239,7 @@
>  	case FBIOPUT_CON2FBMAP:
>  		arg = (unsigned long) compat_ptr(arg);
>  	case FBIOBLANK:
> -		ret = fb_ioctl(inode, file, cmd, arg);
> +		ret = __fb_ioctl(inode, file, cmd, arg);
>  		break;
>  
>  	case FBIOGET_FSCREENINFO:
> @@ -1234,7 +1256,7 @@
>  			ret = fb->fb_compat_ioctl(info, cmd, arg);
>  		break;
>  	}
> -	unlock_kernel();
> +	mutex_unlock(&info->hwlock);
>  	return ret;
>  }
>  #endif
> @@ -1256,13 +1278,13 @@
>  		return -ENODEV;
>  	if (fb->fb_mmap) {
>  		int res;
> -		lock_kernel();
> +		mutex_lock(&info->hwlock);
>  		res = fb->fb_mmap(info, vma);
> -		unlock_kernel();
> +		mutex_unlock(&info->hwlock);
>  		return res;
>  	}
>  
> -	lock_kernel();
> +	mutex_lock(&info->hwlock);
>  
>  	/* frame buffer memory */
>  	start = info->fix.smem_start;
> @@ -1271,13 +1293,13 @@
>  		/* memory mapped io */
>  		off -= len;
>  		if (info->var.accel_flags) {
> -			unlock_kernel();
> +			mutex_unlock(&info->hwlock);
>  			return -EINVAL;
>  		}
>  		start = info->fix.mmio_start;
>  		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
>  	}
> -	unlock_kernel();
> +	mutex_unlock(&info->hwlock);
>  	start &= PAGE_MASK;
>  	if ((vma->vm_end - vma->vm_start + off) > len)
>  		return -EINVAL;
> @@ -1323,25 +1345,25 @@
>  {
>  	struct fb_info * const info = file->private_data;
>  
> -	lock_kernel();
> +	mutex_lock(&info->hwlock);
>  	if (info->fbops->fb_release)
>  		info->fbops->fb_release(info,1);
>  	module_put(info->fbops->owner);
> -	unlock_kernel();
> +	mutex_unlock(&info->hwlock);
>  	return 0;
>  }
>  
>  static const struct file_operations fb_fops = {
> -	.owner =	THIS_MODULE,
> -	.read =		fb_read,
> -	.write =	fb_write,
> -	.ioctl =	fb_ioctl,
> +	.owner =		THIS_MODULE,
> +	.read =			fb_read,
> +	.write =		fb_write,
> +	.unlocked_ioctl =	fb_unlocked_ioctl,
>  #ifdef CONFIG_COMPAT
> -	.compat_ioctl = fb_compat_ioctl,
> +	.compat_ioctl = 	fb_compat_ioctl,
>  #endif
> -	.mmap =		fb_mmap,
> -	.open =		fb_open,
> -	.release =	fb_release,
> +	.mmap =			fb_mmap,
> +	.open =			fb_open,
> +	.release =		fb_release,
>  #ifdef HAVE_ARCH_FB_UNMAPPED_AREA
>  	.get_unmapped_area = get_fb_unmapped_area,
>  #endif
> @@ -1377,6 +1399,7 @@
>  			break;
>  	fb_info->node = i;
>  
> +	mutex_init(&fb_info->hwlock);
>  	fb_info->dev = device_create(fb_class, fb_info->device,
>  				     MKDEV(FB_MAJOR, i), "fb%d", i);
>  	if (IS_ERR(fb_info->dev)) {
> @@ -1413,6 +1436,7 @@
>  
>  	event.info = fb_info;
>  	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
> +
>  	return 0;
>  }
>  
> @@ -1464,6 +1488,7 @@
>  	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>  	event.info = fb_info;
>  	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
> +	mutex_destroy(&fb_info.hwlock);
>  done:
>  	return ret;
>  }
> Index: linux-2.6.23.1/include/linux/fb.h
> ===================================================================
> --- linux-2.6.23.1.orig/include/linux/fb.h	2008-04-16 18:52:32.000000000 -0300
> +++ linux-2.6.23.1/include/linux/fb.h	2008-04-16 18:53:22.000000000 -0300
> @@ -802,6 +802,7 @@
>  	struct list_head modelist;      /* mode list */
>  	struct fb_videomode *mode;	/* current mode */
>  
> +	struct mutex hwlock;		/* mutex for protecting hw ops */
>  #ifdef CONFIG_FB_BACKLIGHT
>  	/* assigned backlight device */
>  	/* set before framebuffer registration, 
> 
> 
> 


-- 
Need a kernel or Debian developer?  Contact me, I'm looking for contracts.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
