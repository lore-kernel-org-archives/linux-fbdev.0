From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sat, 13 Nov 2004 23:54:00 +0100
Message-ID: <20041113225400.GA12939@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411132000.31465.adaplas@hotpop.com> <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org> <200411140529.48977.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CT6rL-0000mI-GD
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 14:59:07 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CT6rI-0004v3-1z
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 14:59:07 -0800
Content-Disposition: inline
In-Reply-To: <200411140529.48977.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Linus Torvalds <torvalds@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sun, Nov 14, 2004 at 05:29:46AM +0800, Antonino A. Daplas wrote:
> On Sunday 14 November 2004 02:00, Linus Torvalds wrote:
> > On Sat, 13 Nov 2004, Antonino A. Daplas wrote:
> > > Why not use in_be* and out_be* for __raw_read and raw_write?
> >
> > Please don't start using some stupid magic ppc-specific macros for a
> > driver that has no reason to be PPC-specific. It then only causes bugs
> > that show on one platform and not another.
> 
> I'm not. I'm just wondering that if the other approach was taken (keep the
> hardware in little endian mode), then the write/read* macros, which are just
> wrappers for in_le*/out_le*, would have been used. Would it help fix (or
> cover up) bugs that are in PPC but not x86? 
XFree86 switches the card to big endian mode anyway. Running rivafb in
little endian might cause us great deals of pain for little gain.
Cheers,
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
