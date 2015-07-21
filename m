From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 21 Jul 2015 08:35:41 +0000
Subject: Re: [PATCH 1/2] sm750fb: coding style fixes lines over 80 chars
Message-Id: <20150721083541.GK5371@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437461084-17565-1-git-send-email-simhavcs@gmail.com>
 <1437464402-18451-1-git-send-email-simhavcs@gmail.com>
In-Reply-To: <1437464402-18451-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinay Simha BN <simhavcs@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Tue, Jul 21, 2015 at 01:10:00PM +0530, Vinay Simha BN wrote:
> diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
> index 8dc6bd2..43d700b 100644
> --- a/drivers/staging/sm750fb/sm750_help.h
> +++ b/drivers/staging/sm750fb/sm750_help.h
> @@ -49,17 +49,23 @@
>  /* Field Macros */
>  #define FIELD_START(field)              (0 ? field)
>  #define FIELD_END(field)                (1 ? field)
> -#define FIELD_SIZE(field)               (1 + FIELD_END(field) - FIELD_START(field))
> -#define FIELD_MASK(field)               (((1 << (FIELD_SIZE(field)-1)) | ((1 << (FIELD_SIZE(field)-1)) - 1)) << FIELD_START(field))
> -#define FIELD_NORMALIZE(reg, field)     (((reg) & FIELD_MASK(field)) >> FIELD_START(field))
> -#define FIELD_DENORMALIZE(field, value) (((value) << FIELD_START(field)) & FIELD_MASK(field))
> +#define FIELD_SIZE(field)               (1 + FIELD_END(field) - \
> +						FIELD_START(field))
> +#define FIELD_MASK(field)               (((1 << (FIELD_SIZE(field)-1)) \
> +					| ((1 << (FIELD_SIZE(field)-1)) - 1)) \
> +					<< FIELD_START(field))
> +#define FIELD_NORMALIZE(reg, field)     (((reg) & FIELD_MASK(field)) >> \
> +					FIELD_START(field))
> +#define FIELD_DENORMALIZE(field, value) (((value) << FIELD_START(field)) & \
> +					 FIELD_MASK(field))
>  
>  #define FIELD_INIT(reg, field, value)   FIELD_DENORMALIZE(reg ## _ ## field, \
> -							  reg ## _ ## field ## _ ## value)
> +					  reg ## _ ## field ## _ ## value)
>  #define FIELD_INIT_VAL(reg, field, value) \
>  	(FIELD_DENORMALIZE(reg ## _ ## field, value))
>  #define FIELD_VAL_SET(x, r, f, v)       x = x & ~FIELD_MASK(r ## _ ## f) \
> -					| FIELD_DENORMALIZE(r ## _ ## f, r ## _ ## f ## _ ## v)
> +					| FIELD_DENORMALIZE(r ## _ ## f, \
> +					 r ## _ ## f ## _ ## v)
>  
>  #define RGB(r, g, b) \
>  ( \

These are worse for reading now.  Better to ignore the warning instead
of making the code ugly.

regards,
dan carpenter

