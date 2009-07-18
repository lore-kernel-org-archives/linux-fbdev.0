From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fb/intelfb: conflict with DRM_I915 and hide by default
Date: Fri, 17 Jul 2009 17:13:26 -0700
Message-ID: <20090717171326.4a71d8e3.akpm@linux-foundation.org>
References: <20090703112446.5a69971b@jbarnes-g45>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758097AbZGRANt@vger.kernel.org>
In-Reply-To: <20090703112446.5a69971b@jbarnes-g45>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, 3 Jul 2009 11:24:46 -0700
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

> Users get confused by this driver.  It's really a special purpose
> embedded driver, and causes a lot of problems if enabled.  So hide it
> under EMBEDDED by default, and make sure it doesn't get enabled with
> the i915 DRM driver.
> 
> Dave, I'm hoping you can feed this to Linus through your tree.  It's
> appropriate for 2.6.31 I think.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d6d65ef..ec12f7a 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1117,12 +1117,13 @@ config FB_CARILLO_RANCH
>  
>  config FB_INTEL
>  	tristate "Intel 830M/845G/852GM/855GM/865G/915G/945G/945GM/965G/965GM support (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL && FB && PCI && X86 && AGP_INTEL
> +	depends on EXPERIMENTAL && FB && PCI && X86 && AGP_INTEL && EMBEDDED
>  	select FB_MODE_HELPERS
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	select FB_BOOT_VESA_SUPPORT if FB_INTEL = y
> +	depends on !DRM_I915
>  	help
>  	  This driver supports the on-board graphics built in to the Intel
>            830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.

Nothing happened?

I'll merge this next week(ish) unless given a reason not to.
