From: Ben Dooks <ben@trinity.fluff.org>
Date: Tue, 01 Jun 2010 04:17:13 +0000
Subject: Re: [PATCH 2/6] s3c-fb: Correct FRAMESEL1 bitfield defines for
Message-Id: <20100601041713.GC30276@trinity.fluff.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1275296935-2693-1-git-send-email-p.osciak@samsung.com>
	<1275296935-2693-3-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1275296935-2693-3-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 31, 2010 at 11:08:51AM +0200, Pawel Osciak wrote:
> FRAMESEL1 bitfield starts on 13th bit, not on 14th.

is this true for all variants that have FRAMESEL1?
 
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/regs-fb.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
> index f4259e5..ac10013 100644
> --- a/arch/arm/plat-samsung/include/plat/regs-fb.h
> +++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
> @@ -292,11 +292,11 @@
>  #define VIDINTCON0_FRAMESEL0_ACTIVE		(0x2 << 15)
>  #define VIDINTCON0_FRAMESEL0_FRONTPORCH		(0x3 << 15)
>  
> -#define VIDINTCON0_FRAMESEL1			(1 << 14)
> -#define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 14)
> -#define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 14)
> -#define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 14)
> -#define VIDINTCON0_FRAMESEL1_FRONTPORCH		(0x3 << 14)
> +#define VIDINTCON0_FRAMESEL1			(1 << 13)
> +#define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 13)
> +#define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 13)
> +#define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 13)
> +#define VIDINTCON0_FRAMESEL1_FRONTPORCH		(0x3 << 13)
>  
>  #define VIDINTCON0_INT_FRAME			(1 << 12)
>  #define VIDINTCON0_FIFIOSEL_MASK		(0x7f << 5)
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

