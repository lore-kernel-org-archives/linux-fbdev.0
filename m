From: Kevin Hilman <khilman@ti.com>
Date: Tue, 21 Jun 2011 14:49:59 +0000
Subject: Re: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Message-Id: <87vcvzz1bc.fsf@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
	<1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Thu, 9 Jun 2011 16:56:42 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Use PM runtime and HWMOD support to handle enabling and disabling of DSS
> modules.
>
> Each DSS module will have get and put functions which can be used to
> enable and disable that module. The functions use pm_runtime and hwmod
> opt-clocks to enable the hardware.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Runtime PM usage is much better on this version, thanks!

Like Paul, I'm not crazy about the helper functions, especially the ones
that don't do much other than call runtime PM with some debug code
around them since runtime PM already has useful debug.

However, you're the maintainer and the one who has to debug this code
more than I do, so that decision is up to you.

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin
