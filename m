From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 13:18:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066389516.4777.231.camel@gaston>
References: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AASgu-0006yg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 04:22:45 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AASgE-0005Xu-8Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 04:22:02 -0700
In-Reply-To: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> 
> > --- linux-2.6.0-test7/drivers/video/radeonfb.c	Wed Oct 15 19:12:22 2003
> > +++ fbdev-2.6/drivers/video/radeonfb.c	Wed Oct 15 19:20:51 2003
> 
> drivers/video/radeonfb.c still exists, while the build system now uses the one
> in drivers/video/aty?

I haven't checked what James did here. In my tree, I was careful to keep
both old and new drivers available via 2 separate CONFIG options. 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
