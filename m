From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Tue, 15 Mar 2005 08:54:35 +1100
Message-ID: <1110837275.5863.19.camel@gaston>
References: <20050313082216.GA7362@sci.fi>
	<1110705646.14684.126.camel@gaston> <20050313103936.GA11002@sci.fi>
	<1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<16948.56755.114690.200854@cargo.ozlabs.ibm.com>
	<20050314005613.GA21434@sci.fi> <1110762359.19810.209.camel@gaston>
	<ye8zmx68a2b.fsf@horse01.daimi.au.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <ye8zmx68a2b.fsf@horse01.daimi.au.dk>
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
To: Soeren Sandmann <sandmann@daimi.au.dk>
Cc: Paul Mackerras <paulus@samba.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Mon, 2005-03-14 at 17:30 +0100, Soeren Sandmann wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > In an ideal world ... However, since we are planning to move the memory
> > manager to the kernel, that would mean a kernel access (syscall, ioctl,
> > whatever...) twice per access to AGP memory. Not realistic.
> 
> Could the user space driver batch many such accesses together and use
> a lock_many()/unlock_many() API?

We may have to use a lock/unlock API anyway due to interaction with the
VGA arbiter in fact. If for some reason, the card can't completely
disable decoding of VGA and IO space, it needs to bracket any access to
the framebuffer with something.

That is unuseable for things like MOL though. We are giving the
framebuffer to some foreign OS in an emulation shell that doesn't know
how to do but blit directly at any time. Oh well, I need to think a bit
more about those sceniario.

Ben.
