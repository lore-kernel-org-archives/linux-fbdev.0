From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ioremap problem on highmem
Date: Thu, 16 Oct 2003 12:09:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066298970.646.123.camel@gaston>
References: <Pine.LNX.4.44.0310160012230.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA55Q-0001cy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 03:10:28 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AA55M-00055u-Og
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 03:10:25 -0700
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
To: James Simmons <jsimmons@infradead.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-10-16 at 01:17, James Simmons wrote:
> > My main motivation for this is to have a single driver controlling the 
> > graphics hardware on DRI supported systems. This will eliminate the problem 
> > with saving hardware state between VT's. 
> 
> Unless you disable the VT console system you still have to to deal with 
> switching from KDTEXT to KDGRAPHICS and back again. Its also userlands 
> responiblity to save the console state and restore it.

Which is a bit hellish... I would love a callback "restore" (or maybe
just a set_par with a "force" attribute bypassing check of old par !=
new par that most drivers have that gets called on switch back from
KDGRAPHICS to KDTEXT. In my experience, this is the only way to get
things back properly after XFree with radeons.

XFree _could_ probably be fixed, but it's a bit difficult, especially
saving & restoring the entire 2D accel state, and you know how long it
would take for an xfree fix to get in, while it's so easy for radeonfb
to just put back its own settings...




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
