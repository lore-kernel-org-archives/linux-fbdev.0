From: Jon Smirl <jonsmirl@yahoo.com>
Subject: I2C standalone vs integrated?
Date: Wed, 15 Oct 2003 17:43:49 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016004349.71177.qmail@web14908.mail.yahoo.com>
References: <Pine.LNX.4.44.0310160012230.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9wF4-00079a-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 17:43:50 -0700
Received: from web14908.mail.yahoo.com ([216.136.225.60])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9wF3-0003OP-Oa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 17:43:49 -0700
In-Reply-To: <Pine.LNX.4.44.0310160012230.13660-100000@phoenix.infradead.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- James Simmons <jsimmons@infradead.org> wrote:
> > I'd rather see it in a user space library. Some hardware (Rage128) can only
> > read EDID info from user space becuase of real mode INT10 problems.
> 
> Read it using i2c. I have code for the aty128 driver that reads EDID 
> information. No problems with it.

Can you add it to the aty128 driver in 2.6? I tried porting ben's code from his
new radeonfb driver into aty128fb but I couldn't get it to work.

Also, I2C drivers for Intel810, Savage, Voodoo, etc are implemented as
standalone I2C drivers. Ben implemented his and Matrox as an integral part of
the fb driver. Wouldn't it be better to implement these all standalone? It's
probably the same amount of code, and I can use the standalone ones from Mesa
without loading framebuffer support.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
