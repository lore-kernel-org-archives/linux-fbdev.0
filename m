From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 11:10:05 +1100
Message-ID: <1110759005.5787.198.camel@gaston>
References: <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<20050313232735.GA19781@sci.fi>
	<1110757699.5787.196.camel@gaston>  <20050314000835.GA20393@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050314000835.GA20393@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org


> I don't think "normal" drivers do them at all. I did experiment with 
> DirectFB at one point and had it place all offscreen surfaces to AGP 
> memory. It worked really well on my hardware (G400 + VIA KT133 
> northbridge). I also tried it with PCI transfers and that too worked but 
> was naturally slower. I'd like to make DirectFB use AGP again since 32MB 
> of video memory isn't always enough.
> 
> > (Which is interesting, that means that if we want to copy something out
> > of video memory, we can't write it to AGP memory and then read it, we
> > need to actually do the blit from the CPU, good to know for our memory
> > manager. That also means that we have a problem if the video memory
> > isn't entirely accessible by the CPU ...)
> 
> What about PCI master writes? Are there bridges that don't support even 
> those?

Usually, those work. I have a list of errata of Apple bridges at least
in Darwin, some do not support PCI master writes, but it's only
apparently some never-released revisions :)

> > That's something we should probably think about doing properly: Have a
> > list of AGP "issues" (errata ?) bits that are communicated by the AGP
> > host driver to the DRM.
> > 
> > At least all the early Apple AGP bridges don't do writes, and I remember
> > we have trouble with a few x86 ones as well. There are also issues when
> > a single AGP burst crosses a page boundary, and other things like that.
> 
> :(
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
