From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: aty128fb problems on iMac, kernel 2.8.1 (fwd)
Date: Thu, 23 Sep 2004 10:27:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAOx4-0005Yz-3c
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 01:27:42 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CAOx3-0003A9-9T
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 01:27:42 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Theodore Kilgore <kilgota@banach.math.auburn.edu>

---------- Forwarded message ----------
Date: Wed, 22 Sep 2004 21:14:55 -0500 (CDT)
From: Theodore Kilgore <kilgota@banach.math.auburn.edu>
To: geert@linux-m68k.org
Subject: aty128fb problems on iMac, kernel 2.8.1 (fwd)

Hello.

I suspect that this problem does not come directly under your
specialization, but the mail to the person whose name is on the aty128fb
code ( below ) was returned as undeliverable. Therefore, after doing
enough Google searches to discover that this seems to be an old problem
but I could never come up with anyone who gave the answer, I am back to
square one. I do not ask you more than to help me get help from the right
person about this, realizing that it is not necessarily you yourself who
would want to get involved with the problem.

Assuming that this message reaches the right party, whoever that is, I
will be glad to send any information which is required, or to answer any
questions that I know how to answer. I also willingly volunteer my iMac
for testing new stuff for that hardware platform. That's why I got it, is
for experimentation of this very sort. Of course, I was expecting to
experiment with things like libgphoto2-gphoto2, on MaOS-X and on Linux on
a powerpd, but this is not a problem for me, if it helps to solve a
problem for some others.

Theodore Kilgore



---------- Forwarded message ----------
Date: Mon, 20 Sep 2004 22:13:36 -0500 (CDT)
From: Theodore Kilgore <kilgota@banach.math.auburn.edu>
To: Brad Douglas <brad@neruo.com>
Subject: aty128fb problems on iMac, kernel 2.8.1

Brad,

Sorry to disturb you, but I cannot seem to find any "live" leads to this
problem on Google -- all searches seem to lead to old, dead links.

I have recently decided to learn something about PowerPC architecture, so
I managed to obtain an old iMac, which has in it the model 750 CPU,
running at 350mhz.

I wanted to put both OS-X and Linux on it, with the idea of doing some
software development on both systems (I do some device support for
libgphoto2 and also some other USB stuff, in addition to my "day" job as a
math professor). I am not in a big hurry and being a Slackware lover, I
decided to try to install Slackintosh.

Well, after overcoming many obstacles I have been successful in much of
what I wanted to do, but now it comes to supporting X. Which was compiled
from source on the machine. But it seems that X needs more than what it
sees in order to run properly. I can only get 8-bit color, with a few
problems about artifacts (incidentally, these problems disappear if one
switches the VT back and forth).

I gather that the problem is, I do not have any proper kernel module to
support the framebuffer features of the video chip. So here now is
the problem I had with this.

Doing the kernel config, I enable framebuffer support, and I choose the
support for the ATI Rage 128, which is the chip in the iMac. It also says
in lspci that the ATI Rage 128 is an AGP 4x setup, running off the
uni-north bridge (I wonder if this has anything to do with a framebuffer
setup? I don't know but I enabled it anyway, as a character device module,
and also enabled the agp support module).

So, when I do make modules it says that it compiled the aty128fb module,
but it gives two error messages:

mac_find_mode  undefined

and

mac_vmode_to_var  undefined.


Unless these problems are resolved, I seriously suspect that the module
will not do its proper job. But when it is not available (I did not do
make modules_install after seeing these errors) then the X will not start
unless I fall back to the vga driver with fbdev support. If other than vga
is attempted, the errors say it cannot open any /dev/fbx where x=1,2,...

But if one does not try to run X, then fbset will give any information
wanted -- about /dev/fb0 -- including the fact that it will only give
8-bit color.

I would appreciate it very much if you could let me know what is the cure
for these error messages. It is probably something obvious, but I am sorry
it is a little bit out of my area of knowledge. And my problems in this
regard are compounded by the fact that for me the iMac is an unfamiliar
hardware platform.


Theodore Kilgore


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
