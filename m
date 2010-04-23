From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 23 Apr 2010 21:28:08 +0000
Subject: [PATCH 08/13] viafb: Introduce viafb_find_i2c_adapter()
Message-Id: <1272058093-20914-9-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272058093-20914-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272058093-20914-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The camera driver will need this to look up a specific adapter.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via_i2c.c |   13 +++++++++++++
 drivers/video/via/via_i2c.h |    3 +--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index dbb2392..ba29350 100644
--- a/drivers/video/via/via_i2c.c
+++ b/drivers/video/via/via_i2c.c
@@ -159,6 +159,19 @@ int viafb_i2c_readbytes(u8 adap, u8 slave_addr, u8 index, u8 *buff, int buff_len
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
index da3a96a..41f84ed 100644
--- a/drivers/video/via/via_i2c.h
+++ b/drivers/video/via/via_i2c.h
@@ -36,6 +36,5 @@ int viafb_i2c_readbyte(u8 adap, u8 slave_addr, u8 index, u8 *pdata);
 int viafb_i2c_writebyte(u8 adap, u8 slave_addr, u8 index, u8 data);
 int viafb_i2c_readbytes(u8 adap, u8 slave_addr, u8 index, u8 *buff, int buff_len);
 
-struct viafb_par;
-struct i2c_adapter *viafb_find_adapter(enum viafb_i2c_adap which);
+struct i2c_adapter *viafb_find_i2c_adapter(enum viafb_i2c_adap which);
 #endif /* __VIA_I2C_H__ */
-- 
1.7.0.1

