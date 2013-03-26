From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Mar 2013 23:56:09 +0000
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
Message-Id: <87obe5iulp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Simon

> > > > > On Monday 04 March 2013 21:07:10 Kuninori Morimoto wrote:
> > > > > > The lcdc B side horizon output is shifted
> > > > > > if sh_mobile_lcdc_pan() was called.
> > > > > > This patch fixup this issue.
> > > > > > It is tested on R8A7740 Armadillo800eva HDMI output.
> > > > > > Special thanks to Fukushima-san, and Sano-san
> > > > > > 
> > > > > > Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
> > > > > > Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
> > > > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > > 
> > > > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > 
> > > > Laurent, can you handle getting this merged?
> > > > If not, please let me know who to prod.
> > > 
> > > We have no fbdev maintainer anymore. Can this be pushed through your tree ?
> > 
> > Could you please teach me current status of this patch ?
> 
> Sorry, I have been a bit slow and haven't applied it yet.
> I plan to do so shortly.

Thank you for your help!


Best regards
---
Kuninori Morimoto
