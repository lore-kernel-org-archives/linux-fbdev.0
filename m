From: Andrew Morton <akpm@osdl.org>
Subject: missing savagefb symbols
Date: Tue, 26 Oct 2004 02:11:00 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041026021100.0d984515.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMNO1-00022k-Ox
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 02:13:01 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMNO0-0008CP-RQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 02:13:01 -0700
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
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

From `make allmodconfig'

*** Warning: "savagefb_delete_i2c_busses" [drivers/video/savage/savagefb.ko] undefined!
*** Warning: "savagefb_probe_i2c_connector" [drivers/video/savage/savagefb.ko] undefined!
*** Warning: "savagefb_create_i2c_busses" [drivers/video/savage/savagefb.ko] undefined!
*** Warning: "savagefb_sync" [drivers/video/savage/savagefb.ko] undefined!
*** Warning: "savagefb_imageblit" [drivers/video/savage/savagefb.ko] undefined!
*** Warning: "savagefb_copyarea" [drivers/video/savage/savagefb.ko] undefined!
*** Warning: "savagefb_fillrect" [drivers/video/savage/savagefb.ko] undefined!

Maybe doing an EXPORT_SYMBOL will fix this.  Or we need to link those
objects together into a single .ko - your call.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
