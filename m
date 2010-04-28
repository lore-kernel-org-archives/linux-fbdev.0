From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 28 Apr 2010 22:17:20 +0000
Subject: [PATCH 19/30] viafb: Introduce viafb_find_i2c_adapter()
Message-Id: <1272493051-25380-20-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The camera driver will need this to look up a specific adapter.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via_i2c.c |   13 +++++++++++++
 drivers/video/via/via_i2c.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index c88450e..febc1dd 100644
--- a/drivers/video/via/via_i2c.c
+++ b/drivers/video/via/via_i2c.c
@@ -157,6 +157,19 @@ int viafb_i2c_readbytes(u8 adap, u8 slave_addr, u8 index, u8 *buff, int buff_len
 	return i2c_transfer(&via_i2c_par[adap].adapter, msgs, 2);
 }
 
+/*
+ * Allow other viafb subdevices to look up a specific adapter
+ * by port name.
+ */
+struct i2c_adapter *viafb_find_i2c_adapter(enum viafb_i2c_adap which)
+{
+	struct via_i2c_stuff *stuff = &via_i2c_par[which];
+
+	return &stuff->adapter;
+}
+EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);
+
+
 static int create_i2c_bus(struct i2c_adapter *adapter,
 			  struct i2c_algo_bit_data *algo,
 			  struct via_port_cfg *adap_cfg,
diff --git a/drivers/video/via/via_i2c.h b/drivers/video/via/via_i2c.h
index 1d18e7d..44532e4 100644
--- a/drivers/video/via/via_i2c.h
+++ b/drivers/video/via/via_i2c.h
@@ -35,6 +35,7 @@ struct via_i2c_stuff {
 int viafb_i2c_readbyte(u8 adap, u8 slave_addr, u8 index, u8 *pdata);
 int viafb_i2c_writebyte(u8 adap, u8 slave_addr, u8 index, u8 data);
 int viafb_i2c_readbytes(u8 adap, u8 slave_addr, u8 index, u8 *buff, int buff_len);
+struct i2c_adapter *viafb_find_i2c_adapter(enum viafb_i2c_adap which);
 
 extern int viafb_i2c_init(void);
 extern void viafb_i2c_exit(void);
-- 
1.7.0.1

