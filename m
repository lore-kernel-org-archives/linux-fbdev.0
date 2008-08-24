From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Initialize framebuffer in bootloader?
Date: Sun, 24 Aug 2008 20:40:15 +0400
Message-ID: <200808242040.15869@blacky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KXIdm-0000Up-7o for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 09:40:34 -0700
Received: from gate.lvk.cs.msu.su ([158.250.17.1] helo=lvk.cs.msu.su)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KXIdh-0005ts-El
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 09:40:33 -0700
Received: from Debian-exim by zigzag.lvk.cs.msu.su with spam-scanned (Exim
	4.63) (envelope-from <yoush@cs.msu.su>) id 1KXIdV-0008Go-CI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 20:40:20 +0400
Received: from ppp85-140-110-128.pppoe.mtu-net.ru ([85.140.110.128]
	helo=blacky)
	by zigzag.lvk.cs.msu.su with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63) (envelope-from <yoush@cs.msu.su>) id 1KXIdV-0008Gk-89
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 20:40:17 +0400
Received: from nikita by blacky with local (Exim 4.63)
	(envelope-from <yoush@cs.msu.su>) id 1KXIdT-000827-Vd
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 20:40:16 +0400
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

Hello

In an embedded system I'm involved in, there is a requirement to get some 
graphical information displayed very fast (about a second) after poweron, 
and then keep the picture on screen without blinking etc.

Since it is virtually impossible to boot the kernel and start the 
application that fast, we are thinking about initializing display hardware 
and drawing the picture in bootloader.

There is no major problems in adding required code to U-Boot. What looks 
more difficult s how to smoothly pass display hardware control to linux 
framebuffer driver, such that "nobody will notice". Since main memory is 
used for some hardware-accessed data structures and the frame buffer 
itself, such a trick will likely require some altering of linux memory 
management, etc

Before trying to implement all that, I'd like to ask if anyone has done 
something similar, or maybe could provide some comments or pointers to any 
related information.

Thanks.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
