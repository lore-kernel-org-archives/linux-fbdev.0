From: Andrew Walrond <andrew@walrond.org>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Tue, 16 Nov 2004 23:29:27 +0000
Message-ID: <200411162329.27230.andrew@walrond.org>
References: <200411162244.37709.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUClY-0006xl-3R
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 15:29:40 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUClU-0007Tx-11
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 15:29:39 -0800
Received: from [62.24.231.115] (helo=orac.walrond.org)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1CUClL-00062I-1d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Nov 2004 23:29:27 +0000
In-Reply-To: <200411162244.37709.andrew@walrond.org>
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

On Tuesday 16 Nov 2004 22:44, Andrew Walrond wrote:
> Hi guys,
>
> I just upgraded my kernel to linus latest bk head, booting with a built in
> rivafb as usual, but I get a corrupted display.
>
> 2.6.8.1 worked just fine.
>

2.6.9 is also fine. I'll try and narrow it down some more...


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
