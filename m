From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ioremap problem on highmem
Date: Thu, 16 Oct 2003 12:12:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066299131.661.127.camel@gaston>
References: <20031016003435.45380.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA58X-000218-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 03:13:41 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AA58T-0005Us-3b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 03:13:37 -0700
In-Reply-To: <20031016003435.45380.qmail@web14912.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> How about making a small driver with all of it's code marked __init that
> initializes the mode on boxes with absolutely no support? That would be enough
> to get us to the point where we can run user mode code and provide a more full
> featured driver. The user mode driver would have full support for mode
> setting/edid in user space libraries.

That would need proper synchronisation with whatever kernel driver does
command processing (something we +/- lack today as well) since we must
stop it when doing mode switching.

Actually, I much prefer keeping the mode setting driver in the kernel
(like any other OS btw). While the accel stuffs location is debatable
(best option beeing what DRI does imho, that is a kernel module taking
care of sending the command blocks & dealing with irqs, while the actual
constuct of the command blocks goes to userland).

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
