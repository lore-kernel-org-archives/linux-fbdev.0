From: James Simmons <jsimmons@infradead.org>
Subject: Re: ioremap problem on highmem
Date: Thu, 16 Oct 2003 00:17:47 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310160012230.13660-100000@phoenix.infradead.org>
References: <20031014175939.2616.qmail@web14916.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9utv-0004Y4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 16:17:55 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A9uts-0005NB-Jp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 16:17:52 -0700
In-Reply-To: <20031014175939.2616.qmail@web14916.mail.yahoo.com>
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
Cc: Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> My main motivation for this is to have a single driver controlling the 
> graphics hardware on DRI supported systems. This will eliminate the problem 
> with saving hardware state between VT's. 

Unless you disable the VT console system you still have to to deal with 
switching from KDTEXT to KDGRAPHICS and back again. Its also userlands 
responiblity to save the console state and restore it.

> Another issue I am having trouble with is having mode setting/EDID code in a
> device driver. That is a lot of seldom used code sitting in a device driver.

Prehaps but on platforms lacking firmware that sets the video mode this is 
a problem. A good example is most mips boxes. The prom almost nevers 
initializes the graphics cards. You have to set the video mode yourself. 
No way around it. 

> I'd rather see it in a user space library. Some hardware (Rage128) can only
> read EDID info from user space becuase of real mode INT10 problems.

Read it using i2c. I have code for the aty128 driver that reads EDID 
information. No problems with it.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
