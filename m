From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 17:26:18 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046942633.1330.54.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>
	<1046913411.1206.185.camel@localhost.localdomain> 
	<3E670B82.30900@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrcW-0006NO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:24:56 -0800
In-Reply-To: <3E670B82.30900@winischhofer.net>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 16:49, Thomas Winischhofer wrote:
> Antonino Daplas wrote:
> > fbcon_resize() is not that broken, it's only trying to do what it's
> > supposed to do.  It is indeed limited because it is trying to outguess
> > the low-level drivers on the best resolution for a window size.
> > 
> > However, the brokenness is really on the driver side.  They are unable
> > to change the video mode unless they are supplied with the correct
> > timing parameters where in fact they actually have the best knowledge on
> > how to calculate them.  
> 
> Yes, BUT ONLY IF the driver has enough parameters to calculate it. This 
> requires at least x and y dimension AND A CLOCK (or a vertical refresh 
> rate, which I would prefer).

The VESA GTF can calculate timings using only xres, yres and any of the
three...

1. desired pixelclock
2. desired refresh
3. desired hsync

... all of which can be chosen by the driver, or extracted from the monitor
(ie. DDC or uploaded by the user).

For non-GTF compatible monitors, you can choose any of the standard timings
table. 

> 
> The driver is supposed to handle the "var"s it's fed. If that var is 
> like the ones that result from the current fbcon_resize, namely with a 
> new x and y res, but no valid clock, how on earth should the driver do 
> this then? It receives a var which looks correct, and in fact, *could* 
> be correct sometimes:
> 

Mode checking is not simply looking at xres and yres, but also looking
at htotal, and vtotal to derive hsync, vsync and pixelclock.  These are
then compared to the monitor/graphics card's capability.  If any of the
values fall outside the limits then the mode is not valid.  Otherwise,
the new mode should still produce a usable display, perhaps not the one
the user wants (ie refresh rate is lower).  By this time though, the
user can freely use fbset to fine tune all the timings.

For fixed-frequency monitors or analog TV (where timings are critical),
you can use very strict operating limits (like vsync_min = 60 and
vsync_max = 60).  With strict limits, it's unlikely that the new timings
will be valid, so the driver will always be forced to calculate a new
mode.

> Suppose we have another application, say DirectFB, feeding the low level 
> drivers with complete and correct "var"s.
> 
> In both cases we have valid x any y resultions, and a non-zero clock field.
> 
> Should we then let the driver read the x and y resolution and forget 
> about the rest of that var? I hardly think that's what the public var is 
> for. It could be reduced to a struct { USHORT xres, USHORT yres } then.
> 
> > So the question:  Do we let fbcon spoonfeed the timings to fbdev, or do
> > we let the drivers calculate it for themselves?  I go for the latter, as
> > fbcon really should not have any business with hardware.
> 
> What about the following solution: What if fbcon_resize sets the clock 
> in the var to 0? We could use this to force low level drivers to decide 
> on the clock for themselves. Otherwise, ie if the clock field is 
> non-zero, they are supposed to take it as the desired clock.
> 

Yes, that's another solution.  Just invalidate the timings and force the
driver to compute a modeline each time.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
