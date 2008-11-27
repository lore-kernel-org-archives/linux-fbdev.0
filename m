From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 2/2] pxa/littleton: update tdo24m LCD
	panel support
Date: Thu, 27 Nov 2008 13:26:42 +0200
Message-ID: <492E83F2.4040806@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>) id 1L5f1L-0005JK-5o
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Nov 2008 11:26:55 +0000
Received: from 89.6b.364a.static.theplanet.com ([74.54.107.137]
	helo=cathcart.site5.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L5f1C-0002Pe-BS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Nov 2008 11:26:55 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: eric miao <eric.miao@marvell.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index b4d00ab..2aad849 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -23,6 +23,8 @@
 #include <linux/spi/spi.h>
 #include <linux/smc91x.h>

+#include <video/tdo24m.h>
+
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -186,6 +188,10 @@ static struct pxa2xx_spi_chip littleton_tdo24m_chip = {
 	.cs_control	= littleton_tdo24m_cs,
 };

+static struct tdo24m_platform_data littleton_tdo24m_pdata = {
+	.model = TDO24M,
+};
+
 static struct spi_board_info littleton_spi_devices[] __initdata = {
 	{
 		.modalias	= "tdo24m",
@@ -193,6 +199,7 @@ static struct spi_board_info littleton_spi_devices[] __initdata = {
 		.bus_num	= 2,
 		.chip_select	= 0,
 		.controller_data= &littleton_tdo24m_chip,
+		.platform_data	= &littleton_tdo24m_pdata,
 	},
 };


-- 
Sincerely yours,
Mike.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
