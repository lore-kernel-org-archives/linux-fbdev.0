From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Fri, 24 Nov 2017 21:30:34 +0000
Subject: Re: [PATCH] video/fbdev/stifb: Delete an error message for a failed memory allocation in stifb_init_
Message-Id: <25624997.nONnEdNj0s@daneel.sf-tec.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1690480.eUU9do5mRG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
In-Reply-To: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Helge Deller <deller@gmx.de>, "James E. J. Bottomley" <jejb@parisc-linux.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

--nextPart1690480.eUU9do5mRG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 24 Nov 2017 22:22:06 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/video/fbdev/stifb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
> index 6ded5c198998..fe217a2f7d21 100644
> --- a/drivers/video/fbdev/stifb.c
> +++ b/drivers/video/fbdev/stifb.c
> @@ -1126,10 +1126,8 @@ static int __init stifb_init_fb(struct sti_struct
> *sti, int bpp_pref) int bpp, xres, yres;
> 
>  	fb = kzalloc(sizeof(*fb), GFP_ATOMIC);
> -	if (!fb) {
> -		printk(KERN_ERR "stifb: Could not allocate stifb structure\n");
> +	if (!fb)
>  		return -ENODEV;
> -	}
> 
>  	info = &fb->info;

This should be -ENOMEM.

Eike
--nextPart1690480.eUU9do5mRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAloYj38ACgkQXKSJPmm5/E5cfQCgoFeHSeRxr9yoOVPpNYvJLiXJ
1NkAoJb/M52HEUrAxPl/xOf55aOpDGdq
=roWr
-----END PGP SIGNATURE-----

--nextPart1690480.eUU9do5mRG--

