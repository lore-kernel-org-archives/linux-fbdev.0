From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Building fbtest impossible
Date: Mon, 30 Aug 2004 22:28:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41338DD3.26D693AA@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1slB-0003vW-4b
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 13:28:13 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1sl9-0007D5-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 13:28:12 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 30 Aug 2004 22:33:07 +0200
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
To: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>

The fbtest app can't be build, I always gets the following errors:

ld -r -o tests.o test001.o test002.o test003.o test004.o test005.o
test006.o test007.o test008.o test009.o test010.o
make[1]: Leaving directory `/usr/src/Devel/fbtest/tests'
pnmtohex.c:17:17: pnm.h: No such file or directory
make[1]: *** [.depend] Error 1
/bin/sh: line 1: ../pnmtohex/pnmtohex: No such file or directory
make[1]: *** [penguin.c] Error 127
make: *** No rule to make target `images/images.o', needed by `fbtest'.  Stop.

Where is pnm.h?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
