From: stufever@gmail.com
Date: Sat, 06 Aug 2011 13:26:20 +0000
Subject: [PATCH] viafb: fix pointer type missmatch
Message-Id: <1312637180-6107-1-git-send-email-wangshaoyan.pt@taobao.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, FlorianSchandinat@gmx.de, Wang Shaoyan <wangshaoyan.pt@taobao.com>

From: Wang Shaoyan <wangshaoyan.pt@taobao.com>

  drivers/video/via/via-core.c: In function 'via_pci_probe':
  drivers/video/via/via-core.c:691: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Wang Shaoyan <wangshaoyan.pt@taobao.com>
---
 drivers/video/via/via-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index eb112b6..dd58b53 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -35,7 +35,7 @@ static struct via_port_cfg adap_configs[] = {
  * The OLPC XO-1.5 puts the camera power and reset lines onto
  * GPIO 2C.
  */
-static const struct via_port_cfg olpc_adap_configs[] = {
+static struct via_port_cfg olpc_adap_configs[] = {
 	[VIA_PORT_26]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x26 },
 	[VIA_PORT_31]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x31 },
 	[VIA_PORT_25]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x25 },
-- 
1.7.0.4

