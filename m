From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Jan 2012 00:53:39 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi: add extra settings method for platform
Message-Id: <87fwf255kf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi

> How does TI handle that for the OMAP platform ? I don't think they configure 
> the LCD module/panel in board code. Maybe we should ask them if they have a 
> solution, or even plans to handle the problem ? Tomi Valkeinen is probably the 
> right person to ask.

I asked it to Tomi (off-list), and I got one solution.
I will create SuperH panel driver for it.

Thank you Laurent, Tomi.

Best regards
---
Kuninori Morimoto
