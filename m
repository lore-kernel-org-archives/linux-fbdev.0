From: Jim Hague <jim.hague@acm.org>
Subject: Soft cursor woes (?) in fbdev-2.5
Date: Thu, 02 Oct 2003 00:03:58 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20031002000358.jim.hague@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A5ODX-0007eb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Oct 2003 04:35:27 -0700
Received: from mta07-svc.ntlworld.com ([62.253.162.47])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A5ODW-00027v-Nv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Oct 2003 04:35:26 -0700
Received: from fluffy.bear-cave.org.uk ([81.103.192.171])
          by mta02-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20031001230359.TJX16630.mta02-svc.ntlworld.com@fluffy.bear-cave.org.uk>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Thu, 2 Oct 2003 00:03:59 +0100
Received: from hagrid ([192.168.1.1] helo=hagrid.bear-cave.org.uk)
	by fluffy.bear-cave.org.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1A4q0k-0007Tg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 02 Oct 2003 00:03:58 +0100
Received: from jim by hagrid.bear-cave.org.uk with local (Exim 3.36 #1 (Debian))
	id 1A4q0k-0000Eh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 02 Oct 2003 00:03:58 +0100
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

Hope I haven't missed a discussion of this....

I've been trying the current fbdev-2.5 tree, and am getting a corrupted console
display on pm2fb. The display is fine in stock 2.6.0-test6 with the same driver.

The symptoms are missing characters and characters replaced by underlined
blanks. Something like this

Starting NTP server: ntpd.

becomes

 art_ng_N_P  erv_r: _tpd.________________________________________________

The block cursor is present, but not flashing. Well, not quite - the bottom few
lines of the cursor (corresponding to the surplus _) are flashing.

I'm wondering if it's the updated soft cursor code (i.e. I'm hoping it isn't
the fault of my driver :-)).

Q1: Does any other driver that uses the soft cursor routines exhibit similar?
Graphics mode is 1280x1024@74, depth 8, FWIW.

Q2: Any other suggestions?

Ta.

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
