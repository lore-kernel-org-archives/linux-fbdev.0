From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 12:58:07 +0100
Message-ID: <20041119115807.GF6409@bogon.ms20.nix>
References: <20041118164946.GA3763@bogon.ms20.nix> <200411190719.24961.adaplas@hotpop.com> <20041119080951.GA6409@bogon.ms20.nix> <200411191909.13371.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV7d0-0003we-4K
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 04:12:38 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CV7cw-0004IE-LR
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 04:12:37 -0800
Content-Disposition: inline
In-Reply-To: <200411191909.13371.adaplas@hotpop.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Fri, Nov 19, 2004 at 07:09:13PM +0800, Antonino A. Daplas wrote:
> Anyway, I'm planning to write another driver for nvidia, based on xorg
> sources, as nvidiafb.  The rivafb uses programmed io, whereas the newer
Great, I thought about this already too. Would be nice to have...

> chipsets uses DMA, and without docs, that's the only way we can support
> newer chipsets (use X sources).
> 
> So, eventually, rivafb will support only nv20 chipsets and older, whilst
> nvidiafb nv10 and newer.
Well we should at least support the NV30 cards that are known to work,
ppc users want this badly since rivafb has backlight control while offb
hasn't.
Cheers,
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
