From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Jan 2020 17:51:17 +0000
Subject: Re: [PATCH] fbdev: wait for references go away
Message-Id: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
In-Reply-To: <20200120100014.23488-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, marmarek@invisiblethingslab.com, open list <linux-kernel@vger.kernel.org>


Hi,

On 1/20/20 11:00 AM, Gerd Hoffmann wrote:
> Problem: do_unregister_framebuffer() might return before the device is
> fully cleaned up, due to userspace having a file handle for /dev/fb0

do_unregister_framebuffer() doesn't guarantee that fb_info is freed after
function's return (it only drops the kernel reference on fb_info).

> open.  Which can result in drm driver not being able to grab resources
> (and fail initialization) because the firmware framebuffer still holds
> them.  Reportedly plymouth can trigger this.

Could you please describe issue some more?

I guess that a problem is happening during DRM driver load while fbdev
driver is loaded? I assume do_unregister_framebuffer() is called inside
do_remove_conflicting_framebuffers()?

At first glance it seems to be an user-space issue as it should not be
holding references on /dev/fb0 while DRM driver is being loaded.

> Fix this by trying to wait until all references are gone.  Don't wait
> forever though given that userspace might keep the file handle open.

Where does the 1s maximum delay come from?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/fbdev/core/fbmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index d04554959ea7..2ea8ac05b065 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -35,6 +35,7 @@
>  #include <linux/fbcon.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
> =20
>  #include <asm/fb.h>
> =20
> @@ -1707,6 +1708,8 @@ static void unlink_framebuffer(struct fb_info *fb_i=
nfo)
> =20
>  static void do_unregister_framebuffer(struct fb_info *fb_info)
>  {
> +	int limit =3D 100;
> +
>  	unlink_framebuffer(fb_info);
>  	if (fb_info->pixmap.addr &&
>  	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
> @@ -1726,6 +1729,10 @@ static void do_unregister_framebuffer(struct fb_in=
fo *fb_info)
>  	fbcon_fb_unregistered(fb_info);
>  	console_unlock();
> =20
> +	/* try wait until all references are gone */
> +	while (atomic_read(&fb_info->count) > 1 && --limit > 0)
> +		msleep(10);
> +
>  	/* this may free fb info */
>  	put_fb_info(fb_info);
>  }
