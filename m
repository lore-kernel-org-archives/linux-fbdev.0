From: James Simmons <jsimmons@infradead.org>
Subject: Re: Including fb.h from userspace
Date: Wed, 28 Jan 2004 17:06:56 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401281706320.31165-100000@phoenix.infradead.org>
References: <20040128104112.GM23652@pengutronix.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alt9X-0007u5-CE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 09:06:59 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Alt9W-0000JC-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 09:06:59 -0800
In-Reply-To: <20040128104112.GM23652@pengutronix.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Schwebel <robert@schwebel.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


I have a fix for that. I will be submitting it soon up stream.


On Wed, 28 Jan 2004, Robert Schwebel wrote:

> I'm trying to compile the XFree86-4.3.99.10 framebuffer driver with
> Linux-2.6.1. It breaks because the driver includes the kernel's fb.h
> which includes other stuff which seems not to be userland clean. 
> 
> What's the "right" way or variant to include fb.h from userland? 
> 
> Robert
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
