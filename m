From: Admar Schoonen <admar@luon.net>
Subject: sparc64, 2 x mach64 & 2.6.8-rc4: no working XFree86
Date: Sat, 14 Aug 2004 15:54:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040814135408.GM21828@azrael.luon.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bvywh-00025K-NQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 06:51:43 -0700
Received: from cp552357-a.roose1.nb.home.nl ([82.72.161.65] helo=azrael.luon.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bvywh-0004dJ-Bi
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Aug 2004 06:51:43 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi

I have a sun blade 100 with 1 onboard PGX64 and 1 pci card PGX64 (both
Ati mach64 cards).

With linux 2.4 series, both framebuffers worked, and XFree86 worked on
both cards.

With 2.6.X (X <= 7), only the primary (onboard) card worked ; secondary
was always black in console and in XFree86.

Starting with 2.6.8-rc1, the console works on both cards again, however,
XFree86 doesn't work anymore. It crashes with signal 11 even before it
can display it's famous black & white dot pattern.

I've tried 2.6.8-rc4 on a sun ultra 5 with only 1 onboard PGX24 (Ati
mach64 card) and XFree86 works fine there, so I guess the problem is due
to the secondary card. I don't know which is at fault here (if it's the
kernel or X), but as the problem was introduced with 2.6.8-rc1, I'm
asking here.

Does anyone have any idea?

Regards

Admar Schoonen

PS: please CC any replies to me, as I'm not on this list


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
