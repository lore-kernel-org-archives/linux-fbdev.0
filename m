From: James Simmons <jsimmons@infradead.org>
Subject: RE: Framebuffer with banked memory
Date: Thu, 31 Oct 2002 13:48:08 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210311345270.1721-100000@maxwell.earthlink.net>
References: <2B4461BF89BAD511A86100508B66D53804E4FA67@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120] helo=albatross.prod.itd.earthlink.net)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187MLB-0000ca-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 12:54:57 -0800
In-Reply-To: <2B4461BF89BAD511A86100508B66D53804E4FA67@fmsmsx112.fm.intel.com>
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
To: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Cc: 'alain volmat' <avolmat@yahoo.fr>, linux-fbdev-devel@lists.sourceforge.net


>   The short answer to your problem is that, sadly, much of the 2.4
> framebuffer is badly implemented, allowing device independent code to
> directly access device memory etc. Some of this is cleaned up for 2.5, but
> as I've not looked at it lately I'm not sure how much.  Here are some
> pointers as to what is required for 2.4.
>
> #1 The Boot penguin code directly accesses your video memory. If you have
> banked memory this will likely fall off the end of a pointer and oops the
> kernel or worse.

Fixed in 2.5.X. You use the image drawing function to draw the penguin.

> #2 Read/Write Access video memory directly. I had added a read/write
> handler to the fb_ops to hook these out and switch banks.
> Read/write are also incorrect if your pitch != width.

Fixed. I have hooks now. I didn't notice the pitch != width problem. Give
me time to fix up a patch, unless someone bets me to the punch.

> #3 Memory map can't be done. I had coded up a working version that would
> map a single back and page fault in the banks as necessary. This worked
> but would get hung up on unaligned accesses where one instruction accessed
> two memory banks at the same time. So memory map isn't possible.

:-( Even with providing your own mmap function you still couldn't get it
to work.




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
