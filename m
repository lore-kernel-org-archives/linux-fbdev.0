From: Miernik <miernik@ctnet.pl>
Subject: wierd neofb framebuffer problem, blank screen if no CD drive
Date: Tue, 12 Oct 2004 08:53:18 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041017131312.3ACA.0.NOFFLE@localhost.localdomain.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJBFi-0003HF-6V
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 06:39:14 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJBFi-0002tz-23
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 06:39:14 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CJBFf-0007DQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 15:39:11 +0200
Received: from 82.160.30.99 ([82.160.30.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 15:39:11 +0200
Received: from miernik by 82.160.30.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 15:39:11 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-fbdev-users@lists.sourceforge.net

Up till today everything was OK. Today I upgraded kernel from 2.6.8-3 to
2.6.8-4 Debian revision.

And I always started my laptop wth vga=303 parameter to get 800x600
screen, instead of the ugly emulated 640x480 (LCD physical resolution is
800x600).

This loaded vesafb framebuffer. After this upgrade, a few seconds
after GRUB boots, and the vesafb is activated, the screen goes blank,
and laptop doesn't continue the boot (the HDD led doesn't light)
If I remove vga=303, it boots normally.

Then: I downgraded the kernel back to 2.6.8-3, but it didn't help!

And one more interesting thing: I have a bay where I can put in a
CD-ROM, a floppy or a battery.

And if the CD-drive is in the bay (may be without any CD), it boots OK
even with the vga=303 800x500 framebuffer.

any ideas?

-- 
Miernik             _________________________  xmpp:miernik@amessage.info
___________________/_______________________/      mailto:miernik@ffii.org
Why software shouldn't be covered by patents
http://bladeenc.mp3.no/articles/software_patents.html



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
