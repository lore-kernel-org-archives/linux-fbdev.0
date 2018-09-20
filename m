From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Date: Thu, 20 Sep 2018 07:47:33 +0000
Subject: Re: [PATCH v2 1/3] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
Message-Id: <9c7cbfd4-23dc-4729-a7ca-82bbc8f6c1aa@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 19.9.2018 15:17, Michal Vokáč wrote:
> The reset signal can be produced by GPIO expander that can sleep.
> In that case the probe function fails. Allow using GPIO expanders for
> the reset signal by using the non-atomic gpiod_set_value_cansleep()
> function.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

I forgot to add R-by from Fabio from v1, sorry.
I made the respin in a hurry and skipped my pre-submission checklist..

Michal

> ---
> v2 changes: none
> 
>   drivers/video/fbdev/ssd1307fb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index ba66c02..e7ae135 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -728,9 +728,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
>   
>   	if (par->reset) {
>   		/* Reset the screen */
> -		gpiod_set_value(par->reset, 0);
> +		gpiod_set_value_cansleep(par->reset, 0);
>   		udelay(4);
> -		gpiod_set_value(par->reset, 1);
> +		gpiod_set_value_cansleep(par->reset, 1);
>   		udelay(4);
>   	}
>   
> 
