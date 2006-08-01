From: Richard Wolf <rwolf@cardaccess.com.au>
Subject: Driver for Sharp LH155BA
Date: Tue, 1 Aug 2006 10:31:47 +1000
Message-ID: <170385E48B041543AC99CCD09E325AD1952BB0@mail.rogermanagement.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7htx-0006KC-HN for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 17:14:26 -0700
Received: from mail1.cardaccess.com.au ([203.166.87.76])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7htu-0001C8-Gv
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 17:14:25 -0700
Received: from MAIL.cardaccess.com.au (unknown [203.41.80.28])
	by mail1.cardaccess.com.au (Postfix) with ESMTP id C839DD349E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Aug 2006 10:13:57 +1000 (EST)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I'm writing a driver for the Sharp LH155BA LCD driver.  This is a driver
designed for controlling small/medium lcd panels (up to 128 x 64 pixels).  

I'm trying to decide whether it is sensible to write a frame buffer driver
for a device of this nature.  Does the frame buffer abstraction make sense
for a display this small?  

On our target hardware it is not possible to access the display memory
directly.  Rather, all accesses to display memory and other control
registers are through a small number of io ports.  Therefore it is not
possible to map display memory.  Is this relevant?  

Thank you for your help.

Regards,

Richard Wolf
Card Access Services Pty Ltd
Level 2, 7-9 Albany Street
Crows Nest  NSW  2065
Phone: +612 9906 7209
Fax: +612 9906 7218
www.cardaccess.com.au

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
