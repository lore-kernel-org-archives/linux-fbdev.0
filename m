From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Tue, 28 Oct 2003 19:40:33 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310281855430.5142-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0310271753180.1600-100000@home.osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310271753180.1600-100000@home.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> > I see your point about fbdev not beeing the proper interface here.
> > 
> > But then, what would be the relationchip between that low level stuff
> > and fbdev ?
> 
> My suggestion, as a starting point, is to really think very rudimentary at
> first. A truly _minimal_ thing. Minimal partly because that just avoids
> all the interface design issues ("there are none" ;), but partly because
> everybody involved will have rather different goals. In particular, the
> XFree86 people would have as a goal to keep the differences to a
> user-space implementation minimal, so in that sense you really want to
> have an abstraction that doesn't hide the hardware AT ALL.
> 
> NOTE! I'm not saying this is necessarily the best interface or a truly 
> great idea. This is just throwing out my thought of the day. I'm nothing 
> if not flexible - some people think I change my mind _too_ often ;)
> 
> So the thing should really just have 
>  - discovery and attach/detach
>  - interrupt event notification (and it can't just be "an interrupt 
>    happened" - the interrupt driver actually has to know enough to ACK the
>    interrupt, so that we can tell user space that an interrupt happened 
>    without having to disable the interrupt until the event goes away)
>  - serialization (ie a lock) and waiting for events ("engine idle" or 
>    "command queue less than half full")
>  - DMA arbitration and setup.

   This is good design for DMA based graphics cards. Unfortunely at present 
maybe one fbdev driver actaully uses DMA (i810fb). Almost all fbdev drivers 
use IO access :-( Sure we could convert as many as possible to DMA, which I was 
planning to do anyways :-)
 
> Most of the rest (actual IO accesses etc) can be done outside the lowlevel
> crud, once you have the lock. This is also why DMA really _is_ special,
> since it's asynchronous: so it can and does happen independently of the
> lock. But normal synchronous programmed IO doesn't need any real help, and 
> there's no point in forcing that into the low-level driver. All the users 
> might as well do any direct IO directly.
> 
> So the low-level driver wouldn't know about palettes or cursors or any 
> "high-level" concepts like that. It would have a few locks to make sure 
> that the users that try to access the things don't stop on each other, 
> nothing more (maybe the locks themselves would be grouped into "palette 
> lock" vs "cursor lock" vs "DMA engine lock" since hardware may be threaded 
> enough to allow it, but the point is that the low-level driver wouldn't 
> actually _do_ anything, it only allows others to do what they want without 
> stomping on each others toes).

   Unfortunely most fbdev drivers set the hardware in IO access mode. Plus 
some of the devices lack any kind of DMA support. In this case seperating 
out the parts of the driver that program the "high level" stuff leaves 
almost nothing left. Would it still be wise to seperate it out as you 
suggest? Would we really gain that much doing this for the case of IO 
access only graphics hardware?  	

> > This looks like just an extension of the current DRI modules, and having
> > things like fbdev stack on top of them...
> 
> Quite the reverse, I think. It would be a _shrink_ of the DRI modules.

:-)




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
