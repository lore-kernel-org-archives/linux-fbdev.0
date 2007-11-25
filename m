From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: Questions about fbdriver integration
Date: Sun, 25 Nov 2007 05:48:06 -0500
Message-ID: <45a44e480711250248x692c3d2p8b5bade876a36d26@mail.gmail.com>
References: <20071124214325.GD3183@pruts.nl> <20071124221447.GF3183@pruts.nl>
	<45a44e480711241449l5c368250q40e5adc1fab117fa@mail.gmail.com>
	<20071125090525.GG3183@pruts.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwF1z-0005Dl-49 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 02:48:07 -0800
Received: from rv-out-0910.google.com ([209.85.198.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwF1y-0007yz-TW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 02:48:07 -0800
Received: by rv-out-0910.google.com with SMTP id g11so886223rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 02:48:06 -0800 (PST)
In-Reply-To: <20071125090525.GG3183@pruts.nl>
Content-Disposition: inline
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

On Nov 25, 2007 4:05 AM, Ico Doornekamp <fbdev@zevv.nl> wrote:
>
> This seems to fix my mmap problem, although the first mmap
> access yields a kernel warning:
>
>         WARNING: at fs/buffer.c:696 __set_page_dirty()
>         [<c01622f8>] __set_page_dirty+0xb8/0xf0
>         [<c0134169>] set_page_dirty+0x29/0x50
>         [<c0134d5b>] set_page_dirty_balance+0xb/0x40
>         [<c0139470>] __do_fault+0x160/0x340
>         [<c013a9d3>] handle_mm_fault+0xd3/0x3d0
>

Odd. I don't see the same warning. I am still on 2.6.22.10 so maybe
it's a recent change. Just curious, which kernel are you using and on
which arch?

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
