From: Richard Wolf <rwolf@cardaccess.com.au>
Subject: cfb_fillrect and friends undefined
Date: Thu, 3 Aug 2006 12:39:33 +1000
Message-ID: <170385E48B041543AC99CCD09E325AD1AC54B4@mail.elevenonline.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8Sqi-0001KO-P6 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 19:22:12 -0700
Received: from [203.166.87.76] (helo=mail1.cardaccess.com.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G8Sqh-0002HQ-Aj
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 19:22:12 -0700
Received: from MAIL.cardaccess.com.au (mail.rogermanagement.com.au
	[203.41.80.28])
	by mail1.cardaccess.com.au (Postfix) with ESMTP id 6F434D33C8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  3 Aug 2006 12:21:22 +1000 (EST)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I'm trying to write a frame buffer driver, basing it on the vfb virtual
driver.  When I try to load the module I get an error message:

lh155ba: Unknown symbol platform_driver_unregister
lh155ba: Unknown symbol cfb_copyarea
lh155ba: Unknown symbol platform_device_register
lh155ba: Unknown symbol platform_driver_register
lh155ba: Unknown symbol platform_device_unregister
lh155ba: Unknown symbol cfb_imageblit
lh155ba: Unknown symbol cfb_fillrect

I can't work out what config options to enable to define these symbols.  I
can get cfb_* to appear by selecting the vfb driver, but I don't want that
driver, just the cfb_* functions.  Any help?

Thanks,

Richard Wolf
Card Access Services Pty Ltd
Level 2, 7-9 Albany Street
Crows Nest  NSW  2065
Phone: +612 9906 7209
Fax: +612 9906 7218
www.cardaccess.com.au

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
