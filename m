From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] kyrofb support
Date: Wed, 14 Jan 2004 15:58:49 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1074056156.765.23.camel@gaston>
References: <20040114013306.GB9515@linux-sh.org>
	 <20040113180926.5fdb0824.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgdDc-000298-8u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 21:05:28 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AgdDb-0002lK-S1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 21:05:28 -0800
In-Reply-To: <20040113180926.5fdb0824.akpm@osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>


> In general, what are the fbdev drivers doing here btw?  It's very strange
> that some core file (fbmem.c) has to "know" about individual card drivers. 
> It should be sufficient for the driver to just register itself with the core
> at the drivers's module_init() time.
> 
> Sigh.  Too late to fix that now I guess.

Pre-historical junk that should be killed for 2.7 (I hope).

There isn't that a bad internal API change, the main of it is the allocation
and freeing of the fbdev, adapting the driver to that should be trivial. I
hope James will feed you with the new stuff asap now. Most of my concerns
about the core stuff are adressed at this point (though I didn't look at
individual drivers). The fbcon resize stuff is still broken in subtle ways,
but that shouldn't prevent merging what we have now.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
