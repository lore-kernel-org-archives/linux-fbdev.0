From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 26 Nov 2016 10:20:58 +0000
Subject: [patch] staging: sm750fb: fix a type issue in sm750_set_chip_type()
Message-Id: <20161126102058.GA7640@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

"revId" needs to be unsigned because we use it to test:

	if (revId = SM750LE_REVISION_ID) {

and SM750LE_REVISION_ID is ((unsigned char )0xfe).

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index e97e859..e63b8b2 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -87,7 +87,7 @@ struct initchip_param {
 };
 
 logical_chip_type_t sm750_get_chip_type(void);
-void sm750_set_chip_type(unsigned short devId, char revId);
+void sm750_set_chip_type(unsigned short devId, u8 revId);
 unsigned int sm750_calc_pll_value(unsigned int request, struct  pll_value *pll);
 unsigned int sm750_format_pll_reg(struct pll_value *pPLL);
 unsigned int ddk750_get_vm_size(void);
diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 94f59f4..f59ce5c 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -14,7 +14,7 @@ logical_chip_type_t sm750_get_chip_type(void)
 	return chip;
 }
 
-void sm750_set_chip_type(unsigned short devId, char revId)
+void sm750_set_chip_type(unsigned short devId, u8 revId)
 {
 	if (devId = 0x718)
 		chip = SM718;
