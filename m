From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 20 Sep 2011 21:46:08 +0000
Subject: Re: [patch 1/1] fb: fix potential deadlock between lock_fb_info and
Message-Id: <4E7909A0.7080803@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201109202111.p8KLBAJD019239@wpaz13.hot.corp.google.com>
In-Reply-To: <201109202111.p8KLBAJD019239@wpaz13.hot.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Andrew,

On 09/20/2011 09:11 PM, akpm@google.com wrote:
> From: Andrea Righi <arighi@develer.com>
> Subject: fb: fix potential deadlock between lock_fb_info and console_lock
>=20
> fb_set_suspend() must be called with the console semaphore held, which
> means the code path coming in here will first take the console_lock() and
> then call lock_fb_info().
>=20
> However several framebuffer ioctl commands acquire these locks in reverse
> order (lock_fb_info() and then console_lock()).  This gives rise to
> potential AB-BA deadlock.
>=20
> Fix this by changing the order of acquisition in the ioctl commands that
> make use of console_lock().

I already have another patch [1] that fixes the same issue in a different w=
ay.
It looks less risky than yours and got more feedback.


Best regards,

Florian Tobias Schandinat


[1] http://marc.info/?l=3Dlinux-kernel&m=130833638508657&w=3D2

>=20
> Signed-off-by: Andrea Righi <arighi@develer.com>
> Reported-by: Peter Nordstr=F6m (Palm GBU) <peter.nordstrom@palm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@kernel.org>
>=20
> Signed-off-by: Andrew Morton <akpm@google.com>
> ---
>=20
>  drivers/video/fbmem.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff -puN drivers/video/fbmem.c~fb-fix-potential-deadlock-between-lock_fb=
_info-and-console_lock drivers/video/fbmem.c
> --- a/drivers/video/fbmem.c~fb-fix-potential-deadlock-between-lock_fb_inf=
o-and-console_lock
> +++ a/drivers/video/fbmem.c
> @@ -1076,14 +1076,16 @@ static long do_fb_ioctl(struct fb_info *
>  	case FBIOPUT_VSCREENINFO:
>  		if (copy_from_user(&var, argp, sizeof(var)))
>  			return -EFAULT;
> -		if (!lock_fb_info(info))
> -			return -ENODEV;
>  		console_lock();
> +		if (!lock_fb_info(info)) {
> +			console_unlock();
> +			return -ENODEV;
> +		}
>  		info->flags |=3D FBINFO_MISC_USEREVENT;
>  		ret =3D fb_set_var(info, &var);
>  		info->flags &=3D ~FBINFO_MISC_USEREVENT;
> -		console_unlock();
>  		unlock_fb_info(info);
> +		console_unlock();
>  		if (!ret && copy_to_user(argp, &var, sizeof(var)))
>  			ret =3D -EFAULT;
>  		break;
> @@ -1112,12 +1114,14 @@ static long do_fb_ioctl(struct fb_info *
>  	case FBIOPAN_DISPLAY:
>  		if (copy_from_user(&var, argp, sizeof(var)))
>  			return -EFAULT;
> -		if (!lock_fb_info(info))
> -			return -ENODEV;
>  		console_lock();
> +		if (!lock_fb_info(info)) {
> +			console_unlock();
> +			return -ENODEV;
> +		}
>  		ret =3D fb_pan_display(info, &var);
> -		console_unlock();
>  		unlock_fb_info(info);
> +		console_unlock();
>  		if (ret =3D 0 && copy_to_user(argp, &var, sizeof(var)))
>  			return -EFAULT;
>  		break;
> @@ -1159,14 +1163,16 @@ static long do_fb_ioctl(struct fb_info *
>  		unlock_fb_info(info);
>  		break;
>  	case FBIOBLANK:
> -		if (!lock_fb_info(info))
> -			return -ENODEV;
>  		console_lock();
> +		if (!lock_fb_info(info)) {
> +			console_unlock();
> +			return -ENODEV;
> +		}
>  		info->flags |=3D FBINFO_MISC_USEREVENT;
>  		ret =3D fb_blank(info, arg);
>  		info->flags &=3D ~FBINFO_MISC_USEREVENT;
> -		console_unlock();
>  		unlock_fb_info(info);
> +		console_unlock();
>  		break;
>  	default:
>  		if (!lock_fb_info(info))
> _
>=20

