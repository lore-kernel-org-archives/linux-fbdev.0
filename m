From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 22 Feb 2012 18:53:05 +0000
Subject: [PATCH 1/5] viafb: another workaround for OLPCs weird wiring
Message-Id: <78145b7a343fe2950478e649e905f557054df884.1329936280.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1329936280.git.FlorianSchandinat@gmx.de>
In-Reply-To: <cover.1329936280.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On OLPC we must not touch this I2C bus or it will hang.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 4791165..9cfa92e 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1752,8 +1752,10 @@ static void __devinit i2c_bus_probe(struct viafb_shared *shared)
 	shared->i2c_31 = via_aux_probe(viafb_find_i2c_adapter(VIA_PORT_31));
 
 	/* FIXME: what is this? */
-	printk(KERN_INFO "viafb: Probing I2C bus 0x2C\n");
-	shared->i2c_2C = via_aux_probe(viafb_find_i2c_adapter(VIA_PORT_2C));
+	if (!machine_is_olpc()) {
+		printk(KERN_INFO "viafb: Probing I2C bus 0x2C\n");
+		shared->i2c_2C = via_aux_probe(viafb_find_i2c_adapter(VIA_PORT_2C));
+	}
 
 	printk(KERN_INFO "viafb: Finished I2C bus probing");
 }
-- 
1.7.9

