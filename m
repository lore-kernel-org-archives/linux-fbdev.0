From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 16:39:12 -0800
Message-ID: <20050307163912.14f9f0d4.akpm@osdl.org>
References: <200503060816.55890.adaplas@hotpop.com>
	<20050307022828.54d52983.akpm@osdl.org>
	<9e47339105030711117f6ffdc9@mail.gmail.com>
	<20050307154355.2fd5094c.akpm@osdl.org>
	<9e4733910503071605486c9c93@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Skq-0005BN-Vy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:39:20 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8Skn-0005pZ-DH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:39:20 -0800
In-Reply-To: <9e4733910503071605486c9c93@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> Here's the same patch as an attachment. It is against a clean linus bk tree.

Tony has already sent a monster fbdev Kconfig cleanup patch, so your latest
patch does:

patching file drivers/video/Kconfig
Hunk #2 FAILED at 112.
Hunk #3 FAILED at 120.
Hunk #4 FAILED at 144.
Hunk #5 FAILED at 201.
Hunk #6 succeeded at 292 (offset 80 lines).
Hunk #7 FAILED at 300.
Hunk #8 FAILED at 393.
Hunk #9 FAILED at 410.
Hunk #10 succeeded at 421 (offset 57 lines).
Hunk #11 FAILED at 432.
Hunk #12 FAILED at 447.
Hunk #13 FAILED at 493.
Hunk #14 FAILED at 598.
Hunk #15 succeeded at 1121 (offset 167 lines).
Hunk #16 succeeded at 1075 (offset 76 lines).
Hunk #17 FAILED at 1093.
Hunk #18 FAILED at 1115.
Hunk #19 FAILED at 1123.
14 out of 19 hunks FAILED -- saving rejects to file drivers/video/Kconfig.rej
patching file drivers/video/Makefile
Hunk #1 FAILED at 8.
1 out of 1 hunk FAILED -- saving rejects to file drivers/video/Makefile.rej
patching file drivers/video/console/Makefile
patching file drivers/video/fbmem.c
Hunk #1 succeeded at 1205 (offset 1 line).


I assume that Tony must have fixed up your original or something.

Sorry, but at this stage of the kernel cycle when I'm 800-900 patches away
from Linus, things are a bit difficult.  A fixup patch against
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 would really be
ideal, please.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
