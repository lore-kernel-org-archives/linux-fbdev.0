From: Luc Verhaegen <libv@skynet.be>
Date: Mon, 29 Sep 2014 16:58:42 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929165842.GC5599@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather> <20140927235601.19023.31593@quantum>
 <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929162814.GE4081@lukather>
In-Reply-To: <20140929162814.GE4081@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
> On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
> > 
> > This is a fundamental issue that we are facing and I'm trying to come up
> > with a solution that is future-proof and will work for drivers other
> > than simplefb.
> > 
> > Just because we currently lack this functionality doesn't make it a hack
> > trying to add it.
> 
> Or maybe it's just showing that the trend to rely more and more on the
> firmware is a bad idea?
> 
> I really start to consider adding a sunxi-uboot-fb, that would just
> duplicate the source code of simplefb but also taking the
> clocks. Somehow, I feel like it will be easier (and definitely less of
> a hack than using the generic common clock API).

In the 2nd round of this discussion, i stated that another fb or even a 
drm driver altogether seemed to be the sensible way out of this mess.

I suggest drm_rescue.

> > Then instead of hacking existing drivers to work on your particular
> > platform you should start looking into hacking your platform drivers to
> > cope with the lack of a proper display driver. Or alternatively spend
> > the time getting a proper display driver merged.
> > 
> > Whether simplefb is used as primary framebuffer or just during only boot
> > until hand-off to a real driver, it still remains a stop-gap solution.
> 
> Then really, simplefb deserves a more appropriate name. Like
> uselessfb, tegrafb, DONOTUSEITYOUSTUPIDDEVfb or whatever makes it not
> look generic.

Very early on, now almost two months back, i used the word "denialfb".
rpifb is the real name of this thing though, but then the dt binding 
names would have to change and whatnot.

I don't get the resistance, at least not from a technical point of view. 
And i do not care enough to get properly involved in this pointless and 
endless discussion. drm_rescue it is.

Luc Verhaegen.
