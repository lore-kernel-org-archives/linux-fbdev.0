From: Antonino Daplas <adaplas@pol.net>
Subject: Re: clipping
Date: 09 Jan 2003 00:26:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042043066.982.118.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301081053400.21171-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WJDh-0000kS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 08:38:21 -0800
In-Reply-To: <Pine.GSO.4.21.0301081053400.21171-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-08 at 17:54, Geert Uytterhoeven wrote:
> On Tue, 7 Jan 2003, James Simmons wrote:
> > > > > BTW, do we really need clipping in fb_ops.fb_{fillrect,copyarea,imageblit}()?
> > > > Personally, I don't think we need clipping.  I tried removing it before
> > > > (circa linux-2.5.30+), but the console segfaults whenever I decrease
> > > > var->yres_virtual.  I haven't tried this again with the newest
> > > > framebuffer framework though.
> > > 
> > > Any definitive answer on this?
> > > 
> > > What happens if you resize the VT to such a large size that columns*fontwidth >
> > > xres_virtual or rows*fontheight > yres_virtual? I guess clipping prevents a
> > > crash there?
> > 
> > Correct. Actually fbcon_resize checks to make sure the user doesn't do 
> > something stupid like this. So we might not needed. Hm.
> 
> And what if you use fbset to reduce the resolution below what's needed to
> accomodate the current console size?
> 
Then we do need clipping :-)  I think that happened to me, I just did
not recognize it.  I accidentally lowered the window size using fbset,
and suddenly I had a console where the tail end of each row of text
wraps to the next row.  I wasn't using cfb_imageblit then so this was
done by hardware.  If I was using cfb_imageblit, this will be clipped.

So, I think we do need clipping, but instead of implementing it in
fb_{fillrect,copyarea,imageblit}, we implement it higher up, in
accel_putcs() and family.  This should also protect drivers using 
hardware-based drawing. 

So perhaps, a function something like this:

void fb_clip(struct fb_fillrect *region, struct fb_fillrect *clip);

This should not be difficult to implement, and I'll code it if everyone
agrees.

The other option (which I don't like) is just to check the passed
fb_var_screeninfo in the put_var ioctl against the current console
window size.  But this is not foolproof as we will not be sure of the
resulting window size _after_ the fb_set_var() call.

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
