From: James Simmons <jsimmons@infradead.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 18:48:50 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310161848180.7130-100000@phoenix.infradead.org>
References: <20031016104445.GW17986@fs.tum.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AACF7-0000tL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 10:48:57 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AACF5-00071o-Hq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 10:48:55 -0700
In-Reply-To: <20031016104445.GW17986@fs.tum.de>
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
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> > Several fixes. The patch is against 2.6.0-test7
> > 
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> >...
> 
> When reaming entries in pci_ids.h you should check whether there are 
> other users.
> 
> The following compile error was caused by your patch:

Ug. I turned on all the DRI and APG drivers and well as the fbdev drivers. 
Will fix.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
