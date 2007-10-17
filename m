From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: YUV Framebuffer
Date: Wed, 17 Oct 2007 21:45:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710172141180.16690@anakin>
References: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
	<Pine.LNX.4.64.0710170852350.29643@anakin>
	<27AAC353AE72C840926448157F375E72012B5A8F@NAEX17.na.qualcomm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiEpL-00030z-Qy for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 12:45:11 -0700
Received: from ananke.telenet-ops.be ([195.130.137.78])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiEpJ-00028Q-FH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 12:45:11 -0700
In-Reply-To: <27AAC353AE72C840926448157F375E72012B5A8F@NAEX17.na.qualcomm.com>
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
To: "Rhee, C. Joon" <jrhee@qualcomm.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 17 Oct 2007, Rhee, C. Joon wrote:
> Interleaved means YCBCR is on the same plane in this order.
> Y CB Y CR Y CB Y CR.... (TV-Out)

So it's still FB_TYPE_PACKED_PIXELS.

> The problem of matching Y=G, CB=B and CR=R for RGB offset is that the
> pixel cannot be represented directly since CB/CR gets shared between Ys.
> 
> So, bitsperpixel would be 16 bit and both B and R offset will be 8.

Doesn't sound that bad to me, if you introduce a FB_VISUAL_YCBYCR
visual. Even pixels have a Cb, odd have a Cr component.

The alternative is to sets bits_per_pixel = 32, but then you get more
illogical component offsets.

Anyone with a better suggestion?

> -----Original Message-----
> From: geert@linux-m68k.org [mailto:geert@linux-m68k.org] 
> Sent: Tuesday, October 16, 2007 11:58 PM
> To: Rhee, C. Joon
> Cc: Linux Frame Buffer Device Development
> Subject: Re: [Linux-fbdev-devel] YUV Framebuffer
> 
> On Tue, 16 Oct 2007, Rhee, C. Joon wrote:
> > Is it possible to create framebuffer color format in YUV (eg. YUV422
> > interleaved) and expose it through /dev/fb?
> > 
> > What would be fb_info type?  
> 
> What do you mean with `interleaved'?
> Even and odd frames are separate (interlace)?
> 
> For YUV422, you have to add a new visual type.
> 
> A long time ago, I used this for a non-public test project:
> 
> #define FB_TYPE_PACKED_PIXELS_LACED     5       /* Interlaced Packed
> Pixels */
> #define FB_TYPE_PACKED_PIXELS_4AREAS    6       /* 4 areas of Packed
> Pixels */
> 
> #define FB_VISUAL_YCBCR422              6       /* YCbCr 4:2:2 */
> #define FB_VISUAL_YCBCR420              7       /* YCbCr 4:2:0 */
> 
> > And how about about fb_var_screeninfo.green/blue/red offset? 
> 
> Just assume red, green, and blue mean Y, U, and V?

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
