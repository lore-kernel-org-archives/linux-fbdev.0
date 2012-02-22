From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 22 Feb 2012 18:53:08 +0000
Subject: [PATCH 4/5] viafb: fix IGA1 modesetting on VX900
Message-Id: <43951de17c7a84280f3fbfb10d681ee73149a96e.1329936280.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1329936280.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1329936280.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, stable@vger.kernel.org

Even if the documentation calls this bit "Reserved" it has to be set
to 0 for correct modesetting on IGA1.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: stable@vger.kernel.org
---
 drivers/video/via/hw.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index e6e7a8f..376af05 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1804,6 +1804,9 @@ static void hw_init(void)
 		break;
 	}
 
+	/* magic required on VX900 for correct modesetting on IGA1 */
+	via_write_reg_mask(VIACR, 0x45, 0x00, 0x01);
+
 	/* probably this should go to the scaling code one day */
 	via_write_reg_mask(VIACR, 0xFD, 0, 0x80); /* VX900 hw scale on IGA2 */
 	viafb_write_regx(scaling_parameters, ARRAY_SIZE(scaling_parameters));
-- 
1.7.9

