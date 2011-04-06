From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 18:47:48 +0000
Subject: Re: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
Message-Id: <20110406184746.GE18426@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110406163805.GA11820@linux-sh.org>
	<20110406184022.GI13963@pengutronix.de>
In-Reply-To: <20110406184022.GI13963@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 06, 2011 at 08:40:22PM +0200, Uwe Kleine-K?nig wrote:
> On Thu, Apr 07, 2011 at 01:38:13AM +0900, Paul Mundt wrote:
> > On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K??nig wrote:
> > > All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> > > so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> > > depend on ARCH_MX1 or ARCH_MX2.
> > > 
> > > Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > should this go via Sascha's or Paul's tree?
> > > 
> > There shouldn't be anything it conflicts with in my tree, so it can go
> > via either. Most of the imx changes have bypassed the fbdev tree, so I'm
> > unaware if there are outstanding patches in Sascha's tree at the moment
> > or not. I can of course take it though.
> I currently collect imx patches for Sascha because he is busy doing
> other stuff.  Can I have your ack for the patch that Baruch pointed out?
> Then I'd take it for the imx tree.
> 
That's fine for this, but in the future it would be nice to have changes
that impact the fb driver go through the fb tree. In cases like this
where you have clear interdependencies in Kconfig language it obviously
doesn't make much sense to split things up, but it's something to keep in
mind for the things that can be.

Acked-by: Paul Mundt <lethal@linux-sh.org>
