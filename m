From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 16:37:09 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6619A5.7020502@winischhofer.net>
References: <3E65EAFB.7020208@winischhofer.net>	<1046870342.1291.86.camel@localhost.localdomain> 	<3E66044D.5030007@winischhofer.net> <1046877920.1228.190.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qazx-00020i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:40:01 -0800
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
>>Ack. Is 16 fuzzy enough, what do you think?
> 
> 
> I think you should only accept modes where the difference is a fraction
> of a character width or height.  A difference more than that and
> clear_margins() will not work correctly.  

How do I - from a low level fb driver - determine the character size?

>>>I still believe though that scrolling should be determined by the
>>>driver, not fbcon.
>>
>>Well, what should I do now?
>>
>>The rivafb only forces y panning (ie sets yres_virtual to maximum) if 
>>yres_virtual is -1. This is never the case, as default var is constantly 
>>reused and I nowhere saw that any of the res_virtuals was set to -1.
>>
> 
> 
> For now, maximize yres_virtual, then set info->var.accel_flag to 1.

That's what I do.

(shifted boot screen)
 >>I am almost sure that this has to do with the fact that I adapt var in
 >>my check_var from 800x592 to 800x600. Console (or whoever) seems to
 >>attempt to change the mode to its initially desired dimension on many
 >>occasions.
 >
 > Strange.  If you boot at 800x600, the console will compute that as
 > 100x37.  On fbcon_resize, it will request 800x592 but because the
 > difference is only 8, fb_set_var should be skipped, so no mode change
 > should happen throughout.

But it definitely does. I can see this on my LCD (which goes dark during 
mode changes) and, of course, the log.

 > I have no idea.  I booted with other drivers at 800x600 and get no ill
 > effects.  I get a margin at the bottom of 8 pixels.
 >
 > How about checking what the offsets are during fb_pan_display()?

Done that. Nothing special; The penguin is where it should be, but the 
text below starts 8 lines too low.

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
