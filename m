From: James Simmons <jsimmons@infradead.org>
Subject: Re: cfb* routines and high mem
Date: Mon, 22 Sep 2003 20:17:09 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309221953110.6431-100000@phoenix.infradead.org>
References: <20030922164845.42403.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1WBP-0005Jl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 12:17:15 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1WBO-00078r-5V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 12:17:14 -0700
In-Reply-To: <20030922164845.42403.qmail@web14914.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> I believe the best solution to this is to push the ioremap and all fb access
> down into fbconsole. This will localize it to a single point. Then modify
> fbconsole to map the framebuffer into high mem address space. All accesses to
> the high mem framebuffer will need to be bracketed by the high mem access
> marcos. I also don't think the kernel has a high mem ioremap() so one will need
> to be written.
> 
> Will this work for the penguin code?

No. The penguin code works for fbdev without console support. The logo can 
be displayed for embedded fbdev devices so the developer knows it is 
loaded.

> Are there non-cfb drivers? How hard would it be to convert them?
> Is there another solution to the problem?

There are several non-cfb drivers. Breaking the code up and pushing it 
into the fbconsole layer is a bad idea. 

Accelerated driver (non-cfb) don't need to ioremap the framebuffer memory
except for the case of fb_read/fb_write. That can be handled. What should 
be done is a surface api that allocates the amount of memory we really 
need at any time. 







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
