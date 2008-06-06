From: Christian Schoenebeck <cuse@users.sourceforge.net>
Subject: deferred IO
Date: Fri, 6 Jun 2008 11:34:13 +0200
Message-ID: <200806061134.13496.cuse@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4YLn-0001Bg-FJ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 02:35:17 -0700
Received: from dns1.rz.hs-heilbronn.de ([141.7.1.18])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4YLj-00080j-N3
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 02:35:09 -0700
Received: from fry.software-engineering.org ([141.7.66.13])
	by dns1.rz.hs-heilbronn.de (8.14.1/8.14.1) with ESMTP id m569YxYA025265
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 6 Jun 2008 11:34:59 +0200 (CEST)
Received: from trinity.local (unknown [193.238.222.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fry.software-engineering.org (Postfix) with ESMTP id AFE6F49204
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  6 Jun 2008 13:33:47 +0200 (CEST)
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

Hi!

Is it possible that the deferred IO implementation in kernel 2.6.22 is buggy? 
Or do I probably misunderstand the overall concept of the FB deferred IO 
mechanism?

I wrote a framebuffer driver for a LCD which is connected via USB. As the 
video memory of the LCD is not physically available to the system (thus not 
IO memory mapped) I registered a FB deferred IO calllback function which 
performs the job of sending the new screen information via USB to the LCD 
whenever someone modified the framebuffer memory.

Unfortunately this deferred IO callback function is only called once per 
process lifetime and not (as I expected it to be) each time the framebuffer 
is actually modified.

I implemented a proc file where I could actually see the framebuffer content 
at any time and placed a:

	printk(KERN_INFO "cuselcdfb_display_update %d\n", ++i);

line in the deferred io callback to see when and how often the deferred IO 
callback function is called. So I could check that a process actually wrote 
to the framebuffer, but the callback would only be triggered once.

Any clues?

Thanks for any comments!

CU
Christian

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
