From: "Wang, Annie" <Annie.Wang@amd.com>
Date: Tue, 05 Apr 2016 06:56:57 +0000
Subject: RE: [PATCH v2] video: AMBA CLCD: Remove unncessary include in amba-clcd.c
Message-Id: <BLUPR12MB04332A5BE0C2D54190FF8222819E0@BLUPR12MB0433.namprd12.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457922549-2610-1-git-send-email-annie.wang@amd.com>
In-Reply-To: <1457922549-2610-1-git-send-email-annie.wang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Wang, Annie" <Annie.Wang@amd.com>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>

Hi Tomi,

Any comments of this patch? 

Regards,
Hongcheng Wang(Annie)

>-----Original Message-----
>From: Wang Hongcheng [mailto:annie.wang@amd.com]
>Sent: Monday, March 14, 2016 10:29 AM
>To: Russell King; Jean-Christophe Plagniol-Villard; Tomi Valkeinen; linux-
>fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; Borislav Petkov;
>SPG_Linux_Kernel
>Cc: Wang, Annie
>Subject: [PATCH v2] video: AMBA CLCD: Remove unncessary include in amba-
>clcd.c
>
>The header file asm/sizes.h is unnecessary.
>And it can also be compiled under X86 arch after the removal.
>
>Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
>---
> drivers/video/fbdev/amba-clcd.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
>index 9362424..1a1ed80 100644
>--- a/drivers/video/fbdev/amba-clcd.c
>+++ b/drivers/video/fbdev/amba-clcd.c
>@@ -34,8 +34,6 @@
> #include <video/of_display_timing.h>
> #include <video/videomode.h>
>
>-#include <asm/sizes.h>
>-
> #define to_clcd(info)	container_of(info, struct clcd_fb, fb)
>
> /* This is limited to 16 characters when displayed by X startup */
>--
>1.9.1

