From: Jon Smirl <jonsmirl@yahoo.com>
Subject: cfb* routines and high mem
Date: Sun, 21 Sep 2003 22:39:53 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922053954.47449.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1JQQ-0007D2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 22:39:54 -0700
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1JQQ-0000Xf-6C
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 22:39:54 -0700
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

After grepping around for a while it looks like the only user of the cfb*
routines is the console code. There doesn't appear to be a way to get to these
from user space but I may have missed one.

If this is true, then the cfb* code could be moved down into the console
directory and be built into that driver. The frame buffer drivers would just
return NULL for the function pointers if they don't implement an accelerated
routine. Doing this would help isolate high mem access code into fbconsole.

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
