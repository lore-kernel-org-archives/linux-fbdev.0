From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 15 Apr 2014 12:08:43 +0000
Subject: Re: [PATCH 1/2] video: mmp: Remove references to CPU_MMP3
Message-Id: <000001cf58a3$720382e0$560a88a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397561044.1985.47.camel@x220>
In-Reply-To: <1397561044.1985.47.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Paul Bolle' <pebolle@tiscali.nl>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Richard Weinberger' <richard@nod.at>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, April 15, 2014 8:24 PM, Paul Bolle wrote:
> 
> From: Richard Weinberger <richard@nod.at>
> 
> References to the Kconfig symbol CPU_MMP3 were added to the tree since
> v3.6. But that Kconfig symbol has never been part of the tree. So get
> rid of these references.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> 0) Tested with git grep.
> 
> 1) Originally sent as "[PATCH 01/28] Remove CPU_MMP3" two months ago.
> Added a proper commit explanation to aid reviewers.
> 
> 2) One reference to CPU_MMP3 remains. I'll remove that in a more
> elaborate patch.
> 
>  drivers/video/mmp/Kconfig    | 2 +-
>  drivers/video/mmp/hw/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/mmp/Kconfig b/drivers/video/mmp/Kconfig
> index e9ea39e13722..969925d694c9 100644
> --- a/drivers/video/mmp/Kconfig
> +++ b/drivers/video/mmp/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig MMP_DISP
>          tristate "Marvell MMP Display Subsystem support"
> -        depends on CPU_PXA910 || CPU_MMP2 || CPU_MMP3 || CPU_PXA988
> +        depends on CPU_PXA910 || CPU_MMP2 || CPU_PXA988
>          help
>  	  Marvell Display Subsystem support.
> 
> diff --git a/drivers/video/mmp/hw/Kconfig b/drivers/video/mmp/hw/Kconfig
> index 02f109a20cd0..99f0506afc99 100644
> --- a/drivers/video/mmp/hw/Kconfig
> +++ b/drivers/video/mmp/hw/Kconfig
> @@ -2,12 +2,12 @@ if MMP_DISP
> 
>  config MMP_DISP_CONTROLLER
>  	bool "mmp display controller hw support"
> -	depends on CPU_PXA910 || CPU_MMP2 || CPU_MMP3 || CPU_PXA988
> +	depends on CPU_PXA910 || CPU_MMP2 || CPU_PXA988
>  	default n
>  	help
>  		Marvell MMP display hw controller support
>  		this controller is used on Marvell PXA910,
> -		MMP2, MMP3, PXA988 chips
> +		MMP2, PXA988 chips
> 
>  config MMP_DISP_SPI
>  	bool "mmp display controller spi port"
> --
> 1.9.0

