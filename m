From: Chris Jones <cjns1989@gmail.com>
Subject: Turn off LCD back light.
Date: Mon, 31 Aug 2009 15:23:09 -0400
Message-ID: <20090831192309.GA6937@turki.gavron.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cjns1989@gmail.com>) id 1MiCTH-0000p2-Q7
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Aug 2009 19:23:19 +0000
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MiCTD-0004tx-S1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Aug 2009 19:23:19 +0000
Received: from turki.gavron.org
	(ool-45704694.dyn.optonline.net [69.112.70.148]) by
	mta4.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0KP900BWN9ULOW10@mta4.srv.hcvlny.cv.net> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Aug 2009 15:23:10 -0400 (EDT)
Received: from gavron by turki.gavron.org with local (Exim 4.69)
	(envelope-from <cjns1989@gmail.com>)
	id 1MiCT7-0005fw-9Q	for linux-fbdev-devel@lists.sourceforge.net; Mon,
	31 Aug 2009 15:23:09 -0400
Content-disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hopefully, this is the correct place to ask such questions - I tried the
fbdev-users mailing list a couple of days ago, but is looks like it's
not currently very active.

I would like my laptop's  LCD panel to switch itself off automatically
after a few minutes of inactivity.

The /etc/kbd/config file specifies:

BLANK_DPMS=on
POWERDOWN_TIME=2

The /etc/init.d/console-screen.kbd.sh script appears to issue a setterm
command with the above options a boot time, yet nothing happens.

I issued the corresponding "setterm" command manually also to no effect.

Is there something that I need to configure in the linux kernel?

Is this a limitation of the frambuffer console with the atyfb driver?

Manually executing "vbetool dpms off" does the trick, so it doesn't look
like this is a hardware limitation per se.

The video card is an ATI Technologies Rage Mobility P/M AGP 2x (rev 64).

Relevant (?) software:

linux-image      :       2.6.26-1-686
acpid            :       1.0.8-1
util-linux       :       2.13.1.1-1
kbd              :       1.14.1-4

Thanks,

CJ.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
