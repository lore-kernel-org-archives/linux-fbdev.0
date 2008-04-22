From: Christian Schoenebeck <cuse@users.sourceforge.net>
Subject: basic FB development questions
Date: Wed, 23 Apr 2008 00:50:30 +0200
Message-ID: <200804230050.31349.cuse@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoRK1-0003tp-CZ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:50:45 -0700
Received: from dns1.rz.hs-heilbronn.de ([141.7.1.18])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JoRJz-0004ek-Ji
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 22 Apr 2008 15:50:45 -0700
Received: from fry.software-engineering.org ([141.7.66.13])
	by dns1.rz.hs-heilbronn.de (8.14.1/8.14.1) with ESMTP id m3MMoaTh011693
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 00:50:36 +0200 (CEST)
Received: from host391.homenet.telecomitalia.it
	(host2-28-static.38-79-b.business.telecomitalia.it [79.38.28.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fry.software-engineering.org (Postfix) with ESMTP id 77FAC487A8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 00:41:14 +0200 (CEST)
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

I'm currently writing a Linux FB driver for an USB LCD. I've written Linux 
drivers before, but not a FB driver yet, so I hope you can help me with some 
basic FB development questions.

First of all, AFAIK most FB drivers are based upon memory mapped IO, right? 
But in my case the graphics are forwarded via calls of Linux's USB subsystem. 
Which FB approach would suggest in this case? Something like the virtual 
framebuffer driver with some kind of static allocated buffer? If yes, what 
kind of function would I have to implement to trigger the screen sync between 
that modified buffer and the hardware (that is sending the buffer's data via 
USB to the device)? Or should I implement mmap? I mean: I know everything 
about the USB side to recognize the device and sending data etc., I just 
don't know how to establish a FB callback or something to "flush" the 
suggested graphics buffer.

In the "fb_var_screeninfo" struct there are the following members which I'm 
not sure about their precise purpose:

	* "pixclock": is that the average speed (in ps) with which one pixel of the
	  screen is changed?

	* "left_margin", "right_margin", "upper_margin", "lower_margin":
	  I'm confused about these members, I first thought that would be some kind
	  of reference margin (in pixels), but the header file says those are timing
	  values?

	* "hsync_len", "vsync_len":
	  what's that exactly and is it a timing or pixel value?

If there are basic docs about FB terms etc, please let me know!

Thanks for any help!

CU
Christian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
