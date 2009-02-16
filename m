From: Karim 'Kasi Mir' Senoucci <lists@tvetc.de>
Subject: Should intelfb work on Gigabyte GA-GC203D
	(Intel 945G)?
Date: Mon, 16 Feb 2009 10:41:29 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0902161009280.20805@kephalonia.melzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1LZ0MO-0004DJ-OX
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Feb 2009 10:05:56 +0000
Received: from mx1.melzone.de ([81.169.156.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LZ0MM-0004gD-D4
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Feb 2009 10:05:56 +0000
Received: from uucp by mx1.melzone.de with local-rmail (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1LYzzN-0002TZ-W5
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Feb 2009 10:42:10 +0100
Received: by kephalonia.melzone.de with esmtp (Exim 4.69 #1)
	id 1LYzyj-00064q-5h for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Feb 2009 10:41:29 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hello all,
another mainboard, another problem...

I have got this Gigabyte Mini-ITX Mainboard, which has the same specs as 
the Intel D945GCLF (i945G chipset) and looks like a twin brother of it 
(just with different-color heatsinks). However, while the Intel board 
works fine with the intelfb kernel driver, the Gigabyte one either 
freezes completely (as witnessed on a Gentoo linux with a 2.6.27.7 and a 
2.6.28.5 kernel) or at the very least hangs the modprobe command (as 
witnessed with a Knoppix 5.3 boot cd). Has anyone gotten this board to 
work with intelfb, or does anyone know whether it should work at all?

I also tried uvesafb, which kind of works, but does not enable panning 
(no matter which parameters I use, I always get "scrolling: redraw"). As 
the DirectFB application I try to run on this board needs panning, it 
fails on start. Does anyone know why uvesafb doesn't/can't enable 
panning on i956G graphics chips?

Thanks in advance for any new insight into the matter.

Greetings
Kasi Mir


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
