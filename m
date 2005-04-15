From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Fri, 15 Apr 2005 11:07:41 +0800
Message-ID: <200504151107.45594.adaplas@hotpop.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com> <20050414191323.10d7d435.khali@linux-fr.org> <a44ae5cd05041411194c3914b1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMHCB-0001EN-6O
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 20:08:39 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMHBu-0004y8-5Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 20:08:39 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5CE8C152E70F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Apr 2005 03:08:10 +0000 (UTC)
In-Reply-To: <a44ae5cd05041411194c3914b1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Miles Lane <miles.lane@gmail.com>, Jean Delvare <khali@linux-fr.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Friday 15 April 2005 02:19, Miles Lane wrote:
> Perhaps I am mistaken, but I thought Andrew wanted to see the nvidiafb
> driver work with a default X86 kernel configuration (which allows for
> up to 128M to be allocated).  Is the driver attempting to allocate
> exactly 128M because that is how much video ram is present in my video
> card?
>

Not allocation, as standalone cards have already a fixed amount of RAM. The
patch will limit the amount of video RAM that the kernel can access to a
maximum of 128 MiB.

> If lots of video cards exist that have more than 128M of video ram,
> won't we be seeing many boot problems with the default kernel
> configuration?  Does this point to a problem in the kernel design?  Is
> this limitation in the kernel's default configuration advantageous?
>

The patch is a short-term workaround where cards with large amounts
of video RAM eat a large amount of the kernel's address space.

What I intend to do is to mimic what radeonfb is doing. Ie, info->screen_size
points to the actual vram, while fix->smem_len points to ioremapped area only.
I'll do some testing first since nvidiafb uses the last chunk of the ioremapped
vram for the DMA buffer, and I don't know the consequence if this buffer is
unintentionally exported to user space, from the security point of view.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
