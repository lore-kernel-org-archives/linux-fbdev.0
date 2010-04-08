From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/16] suppress verbose debug messages:  change printk() to DEBUG_MSG()
Date: Thu,  8 Apr 2010 11:15:40 -0600
Message-ID: <1270746946-12467-11-git-send-email-corbet@lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

From: Paul Fox <pgf@laptop.org>

---
 drivers/video/via/via_i2c.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index 18bbbdd..86e6e8d 100644
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
@@ -182,7 +182,7 @@ static struct via_i2c_adap_cfg adap_configs[] = {
 int viafb_create_i2c_busses(struct viafb_par *viapar)
 {
 	int i, ret;
-	printk(KERN_DEBUG "%s: entering\n", __FUNCTION__);
+	DEBUG_MSG(KERN_DEBUG "%s: entering\n", __FUNCTION__);
 
 	for (i = 0; i < VIAFB_NUM_I2C; i++) {
 		struct via_i2c_adap_cfg *adap_cfg = &adap_configs[i];
-- 
1.7.0.1
