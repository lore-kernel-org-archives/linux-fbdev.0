From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: kbuild
Date: Thu, 23 Sep 2004 18:48:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4152FE4A.732A42BB@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAWlb-0007Rr-If
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 09:48:23 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CAWla-0006Gq-L8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 09:48:23 -0700
Received: from orpatec.ch (80.218.105.53)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Sep 2004 18:53:39 +0200
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

IMO kbuild makes it easy to test new framebuffer drivers by anyone. So
I've started to document the tester's part on the web
"http://linux-fvdev.sourceforge.net/index.php?page=kbuilddocs.html". Now
it would be nice if someone could create a correct Makefile for a
framebuffer (preferable radeonfb) and send it to me, so I can put it
into the linux-fbdev CVS.

I first like to put up a sample so all framebuffer drivers have about
the same structure. Afterwards any maintainer may decide if he wants to
get write access to the CVS for his driver. It doesn't necessarily need
to be the official maintainer but they have precedence.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
