From: Martin Michlmayr <tbm@cyrius.com>
Subject: vga16fb: blank screen with Intel GM965/GL960 on
	HP 2510p notebook
Date: Fri, 21 Mar 2008 17:39:44 +0100
Message-ID: <20080321163944.GA22068@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JckHG-0005kO-W2 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Mar 2008 09:39:35 -0700
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JckHE-0005v6-MN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Mar 2008 09:39:34 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: keith.packard@intel.com

When I start debian-installer on my HP 2510p notebook the screen
becomes blank when it tries to start the frame buffer.  I can reproduce
the same behaviour when I load the vga16fb module manually.  I tested
at least 2.6.22 and 2.6.25-rc6.  It works though when I pass vga=773
to the kernel.

When I load the module, I get the following in dmesg and the screen goes
blank:

vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device

This notebook uses the following graphics chip:

00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)

Any idea what to do?


lspci -v
00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c) (prog-if 00 [VGA controller])
        Subsystem: Hewlett-Packard Company Unknown device 30c9
        Flags: fast devsel, IRQ 16
        Memory at e0400000 (64-bit, non-prefetchable) [size=1M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 2000 [size=8]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
        Capabilities: [d0] Power Management version 3

-- 
Martin Michlmayr
http://www.cyrius.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
