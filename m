From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Fri, 12 Sep 2003 18:52:22 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121851350.5017-100000@phoenix.infradead.org>
References: <20030909145202.47914.qmail@web14909.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xs5r-0002hM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 10:52:27 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xs5q-0001Zj-JC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 10:52:27 -0700
In-Reply-To: <20030909145202.47914.qmail@web14909.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>


> I meant make it into two separate device drivers, not just split the files. 
> Then the user could load base+DRI, base+FB or base+FB+DRI. This would minimize
> the RAM footprint and let the DRI people avoid the problem of mapping the
> framebuffer into kernel space.

Nice. That is what struct xxx_par was for. The idea was that in the future 
a core could be implemented xxx_par that could be shared by both DRI and 
fbdev.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
