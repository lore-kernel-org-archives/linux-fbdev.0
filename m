From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] fbdev: fix fillrect for 24bpp modes
Date: Fri, 17 Apr 2009 18:36:17 +0200
Message-ID: <20090417183617.ed7553cd.krzysztof.h1@poczta.fm>
References: <20090413170954.GA8403@tria>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Lur0a-0005aq-4X
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Apr 2009 16:33:44 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lur0L-000858-Pg for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Apr 2009 16:33:39 +0000
In-Reply-To: <20090413170954.GA8403@tria>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 13 Apr 2009 19:09:54 +0200
Michal Januszewski <spock@gentoo.org> wrote:

> The software fillrect routines do not work properly when the number of
> pixels per machine word is not an integer.  To see that, run the following
> command on a fbdev console with a 24bpp video mode, using a non-accelerated
> driver such as (u)vesafb:
> 
>   reset ; echo -e '\e[41mtest\e[K'
> 
> The expected result is 'test' displayed on a line with red background.
> Instead of that, 'test' has a red background, but the rest of the line
> (rendered using fillrect()) contains a distored colorful pattern.
> 
> This patch fixes the problem by correctly computing rotation shifts.
> It has been tested in a 24bpp mode on 32- and 64-bit little-endian
> machines.
> 

I can confirm the patch fixes the issue it describes if the line is not padded
or padded in a special way. See my comments below.

> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
> index 64b3576..396e676 100644
> --- a/drivers/video/cfbfillrect.c
> +++ b/drivers/video/cfbfillrect.c
> @@ -9,10 +9,6 @@
>   *
>   * NOTES:
>   *
> - *  The code for depths like 24 that don't have integer number of pixels per
> - *  long is broken and needs to be fixed. For now I turned these types of
> - *  mode off.
> - *
>   *  Also need to add code to deal with cards endians that are different than
>   *  the native cpu endians. I also need to deal with MSB position in the word.
>   *
> @@ -139,7 +135,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
>  
>  		// Trailing bits
>  		if (last)
> -			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
> +			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
>  	}
>  }
>  
> @@ -297,7 +293,7 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
>  	else
>  		fg = rect->color;
>  
> -	pat = pixel_to_pat( bpp, fg);
> +	pat = pixel_to_pat(bpp, fg);
>  
>  	dst = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
>  	dst_idx = ((unsigned long)p->screen_base & (bytes - 1))*8;
> @@ -333,17 +329,20 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
>  			dst_idx += p->fix.line_length*8;
>  		}
>  	} else {
> -		int right;
> -		int r;
> -		int rot = (left-dst_idx) % bpp;
> +		int right, r;
>  		void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
>  				int dst_idx, unsigned long pat, int left,
>  				int right, unsigned n, int bits) = NULL;
> -
> +#ifdef __LITTLE_ENDIAN
> +		right = left;
> +		left = bpp - right;
> +#else
> +		right = bpp - left;
> +#endif
>  		/* rotate pattern to correct start position */
> -		pat = pat << rot | pat >> (bpp-rot);
> +		r = dst_idx >> (ffs(bits) - 1);

The r is simply dst_idx / bits. Most compilers will optimize it away into 
a simple shift because the bits has only one bit set (it is number of bits in a long variable, ie. 32 or 64).

> +		pat = pat << ((left*r) % bpp) | pat >> ((right*r) % bpp);
>  

If the r = (dst_idx / bits) it is number of long words. The shift by ((left*r) % bpp) does
not make much sense (try left = 3 and r = 24 words - it is always zero but should be 3). 
It is even worse if a line is padded so line's length modulo bpp is not 
zero it does not work. A colorful pattern is produced  after the "mtest" text.

A dst_idx offset is not taken into account (it could be non-zero only for depths < 8 bits).

Kind regards,
Krzysztof


----------------------------------------------------------------------
Najlepsze dzwonki MP3 na telefon komorkowy!
Sprawdz >> http://link.interia.pl/f2128  


------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
