From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 Mar 2013 13:34:07 +0000
Subject: Re: [PATCH 1/5] videomode: simplify videomode Kconfig and Makefile
Message-Id: <2623790.oJdsJXERqZ@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hi Tomi,

Thanks for the patch.

On Tuesday 12 March 2013 12:19:34 Tomi Valkeinen wrote:
> This patch simplifies videomode related Kconfig and Makefile. After this
> patch, there's only one non-user selectable Kconfig option left,
> VIDEOMODE_HELPERS. The reasons for the change:
> 
> * Videomode helper functions are not something that should be shown in
>   the kernel configuration options. The related code should just be
>   included if it's needed, i.e. selected by drivers using videomode.
> 
> * There's no need to have separate Kconfig options for videomode and
>   display_timing. First of all, the amount of code for both is quite
>   small. Second, videomode depends on display_timing, and display_timing
>   in itself is not really useful, so both would be included in any case.
> 
> * CONFIG_VIDEOMODE is a bit vague name, and CONFIG_VIDEOMODE_HELPERS
>   describes better what's included.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>

I like that.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

