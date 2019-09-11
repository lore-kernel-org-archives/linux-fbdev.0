From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 11 Sep 2019 10:51:48 +0000
Subject: Re: [PATCH] backlight: lm3630a: fix module aliases
Message-Id: <20190911105148.4prmcr2f2r36sgrf@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190910152359.7448-1-andreas@kemnade.info>
In-Reply-To: <20190910152359.7448-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com

On Tue, Sep 10, 2019 at 05:23:59PM +0200, Andreas Kemnade wrote:
> Devicetree aliases are missing, so that module autoloading
> does not work properly.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lm3630a_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 3b45a1733198..9d67c07db2f2 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -617,12 +617,14 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> +
>  static const struct of_device_id lm3630a_match_table[] = {
>  	{ .compatible = "ti,lm3630a", },
>  	{ },
>  };
>  
> -MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> +MODULE_DEVICE_TABLE(of, lm3630a_match_table);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
> -- 
> 2.11.0
> 
