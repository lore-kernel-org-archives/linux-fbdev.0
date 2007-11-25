From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Questions about fbdriver integration
Date: Sun, 25 Nov 2007 11:53:56 +0100
Message-ID: <20071125105356.GI3183@pruts.nl>
References: <20071124214325.GD3183@pruts.nl> <20071124221447.GF3183@pruts.nl>
	<45a44e480711241449l5c368250q40e5adc1fab117fa@mail.gmail.com>
	<20071125090525.GG3183@pruts.nl>
	<45a44e480711250248x692c3d2p8b5bade876a36d26@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwF7p-0005ZM-3J for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 02:54:09 -0800
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwF7m-0005GG-KZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 02:54:07 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id 8931112E42D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 11:54:05 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOk8aqpVWAJz
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 11:53:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <45a44e480711250248x692c3d2p8b5bade876a36d26@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


* On 2007-11-25 Jaya Kumar <jayakumar.lkml@gmail.com> wrote  :

> On Nov 25, 2007 4:05 AM, Ico Doornekamp <fbdev@zevv.nl> wrote:
> >
> > This seems to fix my mmap problem, although the first mmap
> > access yields a kernel warning:
> >
> >         WARNING: at fs/buffer.c:696 __set_page_dirty()
> >         [<c01622f8>] __set_page_dirty+0xb8/0xf0
> >         [<c0134169>] set_page_dirty+0x29/0x50
> >         [<c0134d5b>] set_page_dirty_balance+0xb/0x40
> >         [<c0139470>] __do_fault+0x160/0x340
> >         [<c013a9d3>] handle_mm_fault+0xd3/0x3d0
> >
> 
> Odd. I don't see the same warning. I am still on 2.6.22.10 so maybe
> it's a recent change. Just curious, which kernel are you using and on
> which arch?

I'm running 2.6.23.8 on i386. I can post the driver code if this would
be of any help.

Unfortunalely I'm not very familiar with the lowlevel paging and memory
handling, so this is a though one for me to debug myself.

-- 
:wq
^X^Cy^K^X^C^C^C^C

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
