From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 05 Mar 2003 21:26:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046870342.1291.86.camel@localhost.localdomain>
References: <3E65EAFB.7020208@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qYte-0006m4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 05:25:22 -0800
In-Reply-To: <3E65EAFB.7020208@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 20:18, Thomas Winischhofer wrote:
> I am currently porting the SiS framebuffer driver to the - more or less
> - new API. Better late than never :)
> 
> Anyway, during this, I noticed some issues: (I am using stock 2.5.63 for
> development, no fbdev patches)
> 
> 1) Sisfb currently does not work if compiled statically into the kernel.
> (It works as a module if fbcon is a module, too). If sisfb and fbcon are
> the kernel, the mode switch occures but the only thing I see is a white
> rectangle at the left egde of the screen, vertically centered, with some
> flashing grey dots. I almost looks like text mode output while in
> graphics mode, or - better - if fbcon assumes a font size of 1 pixel.
> Finally, it seems to oops, but I can't say that for sure because I don't
> see anything (and I unfortunately don't have a serial console available).
> 
> Can anybody confirm that this (ie both low level driver and fbcon in
> kernel) is supposed to work in 2.5.63 (making it a bug in my sisfb
> implementation)? Did I perhaps miss anything, like a kernel parameter to
> activate fbcon or similar?

Yes, it it does work.

> 
> 2) If both sisfb and fbcon are modules, everything works s supposed when
> first modprobing sisfb and then fbcon. Upon modprobing fbcon, the mode
> switch occures and I see a graphical console (with a white rectangle of
> the size of the previous console size which vanishes upon pressing enter).

Ideally, fbdev should only change the video mode on the first fb_open()
or fb_set_par() and restore the state on the last fb_close().  This is
so you can load fbdev without having a framebuffer console.  If memory
serves me correctly, that's how sisfb in 2.4 works?.

> 
> However, I could not manage to gain a graphical console if sisfb is a
> module, but fbcon is in the kernel. Is this combination supposed to
> work? If so, how?

No, fbcon will not load unless there's at least one registered fbdev.
So, you must compile sisfb statically too.

> 
> 3) The resizing using stty is - how do I put this - slightly imperfect.
> I don't know how you fbdev folks do it, but I am not used to think in
> row/col categories, but *resolutions* instead. Apart from this - IMHO a
> bit annoying - inconvenience, this method has further issues:
> 
> a) Calculating the desired mode resolution my simply multiplying the
> rows/cols by the font size very often results in odd modes like 800x592.
> This even when using a standard 8x16 font, not thinking of situations
> where for instance 12x22 fonts are used. How is the low level driver
> supposed to handle this?

Ideally, the driver should round up to the nearest mode it's capable
of.  The "fraction of a character dimensions" will be automatically
cleared by the "clear_margins" hook.

> 
> To temporarily overcome this, I implemented a somewhat fuzzy mode
> identification routine, searching for modes with resolutions within a
> range of [desired res] - [desired res + 16]. But I can't imagine this
> being the Real Thing.

Yes, that's the Real Thing :-)  fbcon_resize has a "fuzzy mode" too --
it won't do an fb_set_var() if the change in dimensions is only a
fraction of a character's dimension.

> 
> b) The call to fb_set_var() inside fbcon_resize() is checked for errors,
> but not the call to fbcon_resize() from within fbcon_switch(). This
> leads to catastrophic drawing errors if the requested mode is not
> supported by the low level driver.

Yes, it's a bug.  I think I submitted a patch to fix that, but I'm not
sure if James applied it to his tree.

> 
> c) fbcon_resize() only changes var.xres and var.yres, leaving everything
> else - var.pixclock, for instance - alone. fb_set_var() just calles the
> driver's check_var() routine and then set_par(). How is the low level
> driver supposed to behave in this situation, especially considering the
> unchanged pixclock?
> 

Right, using stty to change the window size assumes that the fbdev
driver has an algorithm to calculate modelines based on xres and yres
independently.  This is probably a bit of work for most driver authors. 
There's new code in fbmon.c (fb_find_mode and fb_validate_mode) that
should ease code writing if you have a VESA GTF compliant monitor.  You
can use that if you want as long as the display's operating limits are
known (info->monspecs).

Another solution is to reimplement resizing by fbset.  The code is not
very difficult and can be added if most people want it.

> d) Starting with a mode of 1024x768 and resizing to 800x600 using stty
> works after all (see a)), but only if I execute stty twice. The desired
> mode the low level driver receives at the first attempt is 800x768.
> Could this be related to an outdated or buggy stty, calling the console
> code twice if rows and cols are specified at the same time...?

Yes, this is a limitation of stty.  It calls con_resize twice (one for
row and another for cols, depending on the order of the options) so it
will not work if the driver only supports a fixed set of modes.  Another
reason to bring back fbset resizing.

> 
> 3) About y panning: In the 2.4 version of sisfb, I simply forced the
> console to do y panning (unless positively disabled by the user) by
> "patching" yres_virtual to the maximum, depending on the available video
> memory. I am allowed to do that with the 2.5 API? (The rivafb code makes
> be believe so...)

Scrolling mode is now determined by fbcon.  If var->accel_flag is
nonzero, scrolling is ypan, otherwise, it's yredraw.  It's because ypan
requres a lot of block copy which is slow when done by software.

I still believe though that scrolling should be determined by the
driver, not fbcon.

Tony 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
