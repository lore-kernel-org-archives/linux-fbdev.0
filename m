From: Andy Ritger <ARitger@nvidia.com>
Subject: Re: What Flip means???
Date: Tue, 15 Jul 2003 01:43:00 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307150135480.20499-100000@stravinsky.nvidia.com>
References: <E519BE9E8DAC6A4B89DA4AD1D2A155B7213BE4@soc-mail.soc-soft.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hqemgate00.nvidia.com ([216.228.112.144])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19cIMe-0002RO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Jul 2003 22:28:36 -0700
In-Reply-To: <E519BE9E8DAC6A4B89DA4AD1D2A155B7213BE4@soc-mail.soc-soft.com>
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
To: Nitin Mahajan <Nitin@soc-soft.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


In the context of doubled buffered graphics, "flipping" refers to
changing the scanout start address as a means of swapping buffers
(as opposed to the generally lower performance swapping mechanism
of blitting the back buffer contents to the front buffer).

- Andy Ritger


On Tue, 15 Jul 2003, Nitin Mahajan wrote:

> Hi!
> Can anyone please tell what "Full Screen Page Flip" or simply flip
> means????
> Thanking u in advance,
> regards,
>  
> Nitin Mahajan
> mail:nitin@soc-soft.com
> Mobile : 9886099925
> ======================================
> The Lord gave us two ends -- one to sit on and the other to think with.
> Success depends on which one we use the most.
>  
> 


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
