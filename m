From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Thu, 18 Nov 2004 08:12:09 +0800
Message-ID: <200411180812.09635.adaplas@hotpop.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <Pine.LNX.4.58.0411171504220.2222@ppc970.osdl.org> <200411172337.04192.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUZuQ-0000VQ-R1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 16:12:22 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CUZuP-0000gx-QG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 16:12:22 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1DCAE9FF74A
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Nov 2004 00:12:15 +0000 (UTC)
In-Reply-To: <200411172337.04192.andrew@walrond.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>
Cc: Linus Torvalds <torvalds@osdl.org>

On Thursday 18 November 2004 07:37, Andrew Walrond wrote:
> On Wednesday 17 Nov 2004 23:12, Linus Torvalds wrote:
> > On Wed, 17 Nov 2004, Andrew Walrond wrote:
> > > And I can confirm that the problem exists in both 32bit and 64bit
> > > kernels.
> >
> > Ok. None of the code should actually have changed at all, but I notice
> > one bug:
> >
> >
> > please undo those parts (by hand, I've messed up white-space), since they
> > make "burst" be one too big. Looks like the reason for doing that in the
> > first place was an old sparse warning that no longer exists.
>
> Ok reverted and tested, but made no difference to corruption.
> (I only tried 64bit kernel; I assume 32bit would behave similarly)
>

It works on x86, and I presume ppc.

If in a bind you can always boot with:

video=rivafb:noaccel

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
