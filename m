From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Thu, 06 Mar 2003 10:43:36 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E671848.5020506@winischhofer.net>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>	<1046913411.1206.185.camel@localhost.localdomain> 	<3E670B82.30900@winischhofer.net> <1046942633.1330.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrxT-0001Gk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:46:35 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
> On Thu, 2003-03-06 at 16:49, Thomas Winischhofer wrote:
>>>However, the brokenness is really on the driver side.  They are unable
>>>to change the video mode unless they are supplied with the correct
>>>timing parameters where in fact they actually have the best knowledge on
>>>how to calculate them.  
>>
>>Yes, BUT ONLY IF the driver has enough parameters to calculate it. This 
>>requires at least x and y dimension AND A CLOCK (or a vertical refresh 
>>rate, which I would prefer).
> 
> The VESA GTF can calculate timings using only xres, yres and any of the
> three...
> 
> 1. desired pixelclock
> 2. desired refresh
> 3. desired hsync
> 
> ... all of which can be chosen by the driver, or extracted from the monitor
> (ie. DDC or uploaded by the user).

See? Need a clock! My word! :)

> Mode checking is not simply looking at xres and yres, but also looking
> at htotal, and vtotal to derive hsync, vsync and pixelclock.  These are
> then compared to the monitor/graphics card's capability.  If any of the
> values fall outside the limits then the mode is not valid.  Otherwise,
> the new mode should still produce a usable display, perhaps not the one
> the user wants (ie refresh rate is lower).  By this time though, the
> user can freely use fbset to fine tune all the timings.

Perhaps I have not made myself clear:

I start with a default 800x600-60. Pixelclock in var is now X.

fbcon_resize adapts the xres and yres, leaving the pixelclock alone.

The driver sees upon the check_var call: xres, yres and X - the old 
pixelclock (which is non-zero).

That pixelclock *COULD* be valid, but it COULD also be invalid! There is 
no way of distinguishing!

>>What about the following solution: What if fbcon_resize sets the clock 
>>in the var to 0? We could use this to force low level drivers to decide 
>>on the clock for themselves. Otherwise, ie if the clock field is 
>>non-zero, they are supposed to take it as the desired clock.
> 
> Yes, that's another solution.  Just invalidate the timings and force the
> driver to compute a modeline each time.

I think Geert came up with a better solution in the meantime.

But a general rule should be anyway: Whenever passing a var to the 
driver which only changed in a few fields and through this invalidated 
the timing settings, the caller should set everthing else to ZERO, in 
other words: invalidate it in a recognizable way. That's IMHO the only 
way the driver can distinguish between intended and unintended settings.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
