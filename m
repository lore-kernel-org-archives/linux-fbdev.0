From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 27 Nov 2018 10:57:33 +0000
Subject: Re: [PATCH 2/2] backlight: lm3630a: add backlight driver match_table
Message-Id: <20181127105733.5t275fixa3utnkaz@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181124141703.29232-2-masneyb@onstation.org>
In-Reply-To: <20181124141703.29232-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, ctatlor97@gmail.com, jonathan@marek.ca, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, robh+dt@kernel.org, lee.jones@linaro.org

On Sat, Nov 24, 2018 at 09:17:03AM -0500, Brian Masney wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add device tree support to the lm3630a driver.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [masneyb@onstation.org: checkpatch fixes; add 'a' to compatible string]
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> This is part of upstreaming various components of the LG Nexus 5
> (hammerhead) phone.
> 
>  drivers/video/backlight/lm3630a_bl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 2030a6b77a09..159d4013d9c2 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -470,11 +470,18 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };

Similar to my reply to the DT bindings: I would have expected there
to be code to handle DT properties here.


Daniel.



>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
> +
>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
>  		   .name = LM3630A_NAME,
> +		   .of_match_table = lm3630a_match_table,
>  		   },
>  	.probe = lm3630a_probe,
>  	.remove = lm3630a_remove,
> -- 
> 2.17.2
> 
