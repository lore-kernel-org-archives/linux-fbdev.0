From: Jon Smirl <jonsmirl@yahoo.com>
Subject: ioremap and 1GB RAM
Date: Sat, 6 Sep 2003 19:11:58 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030907021158.66677.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vp1y-0003nr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 06 Sep 2003 19:11:59 -0700
Received: from web14911.mail.yahoo.com ([216.136.225.249])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19vp1y-0000KI-HV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Sep 2003 19:11:58 -0700
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

I'm running 2.6 with 1GB mem and HIGHMEM4G.
My system is booted and then I 'modprobe radeonfb'.
My ioremap of the framebuffer fails.
If I reboot with mem=850M this works.

Am I out of address space for the video memory ioremap?
Is there a kernel param to force more memory to be highmem?



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
