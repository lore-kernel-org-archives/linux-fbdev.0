From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Framebuffer support for HTC Dream
Date: Mon, 29 Jun 2009 12:38:40 -0700
Message-ID: <20090629123840.1e20f17d.akpm@linux-foundation.org>
References: <20090629111029.GA15514@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757993AbZF2Tj3@vger.kernel.org>
In-Reply-To: <20090629111029.GA15514@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, swetland@google.com

On Mon, 29 Jun 2009 13:10:30 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> I cleaned up dead code, a lot of debugging infastructure and horrific
> logo code. I had to remove earlysuspend support, because neccessary
> headers are not in mainline. The driver still works :-).

So you didn't wrote the code?

> I'd like to see it applied, working framebuffer is quite important for
> debugging / getting other drivers into working state.
> 
> 								Pavel
> 
> ---
> 
> This adds support for framebuffer on HTC Dream smartphone (aka
> T-Mobile G1, aka ADP1).
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Cc: Brian Swetland <swetland@google.com>

Someone did.  Are the signoffs and attributions correct and
appropriate?  Should we at least mention the driver's history in the
changelog?

Will it have a maintainer?

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index fb19803..4a7873b 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2119,6 +2119,14 @@ config FB_PRE_INIT_FB
>  	  Select this option if display contents should be inherited as set by
>  	  the bootloader.
>  
> +config FB_MSM
> +	tristate
> +	depends on FB && ARCH_MSM
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	default y

I'm seeing gpio calls in there.  Do we need a gpio dependency, or did
ARCH_MSM give us gpio anyway?
