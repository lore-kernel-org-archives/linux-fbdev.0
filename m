From: Jesse Barker <jesse.barker@linaro.org>
Date: Wed, 20 Jun 2012 15:09:19 +0000
Subject: Re: [Linaro-mm-sig] [RFC/PATCH] fb: Add dma-buf support
Message-Id: <CAC57bwtvfYDGO91r3zRry+WENm7x=UZ6TdOkXpmHDbQWT0feRA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340201368-20751-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1340201368-20751-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org

Laurent,

Your recent documentation efforts are extremely commendable.  Just a
couple of small nits below...

On Wed, Jun 20, 2012 at 7:09 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Add support for the dma-buf exporter role to the frame buffer API. The
> importer role isn't meaningful for frame buffer devices, as the frame
> buffer device model doesn't allow using externally allocated memory.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =A0Documentation/fb/api.txt | =A0 36 ++++++++++++++++++++++++++++++++++++
> =A0drivers/video/fbmem.c =A0 =A0| =A0 36 ++++++++++++++++++++++++++++++++=
++++
> =A0include/linux/fb.h =A0 =A0 =A0 | =A0 12 ++++++++++++
> =A03 files changed, 84 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/fb/api.txt b/Documentation/fb/api.txt
> index d4ff7de..f0b2173 100644
> --- a/Documentation/fb/api.txt
> +++ b/Documentation/fb/api.txt
> @@ -304,3 +304,39 @@ extensions.
> =A0Upon successful format configuration, drivers update the fb_fix_screen=
info
> =A0type, visual and line_length fields depending on the selected format. =
The type
> =A0and visual fields are set to FB_TYPE_FOURCC and FB_VISUAL_FOURCC respe=
ctively.
> +
> +
> +5. DMA buffer sharing
> +---------------------
> +
> +The dma-buf kernel framework allows DMA buffers to be shared across devi=
ces
> +and applications. Sharing buffers across display devices and video captu=
re or
> +video decoding devices allow zero-copy operation when displaying video c=
ontent
> +produced by a hardware device such as a camera or a hardware codec. This=
 is
> +crucial to achieve optimal system performances during video display.
> +
> +While dma-buf supports both exporting internally allocated memory as a d=
ma-buf
> +object (known as the exporter role) and importing a dma-buf object to be=
 used
> +as device memory (known as the importer role), the frame buffer API only
> +supports the exporter role, as the frame buffer device model doesn't sup=
port
> +using externally-allocated memory.
> +
> +The export a frame buffer as a dma-buf file descriptors, applications ca=
ll the

s/The/To
s/descriptors/descriptor

cheers,
Jesse

> +FBIOGET_DMABUF ioctl. The ioctl takes a pointer to a fb_dmabuf_export
> +structure.
> +
> +struct fb_dmabuf_export {
> + =A0 =A0 =A0 __u32 fd;
> + =A0 =A0 =A0 __u32 flags;
> +};
> +
> +The flag field specifies the flags to be used when creating the dma-buf =
file
> +descriptor. The only supported flag is O_CLOEXEC. If the call is success=
ful,
> +the driver will set the fd field to a file descriptor corresponding to t=
he
> +dma-buf object.
> +
> +Applications can then pass the file descriptors to another application or
> +another device driver. The dma-buf object is automatically reference-cou=
nted,
> +applications can and should close the file descriptor as soon as they do=
n't
> +need it anymore. The underlying dma-buf object will not be freed before =
the
> +last device that uses the dma-buf object releases it.
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 0dff12a..400e449 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -15,6 +15,7 @@
>
> =A0#include <linux/compat.h>
> =A0#include <linux/types.h>
> +#include <linux/dma-buf.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/kernel.h>
> =A0#include <linux/major.h>
> @@ -1074,6 +1075,23 @@ fb_blank(struct fb_info *info, int blank)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> +int
> +fb_get_dmabuf(struct fb_info *info, int flags)
> +{
> + =A0 =A0 =A0 struct dma_buf *dmabuf;
> +
> + =A0 =A0 =A0 if (info->fbops->fb_dmabuf_export =3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOTTY;
> +
> + =A0 =A0 =A0 dmabuf =3D info->fbops->fb_dmabuf_export(info);
> + =A0 =A0 =A0 if (IS_ERR(dmabuf))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(dmabuf);
> +
> + =A0 =A0 =A0 return dma_buf_fd(dmabuf, flags);
> +}
> +#endif
> +
> =A0static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long arg)
> =A0{
> @@ -1084,6 +1102,7 @@ static long do_fb_ioctl(struct fb_info *info, unsig=
ned int cmd,
> =A0 =A0 =A0 =A0struct fb_cmap cmap_from;
> =A0 =A0 =A0 =A0struct fb_cmap_user cmap;
> =A0 =A0 =A0 =A0struct fb_event event;
> + =A0 =A0 =A0 struct fb_dmabuf_export dmaexp;
> =A0 =A0 =A0 =A0void __user *argp =3D (void __user *)arg;
> =A0 =A0 =A0 =A0long ret =3D 0;
>
> @@ -1191,6 +1210,23 @@ static long do_fb_ioctl(struct fb_info *info, unsi=
gned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0console_unlock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unlock_fb_info(info);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> + =A0 =A0 =A0 case FBIOGET_DMABUF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&dmaexp, argp, sizeof(dm=
aexp)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!lock_fb_info(info))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmaexp.fd =3D fb_get_dmabuf(info, dmaexp.fl=
ags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unlock_fb_info(info);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dmaexp.fd < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dmaexp.fd;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D copy_to_user(argp, &dmaexp, sizeof(=
dmaexp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? -EFAULT : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +#endif
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!lock_fb_info(info))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index ac3f1c6..c9fee75 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -39,6 +39,7 @@
> =A0#define FBIOPUT_MODEINFO =A0 =A0 =A0 =A00x4617
> =A0#define FBIOGET_DISPINFO =A0 =A0 =A0 =A00x4618
> =A0#define FBIO_WAITFORVSYNC =A0 =A0 =A0_IOW('F', 0x20, __u32)
> +#define FBIOGET_DMABUF =A0 =A0 =A0 =A0 _IOR('F', 0x21, struct fb_dmabuf_=
export)
>
> =A0#define FB_TYPE_PACKED_PIXELS =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 /* Pack=
ed Pixels =A0 =A0 =A0 =A0*/
> =A0#define FB_TYPE_PLANES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 /=
* Non interleaved planes */
> @@ -403,6 +404,11 @@ struct fb_cursor {
> =A0#define FB_BACKLIGHT_MAX =A0 =A0 =A0 0xFF
> =A0#endif
>
> +struct fb_dmabuf_export {
> + =A0 =A0 =A0 __u32 fd;
> + =A0 =A0 =A0 __u32 flags;
> +};
> +
> =A0#ifdef __KERNEL__
>
> =A0#include <linux/fs.h>
> @@ -418,6 +424,7 @@ struct vm_area_struct;
> =A0struct fb_info;
> =A0struct device;
> =A0struct file;
> +struct dma_buf;
>
> =A0/* Definitions below are used in the parsed monitor specs */
> =A0#define FB_DPMS_ACTIVE_OFF =A0 =A0 1
> @@ -701,6 +708,11 @@ struct fb_ops {
> =A0 =A0 =A0 =A0/* called at KDB enter and leave time to prepare the conso=
le */
> =A0 =A0 =A0 =A0int (*fb_debug_enter)(struct fb_info *info);
> =A0 =A0 =A0 =A0int (*fb_debug_leave)(struct fb_info *info);
> +
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> + =A0 =A0 =A0 /* Export the frame buffer as a dmabuf object */
> + =A0 =A0 =A0 struct dma_buf *(*fb_dmabuf_export)(struct fb_info *info);
> +#endif
> =A0};
>
> =A0#ifdef CONFIG_FB_TILEBLITTING
> --
> Regards,
>
> Laurent Pinchart
>
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
