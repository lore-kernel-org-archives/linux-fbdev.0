From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 09:09:51 +0100
Message-ID: <20041119080951.GA6409@bogon.ms20.nix>
References: <20041118164946.GA3763@bogon.ms20.nix> <200411190719.24961.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV43L-0002S7-V3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 00:23:35 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CV43K-0002Sk-WA
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 00:23:35 -0800
Content-Disposition: inline
In-Reply-To: <200411190719.24961.adaplas@hotpop.com>
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

On Fri, Nov 19, 2004 at 07:19:24AM +0800, Antonino A. Daplas wrote:
> On Friday 19 November 2004 00:49, Guido Guenther wrote:
> > Hi Antonio,
> > this patch against 2.6.10-rc2 finally detects rivafb on NV30 based power
> > books by adding the pciid. Wolfram Quester tested it and reported it
> > working. It also cleans up the error code reported from the probe
> > function.
> >
> 
> Thanks.
> 
> I also tested NV32 (GeForce FX 5200 0x0322) which also works.  So, I'm
> planning to add a lot of NV30 entries to pci_ids.h and the rivafb pci_table
> just so we can get a lot of reports (good and bad) from users.
Hmmm...shouldn't we delay this past 2.6.10? People with rivafb compiled
into the kernel but a - until now undetected - card,  might get bitten
otherwise.
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
