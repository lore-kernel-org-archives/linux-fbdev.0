From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Mon, 14 Mar 2005 12:05:59 +1100
Message-ID: <1110762359.19810.209.camel@gaston>
References: <20050313082216.GA7362@sci.fi>
	<1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi>
	<1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<16948.56755.114690.200854@cargo.ozlabs.ibm.com>
	<20050314005613.GA21434@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050314005613.GA21434@sci.fi>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Paul Mackerras <paulus@samba.org>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org


> It should be the responsibility of the memory manager. If anything wants 
> to access the memory it would call lock() and when it's done with the 
> memory it calls unlock(). That's exactly how DirectFB's memory manager 
> works.

In an ideal world ... However, since we are planning to move the memory
manager to the kernel, that would mean a kernel access (syscall, ioctl,
whatever...) twice per access to AGP memory. Not realistic.

The case of the CP ring is easy to deal with by the macros we have there
already and it would be kernel-kernel. But it would be a hit for a lot
of other things I suppose.

Ben.
