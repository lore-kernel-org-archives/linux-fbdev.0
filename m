From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Large framebuffers and HIGHMEM systems
Date: Tue, 9 Sep 2003 14:28:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909212824.95374.qmail@web14916.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wq2G-0004bk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 14:28:28 -0700
Received: from web14916.mail.yahoo.com ([216.136.225.229])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19wq2D-0006bK-7u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 14:28:25 -0700
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

Fbdev needs to come up with a general solution for mapping large framebuffers
on systems with over 1GB memory. For example my system does not have 64MB of
free address space below 1GB, this causes my framebuffer drivers to fail when
loading. With RAM prices at $200 for 1GB memory 1GB systems will be common
during the 2.6 timeframe.

There are many possible solutions...
1) add reserve=XXXX to the kernel at boot. Drawback to this is reserving
256-512MB takes this memory out of lowmem kernel use. This will push page
tables into highmem slowing the whole system down.
2) Only map a 2048x2048x32 piece of the framebuffer. This still uses 16MB of
address space which may not always be available. It could be possible to modify
the kernel to always reserve this much address space at boot.
3) Only map what is actually needed on each mode change. Mode change could fail
at run time if not enough free address space.
4) Map the buffer into the highmem address space using the highmem access
macros.
5) Map the fb in a user process and send it signals to draw.

I would also suggest modifying all current fb drivers to print a message about
adding reserve=xxxxx at boot if their ioremap() of the fb fails. This will at
least point people at an immediate work around.

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
