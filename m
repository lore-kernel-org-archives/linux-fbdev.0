From: Andrew Walrond <andrew@walrond.org>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Fri, 19 Nov 2004 09:20:44 +0000
Message-ID: <200411190920.44609.andrew@walrond.org>
References: <20041118164946.GA3763@bogon.ms20.nix> <200411190719.24961.adaplas@hotpop.com> <20041119080951.GA6409@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV4wn-0006ba-16
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 01:20:53 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CV4wl-0002TT-Uu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 01:20:52 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Guido Guenther <agx@sigxcpu.org>, adaplas@pol.net, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Friday 19 Nov 2004 08:09, Guido Guenther wrote:
>
> Hmmm...shouldn't we delay this past 2.6.10? People with rivafb compiled
> into the kernel but a - until now undetected - card,  might get bitten
> otherwise.
>  -- Guido
>

Why would 2.6.11 be a better time than 2.6.10 for this change? People tend to 
expect a few problems whenever they upgrade a kernel.

Andrew Walrond


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
