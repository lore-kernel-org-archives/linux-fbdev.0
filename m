From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 00:18:48 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303060006030.394-100000@phoenix.infradead.org>
References: <3E66785D.1070202@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qj6a-0003Rw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 16:19:24 -0800
In-Reply-To: <3E66785D.1070202@winischhofer.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Excuse me that I dare to comment on this as a total fbdev-rookie:

No problem. Its rare I take things personally. So I don't mind people 
critizing my work. You have to have a thick skin for this line of work.
 
> Please think about usability, too. Forcing people to fiddle with rows 
> and cols, requiring knowledge about font sizes and stuff is at least 
> inappropriate. Folks are used to think in resolutions, that's what they 
> understand, and that's what is most obvious. I can't imagine anyone 
> caring about the amount of rows or columns on a text screen.

Actually it is normal. Changing a console via stty has been around 
forever. When you ask what size is your VGA console you say 80x25. Now why 
is that. The main thing is people think of it as a text mode and second
you really can't change it or boot to to many different size resolutions.
Does this mean VGA console should be limited? NO!!! I plan to make vgacon 
some day changable in window size. So the final answer is:

Portablity. 

You could use stty or some other program using the tty layer to change the 
resolution on any type of hardware running any type of console driver. The 
next best thing is some day we can get ride of con_switch in the upper 
console layers. We can just use set_font and vc_resize on VT switching 
since that is all you are doing on vc_switching. 

P.S
   If you look at struct winsize you have a ws_xpixel and a ws_ypixel 
field. The question is now do we place the exact size of the screen in 
pixels or vc->font.width[height]*width[height]. So it is stty program 
that is limiting and not the tty layer. In theory you could write fbset to 
use the proper tty ioctl to do this.
 
> BTW: What happens currently if I instruct console to replace the current 
> font with a bigger one (if that's possible at run-time at all) ?

It should work.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
