From: "Hans J. Koch" <hjk@linutronix.de>
Subject: fb driver for 6963 Dot Matrix LCD controller
Date: Tue, 17 Jun 2008 12:49:43 +0200
Message-ID: <20080617104942.GA2231@local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K8YlB-0003gH-Vs for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 03:49:58 -0700
Received: from www.tglx.de ([62.245.132.106])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K8YlA-0007wy-Cw
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Jun 2008 03:49:57 -0700
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
Cc: Manuel Traut <manut@linutronix.de>

Hi,
I need a driver for a primitive dot matrix LCD using a Toshiba T6963CFG
controller. These displays usually have low resolutions, e.g. 240x64. A
driver could be implemented by allocating a framebuffer in kernel
memory, and copy its contents to the LCD every 100ms or so in a timer
routine.

Before I start writing such a thing I'd like to ask if somebody already
wrote something similar?

Any other hints?

Thanks,
Hans


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
