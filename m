From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 14:33:14 +0100
Message-ID: <20041119133314.GG6409@bogon.ms20.nix>
References: <20041118164946.GA3763@bogon.ms20.nix> <20041119080951.GA6409@bogon.ms20.nix> <200411191909.13371.adaplas@hotpop.com> <200411191224.00921.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV97L-0003MJ-Sy
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 05:48:03 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CV97G-0001gv-36
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 05:48:03 -0800
Content-Disposition: inline
In-Reply-To: <200411191224.00921.andrew@walrond.org>
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
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Fri, Nov 19, 2004 at 12:24:00PM +0000, Andrew Walrond wrote:
> On Friday 19 Nov 2004 11:09, Antonino A. Daplas wrote:
> >
> > Anyway, I'm planning to write another driver for nvidia, based on xorg
> > sources, as nvidiafb.  The rivafb uses programmed io, whereas the newer
> > chipsets uses DMA, and without docs, that's the only way we can support
> > newer chipsets (use X sources).
> >
> 
> How come xorg have more information than you? Is their (open source) driver 
> provided by NVidia?
The driver was originally written by Mark Vojkovich who had access to
the documentation.
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
