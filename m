From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fw: framebuffer blitting performance loss 
 2.6.12 -> 2.6.13-rc3
Date: Fri, 29 Jul 2005 20:51:34 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org>
References: <20050715033912.1cd9b6c3.akpm@osdl.org> <200507221158.23454.adaplas@gmail.com>
 <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de>
 <42EA4E6A.70907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyatW-00006M-N1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 12:51:46 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DyatU-0007md-8v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 12:51:46 -0700
In-Reply-To: <42EA4E6A.70907@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Knut Petersen <Knut_Petersen@t-online.de>, Andrew Morton <akpm@osdl.org>


> Thank you for your persistence.  I think I know the culprit.  Someone
> insisted on using memcpy in fb_pad_aligned_buffer().  I have already
> fixed this before, but apparently, the memcpy was brought back.  Try
> the attached patch and let me know.

Yipes, I did that. The memcpy function is suppose to be optimized for the 
platform. See string.h in the include/asm directory. I seen for example 
the Athlon would use the 3DNow instruction set to copy data. Something 
is really wrong with memcpy if moving byte by byte is faster !!!! 
Alot of drivers use memcpy. If memcpy sucks then drivers should be copying 
byte by byte then. The question I have is this the case for non intel 
platforms as well. Could someone run the numbers on other platforms?

> Tony
> 
>    fbdev: Replace memcpy with for-loop when preparing bitmap
> 
>     Do not use memcpy in fb_pad_aligned_buffer. It is suboptimal because only
>     a few bytes are moved at a time. Replace with a for-loop.
> 
>     From: Antonino Daplas <adaplas@pol.net>
>     Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
>  fbmem.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -80,10 +80,12 @@ EXPORT_SYMBOL(fb_get_color_depth);
>   */
>  void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
>  {
> -	int i;
> +	int i, j;
>  
>  	for (i = height; i--; ) {
> -		memcpy(dst, src, s_pitch);
> +		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
> +		for (j = 0; j < s_pitch; j++)
> +			dst[j] = src[j];
>  		src += s_pitch;
>  		dst += d_pitch;
>  	}
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO September
> 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
