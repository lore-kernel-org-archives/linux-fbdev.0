From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb.h header fix.
Date: Wed, 4 Feb 2004 18:58:31 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402041857210.20659-100000@phoenix.infradead.org>
References: <1075867994.1747.1.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoSER-0001Fv-Am
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 10:58:39 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AoSEQ-0000TQ-LX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 10:58:38 -0800
In-Reply-To: <1075867994.1747.1.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@transmeta.com, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > The XFree86 fbdev server build breaks with the current fb.h. This patch 
> > >  fixes that.
> > 
> > The previous version of this patch caused the ppc64 build to fail.  Did
> > that get addressed?
> 
> Not yet, it's a ppc64 bug, I haven't had time to fix it, for some
> reason, ppc64 doesn't have readq/writeq nor __raw_ IO accessors.

This means more than the fbdev layer will break on the ppc64.
Ben you you post a patch for the ppc64 so the fbdev patch can go in?




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
