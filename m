From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Unifying radeon.h constant files
Date: Sun, 31 Aug 2003 22:25:43 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030901052543.31422.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19thCB-0006fo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 31 Aug 2003 22:25:43 -0700
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19thCB-0001yf-Df
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Aug 2003 22:25:43 -0700
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos <kronos@kronoz.cjb.net>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

What do you think about getting rid of include/video/radeon.h and replacing it
with the much more comprehensive one from XFree86? It would make life easier if
constants had the same names in the kernel and XFree86 code. radeonfb would
need to be touched up for about 100 name changes. 

char/drm/radeon_drv.h has a third set of names but that is up to the DRI people
to fix. If we can get radeonfb and 2D XFree on the same set of names I'll see
if I can get the 3D people to go along.

If this works for Radeon we should do it for Rage128 too.

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
