From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sat, 13 Nov 2004 20:00:30 +0800
Message-ID: <200411132000.31465.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1100309972.20511.103.camel@gaston> <20041113112234.GA5523@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSwaS-0004lQ-4u
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 04:01:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CSwaQ-0007hc-P8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 04:00:59 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 41ADB718E6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Nov 2004 12:00:45 +0000 (UTC)
In-Reply-To: <20041113112234.GA5523@bogon.ms20.nix>
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
To: Guido Guenther <agx@sigxcpu.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Saturday 13 November 2004 19:22, Guido Guenther wrote:
> On Sat, Nov 13, 2004 at 12:39:32PM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:
> In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
> __raw_{read,write}b is different. So you mean __raw_{read,write}b in the
> above? (no nitpicking, just want to be sure I understand this
> correctly).

Why not use in_be* and out_be* for __raw_read and raw_write?  If I
understand correctly, they also have barriers.  Or would that hurt
performance?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
