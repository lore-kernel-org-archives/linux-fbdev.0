From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:14 +0000
Subject: Re: [PATCH v3] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <64d46ff6-a16f-1cf6-4bb9-84524ce43207@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200513184838eucas1p1df4f9229dca2094694e4b16d82a95418@eucas1p1.samsung.com>
 <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589395691-8762-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, andy.shevchenko@gmail.com, Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>


[ added dri-devel ML to Cc: ]

Hi,

Sorry for the delay.

On 5/13/20 8:48 PM, Rodrigo Alencar wrote:
> From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
> 
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
> 
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Please resend with "From:" & "Signed-off-by:" tags fixed to match so
I can merge the patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> index 27333b9551b3..2dcb6d12d137 100644
> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -19,6 +19,7 @@ Optional properties:
>    - vbat-supply: The supply for VBAT
>    - solomon,segment-no-remap: Display needs normal (non-inverted) data column
>                                to segment mapping
> +  - solomon,col-offset: Offset of columns (COL/SEG) that the screen is mapped to.
>    - solomon,com-seq: Display uses sequential COM pin configuration
>    - solomon,com-lrremap: Display uses left-right COM pin remap
>    - solomon,com-invdir: Display uses inverted COM pin scan direction
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 8e06ba912d60..102f941104c0 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -74,6 +74,7 @@ struct ssd1307fb_par {
>  	struct fb_info *info;
>  	u8 lookup_table[4];
>  	u32 page_offset;
> +	u32 col_offset;
>  	u32 prechargep1;
>  	u32 prechargep2;
>  	struct pwm_device *pwm;
> @@ -458,11 +459,11 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = ssd1307fb_write_cmd(par->client, 0x0);
> +	ret = ssd1307fb_write_cmd(par->client, par->col_offset);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = ssd1307fb_write_cmd(par->client, par->width - 1);
> +	ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -626,6 +627,9 @@ static int ssd1307fb_probe(struct i2c_client *client)
>  	if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
>  		par->page_offset = 1;
>  
> +	if (device_property_read_u32(dev, "solomon,col-offset", &par->col_offset))
> +		par->col_offset = 0;
> +
>  	if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
>  		par->com_offset = 0;
>  
> 
