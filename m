From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap problem on highmem
Date: Wed, 15 Oct 2003 17:34:35 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016003435.45380.qmail@web14912.mail.yahoo.com>
References: <Pine.LNX.4.44.0310160012230.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9w8Q-00061V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 17:36:58 -0700
Received: from web14912.mail.yahoo.com ([216.136.225.248])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9w7U-000128-6b
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 17:36:00 -0700
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
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- James Simmons <jsimmons@infradead.org> wrote:
> > Another issue I am having trouble with is having mode setting/EDID code in
> a device driver. That is a lot of seldom used code sitting in a device
> driver.
> 
> Prehaps but on platforms lacking firmware that sets the video mode this is 
> a problem. A good example is most mips boxes. The prom almost nevers 
> initializes the graphics cards. You have to set the video mode yourself. 
> No way around it. 
> 
How about making a small driver with all of it's code marked __init that
initializes the mode on boxes with absolutely no support? That would be enough
to get us to the point where we can run user mode code and provide a more full
featured driver. The user mode driver would have full support for mode
setting/edid in user space libraries.

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
