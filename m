From: Panagiotis Papadakos <papadako@csd.uoc.gr>
Subject: Mobility X700 and radeonfb.
Date: Tue, 8 Nov 2005 18:15:53 +0200
Message-ID: <200511081815.54018.papadako@csd.uoc.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZW83-0005sf-Bs
	for Linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Nov 2005 08:15:23 -0800
Received: from tenar.csd.uoc.gr ([147.52.16.3])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZW7u-0004JP-9y
	for Linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Nov 2005 08:15:20 -0800
Received: from [147.52.19.178] ([147.52.19.178])
	by tenar.csd.uoc.gr (8.12.10/8.12.10) with ESMTP id jA8GEBjf027615
	for <Linux-fbdev-devel@lists.sourceforge.net>; Tue, 8 Nov 2005 18:14:11 +0200 (EET)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux-fbdev-devel@lists.sourceforge.net

I am trying to make my radeon X700 mobility work with the radeonfb driver.
I added the pci id in ati_ids.h and modified appropriately radeon_base.c but
all I got was a blank screen. Could anyone help me with this?
Any pointers where I should look to get it working (radeon from X.org?)

Thank you.
-- 
Papadakos Panagiotis


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
