From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 18:13:32 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310271753180.1600-100000@home.osdl.org>
References: <1067298909.26680.22.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <1067298909.26680.22.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


On Tue, 28 Oct 2003, Benjamin Herrenschmidt wrote:
> 
> I see your point about fbdev not beeing the proper interface here.
> 
> But then, what would be the relationchip between that low level stuff
> and fbdev ?

My suggestion, as a starting point, is to really think very rudimentary at
first. A truly _minimal_ thing. Minimal partly because that just avoids
all the interface design issues ("there are none" ;), but partly because
everybody involved will have rather different goals. In particular, the
XFree86 people would have as a goal to keep the differences to a
user-space implementation minimal, so in that sense you really want to
have an abstraction that doesn't hide the hardware AT ALL.

NOTE! I'm not saying this is necessarily the best interface or a truly 
great idea. This is just throwing out my thought of the day. I'm nothing 
if not flexible - some people think I change my mind _too_ often ;)

So the thing should really just have 
 - discovery and attach/detach
 - interrupt event notification (and it can't just be "an interrupt 
   happened" - the interrupt driver actually has to know enough to ACK the
   interrupt, so that we can tell user space that an interrupt happened 
   without having to disable the interrupt until the event goes away)
 - serialization (ie a lock) and waiting for events ("engine idle" or 
   "command queue less than half full")
 - DMA arbitration and setup.

Most of the rest (actual IO accesses etc) can be done outside the lowlevel
crud, once you have the lock. This is also why DMA really _is_ special,
since it's asynchronous: so it can and does happen independently of the
lock. But normal synchronous programmed IO doesn't need any real help, and 
there's no point in forcing that into the low-level driver. All the users 
might as well do any direct IO directly.

So the low-level driver wouldn't know about palettes or cursors or any 
"high-level" concepts like that. It would have a few locks to make sure 
that the users that try to access the things don't stop on each other, 
nothing more (maybe the locks themselves would be grouped into "palette 
lock" vs "cursor lock" vs "DMA engine lock" since hardware may be threaded 
enough to allow it, but the point is that the low-level driver wouldn't 
actually _do_ anything, it only allows others to do what they want without 
stomping on each others toes).

Is this wonderful and solves all problems? Hell no. The interfaces would 
be pretty ugly and specialized.

That doesn't mean that there aren't any issues at all. For example for
locking, you probably don't want just "lock" and "unlock": you'd likely 
want the low-level driver to implement the "expensive lock", but do your 
own cheap locks in low-level drivers. That in turn means that the 
lowlevel lock needs to have a "please release the lock" callback thing. 
Something that works for everybody. Which might not be all that east at 
all.

> There are lots of tricky things to do especially at board init time
> that basically require direct register access (and if possible beeing
> in the kernel with irq off for subtle things like "measuring" the
> board PLL, unfortunately necessary on some cards).

This is exactly the kinds of things I would advice against very strongly. 
You do _not_ want to have a common driver that knows that much about the 
hardware. Because if the common driver has to know all the esoteric 
details, there's no way it will get them all right. And once it gets 
something wrong, people start trying to work around it and have driver 
quirks and version dependencies etc.

> This looks like just an extension of the current DRI modules, and having
> things like fbdev stack on top of them...

Quite the reverse, I think. It would be a _shrink_ of the DRI modules.

		Linus



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
