From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Problem with radeon new ROM probe code
Date: Wed, 24 Sep 2003 14:06:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064405197.15996.44.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A28QX-0007xV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 05:07:25 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A28QW-0007yy-82
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Sep 2003 05:07:24 -0700
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Jon !

Your new code for looking at the card's ROM is causing a problem for
me. On some cards, typically the "Mac" cards, the ROM doesn't contain
an x86 BIOS, but rather an OF driver. The current code will blindly
tap that, though it contains none of the expected tables, and will
use completely wrong values.

Do you have ideas how to make some sanity checking on the ROM content ?

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
