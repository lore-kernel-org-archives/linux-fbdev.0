From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 10 Jul 2018 09:00:03 +0000
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-Id: <20180710090003.2flpkbgkakmnefpn@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180709215156.GA8782@embeddedor.com>
In-Reply-To: <20180709215156.GA8782@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:51:56PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Having checked the datasheets...

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/adp8860_bl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 16119bd..f1dc41c 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -690,6 +690,7 @@ static int adp8860_probe(struct i2c_client *client,
>  	switch (ADP8860_MANID(reg_val)) {
>  	case ADP8863_MANUFID:
>  		data->gdwn_dis = !!pdata->gdwn_dis;
> +		/* fall through */
>  	case ADP8860_MANUFID:
>  		data->en_ambl_sens = !!pdata->en_ambl_sens;
>  		break;
> -- 
> 2.7.4
> 
