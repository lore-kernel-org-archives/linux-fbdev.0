From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sun, 14 Nov 2004 05:29:46 +0800
Message-ID: <200411140529.48977.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411132000.31465.adaplas@hotpop.com> <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CT5TE-0001mx-6a
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 13:30:08 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CT5TC-0000FT-6S
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 13:30:08 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AA5119E5213
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Nov 2004 21:29:49 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Guido Guenther <agx@sigxcpu.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sunday 14 November 2004 02:00, Linus Torvalds wrote:
> On Sat, 13 Nov 2004, Antonino A. Daplas wrote:
> > Why not use in_be* and out_be* for __raw_read and raw_write?
>
> Please don't start using some stupid magic ppc-specific macros for a
> driver that has no reason to be PPC-specific. It then only causes bugs
> that show on one platform and not another.

I'm not. I'm just wondering that if the other approach was taken (keep the
hardware in little endian mode), then the write/read* macros, which are just
wrappers for in_le*/out_le*, would have been used. Would it help fix (or
cover up) bugs that are in PPC but not x86? 

Tony 





-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
