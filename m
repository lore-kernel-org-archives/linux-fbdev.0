From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Large framebuffers and HIGHMEM systems
Date: Wed, 10 Sep 2003 08:01:00 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030910150100.89767.qmail@web14914.mail.yahoo.com>
References: <Pine.GSO.4.21.0309101039170.1390-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x6TE-00012y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 08:01:24 -0700
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19x6TC-00019d-19
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 08:01:22 -0700
In-Reply-To: <Pine.GSO.4.21.0309101039170.1390-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Or modify ioremap() to print the message? This problem is not only limited to
> frame buffer devices, but to every driver that needs to ioremap() large
> regions, right?
> 
ioremap() is supposed to map the region into the bottom 1GB or fail. After
ioremap() fails you need to use a different API to map to the highmem regions.
The way Linux is set up there is always about 20-30MB of free address space
below 1GB. All of the hardware I've seen can map into that space. The only
exception is the huge amount of address space needed for kernel mapped video
frame buffers.

Memory below 1GB is important to the kernel for keeping page tables. Page table
can be pushed above 1GB but you incur performance penalties. There is no
problem creating a 256MB hole with reserve=XXXX in the 1GB address space to
allow the latest ATI/NV cards to run with framebuffers; but doing this will
slow your system down. It is also a very non-obvious solution to why a
framebuffer fails to load.

I don't think we should be forcing non-performance sensitve framebuffer memory
into the bottom 1GB and pushing performance sensitive page tables into highmem.
Besides, we are going that have to do something, we are likely to have 1GB
video cards two years from now.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
