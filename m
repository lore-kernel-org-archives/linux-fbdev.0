From: James Simmons <jsimmons@infradead.org>
Date: Mon, 15 Mar 2010 11:58:58 +0000
Subject: Re: [PATCH] fix Kconfig breakage in drivers/video
Message-Id: <alpine.LFD.2.00.1003151158031.16108@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003151152260.16108@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1003151152260.16108@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Krzysztof,

On Sun, Mar 14, 2010 at 10:53:29PM +0100, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> There are two new options inside the CONFIG_FB section which do not
> depend on the CONFIG_FB. This break Kconfig menu layout.
> 
> Fix it and reduce few conditions for sparc frame buffers
> as the FB_SBUS = ((FB = y) && SPARC).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> --- linux-orig/drivers/video/Kconfig	2010-03-14 23:54:39.000000000 +0100
> +++ linux-git/drivers/video/Kconfig	2010-03-15 00:05:59.000000000 +0100
> @@ -400,12 +400,9 @@ config FB_SA1100
>  	  If you plan to use the LCD display with your SA-1100 system, say
>  	  Y here.
>  
> -config HAVE_FB_IMX
> -	bool
> -
>  config FB_IMX
>  	tristate "Motorola i.MX LCD support"
> -	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
> +	depends on FB && (ARCH_MX1 || ARCH_MX2)

This hunk reverts f6014419 (imxfb: add support for i.MX25). Is this 
intentional?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -


