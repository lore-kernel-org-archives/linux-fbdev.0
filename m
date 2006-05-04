From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/9] nvidiafb: Add support for Geforce 6100 and related chipsets
Date: Thu, 04 May 2006 20:27:45 +0800
Message-ID: <4459F341.3030504@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd5O-0007lf-6r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:38 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd5O-0002Pa-1N
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:38 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:37:36 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add support for Geforce 6100 and related chipsets (PCI device id 0x024x)

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nv_hw.c  |   10 ++++++++--
 drivers/video/nvidia/nvidia.c |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index 99c3a8e..9ed640d 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -886,7 +886,10 @@ void NVCalcStateExt(struct nvidia_par *p
 	case NV_ARCH_20:
 	case NV_ARCH_30:
 	default:
-		if (((par->Chipset & 0xffff) == 0x01A0) ||
+		if ((par->Chipset & 0xfff0) == 0x0240) {
+			state->arbitration0 = 256;
+			state->arbitration1 = 0x0480;
+		} else if (((par->Chipset & 0xffff) == 0x01A0) ||
 		    ((par->Chipset & 0xffff) == 0x01f0)) {
 			nForceUpdateArbitrationSettings(VClk,
 							pixelDepth * 8,
@@ -1235,6 +1238,7 @@ void NVLoadStateExt(struct nvidia_par *p
 					break;
 				case 0x0160:
 				case 0x01D0:
+				case 0x0240:
 					NV_WR32(par->PMC, 0x1700,
 						NV_RD32(par->PFB, 0x020C));
 					NV_WR32(par->PMC, 0x1704, 0);
@@ -1359,7 +1363,9 @@ void NVLoadStateExt(struct nvidia_par *p
 						if(((par->Chipset & 0xfff0)
 						    != 0x0160) &&
 						   ((par->Chipset & 0xfff0)
-						    != 0x0220))
+						    != 0x0220) &&
+						   ((par->Chipset & 0xfff0)
+						    != 0x240))
 							NV_WR32(par->PGRAPH,
 								0x6900 + i*4,
 								NV_RD32(par->PFB,
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 97f3855..ef59615 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1238,6 +1238,7 @@ static u32 __devinit nvidia_get_arch(str
 	case 0x0210:
 	case 0x0220:
 	case 0x0230:
+	case 0x0240:
 	case 0x0290:
 	case 0x0390:
 		arch = NV_ARCH_40;



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
