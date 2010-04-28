From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 28 Apr 2010 22:17:11 +0000
Subject: [PATCH 10/30] suppress verbose debug messages: change printk() to DEBUG_MSG()
Message-Id: <1272493051-25380-11-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Paul Fox <pgf@laptop.org>

[jc: no signoff, added my own]
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: ScottFang@viatech.com.cn
Cc: JosephChan@via.com.tw
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via_i2c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index 8f8e0bf..fe5535c 100644
--- a/drivers/video/via/via_i2c.c
+++ b/drivers/video/via/via_i2c.c
@@ -26,7 +26,7 @@ static void via_i2c_setscl(void *data, int state)
 	u8 val;
 	struct via_i2c_adap_cfg *adap_data = data;
 
-	printk(KERN_DEBUG "reading index 0x%02x from IO 0x%x\n",
+	DEBUG_MSG(KERN_DEBUG "reading index 0x%02x from IO 0x%x\n",
 		adap_data->ioport_index, adap_data->io_port);
 	val = viafb_read_reg(adap_data->io_port,
 			     adap_data->ioport_index) & 0xF0;
@@ -140,7 +140,7 @@ static int create_i2c_bus(struct i2c_adapter *adapter,
 			  struct via_i2c_adap_cfg *adap_cfg,
 			  struct pci_dev *pdev)
 {
-	printk(KERN_DEBUG "viafb: creating bus adap=0x%p, algo_bit_data=0x%p, adap_cfg=0x%p\n", adapter, algo, adap_cfg);
+	DEBUG_MSG(KERN_DEBUG "viafb: creating bus adap=0x%p, algo_bit_data=0x%p, adap_cfg=0x%p\n", adapter, algo, adap_cfg);
 
 	algo->setsda = via_i2c_setsda;
 	algo->setscl = via_i2c_setscl;
-- 
1.7.0.1

