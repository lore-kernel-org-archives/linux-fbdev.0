From: Steven Newbury <steven.newbury1@ntlworld.com>
Subject: atyfb and radeonfb
Date: Fri, 08 Nov 2002 15:28:04 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DCBD804.8050109@ntlworld.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mta03-svc.ntlworld.com ([62.253.162.43])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18AB3A-0007Lb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 08 Nov 2002 07:28:00 -0800
Received: from nucleus.subatomic.net ([62.253.56.29])
          by mta03-svc.ntlworld.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021108152752.MPDK20191.mta03-svc.ntlworld.com@nucleus.subatomic.net>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Fri, 8 Nov 2002 15:27:52 +0000
Received: from ntlworld.com (nucleus.subatomic.net [127.0.0.1])
	by nucleus.subatomic.net (8.12.5/8.12.5) with ESMTP id gA8FS4HJ013073
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 8 Nov 2002 15:28:05 GMT
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Is atyfb in 2.4 known to work with recent Mach64 chips like Rage XL? 
When I install the driver it detects the chip but results in just a 
black screen.  I also noticed that it detects WRAM, whereas I am certain 
it should be SGRAM.  The XFree86 driver detects everything ok and just 
works.

I have also noticed that the radeonfb driver lacks support for 
initialising the card if the BIOS hasn't already done it.  I have 
recently changed from a matrox setup where the matroxfb driver would 
initialise any matrox cards found irrespective of whether the BIOS 
decided to do it unless it was told not to.  Is there any chance that 
this functionality is going to be added to the radeonfb driver?  In 
2.5/6 perhaps?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
