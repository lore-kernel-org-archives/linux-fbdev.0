From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sun, 14 Nov 2004 10:49:32 +1100
Message-ID: <1100389772.20592.131.camel@gaston>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <200411090402.22696.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
	 <200411090608.02759.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
	 <20041112125125.GA3613@bogon.ms20.nix>
	 <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
	 <20041112191852.GA4536@bogon.ms20.nix> <1100309972.20511.103.camel@gaston>
	 <20041113112234.GA5523@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CT7ex-0005B4-7R
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 15:50:23 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CT7eu-0006bh-Hk
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 15:50:23 -0800
In-Reply-To: <20041113112234.GA5523@bogon.ms20.nix>
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
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sat, 2004-11-13 at 12:22 +0100, Guido Guenther wrote:

> > {in,out}_8 are ppc-specific things that are identical to readb/writeb
> > indeed, with barriers.

> In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
> __raw_{read,write}b is different. So you mean __raw_{read,write}b in the
> above? (no nitpicking, just want to be sure I understand this
> correctly).

I just meant they are identical and they have both barriers, sorry.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
