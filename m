From: Otto Solares <solca@guug.org>
Subject: fbdev timings
Date: Mon, 15 Sep 2003 01:30:29 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915073029.GA13799@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ynoz-00066e-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 00:30:53 -0700
Received: from guug.galileo.edu ([168.234.203.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ynoy-0005Gd-Ut
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 00:30:53 -0700
Received: from solca by guug.galileo.edu with local (Exim 3.36 #1 (Debian))
	id 19ynoc-0005It-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 01:30:30 -0600
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

hi!

finally i am coding the video part of a "desktop engine",
but i want something that works profesionally, i'm using
fbdev and embedded mesa for it, i am trying to get the
video modes as automagically as posible, in that regard
my plan is to hack get-edid (cause we don't have a proper
mechanism from userspace, yea modedb is marked _init
and the new edid just works in radeons and only usable
too from kernelspace -end of critic :) into my software
and fallback to a text database like hwdata to obtain
monitor specs if edid doesn't work, but i have a problem,
how i am supposed to construct fbdev timings with just
this info:

- resolution (width x height, 800x600).
- hsync range (31-49 Khz)
- vsync range (48-80 hz)

i do know that is possible to contruct such timings
because the monitor specs in windows xp are stored
in /windows/inf/monitor.inf and contains only that
variables.  Please any detailed response in how can
they construct their timings with just this variables
and how can i use it with fbdevs from userspace in 2.6?

thanks in advance,

-solca

PS. i know 2 questions is a bad habit :) but here goes
the other: how can i access fbdev features like
acceleration from userspace? or i'm supposed to map
the MMIO registers and do my own voodoo?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
