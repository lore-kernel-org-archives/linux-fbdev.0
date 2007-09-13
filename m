From: Timur Tabi <timur@freescale.com>
Subject: Best way to support mulitple planes?
Date: Thu, 13 Sep 2007 14:50:54 -0500
Message-ID: <46E9949E.30908@freescale.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVuiS-0000s8-4N for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 12:51:10 -0700
Received: from de01egw02.freescale.net ([192.88.165.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVuiQ-0007p3-NU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Sep 2007 12:51:08 -0700
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8DJotUv021120 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Sep 2007 12:50:55 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l8DJosXe002208
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Sep 2007 14:50:54 -0500 (CDT)
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

Hi, I'm new to the framebuffer subsystem, so forgive me if this is a FAQ. 
I've spent the past couple hours scouring web sites and sample code, but I 
don't have a definitive answer to my question.

I have a device that supports three planes - memory areas that the hardware 
reads from to generate the physical image.  Each plane supports an alpha 
channel for each pixel, and the hardware just blends all three planes together 
when it draws the image.

Currently, our driver create three framebuffer devices, /dev/fb0, /dev/fb1, 
and /dev/fb2, which means three calls to register_framebuffer().  Is this the 
correct way to do it?

The reason I ask is that our hardware can only handle three planes if the 
resolution is 1024x768 or below.  I can't figure out any way of telling the 
framebuffer subsystem that if it switches to 1280x1024 in plane 0, that plane 
1 and 2 no longer exist.  Any suggestions on how to handle that?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
