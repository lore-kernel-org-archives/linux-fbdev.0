From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: No tux in 24 and 32 bits?
Date: Thu, 4 Sep 2003 22:22:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030904202252.GA13496@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v0eU-0003A4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 13:24:22 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19v0eT-0001c4-UM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Sep 2003 13:24:22 -0700
Received: from www.zensonic.dk (localhost [127.0.0.1])
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) with ESMTP id h84KMqba013801
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 4 Sep 2003 22:22:52 +0200
Received: (from zensonic@localhost)
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) id h84KMqQI013799
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 4 Sep 2003 22:22:52 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi There

During development of a new driver I found that tux is not drawn upon
boot of the kernel if I boot into a 24 or 32 bpp framebuffer
(truecolor, packed pixels) and use the software accelerated routines.

First I thought that I might have done something wrong, but then I
tried the aty128 driver on a ATI Rage 128 card and the same thing
happened.

I now know that my driver behaves like it should, but would anybody
care to explain why it is so? Skimming the logo setup code I see code
for handling truecolor modes and setting up pseudopalettes and stuff,
so I can not see any reasons for it not to be working.

Regards Thomas, Denmark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
