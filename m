From: Antonino Daplas <adaplas@pol.net>
Subject: Re: clipping
Date: 11 Jan 2003 13:12:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042261388.932.141.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301101936110.18287-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XE6L-0004V3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 21:22:33 -0800
In-Reply-To: <Pine.LNX.4.44.0301101936110.18287-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 03:39, James Simmons wrote:
> 
> > > I thought about this. Originally I did have this function but removed it.
> > > WHat do you think Geert?
> > 
> > Yes, that's OK.
> > 
> > But I was most concerned about fb_ops.fb_imageblit(), since clipping impacts
> > fb_image.data as well. IIRC, all (most?) current clipping implementations
> > modify fb_image.{dx,dy,width,height} only, without updating fb_image.data.
> 
> Good point. Of course we could ignore pieces of data in that image instead 
> of altering the data. Altering the entire data would be expensive.
> 
> > > > The other option (which I don't like) is just to check the passed
> > > > fb_var_screeninfo in the put_var ioctl against the current console
> > > > window size.  But this is not foolproof as we will not be sure of the
> > > > resulting window size _after_ the fb_set_var() call.
> > > 
> > > Yuck!!! The other way is better.
> > 
> > Well, in between the calls to fb_ops.fb_check_var() and fb_ops.set_par() you
> > can still perform that check. But it's indeed ugly.
> 
> Altering to the framebuffer via /dev/fb that would effect the tty should 
> not remain after the final close of /dev/fb. Instead the console should 
> reset to its previous state before we first opened /dev/fb.
> 

Right :-) I believe this is nearer the correct solution.  Clipping is
typically used to maximize graphics/video bandwidth, but fbcon is using
it to "cover up" possible bugs in the code.

If we can have a correctly working fbcon, without the clipping code, it
will be proof to its robustness.

So, basically, on the first open we save xres, yres, xres_virtual,
yres_virtual and bits_per_pixel, and restore them on the last close, is
this correct?  Any other parameters that will affect the actual and
virtual window size?

Tony





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
