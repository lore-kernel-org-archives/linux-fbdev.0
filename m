From: Sergey Lapin <slapin@ossfans.org>
Subject: fbcon and framebuffer app
Date: Mon, 7 Sep 2009 18:01:05 +0400
Message-ID: <20090907140105.GB5083@build.ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <slapin@build.ossfans.org>) id 1MkfZR-0007SQ-Pq
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Sep 2009 14:51:53 +0000
Received: from build.ossfans.org ([67.223.233.67])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MkfZP-0000G1-7m
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Sep 2009 14:51:53 +0000
Received: from build.ossfans.org ([127.0.0.1])
	by build.ossfans.org (8.14.3/8.14.3/Debian-5) with ESMTP id
	n87EpgsL005397 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 7 Sep 2009 18:51:42 +0400
Received: (from slapin@localhost)
	by build.ossfans.org (8.14.3/8.14.3/Submit) id n87Epg29005396
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 7 Sep 2009 18:51:42 +0400
Resent-Message-ID: <20090907145142.GA5235@build.ossfans.org>
Resent-To: linux-fbdev-devel@lists.sourceforge.net
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Dmitry <dbaryshkov@gmail.com>

Hi, all!

I have special framebuffer device (128x128x2bpp display via external
framebuffer interface on OMAP3), which works quite well, switching off
backlight with fbcon on, and blanking. A problem is that I need
to run graphics application on a framebuffer. But I also need blanking
on inactivity. Application works perfectly until blanking occurs,
then display is zeroed-out and application still redraws regions it
changes. This is ok while not really clean, but also, when activity
is recieved, backlight is on, but screen is not redrawn, since
application is not aware of blanking, so I have to force it to readraw
all screen.
So, how this should be fixed? I want to keep fbcon
auto-blanking functionality and tty, so removing fbcon is not an option.

Thanks beforehand,
S.


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
