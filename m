From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: YUV Framebuffer
Date: Fri, 19 Oct 2007 07:03:34 +0800
Message-ID: <1192748614.5089.8.camel@daplas>
References: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710170852350.29643@anakin>
	<27AAC353AE72C840926448157F375E72012B5A8F@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710172141180.16690@anakin>
	<1192713610.8484.53.camel@daplas>
	<Pine.LNX.4.62.0710181537490.20173@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiePS-000751-Ec for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 16:04:10 -0700
Received: from hs-out-0708.google.com ([64.233.178.241]
	helo=hs-out-2021.google.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiePP-0007ey-NC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 16:04:10 -0700
Received: by hs-out-2021.google.com with SMTP id 55so244056hsc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 16:04:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0710181537490.20173@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: "Rhee, C. Joon" <jrhee@qualcomm.com>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-10-18 at 15:41 +0200, Geert Uytterhoeven wrote:
> On Thu, 18 Oct 2007, Antonino A. Daplas wrote:
> > On Wed, 2007-10-17 at 21:45 +0200, Geert Uytterhoeven wrote:
> > > On Wed, 17 Oct 2007, Rhee, C. Joon wrote:
> > > > Interleaved means YCBCR is on the same plane in this order.
> > > > Y CB Y CR Y CB Y CR.... (TV-Out)
> > > 
> > > So it's still FB_TYPE_PACKED_PIXELS.
> > > 
> > > > The problem of matching Y=G, CB=B and CR=R for RGB offset is that the
> > > > pixel cannot be represented directly since CB/CR gets shared between Ys.
> > > > 
> > > > So, bitsperpixel would be 16 bit and both B and R offset will be 8.
> > > 
> > > Doesn't sound that bad to me, if you introduce a FB_VISUAL_YCBYCR
> > > visual. Even pixels have a Cb, odd have a Cr component.
> > 
> > We need at least 3 fields to describe YUV.
> > 
> > 1. The component size - fb_bitfield.length
> > 2. The sample period - fb_bitfield.offset
> > 3. The component ordering - fb_bitfield.msb_right
> 
> This completely changes the meaning of the latter 2 fields...
> 

Yes, the intent was to reuse the already present fields to express YUV
formats.

> > So if Y = red, U = green, V = blue
> > 
> > YUV422
> > 
> > red|green|blue.length = 8 /* 8 bits per component */
> > red.offset = 1 /* sampled every pixel */
> > green.offset = blue.offset = 2 /* sampled every 2 pixels */
> > red.msb_right = 1, green.msb_right = 2, blue.msb_right = 3
> > (Y U V order)
> > 
> > UVY411
> > 
> > red|green|blue.length = 8;
> > red.offset = 1;
> > green.offset = blue.offset = 4;
> > red.msb_right = 3, green.msb_right = 2, blue.msb_right = 1;
> 
> And you would use bits_per_pixel = 8, as you no longer have access to the
> fb_bitfield.offsets (in the sense of `offsets within a pixel')?

We can define the bits_per_pixel as the effective pixel size. For 422,
that would be 16. For 411, that would be 12.

> 
> How would you express YUV420?

We can't. We need another set of fields in the vertical axis.

> 
> Alternatively:
>   - YUV422 really is 16 bits per pixel.
>   - YUV411 and YUV420 really are 12 bits per pixel.
> But I don't think this makes things easier, especially not for the 12 bpp
> variants.
> 
> > The FB_VISUAL_* will differentiate if the bitfields are interpreted as
> > RGB or YUV.
> > 
> > That's the only way I can think of describing YUV packed pixel formats
> > without adding new fields, or modifying our user-visible structures.
> > 
> > We will need separate drawing functions for fbcon's use.
> 
> Of course.

Basically, since most YUV formats are fundamentally different from RGB
(where all components are sampled per pixel), our best bet is to revive
the framebuffer overlay support that was proposed several years ago.

Or, if we do not want this in the kernel, we can always tell them to use
the DirectFB library instead.

What do you think? Should we extend the fb system to support YUV
formats?

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
