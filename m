From: James Simmons <jsimmons@infradead.org>
Subject: Re: ACPI output/lcd/auxdisplay mess
Date: Wed, 15 Nov 2006 00:54:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk93K-00019E-00 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 16:54:59 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gk93I-0002QT-Ls
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 16:54:58 -0800
In-Reply-To: <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
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
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: Luming Yu <Luming.yu@intel.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Zabolotny <zap@homelink.ru>, Jamey Hicks <jamey.hicks@hp.com>


> Well, we were aware of video/backlight/* (read below). Anyway,
> auxdisplay doesn't create a class; it did in first versions, but right
> now it behaves just like a framebuffer, no classes in the playground
> (maybe you read a old version?).
...
> However, auxdisplay means "auxiliary display device drivers", not _the
> display_. In such folder we can put every
> auxiliar-optional-secundary-rare display (not just LCDs, framebuffers,
> ...) who has special requirements (like parport wiring, fixed refresh
> rate, different properties...). Also, things like "set_contrast",
> "max_constrast", "set_power"... didn't seem very appropriate.

Is it a framebuffer device ? The framebuffer layer is abstracted to work 
with such devices.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
