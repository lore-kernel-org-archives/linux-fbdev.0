From: Otto Solares <solca@guug.org>
Subject: Re: syncing to mainline kernel
Date: Thu, 9 Oct 2003 12:20:54 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031009182054.GB5249@guug.org>
References: <Pine.LNX.4.44.0310081946520.24451-100000@phoenix.infradead.org> <1065639239.6518.29.camel@gaston> <20031009004146.GC31602@guug.org> <1065685406.7081.68.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7fQe-00053f-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Oct 2003 11:22:24 -0700
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A7fQd-00061e-ON
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Oct 2003 11:22:23 -0700
Content-Disposition: inline
In-Reply-To: <1065685406.7081.68.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Louis Garcia <louisg00@bellsouth.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Oct 09, 2003 at 09:43:26AM +0200, Benjamin Herrenschmidt wrote:
> 
> > Ben, i have problems with your new radeonfb driver, apart that i have
> > to update the pci_ids.h and r200.c in both stock 2.6 and your bk tree
> > to make work my radeon 9200 (rv280 Ya), in your new driver, spaces
> > becomes '_', and after a while all characteres get messy.  My normal
> > setup is 1024x768-32@75 but with your driver the only reliable mode is
> > 640x480-8@60.  Any idea?
> 
> Regarding PCI IDs, I'm changing that now, I decided to add a separate
> drivers/video/aty/ati_ids.h containing a copy of XFree ATI PCI IDs
> instead of using the include/linux/pci_ids.h one. That may see odd,
> but it helps a lot avoiding the merge problems and makes it easier
> to resync with XFree. This is already the case in my bk btw.

Good, adding new cards would become easy but i really like the pci_ids.h
approach as is a centralized db, it doesn't take much time to update
the driver to work with my card.

> Regarding your problem, I don't know what's up with spaces vs '_',
> that doesn't ring any bell to me, especially since there is no use
> of HW accel in this version, so the chars are really only drawn
> by the core fbdev layer.
>
> What do you mean by "reliable mode". What do you get when trying to
> use another mode ? It's normal that fbset doesn't work properly in
> 2.6, this is a known issue. What did you try and what result did you
> get ?

I can't set my fbdev to anything different than the booted mode 640x480-8@60,
trying anything else brings me a black screen or unsynched monitor,
i am using Jon's merged driver (benh+khronos) so probably is not your driver's
fault (but edid support is very tempting, although is not used because i'm
working now on an old monitor without ddc :), i will try your driver alone and
report back.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
