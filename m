From: James Simmons <jsimmons@infradead.org>
Subject: Re: Including fb.h from userspace
Date: Mon, 2 Feb 2004 18:00:50 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402021800330.27538-100000@phoenix.infradead.org>
References: <20040128182942.GA10435@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AniNU-0000YG-GB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Feb 2004 10:00:56 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AniNT-0006HS-VB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 02 Feb 2004 10:00:56 -0800
In-Reply-To: <20040128182942.GA10435@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Robert Schwebel <robert@schwebel.de>, linux-fbdev-devel@lists.sourceforge.net


> > I'm trying to compile the XFree86-4.3.99.10 framebuffer driver with
> > Linux-2.6.1. It breaks because the driver includes the kernel's fb.h
> > which includes other stuff which seems not to be userland clean. 
> > 
> > What's the "right" way or variant to include fb.h from userland? 
> 
> Yea, several people has posted patches to fix the problem but
> they are not getting merged.  Basically you must 'move' fb_pixmap
> to the __KERNEL area and move some includes from top (i remember
> to leave just <asm/types.h> in top, everything else to __KERNEL
> area) in file include/linux/fb.h

Yeap. That is all that is needed.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
