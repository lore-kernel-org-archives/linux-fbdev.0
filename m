From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: New radeonfb 0.2.0 (take 2)
Date: Mon, 8 Sep 2003 20:19:08 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909031908.58173.qmail@web14903.mail.yahoo.com>
References: <1063039868.1836.31.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wZ2A-0005tZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 20:19:14 -0700
Received: from web14903.mail.yahoo.com ([216.136.225.55])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19wZ26-0003Li-FA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Sep 2003 20:19:10 -0700
In-Reply-To: <1063039868.1836.31.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, kronos <kronos@kronoz.cjb.net>

Just a thought, but what do you think about splitting radeonfb into two peices?
Sort of like the way this Rage128 driver is split, http://www.saftware.de/.

First piece does PCI IDs, EDID, mode setting, command parsing, maybe hardware
cursor.
Second does fbcon support such as mapping fb to kernel space, fb accels, etc.

My idea is that this model could evolve over time into having a base driver for
each card, and then the FB or DRI drivers would plug into the base. This would
provide a common place to put locking and state saving code.

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
