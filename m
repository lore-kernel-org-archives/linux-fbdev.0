From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
 seconds to initialize
Date: Mon, 27 Nov 2006 12:35:02 -0800
Message-ID: <20061127123502.4253210c.akpm@osdl.org>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
	<808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
	<20061121003447.GD5160@cosmic.amd.com>
	<808c8e9d0611210618n2d54aaft1e2afb1c73dcf74a@mail.gmail.com>
	<808c8e9d0611270828m4ff91349mdc7bf03fd6875e91@mail.gmail.com>
	<Pine.LNX.4.64.0611271820450.16234@pentafluge.infradead.org>
	<20061127183930.GF588@cosmic.amd.com>
	<20061127115403.059e5f19.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GonCl-0008DF-PT for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 12:35:55 -0800
Received: from smtp.osdl.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GonCk-0002W8-86
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 12:35:55 -0800
In-Reply-To: <20061127115403.059e5f19.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jordan Crouse <jordan.crouse@amd.com>, linux-fbdev-devel@lists.sourceforge.net, Ben Gardner <gardner.ben@gmail.com>

On Mon, 27 Nov 2006 11:54:03 -0800
Andrew Morton <akpm@osdl.org> wrote:

> I'll bring git-geode back, see what happens.

patching file arch/i386/Kconfig
Hunk #1 succeeded at 752 (offset 11 lines).
patching file arch/i386/Makefile.cpu
Hunk #1 succeeded at 39 (offset 1 line).
patching file arch/i386/boot/setup.S
Hunk #1 succeeded at 405 (offset 11 lines).
Hunk #2 succeeded at 1022 (offset 13 lines).
patching file drivers/crypto/Kconfig
Hunk #2 succeeded at 65 with fuzz 2 (offset 13 lines).
patching file drivers/crypto/Makefile
Hunk #1 succeeded at 1 with fuzz 1.
The next patch would create the file drivers/crypto/geode-aes.c,
which already exists!  Applying it anyway.
patching file drivers/crypto/geode-aes.c
Patch attempted to create file drivers/crypto/geode-aes.c, which already exists.
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file drivers/crypto/geode-aes.c.rej
The next patch would create the file drivers/crypto/geode-aes.h,
which already exists!  Applying it anyway.
patching file drivers/crypto/geode-aes.h
Patch attempted to create file drivers/crypto/geode-aes.h, which already exists.
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file drivers/crypto/geode-aes.h.rej


It seems that there's duplication between Herbert's git-cryptodev tree
and your git-geode tree.

What's the story here?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
