From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 06:03:48 +0000
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
Message-Id: <20130327060346.GS25431@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Mar 26, 2013 at 04:56:09PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > > > On Monday 04 March 2013 21:07:10 Kuninori Morimoto wrote:
> > > > > > > The lcdc B side horizon output is shifted
> > > > > > > if sh_mobile_lcdc_pan() was called.
> > > > > > > This patch fixup this issue.
> > > > > > > It is tested on R8A7740 Armadillo800eva HDMI output.
> > > > > > > Special thanks to Fukushima-san, and Sano-san
> > > > > > > 
> > > > > > > Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
> > > > > > > Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
> > > > > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > > > 
> > > > > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > 
> > > > > Laurent, can you handle getting this merged?
> > > > > If not, please let me know who to prod.
> > > > 
> > > > We have no fbdev maintainer anymore. Can this be pushed through your tree ?
> > > 
> > > Could you please teach me current status of this patch ?
> > 
> > Sorry, I have been a bit slow and haven't applied it yet.
> > I plan to do so shortly.
> 
> Thank you for your help!

Can I confirm if this is for v3.9 or v3.10.
If it is for v3.9 perhaps it is also suitable for -stable?
