From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Fri, 12 Sep 2003 23:20:13 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309122317180.5017-100000@phoenix.infradead.org>
References: <20030912193603.GA16977@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xwH6-0007si-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:20:20 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xwH5-0006Yx-EO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:20:19 -0700
In-Reply-To: <20030912193603.GA16977@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> The problem is that mode calculated by fb_get_mode is different from the
> one that comes from get_detailed_timing.

:-( 

> Also, modes  from fb_get_mode  are different from  XFree modes  so every
> time I switch from console to X I have to re-center the screen.
> 
> This happens only when modedb is created from edid, not when using the
> standard modedb.
> 
> Currently create_modedb is unused (the new radeon driver is the first
> user of edid stuff) so we may be hitting a real bug.

Sounds like bugs in the code. The code was never tested before.


BTW where can I find the latest Radeon code. I like to test it myself.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
