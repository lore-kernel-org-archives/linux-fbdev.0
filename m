From: Andrew Walrond <andrew@walrond.org>
Subject: Re: [PATCH: 2.6.10-rc2] fbdev: Fix rivafb breakage (typo introduced by cset 1.2563)
Date: Thu, 18 Nov 2004 12:55:50 +0000
Message-ID: <200411181255.50965.andrew@walrond.org>
References: <200411181239.18093.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUlpO-0002wq-Vu
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Nov 2004 04:55:58 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUlpN-0002Ap-3L
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Nov 2004 04:55:58 -0800
In-Reply-To: <200411181239.18093.andrew@walrond.org>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org

Fixing this typo cures the screen corruption I was seeing on both 32 and 64bit 
x86_64 kernels.

Thanks for the help tracking this down. Please apply!

Andrew Walrond


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
