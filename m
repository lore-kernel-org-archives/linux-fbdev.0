From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Large framebuffers and HIGHMEM systems
Date: Wed, 10 Sep 2003 17:56:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030910155603.GA15485@iliana>
References: <Pine.GSO.4.21.0309101039170.1390-100000@vervain.sonytel.be> <20030910150100.89767.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x7Ki-0008Js-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 08:56:40 -0700
Received: from smtp1.wanadoo.fr ([193.252.22.23] helo=mwinf0803.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x7Kh-0001KC-Cs
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 08:56:39 -0700
Content-Disposition: inline
In-Reply-To: <20030910150100.89767.qmail@web14914.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Sep 10, 2003 at 08:01:00AM -0700, Jon Smirl wrote:
> --- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Or modify ioremap() to print the message? This problem is not only limited to
> > frame buffer devices, but to every driver that needs to ioremap() large
> > regions, right?
> > 
> ioremap() is supposed to map the region into the bottom 1GB or fail. After
> ioremap() fails you need to use a different API to map to the highmem regions.
> The way Linux is set up there is always about 20-30MB of free address space
> below 1GB. All of the hardware I've seen can map into that space. The only
> exception is the huge amount of address space needed for kernel mapped video
> frame buffers.
> 
> Memory below 1GB is important to the kernel for keeping page tables. Page table
> can be pushed above 1GB but you incur performance penalties. There is no
> problem creating a 256MB hole with reserve=XXXX in the 1GB address space to
> allow the latest ATI/NV cards to run with framebuffers; but doing this will
> slow your system down. It is also a very non-obvious solution to why a
> framebuffer fails to load.
> 
> I don't think we should be forcing non-performance sensitve framebuffer memory
> into the bottom 1GB and pushing performance sensitive page tables into highmem.
> Besides, we are going that have to do something, we are likely to have 1GB
> video cards two years from now.

We already have 512MB ones, i guess you will not have to wait for as
long as two years for 1GB video cards.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
