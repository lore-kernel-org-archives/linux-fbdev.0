From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/13] vt: printk: Fix framebuffer
 console triggering might_sleep assertion
Date: Mon, 31 Jul 2006 23:51:00 -0700
Message-ID: <20060731235100.9f792539.akpm@osdl.org>
References: <44CE9108.1030606@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7o5o-00049D-Cr for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 23:51:04 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1G7o5o-00038K-3w
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 23:51:04 -0700
In-Reply-To: <44CE9108.1030606@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


hm, which (if any) of these would be considered 2.6.18 material?

*vt-printk-fix-framebuffer-console-triggering-might_sleep.patch
*au1100fb-info-varrotate-fix.patch
 au1100fb-add-option-to-enable-disable-the-cursor.patch
*au1100fb-fix-startup-sequence.patch
 intelfb-documentation-update.patch
 rivafb-use-constants-instead-of-magic-values.patch
 vfb-document-option-to-enable-the-driver.patch
 fbdev-add-generic-ddc-read-functionality.patch
 nvidiafb-use-generic-ddc-reading.patch
 rivafb-use-generic-ddc-reading.patch
 i810fb-use-generic-ddc-reading.patch
 savagefb-use-generic-ddc-reading.patch
 radeonfb-use-generic-ddc-reading.patch

I've asterisked my guesses.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
