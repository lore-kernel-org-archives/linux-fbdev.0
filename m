From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Mon, 29 Jan 2007 11:39:16 +1100
Message-ID: <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org>
	<20070128160831.fb51347f.akpm@osdl.org>
	<21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBKYJ-0007FR-Fb for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 16:39:20 -0800
Received: from ug-out-1314.google.com ([66.249.92.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBKYI-0000Jl-3n
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 16:39:19 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1092753ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 28 Jan 2007 16:39:16 -0800 (PST)
In-Reply-To: <20070128162907.370f5476.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> > > Because most users won't even be aware of the module option: they'll just
> > > know that their card doesn't work right.
> >
> > This isn't a card problem this is a monitor problem, the card just
> > passes through the edid data from the monitor... or else the
> > programming of the card registers from edid is wrong..
>
> In which case the same problem would occur with different video cards, so
> this patch should be some generic thing, available to all drivers, no?
>

It should be in the fb layer not card specific.. as it may happen on any card...

Dave.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
