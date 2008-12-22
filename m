From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 03/05] video: deferred io sys helpers - hecuba / n411
Date: Mon, 22 Dec 2008 14:58:01 +0900
Message-ID: <20081222055801.GA4927@linux-sh.org>
References: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se> <20081222055301.27821.25166.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081222055301.27821.25166.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, jayakumar.lkml@gmail.com

On Mon, Dec 22, 2008 at 02:53:01PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Change the hecubafb driver and the n411 code to use the new shared sys
> helpers. This allows us to remove some duplicated code. In the future
> this driver can setup the "sysdelay" value to delay flushing.
> 
> While at it, convert space to tabs for the n411 kconfig entry.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  drivers/video/Kconfig    |   17 +++------
>  drivers/video/hecubafb.c |   86 ++--------------------------------------------
>  2 files changed, 11 insertions(+), 92 deletions(-)
> 
> --- 0050/drivers/video/Kconfig
> +++ work/drivers/video/Kconfig	2008-12-22 14:06:31.000000000 +0900
> @@ -712,17 +712,12 @@ config FB_EFI
>  	  using the EFI framebuffer as your console.
>  
>  config FB_N411
> -       tristate "N411 Apollo/Hecuba devkit support"
> -       depends on FB && X86 && MMU
> -       select FB_SYS_FILLRECT
> -       select FB_SYS_COPYAREA
> -       select FB_SYS_IMAGEBLIT
> -       select FB_SYS_FOPS
> -       select FB_DEFERRED_IO
> -       select FB_HECUBA
> -       help
> -         This enables support for the Apollo display controller in its
> -         Hecuba form using the n411 devkit.
> +	tristate "N411 Apollo/Hecuba devkit support"
> +	depends on FB && X86 && MMU
> +	select FB_HECUBA
> +	help
> +	  This enables support for the Apollo display controller in its
> +	  Hecuba form using the n411 devkit.

This drops the FB_DEFERRED_IO select.. FB_HECUBA has a depends on, but
nothing else will select it.
