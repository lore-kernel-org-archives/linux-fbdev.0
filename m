From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: [adaplas@pol.net: Re: Fwd: Re: [Dri-devel] future of DRI?]
Date: Sun, 2 Mar 2003 22:57:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030302215758.GA3390@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
To: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net

Hello, ...

BTW, here is a response from Antonino Daplas, to Linus's message, that
Jon Smirl forwarded to the fbdev mailing list.

I think it doesn't make much sense to have such discution happening
separatedly on two different mailing list, where most peoples involved
only follow one of the two, so i forward the response from Antonino and
also start a cross-thread (or whatever that is called). I hope it is ok
for all of you.

Friendly,

Sven Luther

----- Forwarded message from Antonino Daplas <adaplas@pol.net> -----

On Sun, 2003-03-02 at 02:42, Jon Smirl wrote: 
> --- Linus Torvalds <torvalds@transmeta.com> wrote:
> > From: Linus Torvalds <torvalds@transmeta.com>
> > To: Keith Whitwell <keith@tungstengraphics.com>
> > CC: Jon Smirl <jonsmirl@yahoo.com>, Ian Romanick
> > <idr@us.ibm.com>,
> >         "DRI developer's list"
> > <dri-devel@lists.sourceforge.net>
> > Subject: Re: [Dri-devel] future of DRI?
> > Date: Sat, 1 Mar 2003 10:15:06 -0800 (PST)
> > 
> > 
> > On Sat, 1 Mar 2003, Keith Whitwell wrote:
> > > 
> > > Interesting you mention it.  This is what Brian &
> > I've done in the Mesa 
> > > embedded branch -- layered the radeon dri driver
> > on top of fbdev.  I can also 
> > > build regular DRI drivers from a minimal tree &
> > sane set of makefiles.
> > 
> > Personally, I'd rather see DRI _underneath_ fbdev
> > rather than on top of. 
> > Since fbdev would require at least to know of (and
> > obey) the DRI locking 
> > code - and would likely want to use all the same DRI
> > command execution for 
> > things like blits etc (this is on the assumption
> > that 2d and 3d will 
> > eventually use the same engine, which is probably a
> > safe assumption).
> > 
> > I _assume_ that what you really mean is that you use
> > fbdev really only to
> > set up the screen modes and do things like
> > initialize the graphics
> > buffers.
> > 
> > 		Linus
> > 
Yes, this is the sanest way.  In my opinion, this is how fbdev and DRI
should operate: 

1. fbdev 
- provide a means to initialize and change the video state. 

- provide pointers to graphics/rendering memory, MMIO, DMA/ringbuffers 

- graphics memory may or may not be available to everyone, but the MMIO
and command buffers will only be available to DRI 

- fbdev must not touch any registers besides those required to
initialize the hardware.  No 2D, no 3D. 

2. fbaa 

- or framebuffer acceleration architecture or whatever you want to call
it.  This will be equivalent to Xfree86's XAA. It provides a 2D
abstraction layer for clients residing in kernel space (ie fbcon). It
will have software versions and optionally accelerated versions.  The
accelerated version has intimate knowledge of the 2D engine, but instead
of accessing the hardware directly, it will rely on DRM to pass commands
to the hardware. 

- in its current form, this will be the fb_imageblit(), fb_copyarea()
and fb_fillrect(). 

3. fbcon 

- this is the console driver that runs on top of fbaa 

4. DRM - will get mmio pointer and command buffers from fbdev and will
generally retain its original functions (interrupt handling, locking,
arbitration, DMA interface, the works).  It must also provide an
interface for fbaa. 

5. Userland apps - should only see the graphics memory pointer via
fbdev.  If they need to access the hardware, they have to go through
DRM. 

Advantages:  

1. fbdev will be secure.  Without access to the MMIO regions, crashing
the chipset is unlikely or at least difficult.  Even malicious blit
commands (blits to/from system memory) will not work.  

2. Single point of entry for hardware access (DRI).  You can run
multiple clients trying to access the hardware simultaneously via DRM.  
And because of DRM's features, it will take care of command
verification, arbitration, locking, context switching, etc.  

3.  Because DRM will handle both 2D and 3D and is pretty much the only
one with hardware access, performance might actually increase.  


Disadvantages: 

1. very linux specific.  Xfree86 was designed to run on different
platforms.  Having one code for linux and another for the rest will be
difficult for XFree86 developers to accept. 

2. this will break fb-based apps that require chipset access, ie
DirectFB. 

3. a lot of code are difficult to implement in kernel space, ie
initialization of secondary cards.  Full video bios access can only be
done, from a practical standpoint, in user space (the Intel 830, for
instance, may require this). 

4. Not all fbdev drivers has a DRI counterpart.  For these chipsets,
fbaa still has to access the hardware directly. 


In linux-2.5, fbcon is already separate from fbdev.  Perhaps in 2.7,
fbdev can be further reduced to a minimal core, moving the rest of the
code to fbaa.  Exporting the mmio regions to userland must be
disallowed. 

Secondly, a module to access DRM services from within the kernel will be
needed. 

Any comments? 

Tony  



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

----- End forwarded message -----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
