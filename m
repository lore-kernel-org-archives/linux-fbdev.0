From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Linux 2.6.10-rc2
Date: Wed, 17 Nov 2004 15:54:32 +0000
Message-ID: <200411171554.32382.andrew@walrond.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUS93-0006Vw-Ud
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 07:54:57 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUS92-0004f4-4T
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 07:54:57 -0800
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
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
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

On Monday 15 Nov 2004 02:49, Linus Torvalds wrote:
>
> Antonino Daplas:
...
>   o fbdev: Fix IO access in rivafb

FYI

changeset 1.2563 breaks the rivafb for x86_64 (64bit). I'm looking into it 
with the fbdev guys help, so I'm sure a fix will be forthcoming soon.

Andrew Walrond


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
