From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: speaking of copy_*_user() (fwd)
Date: Wed, 25 Aug 2004 10:28:11 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408251027380.18759@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bzt8l-00010O-QP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Aug 2004 01:28:19 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bzt8k-0002tI-3K
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 Aug 2004 01:28:19 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "David S. Miller" <davem@redhat.com>

---------- Forwarded message ----------
Date: Tue, 24 Aug 2004 21:46:59 -0700
From: David S. Miller <davem@redhat.com>
To: <DELETED>
Subject: speaking of copy_*_user()


I just noticed that fb_{read,write}() uses copy_*_user() with
the kernel buffer being the frame buffer.  It needs to use
the proper device address accessor functions.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
