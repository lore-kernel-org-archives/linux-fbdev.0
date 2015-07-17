From: Joe Perches <joe@perches.com>
Date: Fri, 17 Jul 2015 07:38:41 +0000
Subject: Re: [PATCH] sm750fb: coding style fixes lines over 80 chars
Message-Id: <1437118721.2495.54.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437118085-8432-1-git-send-email-simhavcs@gmail.com>
In-Reply-To: <1437118085-8432-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinay Simha BN <simhavcs@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, open list <linux-kernel@vger.kernel.org>

On Fri, 2015-07-17 at 12:58 +0530, Vinay Simha BN wrote:
> scripts/checkpatch.pl kernel coding style fixes of WARNING

Please use checkpatch's --strict option until you know
kernel style much better.

> diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
[]
> @@ -259,17 +259,22 @@ unsigned int height, /* width and height of rectangle in pixel value */
>  unsigned int rop2);
>  
>  int hw_imageblit(struct lynx_accel *accel,
> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
> -		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
> -		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
> -		 u32 dBase,    /* Address of destination: offset in frame buffer */
> +		 const char *pSrcbuf, /* pointer to start of source
> +					buffer in system memory */

If you change these lines, please use normal kernel comment style.
/*
 * comment block
 */

> diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
[]
> @@ -49,17 +49,23 @@
>  /* Field Macros */
>  #define FIELD_START(field)              (0 ? field)
>  #define FIELD_END(field)                (1 ? field)

Odd statements.

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

I think _none_ of these are actually used so it'd
be better to delete them instead.

