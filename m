From: "Manoj Sharma" <manoj.sharma@wipro.com>
Subject: video mode selection for monochrome
Date: Thu, 27 Jun 2002 10:59:12 +0530 (IST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206241658280.11784-100000@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from wiprom2mx1.wipro.com ([203.197.164.41])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17NRyb-0008IZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Jun 2002 22:37:53 -0700
Received: from m2vwall5.wipro.com (m2vwall5.wipro.com [10.115.50.5])
	by wiprom2mx1.wipro.com (8.11.3/8.11.3) with SMTP id g5R5bbe00833
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Jun 2002 11:07:37 +0530 (IST)
Received: from kaveri.wipro.com ([192.6.8.155]) by
          ec2mail.mail.wipro.com (Netscape Messaging Server 4.15) with
          ESMTP id GYCNM200.KVW for
          <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Jun 2002
          11:07:17 +0530 
Received: from localhost (manoj.sharma@localhost)
	by kaveri.wipro.com (8.11.6/8.11.2) with ESMTP id g5R5TDO02962
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Jun 2002 10:59:13 +0530
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I am trying to use framebuffer with a monochrome display (1bpp).  I need
to specify a suitable video mode at the boot time. I tried to use 'scan'
on the video mode prompt but didn't find anything for the monochrome.  
There is vesa mode for 640x480x8, Is there anything for 640x480x1 ?

The video card is S3 Trio 3D/2X.

Thanks,
Manoj.





-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
