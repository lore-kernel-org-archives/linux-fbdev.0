From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 17 Oct 2019 01:25:10 +0000
Subject: Re: [PATCH] staging: sm750fb: format description of parameters the to kernel doc format
Message-Id: <799632e2-a328-d72b-397d-3ee6b5e87e06@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017011849.6081-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191017011849.6081-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>, outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org

Hi,

On 10/16/19 6:18 PM, Gabriela Bittencourt wrote:
> Cluster comments that describes parameters of functions and create one
> single comment before the function in kernel doc format.

Good plan.

How did you test this patch?

> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 65 +++++++++++++++------------
>  1 file changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index dbcbbd1055da..d5564cd60f3b 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -130,20 +130,24 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>  	return 0;
>  }
>  
> -int sm750_hw_copyarea(
> -struct lynx_accel *accel,
> -unsigned int sBase,  /* Address of source: offset in frame buffer */
> -unsigned int sPitch, /* Pitch value of source surface in BYTE */
> -unsigned int sx,
> -unsigned int sy,     /* Starting coordinate of source surface */
> -unsigned int dBase,  /* Address of destination: offset in frame buffer */
> -unsigned int dPitch, /* Pitch value of destination surface in BYTE */
> -unsigned int Bpp,    /* Color depth of destination surface */
> -unsigned int dx,
> -unsigned int dy,     /* Starting coordinate of destination surface */
> -unsigned int width,
> -unsigned int height, /* width and height of rectangle in pixel value */
> -unsigned int rop2)   /* ROP value */
> +/**

Missing function name and short description.  Documentation/doc-guide/kernel-doc.rst says:

The general format of a function and function-like macro kernel-doc comment is::

  /**
   * function_name() - Brief description of function.
   * @arg1: Describe the first argument.
   * @arg2: Describe the second argument.
   *        One can provide multiple line descriptions
   *        for arguments.
   *
   * A longer description, with more discussion of the function function_name()
   * that might be useful to those using or modifying it. Begins with an
   * empty comment line, and may include additional embedded empty
   * comment lines.
   *
   * The longer description may have multiple paragraphs.
   *
   * Context: Describes whether the function can sleep, what locks it takes,
   *          releases, or expects to be held. It can extend over multiple
   *          lines.
   * Return: Describe the return value of function_name.
   *
   * The return value description can also have multiple paragraphs, and should
   * be placed at the end of the comment block.
   */

> + * @sBase: Address of source: offset in frame buffer
> + * @sPitch: Pitch value of source surface in BYTE
> + * @sx, @sy: Starting coordinate of source surface

Those should be on separate lines.

> + * @dBase: Address of destination: offset in frame buffer
> + * @dPitch: Pitch value of destination surface in BYTE
> + * @Bpp: Color depth of destination surface
> + * @dx, @dy: Starting coordinate of destination surface

Ditto.

> + * @width, @height: width and height of rectangle in pixel value
> + * @rop2: ROP value
> + */
> +int sm750_hw_copyarea(struct lynx_accel *accel,
> +		      unsigned int sBase, unsigned int sPitch,
> +		      unsigned int sx, unsigned int sy,
> +		      unsigned int dBase, unsigned int dPitch,
> +		      unsigned int Bpp, unsigned int dx, unsigned int dy,
> +		      unsigned int width, unsigned int height,
> +		      unsigned int rop2)
>  {
>  	unsigned int nDirection, de_ctrl;
>  
> @@ -288,20 +292,25 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
>  	return de_ctrl;
>  }
>  
> -int sm750_hw_imageblit(struct lynx_accel *accel,
> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
> -		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
> -		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
> -		 u32 dBase,    /* Address of destination: offset in frame buffer */
> -		 u32 dPitch,   /* Pitch value of destination surface in BYTE */
> -		 u32 bytePerPixel,      /* Color depth of destination surface */
> -		 u32 dx,
> -		 u32 dy,       /* Starting coordinate of destination surface */
> -		 u32 width,
> -		 u32 height,   /* width and height of rectangle in pixel value */
> -		 u32 fColor,   /* Foreground color (corresponding to a 1 in the monochrome data */
> -		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
> -		 u32 rop2)     /* ROP value */
> +/**

Similar comments here...

> + * @pSrcbuf: pointer to start of source buffer in system memory
> + * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
> + * and -ive mean button up
> + * @startBit: Mono data can start at any bit in a byte, this value should be
> + * 0 to 7
> + * @dBase: Address of destination: offset in frame buffer
> + * @dPitch: Pitch value of destination surface in BYTE
> + * @bytePerPixel: Color depth of destination surface
> + * @dx, @dy: Starting coordinate of destination surface
> + * @width, @height: width and height of rectangle in pixel value
> + * @fColor: Foreground color (corresponding to a 1 in the monochrome data
> + * @bColor: Background color (corresponding to a 0 in the monochrome data
> + * @rop2: ROP value
> + */
> +int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
> +		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
> +		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
> +		       u32 height, u32 fColor, u32 bColor, u32 rop2)
>  {
>  	unsigned int ulBytesPerScan;
>  	unsigned int ul4BytesPerScan;
> 

Thanks.
-- 
~Randy
