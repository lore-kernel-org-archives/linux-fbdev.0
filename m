From: James Simmons <jsimmons@infradead.org>
Subject: Re: large framebuffers and mmap
Date: Mon, 22 Sep 2003 20:20:08 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309222017280.6431-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0309220915370.4957-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1WEI-0005lc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 12:20:17 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1WEF-0000ou-Im
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 12:20:11 -0700
In-Reply-To: <Pine.GSO.4.21.0309220915370.4957-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> > I looked through a couple of drivers and none of them seem to touch the buffer
> > after it has been remapped. They only pass the pointer back to fbconsole.
> 
> What about
>   - read from/write to /dev/fb*?
>   - the logo code?

Logo code should be using imageblit which in non accelerated cases uses 
cfb_imageblit. So we need the pointer. Also the software cursor uses the
ioremap memory space. Plus read/write to /dev/fb*. So it is not just the 
fbconsole that uses screen_base. The problem is broken drivers that 
allocate way to much memory.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
