From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Wed, 17 Nov 2004 23:37:04 +0000
Message-ID: <200411172337.04192.andrew@walrond.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411172233.28606.andrew@walrond.org> <Pine.LNX.4.58.0411171504220.2222@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUZMZ-0006YA-KP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 15:37:23 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUZMQ-0000RB-Ly
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 15:37:23 -0800
In-Reply-To: <Pine.LNX.4.58.0411171504220.2222@ppc970.osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linus Torvalds <torvalds@osdl.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Wednesday 17 Nov 2004 23:12, Linus Torvalds wrote:
> On Wed, 17 Nov 2004, Andrew Walrond wrote:
> > And I can confirm that the problem exists in both 32bit and 64bit
> > kernels.
>
> Ok. None of the code should actually have changed at all, but I notice one
> bug:
>
>
> please undo those parts (by hand, I've messed up white-space), since they
> make "burst" be one too big. Looks like the reason for doing that in the
> first place was an old sparse warning that no longer exists.
>
Ok reverted and tested, but made no difference to corruption.
(I only tried 64bit kernel; I assume 32bit would behave similarly)

Andrew


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
