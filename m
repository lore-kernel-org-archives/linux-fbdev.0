From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: fb_write change in your tree
Date: Tue, 23 Mar 2004 14:57:04 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1080014223.22188.87.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5dGY-0000Ff-5F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 20:11:50 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B5dGX-0004l6-Ed
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Mar 2004 20:11:49 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James !

What is this change to fb_write() in your tree ? It looks very
wrong to me. You are removing the ability for the driver to
hook it's own fb_write function, which can be a problem. You
basically assume copy_from_user() can be used straight with
the framebuffer as a destination. This is broken. On ppc, for
example, copy_from_user() may do dcbz's cache instruction on
the destination. However, the fb is mapped uncacheable, that
will result in a lot of exceptions during the copy, which is
plain wrong (or possibly the copy failing completely).

What about drivers that are taking great care _NOT_ to map
the framebuffer (or at least not all of it) to avoid having
to ioremap hundreds of megabytes in kernel space ?

A driver should be able to never fill scree_base provided
that it has filled all the accel hooks and provides it's
own fb_read/write functions (which can be slow as they might
have to do mapping/unmapping of fb portions on demand, but
then, mmap is the preferred way for userland to access the
framebuffer content when that is possible).


Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
