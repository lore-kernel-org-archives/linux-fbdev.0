From: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 12:44:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016104445.GW17986@fs.tum.de>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA5h8-0004V4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 03:49:26 -0700
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1AA5gF-0000Gz-Gj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 03:48:31 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Oct 15, 2003 at 11:59:26PM +0100, James Simmons wrote:
> 
> Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> Several fixes. The patch is against 2.6.0-test7
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>...

When reaming entries in pci_ids.h you should check whether there are 
other users.

The following compile error was caused by your patch:

<--  snip  -->

...
  CC      drivers/char/agp/ati-agp.o
drivers/char/agp/ati-agp.c:421: error: `PCI_DEVICE_ID_ATI_RS300_100' 
undeclared here (not in a function)
...
make[3]: *** [drivers/char/agp/ati-agp.o] Error 1

<--  snip  ->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
