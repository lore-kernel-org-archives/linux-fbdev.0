From: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH 5/5] [I810FB]: i810fb fixes
Date: Sat, 31 Jul 2004 02:07:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040731000754.GF2746@fs.tum.de>
References: <200407290955.29735.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267883AbUGaAIW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200407290955.29735.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:04:32AM +0800, Antonino A. Daplas wrote:

>...
> --- linux-2.6.8-rc2-mm1-orig/drivers/video/Kconfig	2004-07-28 19:51:13.000000000 +0000
> +++ linux-2.6.8-rc2-mm1/drivers/video/Kconfig	2004-07-29 00:35:04.115437224 +0000
> @@ -457,7 +457,9 @@ config FB_RIVA_DEBUG
>  
>  config FB_I810
>  	tristate "Intel 810/815 support (EXPERIMENTAL)"
> -	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	
> +	depends on FB && EXPERIMENTAL && PCI	
> +	select AGP
> +	select AGP_INTEL
>  	help
>  	  This driver supports the on-board graphics built in to the Intel 810 
>            and 815 chipsets.  Say Y if you have and plan to use such a board.
>...

This is wrong.

If you select something, you have to ensure that the dependencies of 
what you select are fulfilled.

Since AGP_INTEL depends on X86 && !X86_64 , you must add this to the 
dependencies of FB_I810 if it selects AGP_INTEL.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
