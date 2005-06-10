From: Jurriaan <thunder7@xs4all.nl>
Subject: new framebuffer fonts + updated 12x22 font available
Date: Fri, 10 Jun 2005 15:23:31 +0200
Message-ID: <20050610132331.GA8643@middle.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgjU5-00028c-25
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 06:23:41 -0700
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgjU2-0000ev-D3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 06:23:40 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr7.xs4all.nl (8.13.3/8.13.3) with ESMTP id j5ADNXXB083137
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jun 2005 15:23:33 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

I've spent my offline-vacation on improving the fonts for use with the
framebuffer.

I've added all the characters marked 'FIXME' in the sun12x22 font and
created a 10x18 font (based on the sun12x22 font) and a 7x14 font (based
on the vga8x16 font).

The total patch is about 300 KiB, so I won't attach it here. 

As maintainership of the fonts is unknown to me, I'm posting this to
lkml, fb-devel, Andrew and some choice fb developers.

This patch is non-intrusive, no options are enabled by default so most
users won't notice a thing.

I am placing my changes under the GPL, however, I've not seen any
copyright notices on the sun12x22 font and the vga8x16 font which I
derived my new fonts from so I don't know what the copyright status is.

The patch is available at

http://www.xs4all.nl/~thunder7/fonts_7x14_10x18_12x22.diff

I would appreciate inclusion, of course, or constructive comments.

Thanks,
Jurriaan
-- 
It was not a compliment, but there was praise in it, if one knew how to look.
	Michelle West - Sea of Sorrows
Debian (Unstable) GNU/Linux 2.6.12-rc4-mm2 2x6017 bogomips load 0.02


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
