From: James Simmons <jsimmons@infradead.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 00:22:05 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310160018100.13660-100000@phoenix.infradead.org>
References: <20031015161705.221a579b.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9uy5-0004pn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 16:22:13 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A9uy3-0006Xm-Hh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 16:22:11 -0700
In-Reply-To: <20031015161705.221a579b.akpm@osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chris Heath <chris@heathens.co.nz>


> > Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> > Several fixes. The patch is against 2.6.0-test7
> > 
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Cool.  I've had the below fix floating about for a while.  Is it still
> relevant?

Its not the proper fix. The latest patch fixes this problem. I had to save 
the area under the cursor and redraw that area when the cursor was 
disabled or moved. The cursor api is set in stone from the drivers 
prespective. So it will be easy for driver writers to make use of 
a hardware cursor. The old cursor code was written around a software 
emulated cursor. The new code favors hardware cursors with software 
emulation the exception.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
