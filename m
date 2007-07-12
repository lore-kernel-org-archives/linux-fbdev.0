From: Randy Dunlap <rdunlap@xenotime.net>
Subject: logos work/apply when?
Date: Thu, 12 Jul 2007 13:08:22 -0700
Message-ID: <20070712130822.a8269fe0.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I94tt-00047p-D1 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 13:04:33 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I94tr-0001SU-JC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 13:04:33 -0700
Received: from midway.site ([71.117.236.25]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 13:04:28 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

Is there some kernel config or video config (possibly set at boot time
via vga=xyz or video=wxy) where one or more of the logos is not
applicable?  or the other way:  are there certain kernel or video
configs where only certain logos are applicable?


I've tested vesafb with LOGO_LINUX_VGA16 but I can't see the logo.
I do see an empty space for it at the top of the screen area, however.
(booting with vga=0x317 in /etc/lilo.conf file)

When I use LOGO_LINUX_CLUT224 instead, I do see the logo.

or when I use FB_VGA16 instead of vesafb and also use LOGO_LINUX_VGA16,
I can see the logo.

I'm just trying to understand when/why I should expect (or not expect)
to see a logo (if it is enabled).

Thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
