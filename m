From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 19:09:13 +0800
Message-ID: <200411191909.13371.adaplas@hotpop.com>
References: <20041118164946.GA3763@bogon.ms20.nix> <200411190719.24961.adaplas@hotpop.com> <20041119080951.GA6409@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV6fl-00071W-Ji
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 03:11:25 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CV6fk-0001JH-FC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 03:11:25 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B12B4A0BE89
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 11:11:09 +0000 (UTC)
In-Reply-To: <20041119080951.GA6409@bogon.ms20.nix>
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
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Friday 19 November 2004 16:09, Guido Guenther wrote:
> On Fri, Nov 19, 2004 at 07:19:24AM +0800, Antonino A. Daplas wrote:
> > On Friday 19 November 2004 00:49, Guido Guenther wrote:
> > > Hi Antonio,
> > > this patch against 2.6.10-rc2 finally detects rivafb on NV30 based
> > > power books by adding the pciid. Wolfram Quester tested it and reported
> > > it working. It also cleans up the error code reported from the probe
> > > function.
> >
> > Thanks.
> >
> > I also tested NV32 (GeForce FX 5200 0x0322) which also works.  So, I'm
> > planning to add a lot of NV30 entries to pci_ids.h and the rivafb
> > pci_table just so we can get a lot of reports (good and bad) from users.
>
> Hmmm...shouldn't we delay this past 2.6.10? People with rivafb compiled
> into the kernel but a - until now undetected - card,  might get bitten
> otherwise.

Yes, we're already in rc2, and usually at this point, patches merged tend to
be bug fixes only.

Anyway, I'm planning to write another driver for nvidia, based on xorg
sources, as nvidiafb.  The rivafb uses programmed io, whereas the newer
chipsets uses DMA, and without docs, that's the only way we can support
newer chipsets (use X sources).

So, eventually, rivafb will support only nv20 chipsets and older, whilst
nvidiafb nv10 and newer.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
