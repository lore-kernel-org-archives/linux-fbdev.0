From: Andrew Walrond <andrew@walrond.org>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 12:24:00 +0000
Message-ID: <200411191224.00921.andrew@walrond.org>
References: <20041118164946.GA3763@bogon.ms20.nix> <20041119080951.GA6409@bogon.ms20.nix> <200411191909.13371.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV7o5-00057E-Ew
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 04:24:05 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CV7o3-0004gV-5c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 04:24:05 -0800
In-Reply-To: <200411191909.13371.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Guido Guenther <agx@sigxcpu.org>, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Friday 19 Nov 2004 11:09, Antonino A. Daplas wrote:
>
> Anyway, I'm planning to write another driver for nvidia, based on xorg
> sources, as nvidiafb.  The rivafb uses programmed io, whereas the newer
> chipsets uses DMA, and without docs, that's the only way we can support
> newer chipsets (use X sources).
>

How come xorg have more information than you? Is their (open source) driver 
provided by NVidia?

Andrew


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
