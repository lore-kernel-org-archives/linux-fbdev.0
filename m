From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Adding an fb_sync() operation to fb_ops
Date: 01 Jun 2002 20:31:16 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1022934708.1398.1.camel@daplas>
References: <Pine.LNX.4.44.0205311240100.3190-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17E82g-0001GG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 01 Jun 2002 05:31:34 -0700
Received: from [205.136.61.100] (cwc100.compass.com.ph [205.136.61.100])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id UAA21990
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 1 Jun 2002 20:31:29 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <Pine.LNX.4.44.0205311240100.3190-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-06-01 at 03:56, James Simmons wrote:
> 
> > I don't think we can totally avoid mixing direct
> > graphics memory access with hardware blitting.
> 
> In userland true. In the kernel we can work around it.
> 
> > In order to avoid that, should we:
> >
> > a. Just force a hardware sync after each blit?; or
> 
> > (a) is probably simpler (matrox is already doing that) but might
> > decrease performance a bit (not significant since fbcon is dealing with
> > text)
> 
> This depends. For traditional MMIO we need to sync up. For async DMA, Ring
> buffers, and FIFOs we don't need to sync up. That is why I have no hooks
> for syncing. I figure drivers can call the syncing functions if they need
> it inside their own accel functions.

Is it the other way around, async DMA, ringbuffers, and FIFOS that will
need the syncing? Personally, whether we sync after each blit or sync
only when needed does not matter. Since fb is dealing mostly with
discontiguous regions (character cells), except for the occasional clear
screen, perfomance degradation is not significant. So, is it agreed that
for drivers that need sync's, they will just have to do it after each
blit?  It's just that it defeats the purpose of those FIFO's and
buffers.  

> 
> > b. Add a new operation, fb_sync() which will be called whenever the
> > framebuffer memory will be accessed? fb_sync() should guarantee that the
> > graphics pipeline has been flushed and that there are no pending
> > hardware operations.
> 
> > (b) a bit more complicated, but should not be difficult to add since all
> > drivers probably has some form of 'wait_for_idle' which can be wrapped.
> > Then we can probably just add something like:
> >
> > if (info->fbops->fb_sync())
> > 	info->fbops->fb_sync(info);
> >
> > at the top of fb_write and fb_read.
> 
>   Orginally I had that. Then I realized this doesn't fit all hardware
> models. You are right tho. The one time where we do need a sync is for
Still, a driver can always assign a NULL to fb_sync if it is not
needed.  


> > Secondly (not related to the topic), I was wondering if we can change
> > the color value passed to fillrect and imageblit.  Presently, the
> > palette index is always passed regardless of the visual. Should the
> > color value passed be reflective of the framebuffer format instead?
> > Pass a palette index if pseudocolor, an RGB value for truecolor, etc.
> >
> > Doing the latter will simplify the low-level drawing function and at the
> > same time, it will make the drawing functions more flexible -- ie,
> > possiblity of exporting to userspace.
> 
> We had this discussion sometime ago. We discovered it was just impossible
> to handle all the possible different color formats in the higher levels.
> We ended up with way to many #ifdefs. So it was decided to let the drivers
> handle it instead. Actually if you wanted it to be useable to userland
> then it makes even more sense to use the color map index instead. Think
> about all the if() statements you would need in userland.
> 
I agree that fbcon-accel will be swamped by  if-else/case-switch
statements, and passing palette indices may be the best solution
overall. The price, though, is that those drawing functions may only be
usable within the kernel. 

If these drawing functions are to be exported to userland, then the
current implementation will necessitate a workaround.  Within the kernel
we are dealing with 16 colors, and color palettes (in pseudocolor) have
a practical limit of 256. In userland we are dealing with thousands to
millions of colors.  So how will I convert a particular 16-bit RGB
colorvalue into a palette index?

a.  Reset the colormap so that a particular colorvalue can be indexed
from the map and keep track which colorvalue is in the map or not.  

b.  Tell the accelerator that it is not actually a palette index, but
treat it as directcolor;

c.  Or allocate a colormap that will encompass the entire color range
(insane).

I can't really think of any other way, so correct me if I'm wrong. In
the end though, it's much simpler to just pass the appropriate color
value.

Secondly, if I'm going to use, for instance, imageblit to tile and
expand an 8x8 mono bitmap, then for each tile, the accelerator has to
lookup the color which is too inefficient.  On the other hand, if the
color is looked up in the upper layer, then it's done only once.  Of
course, this is not done in the console, so it's a bad example. 


Tony


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
