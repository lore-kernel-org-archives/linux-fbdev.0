From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ioremap problem on highmem
Date: Wed, 15 Oct 2003 18:46:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066236404.662.60.camel@gaston>
References: <20031014004651.36307.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9onm-0001Jt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 09:47:10 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A9onj-0008Ao-EO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 09:47:07 -0700
In-Reply-To: <20031014004651.36307.qmail@web14914.mail.yahoo.com>
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
Cc: Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> The more I learn about fbconsole the more I think it is a bad idea. This is no
> comment on the skill of the people writing it, I just think the whole concept
> of mapping the framebuffer in to kernel space needs to be eliminated. There is
> only 1GB of kernel space and it make no sense to chew up 128MB or 256MB of it
> mapping a framebuffer just to get a penguin at boot. I do think penguin is
> cute, but not cute enough to waste kernel address space on.

Can you think about non-x86 please ? Most of them don't have anything
remotely like VGA / BIOS

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
