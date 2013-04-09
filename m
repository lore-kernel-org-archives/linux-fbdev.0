From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 09 Apr 2013 00:16:37 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed,  3 Apr 2013 20:39:43 -0600 Stephen Warren <swarren@wwwdotorg.org> wrote:

> A simple frame-buffer describes a raw memory region that may be rendered
> to, with the assumption that the display hardware has already been set
> up to scan out from that buffer.
> 
> This is useful in cases where a bootloader exists and has set up the
> display hardware, but a Linux driver doesn't yet exist for the display
> hardware.
> 
> ...
>
> +config FB_SIMPLE
> +	bool "Simple framebuffer support"
> +	depends on (FB = y) && OF

It's sad that this simple little thing requires Open Firmware.  Could
it be generalised in some way so that the small amount of setup info
could be provided by other means (eg, module_param) or does the
dependency go deeper than that?

> +struct simplefb_format simplefb_formats[] = {
> +	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
> +};

I'll make this static.

