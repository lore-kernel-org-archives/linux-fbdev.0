From: Jon Smirl <jonsmirl@yahoo.com>
Subject: new radeon code and acquire/release_console_sem()
Date: Sat, 13 Sep 2003 17:23:59 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030914002359.33381.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yKgK-0002YI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 17:24:00 -0700
Received: from web14910.mail.yahoo.com ([216.136.225.62])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yKgJ-00024T-K4
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Sep 2003 17:23:59 -0700
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos <kronos@kronoz.cjb.net>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

I don't run fb console on my system so I don't have acquire_console_sem() and
release_console_sem(). Shouldn't these have an #ifdef CONFIG_FRAMEBUFFER_CONSOLE?

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
