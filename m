From: Joe Perches <joe@perches.com>
Date: Mon, 18 Jan 2010 19:17:49 +0000
Subject: Re: [PATCH] video/matrox: Checkpatch cleanups for matroxfb_crtc2.c
Message-Id: <1263842269.26846.122.camel@Joe-Laptop.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001181934.49519.PeterHuewe@gmx.de>
In-Reply-To: <201001181934.49519.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, 2010-01-18 at 19:34 +0100, Peter H=C3=BCwe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> Date: Mon, 18 Jan 2010 19:21:02 +0100
> This patch fixes all 77 errors reported by checkpatch - no functional
> change was made. The line over 80 chars warnings were left untouched.
> diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox=
/matroxfb_crtc2.c
> index 78414ba..790ca47 100644
> --- a/drivers/video/matrox/matroxfb_crtc2.c
> +++ b/drivers/video/matrox/matroxfb_crtc2.c
> @@ -42,42 +43,41 @@ static int matroxfb_dh_setcolreg(unsigned regno, unsi=
gned red, unsigned green,
>  	blue =3D CNVT_TOHW(blue, m2info->fbcon.var.blue.length);
>  	transp =3D CNVT_TOHW(transp, m2info->fbcon.var.transp.length);
> =20
> -	col =3D (red << m2info->fbcon.var.red.offset)     |
> -	      (green << m2info->fbcon.var.green.offset) |
> -	      (blue << m2info->fbcon.var.blue.offset)   |
> -	      (transp << m2info->fbcon.var.transp.offset);
> +	col =3D	(red << m2info->fbcon.var.red.offset)		|
> +			(green << m2info->fbcon.var.green.offset)	|
> +			(blue << m2info->fbcon.var.blue.offset)		|
> +			(transp << m2info->fbcon.var.transp.offset);

I think this is not an improvement.

[]

> +	case 16:
> +		tmp =3D 0x00400000;
> +		break;
>  /*		case 32: */

Even in a comment, you should change this indent.

[]
> @@ -428,133 +435,133 @@ static int matroxfb_dh_ioctl(struct fb_info *info,
>  	DBG(__func__)
> =20
>  	switch (cmd) {
> -		case FBIOGET_VBLANK:
> -			{
> -				struct fb_vblank vblank;
> -				int err;
> -
> -				err =3D matroxfb_dh_get_vblank(m2info, &vblank);
> -				if (err)
> -					return err;
> -				if (copy_to_user((void __user *)arg, &vblank, sizeof(vblank)))
> -					return -EFAULT;
> -				return 0;
> -			}

I suggest putting the open braces on the same line as the case
because that's the more common (~2:1) kernel style and it saves
an indent level

	switch (foo) {
	case: bar {
	}
	}

[]

> +	case MATROXFB_SET_OUTPUT_MODE:
> +	case MATROXFB_GET_OUTPUT_MODE:
> +	case MATROXFB_GET_ALL_OUTPUTS:
> +		{
> +			return minfo->fbcon.fbops->fb_ioctl(&minfo->fbcon, cmd, arg);
> +		}

unnecessary braces, 1 indent level deeper than necessary.

cheers, Joe

