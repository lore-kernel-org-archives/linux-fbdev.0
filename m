From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: syncing to mainline kernel
Date: Thu, 09 Oct 2003 09:43:26 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1065685406.7081.68.camel@gaston>
References: <Pine.LNX.4.44.0310081946520.24451-100000@phoenix.infradead.org>
	 <1065639239.6518.29.camel@gaston>  <20031009004146.GC31602@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7VTX-0005Pp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Oct 2003 00:44:43 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A7VTU-0004Eg-Qd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Oct 2003 00:44:42 -0700
In-Reply-To: <20031009004146.GC31602@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>, Louis Garcia <louisg00@bellsouth.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Ben, i have problems with your new radeonfb driver, apart that i have
> to update the pci_ids.h and r200.c in both stock 2.6 and your bk tree
> to make work my radeon 9200 (rv280 Ya), in your new driver, spaces
> becomes '_', and after a while all characteres get messy.  My normal
> setup is 1024x768-32@75 but with your driver the only reliable mode is
> 640x480-8@60.  Any idea?

Regarding PCI IDs, I'm changing that now, I decided to add a separate
drivers/video/aty/ati_ids.h containing a copy of XFree ATI PCI IDs
instead of using the include/linux/pci_ids.h one. That may see odd,
but it helps a lot avoiding the merge problems and makes it easier
to resync with XFree. This is already the case in my bk btw.

Regarding your problem, I don't know what's up with spaces vs '_',
that doesn't ring any bell to me, especially since there is no use
of HW accel in this version, so the chars are really only drawn
by the core fbdev layer.

What do you mean by "reliable mode". What do you get when trying to
use another mode ? It's normal that fbset doesn't work properly in
2.6, this is a known issue. What did you try and what result did you
get ?

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
