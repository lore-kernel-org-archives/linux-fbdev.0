From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Add three new IOCTLs to FB API
Date: Sun, 21 Sep 2003 22:28:38 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1JFX-0006IZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Sep 2003 22:28:39 -0700
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1JFX-0003te-1W
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Sep 2003 22:28:39 -0700
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
Content-Transfer-Encoding: 7bit
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

I'd like to add three new IOCTLs to the FB API to help support standalone Mesa.
The idea is to eliminate the need for config files. Xfree might even use these
in the future.

In order to load DRM 3D support I need two pieces of information. The name of
the 3D DRM driver and the bus:dev:func of the hardware. DRM does not implement
PCI ID probing, instead you need to it what hardware to use. 

By adding these to the FB API you can start standalone Mesa just by specifying
the name of the FB device to use. I can pick up mode and resolution from the
existing FB API.

1) Get location of card that is associated with this fb device. It would return
bus,dev,func of hardware. There may be more than one piece of the same hardware
installed.

3) Get vendor and card PCI ID

2) Get 3D driver name. Return the name of the DRM driver that is associated
with this fb device. For example aty128fb would return r128, radeonfb would
return radeon. Empty string if there is none. There are eight DRM drivers and
15 fb ones.

The functions are trivial to implement but implementing them will require
touching all of the fbdev files.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
