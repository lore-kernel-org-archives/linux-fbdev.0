From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 05 Mar 2003 23:25:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046877920.1228.190.camel@localhost.localdomain>
References: <3E65EAFB.7020208@winischhofer.net>
	<1046870342.1291.86.camel@localhost.localdomain> 
	<3E66044D.5030007@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qaky-0005VY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:24:32 -0800
In-Reply-To: <3E66044D.5030007@winischhofer.net>
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

On Wed, 2003-03-05 at 22:06, Thomas Winischhofer wrote:

> >>However, I could not manage to gain a graphical console if sisfb is a
> >>module, but fbcon is in the kernel. Is this combination supposed to
> >>work? If so, how?
> > 
> > No, fbcon will not load unless there's at least one registered fbdev.
> > So, you must compile sisfb statically too.
> 
> Then this should definitely go into the kernel config rules, I guess :)
> 

I think so, except that fbcon will depend on so many drivers that no one
has the patience to add that to Kconfig yet :-)

> >>a) Calculating the desired mode resolution my simply multiplying the
> >>rows/cols by the font size very often results in odd modes like 800x592.
> >>This even when using a standard 8x16 font, not thinking of situations
> >>where for instance 12x22 fonts are used. How is the low level driver
> >>supposed to handle this?
> > 
> > Ideally, the driver should round up to the nearest mode it's capable
> > of.  The "fraction of a character dimensions" will be automatically
> > cleared by the "clear_margins" hook.
> 
> OK, that's exactly what I do now. I currently tend to the assumption 
> that this mode should be larger than the requested one...?

Yes. If it's smaller, it unconditionally calls fb_set_var(), I think.

> 
> >>To temporarily overcome this, I implemented a somewhat fuzzy mode
> >>identification routine, searching for modes with resolutions within a
> >>range of [desired res] - [desired res + 16]. But I can't imagine this
> >>being the Real Thing.
> > 
> > Yes, that's the Real Thing :-)  fbcon_resize has a "fuzzy mode" too --
> > it won't do an fb_set_var() if the change in dimensions is only a
> > fraction of a character's dimension.
> 
> Ack. Is 16 fuzzy enough, what do you think?

I think you should only accept modes where the difference is a fraction
of a character width or height.  A difference more than that and
clear_margins() will not work correctly.  

> 
> > Right, using stty to change the window size assumes that the fbdev
> > driver has an algorithm to calculate modelines based on xres and yres
> > independently.  This is probably a bit of work for most driver authors.
> 
> Well, not as much work as more a lack of definition. If the user 
> specified a default of 800x600-75 I can't simply assume he also wants 
> 1024x768-75.
> 
> > There's new code in fbmon.c (fb_find_mode and fb_validate_mode) that
> > should ease code writing if you have a VESA GTF compliant monitor.  You
> > can use that if you want as long as the display's operating limits are
> > known (info->monspecs).
> 
> Well, this assumes that the user always want the best refresh rate, 
> which is not desired in all cases.
> 

fb_get_mode() accepts 4 flags.  Maximum refresh rate, hscan-driven,
vrefresh-driven and dotclock-driven calculations.  It's flexible enough,
but of course not as flexible as specifying your own modeline.
  
> > Another solution is to reimplement resizing by fbset.  The code is not
> > very difficult and can be added if most people want it.
> 
> Awaiting public demand :)
> 

> > Yes, this is a limitation of stty.  It calls con_resize twice (one for
> > row and another for cols, depending on the order of the options) so it
> > will not work if the driver only supports a fixed set of modes.  Another
> > reason to bring back fbset resizing.
> 
> Think so, too. That's a really stupid behavior otherwise, since it 
> involves two mode changes, with one really undesired mode on the way.
> 
> > Scrolling mode is now determined by fbcon.  If var->accel_flag is
> > nonzero, scrolling is ypan, otherwise, it's yredraw.  It's because ypan
> > requres a lot of block copy which is slow when done by software.
> > 
> > I still believe though that scrolling should be determined by the
> > driver, not fbcon.
> 
> Well, what should I do now?
> 
> The rivafb only forces y panning (ie sets yres_virtual to maximum) if 
> yres_virtual is -1. This is never the case, as default var is constantly 
> reused and I nowhere saw that any of the res_virtuals was set to -1.
> 

For now, maximize yres_virtual, then set info->var.accel_flag to 1.  It
wouldn't work until fbset support is reimplemented again, unless you
boot directly to that configuration.

I'll wait a few more days in hope of hearing from more people before
submitting a patch.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
