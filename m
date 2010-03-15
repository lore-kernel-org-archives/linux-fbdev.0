From: James Simmons <jsimmons@infradead.org>
Date: Mon, 15 Mar 2010 11:54:18 +0000
Subject: [PATCH] fix Kconfig breakage in drivers/video
Message-Id: <alpine.LFD.2.00.1003151152260.16108@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Forward to new mailing list. Please us this mailing list instead.

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] fix Kconfig breakage in drivers/video

From: Krzysztof Helt <krzysztof.h1@wp.pl>

There are two new options inside the CONFIG_FB section which do not
depend on the CONFIG_FB. This break Kconfig menu layout.

Fix it and reduce few conditions for sparc frame buffers
as the FB_SBUS = ((FB = y) && SPARC).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

--- linux-orig/drivers/video/Kconfig	2010-03-14 23:54:39.000000000 +0100
+++ linux-git/drivers/video/Kconfig	2010-03-15 00:05:59.000000000 +0100
@@ -400,12 +400,9 @@ config FB_SA1100
 	  If you plan to use the LCD display with your SA-1100 system, say
 	  Y here.
 
-config HAVE_FB_IMX
-	bool
-
 config FB_IMX
 	tristate "Motorola i.MX LCD support"
-	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
+	depends on FB && (ARCH_MX1 || ARCH_MX2)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -802,7 +799,7 @@ config FB_SBUS
 
 config FB_BW2
 	bool "BWtwo support"
-	depends on (FB = y) && (SPARC && FB_SBUS)
+	depends on FB_SBUS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -811,7 +808,7 @@ config FB_BW2
 
 config FB_CG3
 	bool "CGthree support"
-	depends on (FB = y) && (SPARC && FB_SBUS)
+	depends on FB_SBUS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -820,7 +817,7 @@ config FB_CG3
 
 config FB_CG6
 	bool "CGsix (GX,TurboGX) support"
-	depends on (FB = y) && (SPARC && FB_SBUS)
+	depends on FB_SBUS
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
@@ -914,7 +911,7 @@ config FB_XVR2500
 
 config FB_XVR1000
 	bool "Sun XVR-1000 support"
-	depends on SPARC64
+	depends on (FB = y) && SPARC64
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

----------------------------------------------------------------------
Wygraj z armia wampirow!
Kliknij >>> http://link.interia.pl/f23a0




    [ Part 3: "Included Message" ]

From: linux-fbdev-devel-request@lists.sourceforge.net
Subject: confirm 9aa31557d6574dc9acdf61937aa75c169a46fb42

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
