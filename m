From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 09:41:21 +1100
Message-ID: <1110753681.19810.181.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	 <20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	 <20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	 <9e473391050313081937cde207@mail.gmail.com> <20050313174714.GA15871@sci.fi>
	 <9e4733910503130956401e1107@mail.gmail.com>
	 <1110750766.14684.160.camel@gaston>
	 <9e47339105031314175fdd4e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031314175fdd4e9e@mail.gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Sun, 2005-03-13 at 17:17 -0500, Jon Smirl wrote:
> On Mon, 14 Mar 2005 08:52:46 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > > The best model would be to chuck the AGP/PCI Express interface on the
> > > board and have a hyperchannel instead. Hyperchannel provides full
> > > cache consistency without all of these flushing problems. The GPU
> > > really is another specialized CPU, give it a CPU class memory
> > > interface.
> > 
> > You mean HyperTransport ? Well, PCI Express isn't far from that
> > neither...
> 
> Yes, HyperTransport. That's what I get for writing email while the
> babies are crying.
> 
> Does PCI Express support a full cache coherency protocol like
> HyperTransport?

Or just like PCI :)

AGP is just a special case, and I'm not even sure wether the cache
incoherency is a spec thing or just that all implementations are
broken :) I'll check when I find my AGP spec.

>  So if the GPU touches a page of system memory, the
> system memory will get flushed out of the CPU cache? In that case we
> don't need to mark shared GPU/CPU memory as non-cachable.

Well, that's what happen with a normal cache coherent setup, but I'm
fairly sure that won't happen with AGP on a lot of machines.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
