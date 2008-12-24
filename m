From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 04/05] video: deferred io sys helpers - metronome
Date: Tue, 23 Dec 2008 23:58:37 -0500
Message-ID: <45a44e480812232058g5e81ee97r95c4b9c1ed81066@mail.gmail.com>
References: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se>
	 <20081222055309.27821.40219.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081222055309.27821.40219.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

On Mon, Dec 22, 2008 at 12:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> Change the metronome driver to use the new shared sys helpers.
> In the future this driver can setup the "sysdelay" value to
> delay flushing.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
>
>  drivers/video/Kconfig       |    4 -
>  drivers/video/metronomefb.c |  102 +++++++------------------------------------
>  2 files changed, 17 insertions(+), 89 deletions(-)
>
> --- 0051/drivers/video/Kconfig
> +++ work/drivers/video/Kconfig  2008-12-22 14:07:15.000000000 +0900
> @@ -2071,10 +2071,6 @@ config XEN_FBDEV_FRONTEND
>  config FB_METRONOME
>        tristate "E-Ink Metronome/8track controller support"
>        depends on FB
> -       select FB_SYS_FILLRECT
> -       select FB_SYS_COPYAREA
> -       select FB_SYS_IMAGEBLIT
> -       select FB_SYS_FOPS
>        select FB_DEFERRED_IO
>        help
>          This driver implements support for the E-Ink Metronome
> --- 0001/drivers/video/metronomefb.c
> +++ work/drivers/video/metronomefb.c    2008-12-22 14:07:15.000000000 +0900
> @@ -445,7 +445,6 @@ static void metronomefb_dpy_update(struc
>
>        cksum = calc_img_cksum((u16 *) par->metromem_img, fbsize/2);
>        *((u16 *)(par->metromem_img) + fbsize/2) = cksum;
> -       metronome_display_cmd(par);
>  }
>
>  static u16 metronomefb_dpy_update_page(struct metronomefb_par *par, int index)
> @@ -472,97 +471,30 @@ static void metronomefb_dpy_deferred_io(
>        struct fb_deferred_io *fbdefio = info->fbdefio;
>        struct metronomefb_par *par = info->par;
>
> -       /* walk the written page list and swizzle the data */
> -       list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> -               cksum = metronomefb_dpy_update_page(par,
> -                                       (cur->index << PAGE_SHIFT));
> -               par->metromem_img_csum -= par->csum_table[cur->index];
> -               par->csum_table[cur->index] = cksum;
> -               par->metromem_img_csum += cksum;
> +       if (fbdefio->dx != -1) {
> +               /* update the entire screen */
> +               metronomefb_dpy_update(par);

Okay, overall seems okay. But I'm not confident about this specific
change above. The meaning of dx, etc is not clear to me. Okay, I think
I found a problem with above. Here's my explanation, please correct me
if I'm wrong in my reading of the code you've posted. The typical use
case is just a single mmap client (eg: Xfbdev) and nothing else. No
fbcon. The only code path I see that sets defio->dx is in the
write/blit/* paths via the defio_touch in patch 1/5 and none in the
mmap path so with this implementation, all mmap clients would
repeatedly only hit the above full update scenario and never use the
page based update mechanism.

> +       } else {
> +               /* walk the written page list and swizzle the data */
> +               list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> +                       cksum = metronomefb_dpy_update_page(par,
> +                                               (cur->index << PAGE_SHIFT));
> +                       par->metromem_img_csum -= par->csum_table[cur->index];
> +                       par->csum_table[cur->index] = cksum;
> +                       par->metromem_img_csum += cksum;
> +               }
>        }
>
>        metronome_display_cmd(par);
>  }
>
> -static void metronomefb_fillrect(struct fb_info *info,
> -                                  const struct fb_fillrect *rect)
> -{
> -       struct metronomefb_par *par = info->par;
> -
> -       sys_fillrect(info, rect);
> -       metronomefb_dpy_update(par);
> -}
> -
> -static void metronomefb_copyarea(struct fb_info *info,
> -                                  const struct fb_copyarea *area)
> -{
> -       struct metronomefb_par *par = info->par;
> -
> -       sys_copyarea(info, area);
> -       metronomefb_dpy_update(par);
> -}
> -
> -static void metronomefb_imageblit(struct fb_info *info,
> -                               const struct fb_image *image)
> -{
> -       struct metronomefb_par *par = info->par;
> -
> -       sys_imageblit(info, image);
> -       metronomefb_dpy_update(par);
> -}
> -
> -/*
> - * this is the slow path from userspace. they can seek and write to
> - * the fb. it is based on fb_sys_write
> - */
> -static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
> -                               size_t count, loff_t *ppos)
> -{
> -       struct metronomefb_par *par = info->par;
> -       unsigned long p = *ppos;
> -       void *dst;
> -       int err = 0;
> -       unsigned long total_size;
> -
> -       if (info->state != FBINFO_STATE_RUNNING)
> -               return -EPERM;
> -
> -       total_size = info->fix.smem_len;
> -
> -       if (p > total_size)
> -               return -EFBIG;
> -
> -       if (count > total_size) {
> -               err = -EFBIG;
> -               count = total_size;
> -       }
> -
> -       if (count + p > total_size) {
> -               if (!err)
> -                       err = -ENOSPC;
> -
> -               count = total_size - p;
> -       }
> -
> -       dst = (void __force *)(info->screen_base + p);
> -
> -       if (copy_from_user(dst, buf, count))
> -               err = -EFAULT;
> -
> -       if  (!err)
> -               *ppos += count;
> -
> -       metronomefb_dpy_update(par);
> -
> -       return (err) ? err : count;
> -}
> -
>  static struct fb_ops metronomefb_ops = {
>        .owner          = THIS_MODULE,
> -       .fb_write       = metronomefb_write,
> -       .fb_fillrect    = metronomefb_fillrect,
> -       .fb_copyarea    = metronomefb_copyarea,
> -       .fb_imageblit   = metronomefb_imageblit,
> +       .fb_read        = fb_deferred_io_read,
> +       .fb_write       = fb_deferred_io_write,
> +       .fb_fillrect    = fb_deferred_io_fillrect,
> +       .fb_copyarea    = fb_deferred_io_copyarea,
> +       .fb_imageblit   = fb_deferred_io_imageblit,
>  };

Other than the above problem, looks okay and its nice to get rid of
all that stuff above. :-)

Thanks,
jaya
