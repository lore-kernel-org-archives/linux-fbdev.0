From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Fri, 19 Nov 2004 10:06:47 +0100
Message-ID: <20041119090647.GC6409@bogon.ms20.nix>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <Pine.LNX.4.58.0411171504220.2222@ppc970.osdl.org> <200411172337.04192.andrew@walrond.org> <200411180812.09635.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV4wd-0006b2-NN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 01:20:43 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CV4wc-0004CW-52
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 01:20:43 -0800
Content-Disposition: inline
In-Reply-To: <200411180812.09635.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Walrond <andrew@walrond.org>, Linus Torvalds <torvalds@osdl.org>

On Thu, Nov 18, 2004 at 08:12:09AM +0800, Antonino A. Daplas wrote:
> On Thursday 18 November 2004 07:37, Andrew Walrond wrote:
> > On Wednesday 17 Nov 2004 23:12, Linus Torvalds wrote:
> > > On Wed, 17 Nov 2004, Andrew Walrond wrote:
> > > > And I can confirm that the problem exists in both 32bit and 64bit
> > > > kernels.
> > >
> > > Ok. None of the code should actually have changed at all, but I notice
> > > one bug:
> > >
> > >
> > > please undo those parts (by hand, I've messed up white-space), since they
> > > make "burst" be one too big. Looks like the reason for doing that in the
> > > first place was an old sparse warning that no longer exists.
> >
> > Ok reverted and tested, but made no difference to corruption.
> > (I only tried 64bit kernel; I assume 32bit would behave similarly)
> >
> 
> It works on x86, and I presume ppc.
Yes, ppc (NV17/NV30) is fine on -rc2.
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
