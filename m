From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] omapfb: Wrong test on unsigned?
Date: Fri, 16 Oct 2009 15:56:57 -0500
Message-ID: <A24693684029E5489D1D202277BE89444CEFEAF5@dlee02.ent.ti.com>
References: <4AD8BA2F.9090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4AD8BA2F.9090307@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: Roel Kluin <roel.kluin@gmail.com>, Imre Deak <imre.deak@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Roel Kluin
> Sent: Friday, October 16, 2009 1:24 PM
> To: Imre Deak; linux-fbdev-devel@lists.sourceforge.net; 
> linux-omap@vger.kernel.org; Andrew Morton
> Subject: [PATCH] omapfb: Wrong test on unsigned?
> 
> Only if the test is signed negative values can be spotted.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this correct? please review.
> 
> diff --git a/drivers/video/omap/omapfb_main.c 
> b/drivers/video/omap/omapfb_main.c
> index 0d0c8c8..cc7dd93 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -286,7 +286,7 @@ static int _setcolreg(struct fb_info 
> *info, u_int regno, u_int red, u_int green,
>  		if (r != 0)
>  			break;
>  
> -		if (regno < 0) {
> +		if ((int)regno < 0) {

Hmm...

Isn't regno unsigned integer from the start?

2 things here:

- regno will never be negative.
- Casting won't make a difference in the meaning., it'll make a negative only when:

	regno > ((2^32) / 2)

Which doesn't make any sense IMHO.

Isn't it?

Regards,
Sergio
>  			r = -EINVAL;
>  			break;
>  		}
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 