From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [BUG] Strange interaction between X and /dev/fb0 + /dev/fb1
Date: Sun, 31 Jul 2005 07:18:09 +0200
Message-ID: <42EC5F11.2070606@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dz6Bq-00005A-WF
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 22:16:47 -0700
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dz6Bq-0004Vj-Il
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 22:16:46 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi everybody,

  1: the system boots with video=3Dvesafb:ypan
  2: cyblafb is loaded by the boot.local script
  3: con2vt /dev/fb1 /dev/tty1
  4: runlevel 3 (no X) is used

As cyblafb detects the video mode used by vesafb, everything works
fine. If I switch to tty1, the accelerated cyblafb driver is used, all ot=
her
ttys use the slow  vesafb code.
I can unload cyblafb after a con2ct /dev/fb0 /dev/tty1, load it again,=20
switch
between ttys, everything without a problem.

Now I switch to runlevel 5.

  1: Switching from X to any tty, no matter if it is managed
     by vesafb or cyblafb,does work without problems.
  2: Switching from any tty to X works without a problem.
  3: Switching from X to any tty except tty1 (managed by cyblafb)
     and then between any ttys works without problems.

  4: Switching from X to tty1 and then to any other tty does _not_
     work. The cursor stops blinking, otherwise nothing changes
     on the monitor. Blindly entered commands produce no visible
     output, but they are executed.

  5: Switching to X and then back to the "dead" tty solves the problem.
     Output of the blindly run command is now visible, but scrolling
     took place only on the last line of the screen. Everything works
     fine as long as I do not repeat step 4 ;-)

2.6.12 and 2.6.13-rc4 behave identical.

As everything works without X, I do believe that there is no bug in the
framebuffer drivers involved. This is not a problem of programming some
hardware registers.

Loading two framebuffer drivers for one chip is a hack that is usefull
for devopement and debuging, it=B4s nothing a real user would do. We coul=
d=20
silently
ignore this problem as there is an easy workaround. But the upper layers
see nothing but two different framebuffer drivers ... and this should be
handled correctly.

cu,
 Knut






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
