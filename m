From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Nov 2010 16:38:53 +0000
Subject: Re: [PATCH 07/10] MCDE: Add display subsystem framework
Message-Id: <201011121738.53536.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-7-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-8-git-send-email-jimmy.rubin@stericsson.com>
In-Reply-To: <1289390653-6111-8-git-send-email-jimmy.rubin@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 10 November 2010, Jimmy Rubin wrote:
> This patch adds support for the MCDE, Memory-to-display controller,
> found in the ST-Ericsson ux500 products.
> 
> This patch adds a display subsystem framework that can be used
> by a frame buffer device driver to control a display and MCDE.

Like "hardware abstraction layer", "framework" is another term that
we do not like to hear. We write drivers that drive specific hardware,
so better name it after the exact part of the chip that it is driving.

Other terms to avoid include "middleware", "generic subsystem" and
"wrapper".

> +struct kobj_type ovly_type = {
> +	.release = overlay_release,
> +};

You certainly should not define a new kobj_type for use in a device driver.
This is an internal data structure of the linux core code. It might make
sense if you were trying to become the new frame buffer layer maintainer
and rewrite all the existing drivers to be based on the concept of
overlays, but even then there is probably a better way.

Maybe you were thinking of using kref instead of kobj?

> +int __init mcde_dss_init(void)
> +{
> +	return 0;
> +}
> +
> +void mcde_dss_exit(void)
> +{
> +}

If they don't do anything, don't define them.

	Arnd
