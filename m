From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Thu, 06 Mar 2003 10:03:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E670EED.2050805@winischhofer.net>
References: <Pine.LNX.4.44.0303060006030.394-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qrKq-0008CX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 01:06:40 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
> Actually it is normal. Changing a console via stty has been around 
> forever. When you ask what size is your VGA console you say 80x25. Now why 
> is that. The main thing is people think of it as a text mode and second
> you really can't change it or boot to to many different size resolutions.
> Does this mean VGA console should be limited? NO!!! I plan to make vgacon 
> some day changable in window size. So the final answer is:
> 
> Portablity. 
> 
> You could use stty or some other program using the tty layer to change the 
> resolution on any type of hardware running any type of console driver. The 
> next best thing is some day we can get ride of con_switch in the upper 
> console layers. We can just use set_font and vc_resize on VT switching 
> since that is all you are doing on vc_switching. 

OK, if this is your final word on this, I - as the maintainer of a 
driver which due to LCD and TV handling only supports a (huge) number of 
built-in modes - am forced to do the following:

If I receive a request for a mode that isn't supported, I go with the 
next larger one that is supported. Even if that leads to differences 
from requested 813x601 to displayed 1024x768.

Hope you and your console code can deal with that then :)

>>BTW: What happens currently if I instruct console to replace the current 
>>font with a bigger one (if that's possible at run-time at all) ?
> 
> 
> It should work.

... and lead to a mode switch? Funny: If I switch from a 8x16 font to a 
bigger one, because I forgot my glasses, the mode is switched to a 
higher one, because the number of cols and rows hasn't changed, leaving 
me with a nearly identical charcter size?

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
