From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fb.h header fix.
Date: Thu, 05 Feb 2004 10:31:53 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075937512.4029.47.camel@gaston>
References: <Pine.LNX.4.44.0402041857210.20659-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoWVd-00010V-Qz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 15:32:41 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AoWVd-0002zp-Cb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 15:32:41 -0800
In-Reply-To: <Pine.LNX.4.44.0402041857210.20659-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@transmeta.com, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Not yet, it's a ppc64 bug, I haven't had time to fix it, for some
> > reason, ppc64 doesn't have readq/writeq nor __raw_ IO accessors.
> 
> This means more than the fbdev layer will break on the ppc64.
> Ben you you post a patch for the ppc64 so the fbdev patch can go in?

Yes, but I think Andrew should still merge your patch at this point,
I'll send the ppc64 fix today hopefully along with other ppc64 io.h
fixes.

Then we need the rest of the core & driver bits in. I'd really like
2.6.3 to be "complete" for PowerMacs (both ppc32 and ppc64) which
means including the fbdev updates. I think the fbdev core changes are
now good enough to get in. I'm fairly sure there are still fbcon bugs
but I'm also sure those are already upstream so they aren't worth
postponing the merge.
 
Ben.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
