From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH] new version ATI Mach64 for Linux-2.6.0-test5
Date: Sun, 21 Sep 2003 21:47:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200309212057.30272.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1ABv-00077w-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 12:48:19 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1ABt-0006zN-Ou
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 12:48:17 -0700
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: Adam Agnew <agnew@cs.umd.edu>, =?utf-8?q?Dani=C3=ABl=20Mantione?= <daniel@deadlock.et.tudelft.nl>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Souchu <nsouch@free.fr>

Hallo all,

after I read an E-Mail from Daniel about troubles with right DSP_ON_OFF 
values, I found the cause for my problems. Yet I've got beauty image on my 
1400x1050 LCD even with 640x400. I have probed the Daniel's code too, but this 
one had not so good results, strange.

This work is porting from Daniel Mantione driver for Linux 2.4.x, partially 
inspiring from "XL no BIOS" patch and of course "XFree ati driver".

Daniel,

what's size of LCD of testmachines, where you test? I think, that the my 
troubles with your clean code is, that you test on notebook with 800x600 or 
similar. Next smaller resolution is 640x480. It's approximately 80%. And with 
800x600, first double scan is 400x300, 50%. It's all simple values.

By me with 1400x1050, nearest resolution  is 1280x1024, 91%.
First doublescan resolution is 640x480 is 45%.
That's why I can't replace ATIReduceRatio with everything simple.

I hope, that this version will work good on notebooks with smaller DFP too. 
And I hope too, that I become many feedbacks with test results.

Have a nice test time.
Alex

P.S.
Patch is on http://home.arcor.de/alexander.khe/aty_mobility/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
