From: James Simmons <jsimmons@infradead.org>
Subject: patch review
Date: Fri, 17 Nov 2006 18:45:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611171840230.32200@pentafluge.infradead.org>
References: <200611162312.kAGNCLgn010867@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gl8iR-0000fu-IK for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:45:31 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gl8iR-0000XI-2c
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 10:45:31 -0800
In-Reply-To: <200611162312.kAGNCLgn010867@shell0.pdx.osdl.net>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I have been reviewing and testing your patches. I haven't tested them all 
tho. I have tested:

annotate-some-variables-in-vesafb.patch
fbcmapc-mark-structs-const-or.patch
gregkh-driver-fb-device.patch
ioremap-balanced-with-iounmap-for-drivers-video-vesafb.patch
various-fbdev-files-mark-structs-fix.patch
various-fbdev-files-mark-structs.patch

I had no problem with them. I will test the atyfb patches tomorrow.
Please drop the 

fbmem-is-bootup-logo-broken-for-monochrome-lcd.patch

It does address several problems but there are more problmes then that. I 
like to send out another patch to would address all those issues.
Thanks.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
