From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 14:43:55 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030305134355.GA3105@iliana>
References: <1046852721.1228.13.camel@localhost.localdomain> <20030305110529.GA2036@iliana> <1046868330.1229.59.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qZBt-0004er-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 05:44:13 -0800
Content-Disposition: inline
In-Reply-To: <1046868330.1229.59.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Mar 05, 2003 at 08:46:52PM +0800, Antonino Daplas wrote:
> On Wed, 2003-03-05 at 19:05, Sven Luther wrote:
> > On Wed, Mar 05, 2003 at 04:26:04PM +0800, Antonino Daplas wrote:
> > > 
> > > Hi,
> > > 
> > > I believe it's time to finalize what is needed/not needed for the
> > > framebuffer framework:
> > > 
> > > 1. Text mode support?
> > 
> > Would this work also on arches which don't traditionnaly do text mode ?
> > Like ppc for example. 
> 
> Yes, pixel-based drawing is still the default.  It's only for drivers
> (matrox and sbus) where it might be needed.

And do you think there is a chance of standard vgacon working on a ppc
board ? I have a pegasos powerpc/pop based board, and its OF use a x86
emulator to boot the card into vga textmode. matroxfb is broken on it
last i tried, and radeonfb was not uptodate in the kernel that was
provided, and i there is problems with other fbdevs also, so it
would be nice if it was possible to use vgacon on such hardware, until
the fbdevs are fixed, but it is a bit hard to fix things without a
working console.

> > > 2. console resizing using fbset (besides stty)?
> > 
> > What about dynamic multi-head support ?
> > 
> > > 7. Anything else?
> > 
> > Well, what is the exact status of mult-head and multi-seat ? It is
> 
> If you mean one card with multiple heads, that will need driver-specific
> support. 

I thought that the new API, separating the fbcon layer from the fbdev
drivers would add support for this more easily. I guess it would be easy
for the Appian Jeronimo 2000 board, which has two permedia3 chips, and
thus can be seen as two separate devices. Cards with two ramdacs per
chip, like the G400, the later radeon's and most recent cards would need
driver level support, that is understandable, but is all there for fbcon
to take advantage of it ? What about multi-seat, with two full consoles,
with mouse and keyboard for each ?

> > supposed to work, but i did not (yet) experience it myself, mainly
> > because non of my graphic cards are yet supported. One point i would
> > like to see addressed is the ability to share one framebuffer and have
> > both heads be separate viewports into this same framebuffer. This
> > means setting a framebuffer with a stride equal to the sum of both's
> > head resolution and having each head display a subset of it. This would
> > also include having one head be a mirror of the other and other such
> > things. This feature and resizing may cause problems though.
> > 
> 
> Because of the massive rewrite, there wasn't really enough time to add
> major feature sets to the framework.  Most of the effort was spent on
> bug fixing, cleaning up, and speeding up the code (to justify the
> rewrite). 

There is discution about this currently in the DRI/xfree86 mailing list,
and i am facing this also in my xfree86 driver. Maybe for the next
developpment cycle then. I thought that one of the reasons of the
rewrite was to provide easier multi-head and multi-seat support though.

> It does have one benefit though, the newer code should make it easier to
> add an infrastructure on top of fbdev, such as xinerama-style support. 
> But this will be in the future.

Mmm, I don't know if there is really a point to this, are there really
all that much applications which do xinerama-like things on top of fbdev ?
I rather thought that more higlevel userland apps would be doing this.
like either xfree86 with chip-specific drivers or fbdev drivers, or
directfb or something such.

What i think would be nice is to be able to separate the framebuffer
setup (where we write to) from the dac/dp output to the monitors, and
when we outport this to the higher level apps, we export them
separatedly. This way X drivers can use one huge framebuffer, with DRI
enabled to render on the framebuffer, and enable arbitrary setting of
viewports into this framebuffer, with eventual scaling or other such
stuff. And fbcon could then easily use two viewports into the same
framebuffer to do dual-head/dual-seat. Overlays (for cursor and/or video)
would be linked to the monitor outputs and not the framebuffer.

But maybe it is too late for this, good ideas for 2.7.x/3.1.x or
whatever it will be named though, together with a framebuffer/agp memory
management scheme which would be common to DRI, fbdev and X, and would
reside in the drm module.

> > > 8. feature freeze deadline?
> > 
> > This would be for fbdev deature freeze, right, not for the drivers ?
> > 
> 
> Yes, to give people time to port their drivers.

:)))

> > BTW, i will no more be able to work on pm3fb, since i just recently
> > noticed that my nice AGP8 supporting motherboard doesn't accept my
> > Appian Jeronimo 2000 board. :(((
> 
> That's too bad :-(

I will see if i get another board someday, but it will not be in the
immediate future. And it refused to even boot in the pegasos board.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
