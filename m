From: Jon Smirl <jonsmirl@yahoo.com>
Subject: large framebuffers and mmap
Date: Sun, 21 Sep 2003 20:04:48 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922030448.2986.qmail@web14908.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1H0L-0005sc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 20:04:49 -0700
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1H0K-00083R-QL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 20:04:48 -0700
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

Right now the framebuffer drivers are mapping the framebuffer into the kernel
address space. But shouldn't the fbconsole layer be doing the ioremap()? That
way there would be a single point of remap for all framebuffer drivers.  It
would also let all of the high mem access code be localized into fbconsole if
the fb was mapped high.

This would also get around my problem of using framebuffer drivers but not
using framebuffer console. In my case I don't have enough kernel address space
to do the remap. If fbconsole is doing the map, then the kernel map will never
happen on my system since I don't load fbconsole. 

I looked through a couple of drivers and none of them seem to touch the buffer
after it has been remapped. They only pass the pointer back to fbconsole.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
