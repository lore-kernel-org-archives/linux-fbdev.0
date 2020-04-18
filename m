From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 18 Apr 2020 10:10:46 +0000
Subject: Re: [PATCH 1/8] fbdev: w100fb: clean up mach-pxa compile-time dependency
Message-Id: <877dydp0ih.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
 <20200417155553.675905-2-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-2-arnd@arndb.de> (Arnd Bergmann's message
 of "Fri, 17 Apr 2020 17:55:46 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, airlied@linux.ie, Andrzej Hajda <a.hajda@samsung.com>, Laurent.pinchart@ideasonboard.com, marex@denx.de, thellstrom@vmware.com, dsd@laptop.org, Jason Gunthorpe <jgg@ziepe.ca>, masahiroy@kernel.org, Saeed Mahameed <saeedm@mellanox.com>, geert@linux-m68k.org, linux-graphics-maintainer@vmware.com, haojian.zhuang@gmail.com, Nicolas Pitre <nico@fluxnic.net>, dri-devel@lists.freedesktop.org, jfrederich@gmail.com, linux-renesas-soc@vger.kernel.org, kieran.bingham+renesas@ideasonboard.com, daniel@zonque.org

Arnd Bergmann <arnd@arndb.de> writes:

Hi Arnd,

> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index f60bc29aef68..8444d40df1b3 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -549,9 +549,6 @@ config MACH_ICONTROL
>  
>  config ARCH_PXA_ESERIES
>  	bool "PXA based Toshiba e-series PDAs"
> -	select FB_W100
> -	select FB
> -	select PXA25x
This last line puzzles me a bit in this patch. Why removing the PXA25x select ?

Cheers.

-- 
Robert
