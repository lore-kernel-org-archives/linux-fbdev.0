From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Oct 2010 23:45:18 +0000
Subject: Re: [PATCH 1/4] video: add fb_edid_add_monspecs for parsing extended edid information
Message-Id: <20101028234518.GB14720@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010281427240.1257@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010281427240.1257@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Oct 28, 2010 at 04:23:12PM -0700, Andrew Morton wrote:
> On Thu, 28 Oct 2010 14:34:44 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > From: Erik Gilling <konkers@android.com>
> > 
> > Modern monitors/tvs have more extended EDID information blocks which can
> > contain extra detailed modes.  This adds a fb_edid_add_monspecs function
> > which drivers can use to parse those additions blocks.
> > 
> > Signed-off-by: Erik Gilling <konkers@android.com>
> 
> This patch should also be signed-off-by:you, as you were on the
> delivery path.
> 
> I hit a few rejects when merging agains current mainline, the
> drivers/video/sh_mobile_hdmi.c one was not completely trivial, so I ducked
> it all.  Redo and resend, please.
> 
There's also a bunch of stuff in the genesis tree heading to Linus via
rmk that will probably cause more headaches. Once that stuff has merged
then this patch will be much easier to apply.
