From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sat, 13 Nov 2004 14:02:57 +0100
Message-ID: <20041113130257.GA4696@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1100309972.20511.103.camel@gaston> <20041113112234.GA5523@bogon.ms20.nix> <200411132000.31465.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSxba-0001kP-PG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 05:06:14 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CSxbZ-0000l8-6I
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Nov 2004 05:06:14 -0800
Content-Disposition: inline
In-Reply-To: <200411132000.31465.adaplas@hotpop.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sat, Nov 13, 2004 at 08:00:30PM +0800, Antonino A. Daplas wrote:
> On Saturday 13 November 2004 19:22, Guido Guenther wrote:
> > On Sat, Nov 13, 2004 at 12:39:32PM +1100, Benjamin Herrenschmidt wrote:
> > > On Fri, 2004-11-12 at 20:18 +0100, Guido Guenther wrote:
> > In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
> > __raw_{read,write}b is different. So you mean __raw_{read,write}b in the
> > above? (no nitpicking, just want to be sure I understand this
> > correctly).
> 
> Why not use in_be* and out_be* for __raw_read and raw_write?  If I
> understand correctly, they also have barriers.  Or would that hurt
> performance?
I think it would. XFree86 comes along without these barriers nicely (and
this this driver was written with documentation ;), so rivafb should be
o.k. too.
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
