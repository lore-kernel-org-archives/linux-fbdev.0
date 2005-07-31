From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: bugzilla bugs 4312, 4386
Date: Sun, 31 Jul 2005 12:33:28 +0200
Message-ID: <42ECA8F8.5020803@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzB76-0004S7-U3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 03:32:12 -0700
Received: from mailout03.sul.t-online.com ([194.25.134.81])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DzB75-0001Q8-IK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 31 Jul 2005 03:32:12 -0700
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Both bugs are solved with my cyblafb driver.

As these bugs might also be present on other chips (most likely they 
are!)  some comments:

Bug #4312

Most important is CRTC register 2f, signal quality is also improved for 
higher vclk values
by changing set_vclk() according to the X drivers and cyblafb.c

bug # 4386

Acceleration is broken for all BLADE 3D chips for all versions of kernel 
2.6 except
for 32bit modes. Most important reason is that the u32 col parameter of 
the graphics
engine needs the color value replicated to all u8 of the u32 (8bit 
modes) and
to both u16 of the u32.

cu,
 Knut


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
