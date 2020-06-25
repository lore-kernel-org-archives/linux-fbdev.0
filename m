From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 25 Jun 2020 09:41:26 +0000
Subject: Re: [PATCH 4/8] backlight: ili922x: Remove invalid use of kerneldoc syntax
Message-Id: <20200625094126.jp5e7x64sjdu7med@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-5-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, dri-devel@lists.freedesktop.org, Software Engineering <sbabic@denx.de>, linux-arm-kernel@lists.infradead.org

On Wed, Jun 24, 2020 at 03:57:17PM +0100, Lee Jones wrote:
> Kerneldoc is for documenting function arguments and return values.
> 
> Prevents warnings like:
> 
>  drivers/video/backlight/ili922x.c:127: warning: cannot understand function prototype: 'int ili922x_id = 1; '
>  drivers/video/backlight/ili922x.c:136: warning: cannot understand function prototype: 'struct ili922x '
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Software Engineering <sbabic@denx.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/ili922x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> index 8cb4b9d3c3bba..cd41433b87aeb 100644
> --- a/drivers/video/backlight/ili922x.c
> +++ b/drivers/video/backlight/ili922x.c
> @@ -123,7 +123,7 @@
>  
>  #define set_tx_byte(b)		(tx_invert ? ~(b) : b)
>  
> -/**
> +/*
>   * ili922x_id - id as set by manufacturer
>   */
>  static int ili922x_id = 1;
> @@ -132,7 +132,7 @@ module_param(ili922x_id, int, 0);
>  static int tx_invert;
>  module_param(tx_invert, int, 0);
>  
> -/**
> +/*
>   * driver's private structure
>   */
>  struct ili922x {
> -- 
> 2.25.1
> 
