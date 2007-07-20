From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 1/3] ps3fb: Enable VT_HW_CONSOLE_BINDING
	for proper kexec
Date: Fri, 20 Jul 2007 14:55:34 +0200
Message-ID: <20070720130425.126665000@pademelon.sonytel.be>
References: <20070720125533.933475000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1810723364=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBsB1-00023l-RM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Jul 2007 06:05:55 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBsAz-0001F5-70
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Jul 2007 06:05:47 -0700
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
To: Antonino Daplas <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, Geoff Levand <geoffrey.levand@am.sony.com>

--===============1810723364==
Content-Disposition: inline; filename=ps3-stable/ps3fb-unregister.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: VT_HW_CONSOLE_BINDING must be enabled to make console unbinding work,
which is needed to give up all hypervisor resources before reboot or kexec.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/Kconfig |    1 +
 1 files changed, 1 insertion(+)

--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1796,6 +1796,7 @@ config FB_PS3
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
 	select FB_SYS_FOPS
+	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	---help---
 	  Include support for the virtual frame buffer in the PS3 platform.
 

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village ������ Da Vincilaan 7-D1 ������ B-1935 Zaventem ������ Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 ������ B-1840 Londerzeel ������ Belgium	
VAT BE 0413.825.160 ������ RPR Brussels	
Fortis Bank Zaventem ������ Swift GEBABEBB08A ������ IBAN BE39001382358619



--===============1810723364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1810723364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1810723364==--
