From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Tue, 9 Sep 2003 07:52:02 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909145202.47914.qmail@web14909.mail.yahoo.com>
References: <1063094309.675.11.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wjqd-0002X3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 07:52:03 -0700
Received: from web14909.mail.yahoo.com ([216.136.225.61])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19wjqd-0001eg-FK
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 07:52:03 -0700
In-Reply-To: <1063094309.675.11.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>

I meant make it into two separate device drivers, not just split the files. 
Then the user could load base+DRI, base+FB or base+FB+DRI. This would minimize
the RAM footprint and let the DRI people avoid the problem of mapping the
framebuffer into kernel space.


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
