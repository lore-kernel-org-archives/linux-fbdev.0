From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: URGENT: status of atyfb
Date: Mon, 02 Aug 2004 13:31:37 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1091417497.7393.63.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrTas-0006Xf-H0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Aug 2004 20:34:34 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BrTas-00060H-48
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Aug 2004 20:34:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i723W0HR018144
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 1 Aug 2004 22:32:01 -0500
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi !

I'm having more and more pain with atyfb at this point. I really need
the changes that bring the pci_driver (and new PM callbacks) so I can
properly work on these. 

However, bringing just that change from the fbdev tree to the main tree
is incredibly painful due to the major amount of changes that went into
this driver.

So can somebody show up and tell me what is the status of this driver as
it is currently in the fbdev-2.5 bk tree and if that stuff can actually
be sent upstream ASAP or not ?

I don't feel like re-doing just the pci_driver changes, did it once, was
painful enough, but on the other hand, this driver has been drifting
away from mainstream for ages, which is simply not acceptable.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
