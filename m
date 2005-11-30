From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: atyfb & lockups
Date: Wed, 30 Nov 2005 16:51:44 +1100
Message-ID: <1133329905.16726.69.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhKyp-00089r-8H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 21:58:11 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EhKyo-0006KF-2h
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 21:58:11 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id jAU5soWG031968
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 23:54:51 -0600
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

I have an old PowerBook Wallstreet I here with a Rage LT-G. I've been
booting it from Open Firmware instead of MacOS lately (thus didn't give
a chance to the MacOS driver to do it's own tweaking of the chip) and
the machine has been reliably locking up on me. Solid lockups. I finally
figured out that the lockups appear to be atyfb related and that booting
with video=atyfb:noaccel fixes it.

It seems that when it's lockup, the whole machine is down, that is it
won't take interrupts to get to the xmon low level debugger nor
anything, thus I suspect the PCI is locked up.

Are there any ideas of where to look for the source of the problem ?

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
