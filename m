From: James Simmons <jsimmons@infradead.org>
Subject: Re: Need advice on blitting to dword alignment
Date: Fri, 12 Sep 2003 22:24:31 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309122223200.5017-100000@phoenix.infradead.org>
References: <20030912191341.GA23768@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xvPC-0002FF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 14:24:38 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xvP9-0006BA-JD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 14:24:35 -0700
In-Reply-To: <20030912191341.GA23768@zensonic.dk>
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
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Thanks a million --- you guys truely rocks! The good part is, that
> now my mono/font expansion blit actually works and I can actually feel
> the improvement when scrolling around in emacs ;-) .... but it came at a cost it
> seems:

Cool.

> * My software cursor became messed up/flashing. I suspect that the software cursor
>   does not work with alignment>1, but is that right??

This is fixed in later kernels. A few issues remain tho with the software 
cursor in the latest kernels. 

> * Tux, which was nicely drawn using the software fallback before I changed the pixmap 
>   alignment, became messed up.

I seen the other email.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
