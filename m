From: "Cheshire Cat Fish" <cat_fish@hotmail.com>
Subject: Multiple instances of my adapter.
Date: Wed, 07 May 2003 11:14:18 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F36rcR4ZDgC81000043f5@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from f36.law15.hotmail.com ([64.4.23.36] helo=hotmail.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DTQx-0003PF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 11:14:27 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net



how should my driver behave when I put two of my cards in the system.  I 
want one card to become/dev/fb0 and one to become /dev/fb1 (I think).

Do I need to call register_framebuffer multiple times?  insmod wouldn't let 
me load my driver twice, so it seems i must handle all cards in the system 
in a single pass through the driver?

Also, once I get both cards working, one on fb0 and one on fb1, can I run X 
on both simultaneously (dual display) using the X fbdev driver?


Thanks,
Noel.
--
A precariously balanced mixture of myopic optimism and rampant paranoia.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
