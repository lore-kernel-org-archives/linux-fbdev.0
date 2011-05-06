From: Anca Emanuel <anca.emanuel@gmail.com>
Date: Fri, 06 May 2011 00:21:25 +0000
Subject: Re: [PATCH] fbcon -- fix race between open and removal of framebuffers
Message-Id: <BANLkTik4FDvBBE6syMj_kUNsCMG5x5wvuQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304617307-7389-1-git-send-email-tim.gardner@canonical.com>
	<1304617307-7389-2-git-send-email-tim.gardner@canonical.com>
In-Reply-To: <1304617307-7389-2-git-send-email-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: tim.gardner@canonical.com
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

On Thu, May 5, 2011 at 8:41 PM,  <tim.gardner@canonical.com> wrote:
> From: Andy Whitcroft <apw@canonical.com>
>
> Currently there is no locking for updates to the registered_fb list.
> This allows an open through /dev/fbN to pick up a registered framebuffer
> pointer in parallel with it being released, as happens when a conflicting
> framebuffer is ejected or on module unload. =A0There is also no reference
> counting on the framebuffer descriptor which is referenced from all open
> files, leading to references to released or reused memory to persist on
> these open files.
>
> This patch adds a reference count to the framebuffer descriptor to prevent
> it from being released until after all pending opens are closed. =A0This
> allows the pending opens to detect the closed status and unmap themselves.
> It also adds locking to the framebuffer lookup path, locking it against
> the removal path such that it is possible to atomically lookup and take a
> reference to the descriptor. =A0It also adds locking to the read and write
> paths which currently could access the framebuffer descriptor after it
> has been freed. =A0Finally it moves the device to FBINFO_STATE_REMOVED to
> indicate that all access should be errored for this device.
>
> Signed-off-by: Andy Whitcroft <apw@canonical.com>
> Acked-by: Stefan Bader <stefan.bader@canonical.com>
> Signed-off-by: Leann Ogasawara <leann.ogasawara@canonical.com>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
> =A0drivers/video/fbmem.c | =A0132 ++++++++++++++++++++++++++++++++++++++-=
----------
> =A0include/linux/fb.h =A0 =A0| =A0 =A02 +
> =A02 files changed, 105 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index e0c2284..c8562c1 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -42,6 +42,8 @@
>
> =A0#define FBPIXMAPSIZE =A0 (1024 * 8)
>
> +/* Protects the registered framebuffer list and count. */
> +static DEFINE_SPINLOCK(registered_lock);
> =A0struct fb_info *registered_fb[FB_MAX] __read_mostly;
> =A0int num_registered_fb __read_mostly;
>
> @@ -694,9 +696,7 @@ static ssize_t
> =A0fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppo=
s)
> =A0{
> =A0 =A0 =A0 =A0unsigned long p =3D *ppos;
> - =A0 =A0 =A0 struct inode *inode =3D file->f_path.dentry->d_inode;
> - =A0 =A0 =A0 int fbidx =3D iminor(inode);
> - =A0 =A0 =A0 struct fb_info *info =3D registered_fb[fbidx];
> + =A0 =A0 =A0 struct fb_info *info =3D file->private_data;
> =A0 =A0 =A0 =A0u8 *buffer, *dst;
> =A0 =A0 =A0 =A0u8 __iomem *src;
> =A0 =A0 =A0 =A0int c, cnt =3D 0, err =3D 0;
> @@ -705,19 +705,28 @@ fb_read(struct file *file, char __user *buf, size_t=
 count, loff_t *ppos)
> =A0 =A0 =A0 =A0if (!info || ! info->screen_base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 if (info->state !=3D FBINFO_STATE_RUNNING)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> + =A0 =A0 =A0 if (!lock_fb_info(info))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 if (info->state !=3D FBINFO_STATE_RUNNING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EPERM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 if (info->fbops->fb_read)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return info->fbops->fb_read(info, buf, coun=
t, ppos);
> + =A0 =A0 =A0 if (info->fbops->fb_read) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D info->fbops->fb_read(info, buf, cou=
nt, ppos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0total_size =3D info->screen_size;
>
> =A0 =A0 =A0 =A0if (total_size =3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0total_size =3D info->fix.smem_len;
>
> - =A0 =A0 =A0 if (p >=3D total_size)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (p >=3D total_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (count >=3D total_size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count =3D total_size;
> @@ -727,8 +736,10 @@ fb_read(struct file *file, char __user *buf, size_t =
count, loff_t *ppos)
>
> =A0 =A0 =A0 =A0buffer =3D kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> - =A0 =A0 =A0 if (!buffer)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 if (!buffer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0src =3D (u8 __iomem *) (info->screen_base + p);
>
> @@ -751,19 +762,21 @@ fb_read(struct file *file, char __user *buf, size_t=
 count, loff_t *ppos)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cnt +=3D c;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count -=3D c;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D cnt;
>
> =A0 =A0 =A0 =A0kfree(buffer);
> +out_fb_info:
> + =A0 =A0 =A0 unlock_fb_info(info);
>
> - =A0 =A0 =A0 return (err) ? err : cnt;
> + =A0 =A0 =A0 return err;
> =A0}
>
> =A0static ssize_t
> =A0fb_write(struct file *file, const char __user *buf, size_t count, loff=
_t *ppos)
> =A0{
> =A0 =A0 =A0 =A0unsigned long p =3D *ppos;
> - =A0 =A0 =A0 struct inode *inode =3D file->f_path.dentry->d_inode;
> - =A0 =A0 =A0 int fbidx =3D iminor(inode);
> - =A0 =A0 =A0 struct fb_info *info =3D registered_fb[fbidx];
> + =A0 =A0 =A0 struct fb_info *info =3D file->private_data;
> =A0 =A0 =A0 =A0u8 *buffer, *src;
> =A0 =A0 =A0 =A0u8 __iomem *dst;
> =A0 =A0 =A0 =A0int c, cnt =3D 0, err =3D 0;
> @@ -772,8 +785,13 @@ fb_write(struct file *file, const char __user *buf, =
size_t count, loff_t *ppos)
> =A0 =A0 =A0 =A0if (!info || !info->screen_base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 if (info->state !=3D FBINFO_STATE_RUNNING)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> + =A0 =A0 =A0 if (!lock_fb_info(info))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 if (info->state !=3D FBINFO_STATE_RUNNING) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EPERM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (info->fbops->fb_write)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return info->fbops->fb_write(info, buf, co=
unt, ppos);
> @@ -783,8 +801,10 @@ fb_write(struct file *file, const char __user *buf, =
size_t count, loff_t *ppos)
> =A0 =A0 =A0 =A0if (total_size =3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0total_size =3D info->fix.smem_len;
>
> - =A0 =A0 =A0 if (p > total_size)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFBIG;
> + =A0 =A0 =A0 if (p > total_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EFBIG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (count > total_size) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EFBIG;
> @@ -800,8 +820,10 @@ fb_write(struct file *file, const char __user *buf, =
size_t count, loff_t *ppos)
>
> =A0 =A0 =A0 =A0buffer =3D kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> - =A0 =A0 =A0 if (!buffer)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 if (!buffer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fb_info;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0dst =3D (u8 __iomem *) (info->screen_base + p);
>
> @@ -825,10 +847,14 @@ fb_write(struct file *file, const char __user *buf,=
 size_t count, loff_t *ppos)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cnt +=3D c;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count -=3D c;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (cnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D cnt;
>
> =A0 =A0 =A0 =A0kfree(buffer);
> +out_fb_info:
> + =A0 =A0 =A0 unlock_fb_info(info);
>
> - =A0 =A0 =A0 return (cnt) ? cnt : err;
> + =A0 =A0 =A0 return err;
> =A0}
>
> =A0int
> @@ -1303,8 +1329,7 @@ static long fb_compat_ioctl(struct file *file, unsi=
gned int cmd,
> =A0static int
> =A0fb_mmap(struct file *file, struct vm_area_struct * vma)
> =A0{
> - =A0 =A0 =A0 int fbidx =3D iminor(file->f_path.dentry->d_inode);
> - =A0 =A0 =A0 struct fb_info *info =3D registered_fb[fbidx];
> + =A0 =A0 =A0 struct fb_info * const info =3D file->private_data;
> =A0 =A0 =A0 =A0struct fb_ops *fb =3D info->fbops;
> =A0 =A0 =A0 =A0unsigned long off;
> =A0 =A0 =A0 =A0unsigned long start;
> @@ -1316,6 +1341,11 @@ fb_mmap(struct file *file, struct vm_area_struct *=
 vma)
> =A0 =A0 =A0 =A0if (!fb)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0mutex_lock(&info->mm_lock);
> + =A0 =A0 =A0 if (info->state =3D FBINFO_STATE_REMOVED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&info->mm_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (fb->fb_mmap) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int res;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res =3D fb->fb_mmap(info, vma);
> @@ -1352,6 +1382,34 @@ fb_mmap(struct file *file, struct vm_area_struct *=
 vma)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static struct fb_info *get_framebuffer_info(int idx)
> +__acquires(&registered_lock)
> +__releases(&registered_lock)
> +{
> + =A0 =A0 =A0 struct fb_info *fb_info;
> +
> + =A0 =A0 =A0 spin_lock(&registered_lock);
> + =A0 =A0 =A0 fb_info =3D registered_fb[idx];
> + =A0 =A0 =A0 fb_info->ref_count++;
> + =A0 =A0 =A0 spin_unlock(&registered_lock);
> +
> + =A0 =A0 =A0 return fb_info;
> +}
> +
> +static void put_framebuffer_info(struct fb_info *fb_info)
> +__acquires(&registered_lock)
> +__releases(&registered_lock)
> +{
> + =A0 =A0 =A0 int keep;
> +
> + =A0 =A0 =A0 spin_lock(&registered_lock);
> + =A0 =A0 =A0 keep =3D --fb_info->ref_count;
> + =A0 =A0 =A0 spin_unlock(&registered_lock);
> +
> + =A0 =A0 =A0 if (!keep && fb_info->fbops->fb_destroy)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_info->fbops->fb_destroy(fb_info);
> +}
> +
> =A0static int
> =A0fb_open(struct inode *inode, struct file *file)
> =A0__acquires(&info->lock)
> @@ -1363,13 +1421,17 @@ __releases(&info->lock)
>
> =A0 =A0 =A0 =A0if (fbidx >=3D FB_MAX)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> - =A0 =A0 =A0 info =3D registered_fb[fbidx];
> + =A0 =A0 =A0 info =3D get_framebuffer_info(fbidx);
> =A0 =A0 =A0 =A0if (!info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0request_module("fb%d", fbidx);
> - =A0 =A0 =A0 info =3D registered_fb[fbidx];
> + =A0 =A0 =A0 info =3D get_framebuffer_info(fbidx);
> =A0 =A0 =A0 =A0if (!info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0mutex_lock(&info->lock);
> + =A0 =A0 =A0 if (info->state =3D FBINFO_STATE_REMOVED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (!try_module_get(info->fbops->owner)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> @@ -1386,6 +1448,8 @@ __releases(&info->lock)
> =A0#endif
> =A0out:
> =A0 =A0 =A0 =A0mutex_unlock(&info->lock);
> + =A0 =A0 =A0 if (res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_framebuffer_info(info);
> =A0 =A0 =A0 =A0return res;
> =A0}
>
> @@ -1401,6 +1465,7 @@ __releases(&info->lock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->fbops->fb_release(info,1);
> =A0 =A0 =A0 =A0module_put(info->fbops->owner);
> =A0 =A0 =A0 =A0mutex_unlock(&info->lock);
> + =A0 =A0 =A0 put_framebuffer_info(info);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -1549,6 +1614,7 @@ register_framebuffer(struct fb_info *fb_info)
> =A0 =A0 =A0 =A0fb_info->node =3D i;
> =A0 =A0 =A0 =A0mutex_init(&fb_info->lock);
> =A0 =A0 =A0 =A0mutex_init(&fb_info->mm_lock);
> + =A0 =A0 =A0 fb_info->ref_count =3D 1;
>
> =A0 =A0 =A0 =A0fb_info->dev =3D device_create(fb_class, fb_info->device,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 M=
KDEV(FB_MAJOR, i), NULL, "fb%d", i);
> @@ -1592,7 +1658,6 @@ register_framebuffer(struct fb_info *fb_info)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -
> =A0/**
> =A0* =A0 =A0 unregister_framebuffer - releases a frame buffer device
> =A0* =A0 =A0 @fb_info: frame buffer info structure
> @@ -1627,6 +1692,16 @@ unregister_framebuffer(struct fb_info *fb_info)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0event.info =3D fb_info;
> =A0 =A0 =A0 =A0ret =3D fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
> + =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&fb_info->mm_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We must prevent any operations for thi=
s transition, we
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* already have info->lock so grab the in=
fo->mm_lock to hold
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the remainder.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_info->state =3D FBINFO_STATE_REMOVED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&fb_info->mm_lock);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0unlock_fb_info(fb_info);
>
> =A0 =A0 =A0 =A0if (ret) {
> @@ -1646,8 +1721,7 @@ unregister_framebuffer(struct fb_info *fb_info)
> =A0 =A0 =A0 =A0fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
>
> =A0 =A0 =A0 =A0/* this may free fb info */
> - =A0 =A0 =A0 if (fb_info->fbops->fb_destroy)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb_info->fbops->fb_destroy(fb_info);
> + =A0 =A0 =A0 put_framebuffer_info(fb_info);
> =A0done:
> =A0 =A0 =A0 =A0return ret;
> =A0}
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index df728c1..60de3fa 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -834,6 +834,7 @@ struct fb_tile_ops {
> =A0struct fb_info {
> =A0 =A0 =A0 =A0int node;
> =A0 =A0 =A0 =A0int flags;
> + =A0 =A0 =A0 int ref_count;
> =A0 =A0 =A0 =A0struct mutex lock; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Lock for =
open/release/ioctl funcs */
> =A0 =A0 =A0 =A0struct mutex mm_lock; =A0 =A0 =A0 =A0 =A0 /* Lock for fb_m=
map and smem_* fields */
> =A0 =A0 =A0 =A0struct fb_var_screeninfo var; =A0 /* Current var */
> @@ -873,6 +874,7 @@ struct fb_info {
> =A0 =A0 =A0 =A0void *pseudo_palette; =A0 =A0 =A0 =A0 =A0 /* Fake palette =
of 16 colors */
> =A0#define FBINFO_STATE_RUNNING =A0 0
> =A0#define FBINFO_STATE_SUSPENDED 1
> +#define FBINFO_STATE_REMOVED =A0 2
> =A0 =A0 =A0 =A0u32 state; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* H=
ardware state i.e suspend */
> =A0 =A0 =A0 =A0void *fbcon_par; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fbcon u=
se-only private area */
> =A0 =A0 =A0 =A0/* From here on everything is device dependent */
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

Tested-by: Anca Emanuel <anca.emanuel.gmail.com>

I can not use S3 resume without this.
[   21.964367] BUG: unable to handle kernel paging request at 0000010a00000=
010
[   21.964396] IP: [<ffffffff8130abe0>] fb_release+0x30/0x70
[   21.964410] PGD 0
[   21.964416] Oops: 0000 [#1] SMP
[   21.964424] last sysfs file: /sys/devices/virtual/vtconsole/vtcon1/uevent
[   21.964434] CPU 1
[   21.964438] Modules linked in: parport_pc ppdev
snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm
adt7475 hwmon_vid snd_seq_midi snd_rawmidi snd_seq_midi_event nouveau
snd_seq snd_timer snd_seq_device ttm drm_kms_helper snd intel_agp
psmouse soundcore serio_raw intel_gtt snd_page_alloc drm i2c_algo_bit
video lp parport pata_marvell ahci libahci r8169 mii
[   21.964528]
[   21.964533] Pid: 221, comm: plymouthd Not tainted 2.6.39-rc6 #7
MICRO-STAR INTERNATIONAL CO.,LTD MS-7360/MS-7360
[   21.964548] RIP: 0010:[<ffffffff8130abe0>]  [<ffffffff8130abe0>]
fb_release+0x30/0x70
[   21.964560] RSP: 0018:ffff880037211eb8  EFLAGS: 00010286
[   21.964566] RAX: ffff880037210000 RBX: ffff88007f817000 RCX: 00000000000=
00001
[   21.964573] RDX: 0000010a00000000 RSI: ffff8800370f5540 RDI: ffff88007f8=
17008
[   21.964580] RBP: ffff880037211ec8 R08: 0000000000000000 R09: 00000000000=
00000
[   21.964588] R10: ffff8800370f5550 R11: 0000000000000246 R12: ffff88007f8=
17008
[   21.964595] R13: ffff88007d3db540 R14: ffff88007be34d90 R15: ffff88007be=
34d90
[   21.964604] FS:  00007fb335025720(0000) GS:ffff88007fc80000(0000)
knlGS:0000000000000000
[   21.964739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.964746] CR2: 0000010a00000010 CR3: 000000007b41a000 CR4: 00000000000=
006e0
[   21.964754] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   21.964762] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
00400
[   21.964770] Process plymouthd (pid: 221, threadinfo
ffff880037210000, task ffff880036cd16c0)
[   21.964778] Stack:
[   21.964782]  ffff8800370f5540 0000000000000008 ffff880037211f18
ffffffff8115cfaa
[   21.964797]  ffff8800370f5550 ffff8800793c7b00 ffff88006744fcd0
ffff8800370f5540
[   21.964811]  ffff88007c3b9080 0000000000000000 000000000000000b
0000000000000000
[   21.964825] Call Trace:
[   21.964834]  [<ffffffff8115cfaa>] fput+0xea/0x220
[   21.964842]  [<ffffffff811591f6>] filp_close+0x66/0x90
[   21.964849]  [<ffffffff811597c7>] sys_close+0xb7/0x120
[   21.964858]  [<ffffffff815b3002>] system_call_fastpath+0x16/0x1b
[   21.964865] Code: 83 ec 10 48 89 1c 24 4c 89 64 24 08 0f 1f 44 00
00 48 8b 9e a0 00 00 00 4c 8d 63 08 4c 89 e7 e8 d7 ea 29 00 48 8b 93
b8 03 00 00
[   21.964944]  8b 42 10 48 85 c0 74 11 be 01 00 00 00 48 89 df ff d0 48 8b
[   21.964983] RIP  [<ffffffff8130abe0>] fb_release+0x30/0x70
[   21.964992]  RSP <ffff880037211eb8>
[   21.964997] CR2: 0000010a00000010
