From: Otto Solares <solca@guug.org>
Subject: Re: Including fb.h from userspace
Date: Wed, 28 Jan 2004 12:29:42 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040128182942.GA10435@guug.org>
References: <20040128104112.GM23652@pengutronix.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AluR9-0003uB-DU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 10:29:15 -0800
Received: from opensource-ca.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AluR9-0001XS-23
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jan 2004 10:29:15 -0800
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Schwebel <robert@schwebel.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Jan 28, 2004 at 11:41:13AM +0100, Robert Schwebel wrote:
> I'm trying to compile the XFree86-4.3.99.10 framebuffer driver with
> Linux-2.6.1. It breaks because the driver includes the kernel's fb.h
> which includes other stuff which seems not to be userland clean. 
> 
> What's the "right" way or variant to include fb.h from userland? 

Yea, several people has posted patches to fix the problem but
they are not getting merged.  Basically you must 'move' fb_pixmap
to the __KERNEL area and move some includes from top (i remember
to leave just <asm/types.h> in top, everything else to __KERNEL
area) in file include/linux/fb.h

-solca



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
