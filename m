From: Jim Hague <jim.hague@acm.org>
Subject: New API pm2fb driver
Date: Sun, 21 Sep 2003 22:44:00 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030921224400.jim.hague@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1Cfx-0000wC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 15:27:29 -0700
Received: from mta05-svc.ntlworld.com ([62.253.162.45])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1Cfw-0007YI-AD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 15:27:28 -0700
Received: from fluffy.bear-cave.org.uk ([81.103.192.171])
          by mta05-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20030921214437.OGER13360.mta05-svc.ntlworld.com@fluffy.bear-cave.org.uk>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Sun, 21 Sep 2003 22:44:37 +0100
Received: from hagrid ([192.168.1.1] helo=hagrid.bear-cave.org.uk)
	by fluffy.bear-cave.org.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1A1Bzs-0005CS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 22:44:00 +0100
Received: from jim by hagrid.bear-cave.org.uk with local (Exim 3.36 #1 (Debian))
	id 1A1Bzs-0002PW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 22:44:00 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net

First crack at this - as a patch against 2.6.0-test5 - is at
http://www.bear-cave.org.uk/linux/pm2fb/pm2fb-2.6.patch.gz.

Currently the driver only supports 'Generic PCI' cards on x86; that's the only
hardware (Graphics Blaster Exxtreme) I have access to. It is also unaccelerated.
I've been using it for a week in conjunction with the XFree Glint driver (via
UseFBDev) and it seems to work but has received only the most cursory testing.

All reviews/advice/bug reports/etc. welcome.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
