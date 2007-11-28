From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Questions about fbdriver integration
Date: Wed, 28 Nov 2007 12:40:45 +0100
Message-ID: <20071128114045.GU25554@pruts.nl>
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
	id 1IxLHu-00015M-JW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 03:41:49 -0800
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IxLHr-0007ap-V5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 03:41:06 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id BD48212E429
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Nov 2007 12:40:55 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d+aI2FKrOot5
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Nov 2007 12:40:45 +0100 (CET)
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


Hello Jaya,

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
> it's a recent change. 

Just curious, did you happen to take a look at this issue, and were you
able to reproduce it ?

Thank you,

Ico

-- 
:wq
^X^Cy^K^X^C^C^C^C

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
