From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Wed, 17 Nov 2004 22:33:28 +0000
Message-ID: <200411172233.28606.andrew@walrond.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <Pine.LNX.4.58.0411170802500.2222@ppc970.osdl.org> <200411171917.15962.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUYMu-0001py-QD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 14:33:40 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUYMs-0005HM-Ut
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 14:33:40 -0800
In-Reply-To: <200411171917.15962.andrew@walrond.org>
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
Cc: Linus Torvalds <torvalds@osdl.org>

Ok, answering my own question: vmalloc=256M fixed the problem with booting the 
32bit kernel.

And I can confirm that the problem exists in both 32bit and 64bit kernels.

Andrew Walrond


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
