From: Simeon Walker <simeon@sbs.bangor.ac.uk>
Subject: 2.4 atyfb blank screen on Tyan MB
Date: Fri, 25 Jul 2003 16:27:16 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F214C54.3030502@sbs.bangor.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vogon.bangor.ac.uk ([147.143.42.78])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19g4TU-00032P-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 25 Jul 2003 08:27:17 -0700
Received: from sbs.bangor.ac.uk (milliways [147.143.41.38])
	by vogon.bangor.ac.uk (Postfix) with ESMTP id 5B216C4E8
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 25 Jul 2003 16:27:14 +0100 (BST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I am having trouble getting the frame buffer device working on
a machine with A Tyan S2723 motherboard, this has an Intel
i7501 chipset and lspci -v reports the following for the onboard
ATI chip:

01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 18
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at b800 [size=256]
        Memory at fe7ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe7c0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
 
The problem is that no matter what I try the screen goes
blank when the atyfb module is loaded. If compiled in then the
screen goes blank during boot up. Everything else works fine.

Even fbset seems to work, the monitor will indicate the appropriate
changes in resolution/refresh rate but the screen is always blank.

I have tried kernels from stock 2.4.21 to 2.4.22-pre6-ac1 with
no change in the results. Any suggestions?

Regards,
Simeon

-- 
Simeon Walker,                      email: simeon@sbs.bangor.ac.uk
School of Biological Sciences,      phone: +44 (0)1248 383702
University of Wales, Bangor,        fax: +44 (0)1248 382569
Gwynedd, LL57 2UW, UK.              www: http://biology.bangor.ac.uk/




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
