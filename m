From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 13 Dec 2017 23:55:26 +0000
Subject: Re: [RFC PATCH v2 01/13] bootsplash: Initial implementation showing black screen
Message-Id: <db71f29f-a9e0-070c-fd08-274323fc83a5@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-2-mstaudt@suse.de>
In-Reply-To: <20171213194755.3409-2-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On 12/13/2017 11:47 AM, Max Staudt wrote:
> This is the initial prototype for a lean Linux kernel bootsplash.
> 
> As it is now, it will show a black screen rather than a logo, and
> only if manually enabled via the kernel cmdline:
> 
>   bootsplash.enable=1

Is it .enable or .enabled?  (compare below)

> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 7f1f1fbcef9e..f3ff976266fe 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -151,6 +151,30 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>           such that other users of the framebuffer will remain normally
>           oriented.
>  
> +config BOOTSPLASH
> +	bool "Bootup splash screen"
> +	depends on FRAMEBUFFER_CONSOLE
> +	---help---
> +	  This option enables the Linux bootsplash screen.
> +
> +	  The bootsplash is a full-screen logo or animation indicating a
> +	  booting system. It replaces the classic scrolling text with a
> +	  graphical alternative, similar to other systems.
> +
> +	  Since this is technically implemented as a hook on top of fbcon,
> +	  it can only work if the FRAMEBUFFER_CONSOLE is enabled and a
> +	  framebuffer driver is active. Thus, to get a text-free boot,
> +	  the system needs to boot with vesafb, efifb, or similar.
> +
> +	  Once built into the kernel, the bootsplash needs to be enabled
> +	  with bootsplash.enabled=1 and a splash file needs to be supplied.
    	       @@@@@@@@@@@@@@@@@@@@


-- 
~Randy
