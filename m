From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: rivafb: finally enable NV30 based pbooks/cleanup probe errors
Date: Sat, 20 Nov 2004 01:42:11 +0100
Message-ID: <20041120004210.GA5015@bogon.ms20.nix>
References: <20041118164946.GA3763@bogon.ms20.nix> <200411190719.24961.adaplas@hotpop.com> <20041119080951.GA6409@bogon.ms20.nix> <200411190920.44609.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVJMa-00007f-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 16:44:28 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CVJMZ-0004Vn-P7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 16:44:28 -0800
Content-Disposition: inline
In-Reply-To: <200411190920.44609.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>

On Fri, Nov 19, 2004 at 09:20:44AM +0000, Andrew Walrond wrote:
> On Friday 19 Nov 2004 08:09, Guido Guenther wrote:
> >
> > Hmmm...shouldn't we delay this past 2.6.10? People with rivafb compiled
> > into the kernel but a - until now undetected - card,  might get bitten
> > otherwise.
> >  -- Guido
> >
> 
> Why would 2.6.11 be a better time than 2.6.10 for this change? People tend to 
> expect a few problems whenever they upgrade a kernel.
Well, Linus asked for "fixes only" IIRC, risking to break things for
some users without good reason doesn't fit in well into this.
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
