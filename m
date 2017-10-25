From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 25 Oct 2017 17:26:03 +0000
Subject: Re: [RFC 01/14] bootsplash: Initial implementation showing black screen
Message-Id: <2e19f572-5850-ba1e-8b81-94c02c800094@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
 <20171025124602.28292-2-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-2-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

On 10/25/17 05:45, Max Staudt wrote:

> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 7f1f1fbcef9e..a6617c07229a 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -151,6 +151,30 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>           such that other users of the framebuffer will remain normally
>           oriented.
>  
> +config BOOTSPLASH
> +	bool "Bootup splash screen"
> +	depends on FRAMEBUFFER_CONSOLE=y

Fix "help" indentation: (from process/coding-style:)

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> +        ---help---
> +          This option enables the Linux bootsplash screen.
> +
> +          The bootsplash is a full-screen logo or animation indicating a
> +          booting system. It replaces the classic scrolling text with a
> +          graphical alternative, similar to other systems.
> +
> +          Since this is technically implemented as a hook on top of fbcon,
> +          it can only work if the FRAMEBUFFER_CONSOLE is enabled and a
> +          framebuffer driver is active. Thus, to get a text-free boot,
> +          the system needs to boot with vesafb, efifb, or similar.
> +
> +          Once built into the kernel, the bootsplash needs to be enabled
> +	  with bootsplash.enabled=1 and a splash file needs to be supplied.
> +
> +          Further documentation can be found in:
> +            Documentation/fb/bootsplash.txt
> +
> +          If unsure, say N.
> +          This is typically used by distributors and system integrators.
> +
>  config STI_CONSOLE
>          bool "STI text console"
>          depends on PARISC

-- 
~Randy
