From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Tue, 09 Sep 2003 20:13:19 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063131198.642.5.camel@gaston>
References: <1062960554.647.34.camel@gaston>
	 <Pine.LNX.4.44.0309090054470.23354-100000@phoenix.infradead.org>
	 <20030909175404.GA8039@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wn09-0003bU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 11:14:05 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19wn08-0004wL-Md
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 11:14:04 -0700
In-Reply-To: <20030909175404.GA8039@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Ok, but the class_dev stuff isn't a bug fix, it's an API change...
> If you really want it I can start sending patches against your bk tree.

If it's easy enough to fix existing drivers, we can cope with it,
that wouldn't be the first similar breakage we did during 2.6-test
and I beleive it's actually bringing sanity in :-)

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
