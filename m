From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 18:01:50 +0000
Subject: Re: [PATCH] pxa168fb: trivial typo fix
Message-Id: <eb565b21-65f9-74c8-e6f7-9dc2403b3090@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181203114919epcas4p40f0094c4bb5d3614d2c67c6e68094aab@epcas4p4.samsung.com>
 <20181203114751.637390-1-lkundrak@v3.sk>
In-Reply-To: <20181203114751.637390-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-fbdev@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


[ added dri-devel ML & fbdev ML to Cc: ]

On 12/03/2018 12:47 PM, Lubomir Rintel wrote:
> A missing space in an error message.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Patch queued for 4.21, thanks.

> ---
>  drivers/video/fbdev/pxa168fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index e31340fad3c7..1410f476e135 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -279,7 +279,7 @@ static void set_clock_divider(struct pxa168fb_info *fbi,
>  
>  	/* check whether divisor is too small. */
>  	if (divider_int < 2) {
> -		dev_warn(fbi->dev, "Warning: clock source is too slow."
> +		dev_warn(fbi->dev, "Warning: clock source is too slow. "
>  				"Try smaller resolution\n");
>  		divider_int = 2;
>  	}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
