From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 15:43:55 -0800
Message-ID: <20050307154355.2fd5094c.akpm@osdl.org>
References: <200503060816.55890.adaplas@hotpop.com>
	<20050307022828.54d52983.akpm@osdl.org>
	<9e47339105030711117f6ffdc9@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Rua-0002VW-3B
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 15:45:20 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8RuY-0000oJ-C7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 15:45:20 -0800
In-Reply-To: <9e47339105030711117f6ffdc9@mail.gmail.com>
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
> Here's the whole patch again with the build fixes. ppc still needs to
> be checked.

I cannot get either patch to apply, particularly this one:

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
Hunk #15 FAILED at 1011.
Hunk #16 succeeded at 1219 (offset 220 lines).
Hunk #17 FAILED at 1237.
Hunk #18 FAILED at 1259.
Hunk #19 FAILED at 1267.
15 out of 19 hunks FAILED -- saving rejects to file drivers/video/Kconfig.rej
patching file drivers/video/Makefile
patch: **** malformed patch at line 365: fbsysfs.o modedb.o softcursor.o


and both were severely wordwrapped.


A patch against http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 which
is a patch against 2.6.11 would be ideal, please.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
