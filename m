From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 19:09:06 +0800
Message-ID: <200411191909.08742.adaplas@hotpop.com>
References: <20041118164946.GA3763@bogon.ms20.nix> <20041119080951.GA6409@bogon.ms20.nix> <200411190920.44609.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV6fh-00071F-Vj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 03:11:21 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CV6fg-0003Ab-4Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 03:11:21 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DC62373676
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 11:11:00 +0000 (UTC)
In-Reply-To: <200411190920.44609.andrew@walrond.org>
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
Cc: Guido Guenther <agx@sigxcpu.org>, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Friday 19 November 2004 17:20, Andrew Walrond wrote:
> On Friday 19 Nov 2004 08:09, Guido Guenther wrote:
> > Hmmm...shouldn't we delay this past 2.6.10? People with rivafb compiled
> > into the kernel but a - until now undetected - card,  might get bitten
> > otherwise.
> >  -- Guido
>
> Why would 2.6.11 be a better time than 2.6.10 for this change? People tend
> to expect a few problems whenever they upgrade a kernel.

It's too late anyway for 2.6.10, even if I submit patches to Andrew, he won't
merge to mainline until 2.6.10 comes out.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
