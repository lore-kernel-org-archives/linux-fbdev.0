From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Fix cursor + selection
Date: Tue, 2 Sep 2003 18:15:26 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309021806510.11075-100000@phoenix.infradead.org>
References: <20030901212952.0949.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uElE-0005zV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 02 Sep 2003 10:16:08 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19uElE-0001e3-1v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Sep 2003 10:16:08 -0700
In-Reply-To: <20030901212952.0949.CHRIS@heathens.co.nz>
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
To: Chris Heath <chris@heathens.co.nz>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I noticed that the framebuffer console overwrites the mouse pointer and
> selected text when the cursor flashes.
> 
> The attached patch fixes that.  It is rather long, but basically all
> I've done is moved a huge chunk of code from fbcon_cursor into a helper
> function, and called that helper from fbcon_putc and fbcon_putcs.
> 
> The patch is against James's latest fbdev patch that he posted to
> linux-kernel.

Than you for the patch. Over the weekend I fixed up the cursor code and we 
pretty much come to the same results. I ported ove rthe Mach64 cursor to 
the new cursor api. Also the NVIDIA driver is done. A little more work is 
needed and I have to rework the soft cursor. 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
