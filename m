From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: help with consolupdate on modechange in driver
Date: Mon, 22 Sep 2003 12:35:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922103546.GA6398@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1O40-0000Io-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 03:37:04 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1O3z-0003zX-Eo
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 03:37:03 -0700
Received: from www.zensonic.dk (localhost [127.0.0.1])
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) with ESMTP id h8MAZkkc006585
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 12:35:46 +0200
Received: (from zensonic@localhost)
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.4) id h8MAZkXk006583
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 12:35:46 +0200
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

Hi

I have just implemented modechange in my driver and while it
works, the consol *still* thinks we working in the old mode.

How do I inform the console layer that the driver (through fbset)
have changed the actual mode on the screen?

Regards Thomas, Denmark


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
