From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: fbdev/console initialisation
Date: Sat, 15 Nov 2003 13:12:10 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1068862329.4001.40.camel@gaston>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKpvS-00035V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Nov 2003 18:12:38 -0800
Received: from griffin-can-au.getin2net.com ([203.43.225.34])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AKpvR-00066d-HX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Nov 2003 18:12:37 -0800
Received: from gaston ([10.100.1.33])
	by griffin-can-au.getin2net.com (8.11.6/8.11.6) with ESMTP id hAF2CTU16827
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 13:12:29 +1100
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Hi !

There's something I don't understand with the way fbdev's and
fbcon are supposed to be initialized.

So the problem started when working on the ppc64 kernel tree on
the G5, radeonfb for some reason why displaying crap. After some
tracing, it appeared that the "fix" structure wasn't initialized
properly.

After more digging, it appeared that a different IBM 64 bits
machine experienced the same problem with 2 video cards in it
(the G5 had only one though...). Tracing on that later machine,
it appeared that the problem came from fbcon_startup() doing:

	info = registered_fb[num_registered_fb-1];	

That is, it picked the _last_ registered fbdev and called
open(), set_par(), etc.... on that (matroxfb in this case). But the
con2fbmap was full of zeros, and thus, fbcon actually used the _first_
registered fbdev (radeonfb here) to draw, thus drawing using an
fbdev on which it didn't do open, set_var, etc... with an uninitialized
"fix" structure (well, partially uninitialized).

Changing the above line to registered_fb[0] fixed it for this. The
G5 was still broken though. The symptom was exactly the same, leading
me to think it was all about a "fix" init. issue though. I didn't have
time to go deep into what was going on. I just noticed that if I added
those 2 lines in the arch code of ppc64 that we had on ppc32 and not
on ppc64, it made things work (there are executed from setup_arch(),
that is very early during the boot process):

#ifdef CONFIG_DUMMY_CONSOLE
	conswitchp = &dummy_con;
#endif

This is quite mysterious to me. It seems the fbcon layer is cery fragile
in the way it decides to initialize vs. use an fbdev. Shoud I go  back
doing what I did in early 2.5 days and just for a set_var of the default
mode from the driver themselves just before registering ?

Also, I'm having reports of similar problems when radeonfb and/or fbcon
are used as modules (that is mismatch or absent call to initial
set_var).

Ben.



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
