From: Christian Schoenebeck <cuse@users.sourceforge.net>
Subject: Re: basic FB development questions
Date: Wed, 23 Apr 2008 13:41:44 +0200
Message-ID: <200804231341.44720.cuse@users.sourceforge.net>
References: <200804230050.31349.cuse@users.sourceforge.net>
	<Pine.LNX.4.64.0804231058370.15290@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JodMV-00013G-L2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 04:42:07 -0700
Received: from dns1.rz.hs-heilbronn.de ([141.7.1.18])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JodMT-0005xV-T1
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 04:42:07 -0700
Received: from fry.software-engineering.org ([141.7.66.13])
	by dns1.rz.hs-heilbronn.de (8.14.1/8.14.1) with ESMTP id m3NBfrHx029193
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 13:41:57 +0200 (CEST)
Received: from host391.homenet.telecomitalia.it
	(host2-28-static.38-79-b.business.telecomitalia.it [79.38.28.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fry.software-engineering.org (Postfix) with ESMTP id 7C008487A8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 13:32:29 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0804231058370.15290@anakin>
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

Es geschah am Wednesday, 23. April 2008 11:01 als Geert Uytterhoeven schrieb:
> On Wed, 23 Apr 2008, Christian Schoenebeck wrote:
> > First of all, AFAIK most FB drivers are based upon memory mapped IO,
> > right? But in my case the graphics are forwarded via calls of Linux's USB
> > subsystem. Which FB approach would suggest in this case? Something like
> > the virtual framebuffer driver with some kind of static allocated buffer?
> > If yes, what kind of function would I have to implement to trigger the
> > screen sync between that modified buffer and the hardware (that is
> > sending the buffer's data via USB to the device)? Or should I implement
> > mmap? I mean: I know everything about the USB side to recognize the
> > device and sending data etc., I just don't know how to establish a FB
> > callback or something to "flush" the suggested graphics buffer.
>
> Documentation/fb/deferred_io.txt

Ah, that's a good one!

Seems the "hecubafb" driver is a very good candidate for stealing code for 
that USB LCD FB driver.

Thanks a lot Geert!

CU
Christian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
