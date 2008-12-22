From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/6] fbdev: c2p - Cleanups
Date: Mon, 22 Dec 2008 15:22:06 -0800
Message-ID: <20081222152206.707c3214.akpm@linux-foundation.org>
References: <20081221150059.844577615@mail.of.borg>
	<20081221150122.473385775@mail.of.borg>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20081221150122.473385775@mail.of.borg>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: schmitz@opal.biophys.uni-duesseldorf.de, linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 21 Dec 2008 16:01:02 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>   - Improve comments and naming
>   - Use void * for arbitrary pointers
>   - Use a union to represent pixels/words, to avoid casts
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/c2p.c |   80 +++++++++++++++++++++++++++-------------------------
>  drivers/video/c2p.h |    6 +--
>  2 files changed, 45 insertions(+), 41 deletions(-)
> 
> --- a/drivers/video/c2p.c
> +++ b/drivers/video/c2p.c
> @@ -54,7 +54,7 @@ static inline u32 get_mask(int n)
>      return 0;
>  }
>  
> -#define transp_nx1(d, n)				\
> +#define transp8_nx1(d, n)				\
>      do {						\
>  	u32 mask = get_mask(n);				\
>  	/* First block */				\
> @@ -67,7 +67,7 @@ static inline u32 get_mask(int n)
>  	_transp(d, 6, 7, n, mask);			\
>      } while (0)
> -#define transp_nx2(d, n)				\
> +#define transp8_nx2(d, n)				\
>      do {						\
>  	u32 mask = get_mask(n);				\
>  	/* First block */				\
> @@ -78,40 +78,41 @@ static inline u32 get_mask(int n)

I was going to say:

- these don't need to be implemented as macros

- these reference their arguments multiple times and will cause
  problems when passed an expression with side-effects.

- they should be converted to inlined C function, but those functions
  will be waaaaaaaay to big to inline.

but happily, they appear to not have any callers?

>  	_transp(d, 5, 7, n, mask);			\
>      } while (0)
>  
> -#define transp_nx4(d, n)				\
> +#define transp8_nx4(d, n)				\
>      do {						\
>  	u32 mask = get_mask(n);				\
> +	/* Single block */				\
>  	_transp(d, 0, 4, n, mask);			\
>  	_transp(d, 1, 5, n, mask);			\
>  	_transp(d, 2, 6, n, mask);			\
>  	_transp(d, 3, 7, n, mask);			\
>      } while (0)
>  
> -#define transp(d, n, m)	transp_nx ## m(d, n)
> +#define transp8(d, n, m)	transp8_nx ## m(d, n)

ah, yes they do.  Tricky!

>  
>      /*
> @@ -130,12 +131,12 @@ static inline unsigned long comp(unsigne
>       *  Store a full block of planar data after c2p conversion
>       */
>  
> -static inline void store_planar(char *dst, u32 dst_inc, u32 bpp, u32 d[8])
> +static inline void store_planar(void *dst, u32 dst_inc, u32 bpp, u32 d[8])
>  {
>      int i;
>  
>      for (i = 0; i < bpp; i++, dst += dst_inc)
> -	*(u32 *)dst = d[perm_c2p_8bpp[i]];
> +	*(u32 *)dst = d[perm_c2p_32x8[i]];
>  }
>  
>  
> @@ -143,13 +144,13 @@ static inline void store_planar(char *ds
>       *  Store a partial block of planar data after c2p conversion
>       */
>  
> -static inline void store_planar_masked(char *dst, u32 dst_inc, u32 bpp,
> +static inline void store_planar_masked(void *dst, u32 dst_inc, u32 bpp,
>  				       u32 d[8], u32 mask)
>  {
>      int i;
>  
>      for (i = 0; i < bpp; i++, dst += dst_inc)
> -	*(u32 *)dst = comp(d[perm_c2p_8bpp[i]], *(u32 *)dst, mask);
> +	*(u32 *)dst = comp(d[perm_c2p_32x8[i]], *(u32 *)dst, mask);
>  }

This driver needs a inlineectomy.


