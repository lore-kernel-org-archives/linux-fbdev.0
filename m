From: Christian Schoenebeck <cuse@users.sourceforge.net>
Subject: Re: deferred IO
Date: Fri, 6 Jun 2008 12:51:26 +0200
Message-ID: <200806061251.26134.cuse@users.sourceforge.net>
References: <200806061134.13496.cuse@users.sourceforge.net>
	<45a44e480806060240j44887451q12c47595ca76df27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4ZYW-0001eK-Cc for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 03:52:25 -0700
Received: from dns1.rz.hs-heilbronn.de ([141.7.1.18])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4ZYU-0000xv-KA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 03:52:24 -0700
In-Reply-To: <45a44e480806060240j44887451q12c47595ca76df27@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Es geschah am Friday 06 June 2008 als Jaya Kumar schrieb:
> On Fri, Jun 6, 2008 at 2:34 AM, Christian Schoenebeck
>
> <cuse@users.sourceforge.net> wrote:
> > Hi!
> >
> > Is it possible that the deferred IO implementation in kernel 2.6.22 is
> > buggy?
>
> Yes, that's possible. There was a key bug fixed in 2.6.25. You'll
> probably want at least the following commit:
>
> commit	de7c6d15e354bc94a846f03749819768c331280a
> fbdev: defio and Metronomefb

Very good, thanks a lot!
Is there an easy way to retrieve that specific patch?

CU
Christian

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
