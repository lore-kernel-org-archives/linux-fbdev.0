From: <torn@autistici.org>
Subject: Radeon Mobility M6 LY - Various Issues
Date: Thu, 6 Mar 2003 15:24:36 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1789.151.25.40.55.1046960676.squirrel@squirrel.autistici.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.investici.org ([213.140.29.37] helo=astio.investici.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qwHJ-0006sQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 06:23:22 -0800
Received: from autistici.org (localhost [127.0.0.1])
	by astio.investici.org (Postfix) with SMTP id 79FD633984
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  6 Mar 2003 15:24:36 +0100 (CET)
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
To: linux-fbdev-devel@lists.sourceforge.net

I own a Toshiba notebook (satellite 1900-303) that uses a Radeon Mobility
M6 LY. I encountered many problems using this video card with framebuffer,
I'm explaining them here.-
I'm using linux 2.4.20 and i've tryed the original framebuffer driver and
then this one: http://www.berserk.demon.co.uk/linux/radeonfb/. Both give
me the same problems.-
First [little] problem: the whole screen is "moved up" a couple of
millimeters. So the first line of text is halt cut out and on the bottom
there is some blank space. If I do "fbset -vsync high", the screen returns
on its correct position: perfectly centered in the LCD screen. I'd like to
understand why this happens, and why setting vsync high solved the
problem.The VESA framebuffer has the same problem, but I can't solve it with
vsync=high.-
Second [very annoying] problem: when there is the switch from VGA to
framebuffer and from framebuffer to Xwindows often (not always!) happens
that the screen stasts flickering drawing many horizontal lines. From that
condition if I switch a couple of times from X to console and vice versa
the problem disappears, and come back randomally if I switch again from X
to console some times. I already heard about this problem from a user with
a sony vaio notebook.I think that this problem could be related with pixclock: if I simply
change the pixclock some times (instead of switching from and to X and
console) I encounter the same problem (flickering with horizontal lines
every 4 - 6 pixclock changes, returns almost every next pixclock change).The same issue is present also with the Xfree86 driver, even with a
standard VGA console.I use 1024x768, with 800x600 the problem is less visible but still there.
-
Third [not very important] problem: if I try to user
video=radeon:1024x768-16, fbset tells me that it's using 16bpp, but I
think that actually they're 4 (the penguin logo looks horrible).-
Fourth [last!] problem, maybe OT, maybe not: when using DRI on Xfree86
(and the xfree radeon driver) AND the framebuffer console, if I switch a
couple of times from console to X the graphic interface crashes (I can't
see anything logic but I can still reboot with ctrl+alt+del). Do you have
any idea about this?-
Thank you for your time.
I'd like also to test some pre-release radeon drivers if they exist,
please tell me if I can help.-
Paride




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
