From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 08:52:46 +1100
Message-ID: <1110750766.14684.160.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<20050313082216.GA7362@sci.fi> <1110705646.14684.126.camel@gaston>
	<20050313103936.GA11002@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<20050313174714.GA15871@sci.fi>
	<9e4733910503130956401e1107@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e4733910503130956401e1107@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org


> The best model would be to chuck the AGP/PCI Express interface on the
> board and have a hyperchannel instead. Hyperchannel provides full
> cache consistency without all of these flushing problems. The GPU
> really is another specialized CPU, give it a CPU class memory
> interface.

You mean HyperTransport ? Well, PCI Express isn't far from that
neither...

Ben.
