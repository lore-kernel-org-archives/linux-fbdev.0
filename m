From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Thu, 18 Nov 2004 06:28:14 +0800
Message-ID: <200411180628.14510.adaplas@hotpop.com>
References: <200411162244.37709.andrew@walrond.org> <200411171107.21823.andrew@walrond.org> <200411180623.28248.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUYIp-0001Sg-NP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 14:29:27 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CUYIo-0004pW-Ux
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 14:29:27 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3C7377584C
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Nov 2004 22:28:11 +0000 (UTC)
In-Reply-To: <200411180623.28248.adaplas@hotpop.com>
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
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>

On Thursday 18 November 2004 06:23, Antonino A. Daplas wrote:
> On Wednesday 17 November 2004 19:07, Andrew Walrond wrote:
> > On Wednesday 17 Nov 2004 00:33, Andrew Walrond wrote:
> > > On Wednesday 17 Nov 2004 00:15, Antonino A. Daplas wrote:

> I was suspecting imageblit, I never suspected fillrect.  Anyway, can you
> try the 2 patches attached.  The first patch reverts io access to the old
> method (direct pointer loading/reading and forced alignment) and the second
> uses __raw_{read|write} but forces alignment. You need to reverse the
> previous patch before applying the other.

Umm, forget about the first patch, just apply the second patch.

Thanks.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
