From: James Simmons <jsimmons@infradead.org>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 18:25:40 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310141824280.20831-100000@phoenix.infradead.org>
References: <20031014144219.73671.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9Sva-0007nr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 10:25:46 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A9SvY-0002Dn-S9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 10:25:45 -0700
In-Reply-To: <20031014144219.73671.qmail@web14914.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> How about removing all ioremaps from the fb drivers. Then fbcon can check if
> they are accelerated or not and do the ioremap in fbcon if they are not.

Sounds reasonable. The issue then is drivers that provide partial 
accelerated support.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
