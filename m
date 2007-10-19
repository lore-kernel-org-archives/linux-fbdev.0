From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: YUV Framebuffer
Date: Fri, 19 Oct 2007 09:13:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710190909580.23164@anakin>
References: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710170852350.29643@anakin>
	<27AAC353AE72C840926448157F375E72012B5A8F@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710172141180.16690@anakin>
	<1192713610.8484.53.camel@daplas>
	<Pine.LNX.4.62.0710181537490.20173@pademelon.sonytel.be>
	<1192748614.5089.8.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iim3O-0001FR-Qc for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 19 Oct 2007 00:13:54 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iim3O-0001AL-32
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 19 Oct 2007 00:13:54 -0700
In-Reply-To: <1192748614.5089.8.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Rhee, C. Joon" <jrhee@qualcomm.com>

On Fri, 19 Oct 2007, Antonino A. Daplas wrote:
> On Thu, 2007-10-18 at 15:41 +0200, Geert Uytterhoeven wrote:
> > On Thu, 18 Oct 2007, Antonino A. Daplas wrote:
> > > On Wed, 2007-10-17 at 21:45 +0200, Geert Uytterhoeven wrote:
> > > > On Wed, 17 Oct 2007, Rhee, C. Joon wrote:
> > > > > Interleaved means YCBCR is on the same plane in this order.
> > > > > Y CB Y CR Y CB Y CR.... (TV-Out)
> > > > 
> > > > So it's still FB_TYPE_PACKED_PIXELS.
> > > > 
> > > > > The problem of matching Y=G, CB=B and CR=R for RGB offset is that the
> > > > > pixel cannot be represented directly since CB/CR gets shared between Ys.
> > > > > 
> > > > > So, bitsperpixel would be 16 bit and both B and R offset will be 8.
> > > > 
> > > > Doesn't sound that bad to me, if you introduce a FB_VISUAL_YCBYCR
> > > > visual. Even pixels have a Cb, odd have a Cr component.
> > > 
> > > We need at least 3 fields to describe YUV.
> > > 
> > > 1. The component size - fb_bitfield.length
> > > 2. The sample period - fb_bitfield.offset
> > > 3. The component ordering - fb_bitfield.msb_right
> > 
> > This completely changes the meaning of the latter 2 fields...
> 
> Yes, the intent was to reuse the already present fields to express YUV
> formats.

IC.

> > > So if Y = red, U = green, V = blue
> > > 
> > > YUV422
> > > 
> > > red|green|blue.length = 8 /* 8 bits per component */
> > > red.offset = 1 /* sampled every pixel */
> > > green.offset = blue.offset = 2 /* sampled every 2 pixels */
> > > red.msb_right = 1, green.msb_right = 2, blue.msb_right = 3
> > > (Y U V order)
> > > 
> > > UVY411
> > > 
> > > red|green|blue.length = 8;
> > > red.offset = 1;
> > > green.offset = blue.offset = 4;
> > > red.msb_right = 3, green.msb_right = 2, blue.msb_right = 1;
> > 
> > And you would use bits_per_pixel = 8, as you no longer have access to the
> > fb_bitfield.offsets (in the sense of `offsets within a pixel')?
> 
> We can define the bits_per_pixel as the effective pixel size. For 422,
> that would be 16. For 411, that would be 12.
> 
> > How would you express YUV420?
> 
> We can't. We need another set of fields in the vertical axis.
> 
> > Alternatively:
> >   - YUV422 really is 16 bits per pixel.
> >   - YUV411 and YUV420 really are 12 bits per pixel.
> > But I don't think this makes things easier, especially not for the 12 bpp
> > variants.
> > 
> > > The FB_VISUAL_* will differentiate if the bitfields are interpreted as
> > > RGB or YUV.
> > > 
> > > That's the only way I can think of describing YUV packed pixel formats
> > > without adding new fields, or modifying our user-visible structures.
> > > 
> > > We will need separate drawing functions for fbcon's use.
> > 
> > Of course.
> 
> Basically, since most YUV formats are fundamentally different from RGB
> (where all components are sampled per pixel), our best bet is to revive
> the framebuffer overlay support that was proposed several years ago.

What with frame buffers where there's no overlay, i.e. the YUV buffer is
the single frame buffer?

> Or, if we do not want this in the kernel, we can always tell them to use
> the DirectFB library instead.
> 
> What do you think? Should we extend the fb system to support YUV
> formats?

It's definitely needed for single YUV frame buffers.

What about:
  - fb_fix_screeninfo.visual = FB_VISUAL_YUV
  - fb_var_screeninfo.nonstd = FB_NONSTD_YUV
  - use an additional struct fb_yuv_screeninfo for the other parameters?
    or maybe better, put them in fb_var_screeninfo.reserved[]?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
