From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] kyrofb support
Date: Thu, 15 Jan 2004 00:36:12 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401150035050.335-100000@phoenix.infradead.org>
References: <20040114022816.GA9990@linux-sh.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgvUe-0000UB-IV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 16:36:16 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AgvUd-0003YD-UP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 16:36:16 -0800
In-Reply-To: <20040114022816.GA9990@linux-sh.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


> No particular reason, really. I hadn't been following some of the recent fbdev
> changes, so I wasn't sure if this was necessary or not (I was using tdfxfb as
> a reference when tracking API changes, and noticed that it did the #ifdef
> MODULE stuff which it never did earlier). I'll happily drop the #ifdef MODULE
> bits if this isn't necessary. James?

Yes. You can drop the MODULE ifdef. The latest modedb code can work with 
modules and well as without.

> I'll send you another patch for this as soon as I hear back from James or
> someone else about the modedb / #ifdef MODULE stuff, I don't see any reason
> why it would be required, though.

Drop it and send me another patch.




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
