From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 08:51:08 +1100
Message-ID: <1110750668.14684.158.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<20050313174714.GA15871@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050313174714.GA15871@sci.fi>
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


> > If you are doing fallback calculations in a 6MB buffer that is 1,500
> > pages. Accessing all of this effectively flushes the data cache. Once
> > you are done with it you probably don't want those pages in the cache
> > anyway.
> 
> I don't understand why we have "GART memory" anyway. It's just main memory 
> and I don't see any point going through the GART to access it with the 
> CPU. Only the graphics card needs to use the GART.

Which is what we do on some archs, like Apple ppcs, where the GART
doesn't work for CPU accesses. We just use the real RAM pages. However,
we have to map them non-cacheable since the GPU GART accesses bypass the
cache coherency protocol (that is the case on most AGP implementations
afaik and is broken by design, imho).

Ben.
