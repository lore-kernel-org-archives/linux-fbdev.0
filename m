From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Tue, 28 Oct 2003 14:54:10 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310281441470.1600-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310281855430.5142-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310281855430.5142-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


On Tue, 28 Oct 2003, James Simmons wrote:
> 
>    This is good design for DMA based graphics cards. Unfortunely at present 
> maybe one fbdev driver actaully uses DMA (i810fb). Almost all fbdev drivers 
> use IO access :-( Sure we could convert as many as possible to DMA, which I was 
> planning to do anyways :-)

Even if you don't use DMA, you still want the discovery/enumeration and
serialization parts, which you want in the kernel.

And if the driver ends up being really small - all the better. If the card 
literally doesn't even have a command buffer (ie a truly stupid entirely 
synchronous IO programming model like classic VGA) then the driver won't 
even need the "wait for command ring empty" kind of thing.

Now, your reaction might be that "oh, but what a wasteful thing to have a
driver for just a simple serialization and discovery". True. But on the
other hand, it's not like it would be actually wasting that much, and the
nice thing is that this kind of truly minimal driver that doesn't have to
worry about DMA etc can quite likely be shared with pretty much _all_ of
the stupid cards. So we could have just _one_ driver that covers all of
the "this card doesn't do DMA or even retrace interrupts".

So don't worry about the fact that for some hardware the driver might be 
really simple. Even a simple driver is worth it if it means that we can 
have a unified model for synchronizing between the different agents that 
want to touch the video hardware. I think.

>    Unfortunely most fbdev drivers set the hardware in IO access mode. Plus 
> some of the devices lack any kind of DMA support.

I don't think this is "unfortunately" at all. Quite the reverse. If the
card doesn't use/need DMA, that just makes for a simple low-level driver.

The reason I mentioned DMA arbitration as a major thing the driver would
do is not because I think that every driver _has_ to have DMA. I mentioned
it specially because DMA is kind of special in that it is done
asynchronously and thus needs an abitration model that is above-and-beyond
just a normal "lock this card" thing.

			Linus



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
