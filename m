From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 10 May 2010 09:37:41 +0000
Subject: Re: [PATCH 3/4 v2] ARM: add framebuffer support for ap4evb
Message-Id: <uocgoayhi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
 <Pine.LNX.4.64.1005071105140.4777@axis700.grange>
 <Pine.LNX.4.64.1005071641440.4777@axis700.grange>
 <uvdawbopi.wl%kuninori.morimoto.gx@renesas.com>
 <Pine.LNX.4.64.1005100807120.15250@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005100807120.15250@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>


Dear Guennadi

> > Why is this "select" needed here ?
> > Do you want "force select MIPI DSI" on AP4 ?
> 
> Not on all AP4 systems, only on ap4evb board, because I thought, that's 
> the display, that it is using.

sorry, it mean AP4EVB board

> > I asked because AP4 board can select other type LCD.
> > (not only MIPI DSI)
> 
> ap4evb can also have other LCDs attached to it? Then this will have to 
> become a "choice" between various display types, where the MIPI DSI one 
> will select SH_LCD_MIPI_DSI. We can either do this now or later when more 
> LCD types are added.

OK. I understand.

Best regards
--
Kuninori Morimoto
 
