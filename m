From: Michael Hennerich <michael.hennerich@analog.com>
Date: Tue, 10 Jul 2018 06:46:24 +0000
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-Id: <ee4acd3d-e31f-747b-d3a8-adbe0fb46d83@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180709215156.GA8782@embeddedor.com>
In-Reply-To: <20180709215156.GA8782@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 09.07.2018 23:51, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/video/backlight/adp8860_bl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 16119bd..f1dc41c 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -690,6 +690,7 @@ static int adp8860_probe(struct i2c_client *client,
>   	switch (ADP8860_MANID(reg_val)) {
>   	case ADP8863_MANUFID:
>   		data->gdwn_dis = !!pdata->gdwn_dis;
> +		/* fall through */
>   	case ADP8860_MANUFID:
>   		data->en_ambl_sens = !!pdata->en_ambl_sens;
>   		break;
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
