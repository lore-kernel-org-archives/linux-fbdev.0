From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 10:48:19 +1100
Message-ID: <1110757699.5787.196.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<20050313232735.GA19781@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050313232735.GA19781@sci.fi>
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


> > That shouldn't matter the page brought in would be for a speculative
> > read and never accessed. It should just fall out of the cache and not
> > be written back. There is only one cachable mapping. In this model
> > writes are always followed by a flush before telling the GPU to access
> > the memory that has just been written.
> 
> What about this scenario?
> 
> Speculative read -> AGP master writes new data -> CPU has invalid data in 
> cache :(

First, we must be very careful with AGP master writes. I don't know if
we do a lot of them currently, but I know a collection of north bridges
that do not support them.

(Which is interesting, that means that if we want to copy something out
of video memory, we can't write it to AGP memory and then read it, we
need to actually do the blit from the CPU, good to know for our memory
manager. That also means that we have a problem if the video memory
isn't entirely accessible by the CPU ...)

That's something we should probably think about doing properly: Have a
list of AGP "issues" (errata ?) bits that are communicated by the AGP
host driver to the DRM.

At least all the early Apple AGP bridges don't do writes, and I remember
we have trouble with a few x86 ones as well. There are also issues when
a single AGP burst crosses a page boundary, and other things like that.

Ben.
