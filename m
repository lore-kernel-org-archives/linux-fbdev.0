From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Adding an fb_sync() operation to fb_ops
Date: Fri, 31 May 2002 12:56:16 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0205311240100.3190-100000@www.transvirtual.com>
References: <1022899382.561.1.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DsVb-0003Uh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 12:56:23 -0700
In-Reply-To: <1022899382.561.1.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> I don't think we can totally avoid mixing direct
> graphics memory access with hardware blitting.

In userland true. In the kernel we can work around it.

> In order to avoid that, should we:
>
> a. Just force a hardware sync after each blit?; or

> (a) is probably simpler (matrox is already doing that) but might
> decrease performance a bit (not significant since fbcon is dealing with
> text)

This depends. For traditional MMIO we need to sync up. For async DMA, Ring
buffers, and FIFOs we don't need to sync up. That is why I have no hooks
for syncing. I figure drivers can call the syncing functions if they need
it inside their own accel functions.

> b. Add a new operation, fb_sync() which will be called whenever the
> framebuffer memory will be accessed? fb_sync() should guarantee that the
> graphics pipeline has been flushed and that there are no pending
> hardware operations.

> (b) a bit more complicated, but should not be difficult to add since all
> drivers probably has some form of 'wait_for_idle' which can be wrapped.
> Then we can probably just add something like:
>
> if (info->fbops->fb_sync())
> 	info->fbops->fb_sync(info);
>
> at the top of fb_write and fb_read.

  Orginally I had that. Then I realized this doesn't fit all hardware
models. You are right tho. The one time where we do need a sync is for
fb_write and fb_read. How do we solve this? I was planning anyways to
inplement read and write hooks. The reason being is some devices don't
have proper linear framebuffers. Some have banked buffers and some like
the epson 1385 is linear but filling in a solid color at 16bpp gives
strips due to the hardware only working with word or byte align access
only. So we need hooks in this case. So these hooks could also handle the
case of havingv to sync up as well.

> Secondly (not related to the topic), I was wondering if we can change
> the color value passed to fillrect and imageblit.  Presently, the
> palette index is always passed regardless of the visual. Should the
> color value passed be reflective of the framebuffer format instead?
> Pass a palette index if pseudocolor, an RGB value for truecolor, etc.
>
> Doing the latter will simplify the low-level drawing function and at the
> same time, it will make the drawing functions more flexible -- ie,
> possiblity of exporting to userspace.

We had this discussion sometime ago. We discovered it was just impossible
to handle all the possible different color formats in the higher levels.
We ended up with way to many #ifdefs. So it was decided to let the drivers
handle it instead. Actually if you wanted it to be useable to userland
then it makes even more sense to use the color map index instead. Think
about all the if() statements you would need in userland.


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
