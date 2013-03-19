From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 19 Mar 2013 12:38:36 +0000
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
Message-Id: <30306787.0b6JgdbqYg@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txoqmo3p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Simon,

On Tuesday 19 March 2013 13:19:52 Simon Horman wrote:
> On Tue, Mar 05, 2013 at 04:45:46PM +0100, Laurent Pinchart wrote:
> > On Monday 04 March 2013 21:07:10 Kuninori Morimoto wrote:
> > > The lcdc B side horizon output is shifted
> > > if sh_mobile_lcdc_pan() was called.
> > > This patch fixup this issue.
> > > It is tested on R8A7740 Armadillo800eva HDMI output.
> > > Special thanks to Fukushima-san, and Sano-san
> > > 
> > > Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
> > > Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Laurent, can you handle getting this merged?
> If not, please let me know who to prod.

We have no fbdev maintainer anymore. Can this be pushed through your tree ?

-- 
Regards,

Laurent Pinchart

