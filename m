From: Tony Lindgren <tony@atomide.com>
Date: Mon, 08 Oct 2012 17:26:32 +0000
Subject: Re: [PATCH 2/2] OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
Message-Id: <20121008172632.GJ3874@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349699429-12736-1-git-send-email-tomi.valkeinen@ti.com>
 <1349699429-12736-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1349699429-12736-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121008 05:32]:
> Now that vrfb driver is not omap dependent anymore, we can move vrfb.h
> from arch/arm/plat-omap/include/plat to include/video/omapvrfb.h.

Once the request_mem_region in patch 1/2 are handled:

Acked-by: Tony Lindgren <tony@atomide.com>

Also, can you please do a minimal immutable branch on -rc1 that
we both can use? I need these into my cleanup branch for v3.8
merge window.

Regards,

Tony
