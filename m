From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Thu, 06 Mar 2003 09:49:06 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E670B82.30900@winischhofer.net>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org> <1046913411.1206.185.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qr6k-0003rw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 00:52:06 -0800
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
> fbcon_resize() is not that broken, it's only trying to do what it's
> supposed to do.  It is indeed limited because it is trying to outguess
> the low-level drivers on the best resolution for a window size.
> 
> However, the brokenness is really on the driver side.  They are unable
> to change the video mode unless they are supplied with the correct
> timing parameters where in fact they actually have the best knowledge on
> how to calculate them.  

Yes, BUT ONLY IF the driver has enough parameters to calculate it. This 
requires at least x and y dimension AND A CLOCK (or a vertical refresh 
rate, which I would prefer).

The driver is supposed to handle the "var"s it's fed. If that var is 
like the ones that result from the current fbcon_resize, namely with a 
new x and y res, but no valid clock, how on earth should the driver do 
this then? It receives a var which looks correct, and in fact, *could* 
be correct sometimes:

Suppose we have another application, say DirectFB, feeding the low level 
drivers with complete and correct "var"s.

In both cases we have valid x any y resultions, and a non-zero clock field.

Should we then let the driver read the x and y resolution and forget 
about the rest of that var? I hardly think that's what the public var is 
for. It could be reduced to a struct { USHORT xres, USHORT yres } then.

> So the question:  Do we let fbcon spoonfeed the timings to fbdev, or do
> we let the drivers calculate it for themselves?  I go for the latter, as
> fbcon really should not have any business with hardware.

What about the following solution: What if fbcon_resize sets the clock 
in the var to 0? We could use this to force low level drivers to decide 
on the clock for themselves. Otherwise, ie if the clock field is 
non-zero, they are supposed to take it as the desired clock.

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
