From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:34:11 +0000
Subject: [PATCH 1/8] pxa: support pxa168 LCD controller SPI operation
Message-Id: <7c34ac520911160134p6c67b969rf7b430a2970b8a70@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64907d2478947047879b62d"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012s3504b2ek75670ecb057692a7@mail.gmail.com>
In-Reply-To: <7c34ac520911100012s3504b2ek75670ecb057692a7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64907d2478947047879b62d
Content-Type: text/plain; charset=ISO-8859-1

From 40bb744e91d8058faa38fb953ade1964c865e846 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Fri, 13 Nov 2009 14:02:20 +0800
Subject: [PATCH] pxa: support pxa168 LCD controller SPI operation

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/pxa168fb.h |   24 +-------------
 include/video/pxa168fb.h |   47 ++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 23 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 84d8327..aec95c4 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -27,12 +27,90 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/uaccess.h>
+#include <linux/gpio.h>
 #include <video/pxa168fb.h>

 #include "pxa168fb.h"

 #define DEFAULT_REFRESH		60	/* Hz */

+static inline void spi_gpio_assert(int spi_gpio_cs, int val)
+{
+	if (gpio_is_valid(spi_gpio_cs))
+		gpio_set_value(spi_gpio_cs, val);
+}
+
+int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
+		unsigned int spi_gpio_cs, unsigned int cs_active,
+		unsigned int interval_us)
+{
+	u32 x, spi_byte_len;
+	u8 *cmd = (u8 *)value;
+	int i, isr, iopad, ret = 0;
+
+	if (gpio_is_valid(spi_gpio_cs)) {
+		ret = gpio_direction_output(spi_gpio_cs, !cs_active);
+		if (ret)
+			goto spi_exit;
+	}
+	spi_byte_len = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+	spi_byte_len = (spi_byte_len >> 8) & 0xff;
+	/* Alignment should be (spi_byte_len + 7) >> 3, but
+	 * spi controller request set one less than bit length */
+	spi_byte_len = (spi_byte_len + 8) >> 3;
+	/* spi command provided by platform should be 1, 2, or 4 byte aligned */
+	if (3 == spi_byte_len)
+		spi_byte_len = 4;
+
+	iopad = readl(fbi->reg_base + SPU_IOPAD_CONTROL);
+	if ((iopad & CFG_IOPADMODE_MASK) != PIN_MODE_DUMB_18_SPI)
+		writel(PIN_MODE_DUMB_18_SPI, fbi->reg_base + SPU_IOPAD_CONTROL);
+	isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+	writel((isr & ~SPI_IRQ_ENA_MASK), fbi->reg_base + SPU_IRQ_ISR);
+	for (i = 0; i < count; i++) {
+		spi_gpio_assert(spi_gpio_cs, cs_active);
+		udelay(interval_us);
+		switch (spi_byte_len) {
+		case 1:
+			writel(*cmd, fbi->reg_base + LCD_SPU_SPI_TXDATA);
+			break;
+		case 2:
+			writel(*(u16 *)cmd, fbi->reg_base + LCD_SPU_SPI_TXDATA);
+			break;
+		case 4:
+			writel(*(u32 *)cmd, fbi->reg_base + LCD_SPU_SPI_TXDATA);
+			break;
+		default:
+			dev_err(fbi->dev, "Wrong spi bit length\n");
+			spi_gpio_assert(spi_gpio_cs, !cs_active);
+			ret = -EINVAL;
+			goto spi_exit;
+		}
+		cmd += spi_byte_len;
+		x = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+		x |= CFG_SPI_START_MASK;
+		writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
+		isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+		while (!(isr & SPI_IRQ_ENA_MASK)) {
+			udelay(1);
+			isr = readl(fbi->reg_base + SPU_IRQ_ISR);
+		}
+		x = readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
+		x &= ~CFG_SPI_START_MASK;
+		writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
+		spi_gpio_assert(spi_gpio_cs, !cs_active);
+	}
+
+spi_exit:
+	if (gpio_is_valid(spi_gpio_cs))
+		gpio_direction_input(spi_gpio_cs);
+	if ((iopad & CFG_IOPADMODE_MASK) != PIN_MODE_DUMB_18_SPI)
+		writel(iopad, fbi->reg_base + SPU_IOPAD_CONTROL);
+
+	return ret;
+}
+EXPORT_SYMBOL(pxa168fb_spi_send);
+
 static int determine_best_pix_fmt(struct fb_var_screeninfo *var)
 {
 	/*
@@ -728,6 +806,9 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	writel(0, fbi->reg_base + LCD_SPU_SRAM_PARA0);
 	writel(CFG_CSB_256x32(0x1)|CFG_CSB_256x24(0x1)|CFG_CSB_256x8(0x1),
 		fbi->reg_base + LCD_SPU_SRAM_PARA1);
+	if ((mi->spi_ctrl != -1) && (mi->spi_ctrl & CFG_SPI_ENA_MASK))
+		writel(mi->spi_ctrl, fbi->reg_base + LCD_SPU_SPI_CTRL);
+

 	/*
 	 * Allocate color map.
diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
index eee0927..55ec4dc 100644
--- a/drivers/video/pxa168fb.h
+++ b/drivers/video/pxa168fb.h
@@ -170,29 +170,7 @@
 #define     DMA_FRAME_CNT_MASK			0x00000003  /* Video */

 /* SPI Control Register. */
-#define LCD_SPU_SPI_CTRL			0x0180
-#define     CFG_SCLKCNT(div)			((div) << 24)  /* 0xFF~0x2 */
-#define     CFG_SCLKCNT_MASK			0xFF000000
-#define     CFG_RXBITS(rx)			((rx) << 16)   /* 0x1F~0x1 */
-#define     CFG_RXBITS_MASK			0x00FF0000
-#define     CFG_TXBITS(tx)			((tx) << 8)    /* 0x1F~0x1 */
-#define     CFG_TXBITS_MASK			0x0000FF00
-#define     CFG_CLKINV(clk)			((clk) << 7)
-#define     CFG_CLKINV_MASK			0x00000080
-#define     CFG_KEEPXFER(transfer)		((transfer) << 6)
-#define     CFG_KEEPXFER_MASK			0x00000040
-#define     CFG_RXBITSTO0(rx)			((rx) << 5)
-#define     CFG_RXBITSTO0_MASK			0x00000020
-#define     CFG_TXBITSTO0(tx)			((tx) << 4)
-#define     CFG_TXBITSTO0_MASK			0x00000010
-#define     CFG_SPI_ENA(spi)			((spi) << 3)
-#define     CFG_SPI_ENA_MASK			0x00000008
-#define     CFG_SPI_SEL(spi)			((spi) << 2)
-#define     CFG_SPI_SEL_MASK			0x00000004
-#define     CFG_SPI_3W4WB(wire)			((wire) << 1)
-#define     CFG_SPI_3W4WB_MASK			0x00000002
-#define     CFG_SPI_START(start)		(start)
-#define     CFG_SPI_START_MASK			0x00000001
+/* For SPI register, please refer to include/video/pxa168fb.h */

 /* SPI Tx Data Register */
 #define LCD_SPU_SPI_TXDATA			0x0184
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index b5cc72f..01c18bc 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -14,6 +14,32 @@
 #include <linux/fb.h>
 #include <linux/interrupt.h>

+/* SPI Control Register. */
+#define LCD_SPU_SPI_CTRL		0x0180
+#define     CFG_SCLKCNT(div)		((div) << 24)  /* 0xFF~0x2 */
+#define     CFG_SCLKCNT_MASK		0xFF000000
+/* SPI RX/TX bit length, 0x1F~0x1, 0x1: 2bits ... 0x1F: 32bits */
+#define     CFG_RXBITS(rx)		((rx - 1) << 16)
+#define     CFG_RXBITS_MASK		0x00FF0000
+#define     CFG_TXBITS(tx)              ((tx - 1) << 8)
+#define     CFG_TXBITS_MASK		0x0000FF00
+#define     CFG_CLKINV(clk)		((clk) << 7)
+#define     CFG_CLKINV_MASK		0x00000080
+#define     CFG_KEEPXFER(transfer)	((transfer) << 6)
+#define     CFG_KEEPXFER_MASK		0x00000040
+#define     CFG_RXBITSTO0(rx)		((rx) << 5)
+#define     CFG_RXBITSTO0_MASK		0x00000020
+#define     CFG_TXBITSTO0(tx)		((tx) << 4)
+#define     CFG_TXBITSTO0_MASK		0x00000010
+#define     CFG_SPI_ENA(spi)		((spi) << 3)
+#define     CFG_SPI_ENA_MASK		0x00000008
+#define     CFG_SPI_SEL(spi)		((spi) << 2) /* 1: port1; 0: port0 */
+#define     CFG_SPI_SEL_MASK		0x00000004
+#define     CFG_SPI_3W4WB(wire)         ((wire)<<1) /* 1: 3-wire; 0: 4-wire */
+#define     CFG_SPI_3W4WB_MASK		0x00000002
+#define     CFG_SPI_START(start)	(start)
+#define     CFG_SPI_START_MASK		0x00000001
+
 /* Dumb interface */
 #define PIN_MODE_DUMB_24		0
 #define PIN_MODE_DUMB_18_SPI		1
@@ -122,6 +148,27 @@ struct pxa168fb_mach_info {
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
+	/*
+	 * SPI control
+	 */
+	unsigned int	spi_ctrl;
+	unsigned int	spi_gpio_cs;
+	unsigned int 	spi_gpio_reset;
+	/*
+	 * power on/off function.
+	 */
+	int (*pxa168fb_lcd_power)(struct pxa168fb_info *,
+			unsigned int, unsigned int, int);
 };

+/* SPI utility for configure panel SPI command.
+ * value: command array, element should be 1, 2 or 4 byte aligned.
+ * count: command array length
+ * spi_gpio_cs: gpio number for spi chip select
+ * cs_active: CS active polarity for SPI transaction
+ * interval_us: time interval between two commands, us as unit */
+int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
+		unsigned int spi_gpio_cs, unsigned int cs_active,
+		unsigned int interval_us);
+
 #endif /* __ASM_MACH_PXA168FB_H */
-- 
1.5.4.3

--0016e64907d2478947047879b62d
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-pxa-support-pxa168-LCD-controller-SPI-operation.patch"
Content-Disposition: attachment; 
	filename="0001-pxa-support-pxa168-LCD-controller-SPI-operation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2315wfc0

RnJvbSA0MGJiNzQ0ZTkxZDgwNThmYWEzOGZiOTUzYWRlMTk2NGM4NjVlODQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBGcmks
IDEzIE5vdiAyMDA5IDE0OjAyOjIwICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBzdXBwb3J0
IHB4YTE2OCBMQ0QgY29udHJvbGxlciBTUEkgb3BlcmF0aW9uCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYyB8ICAg
ODEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVy
cy92aWRlby9weGExNjhmYi5oIHwgICAyNCArLS0tLS0tLS0tLS0tLQogaW5jbHVkZS92aWRlby9w
eGExNjhmYi5oIHwgICA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFu
Z2VkLCAxMjkgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aWRlby9weGExNjhmYi5jIGIvZHJpdmVycy92aWRlby9weGExNjhmYi5jCmluZGV4IDg0
ZDgzMjcuLmFlYzk1YzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYworKysg
Yi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMKQEAgLTI3LDEyICsyNyw5MCBAQAogI2luY2x1ZGUg
PGxpbnV4L2Nsay5oPgogI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgogI2luY2x1ZGUgPGxpbnV4L3Vh
Y2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC9ncGlvLmg+CiAjaW5jbHVkZSA8dmlkZW8vcHhhMTY4
ZmIuaD4KIAogI2luY2x1ZGUgInB4YTE2OGZiLmgiCiAKICNkZWZpbmUgREVGQVVMVF9SRUZSRVNI
CQk2MAkvKiBIeiAqLwogCitzdGF0aWMgaW5saW5lIHZvaWQgc3BpX2dwaW9fYXNzZXJ0KGludCBz
cGlfZ3Bpb19jcywgaW50IHZhbCkKK3sKKwlpZiAoZ3Bpb19pc192YWxpZChzcGlfZ3Bpb19jcykp
CisJCWdwaW9fc2V0X3ZhbHVlKHNwaV9ncGlvX2NzLCB2YWwpOworfQorCitpbnQgcHhhMTY4ZmJf
c3BpX3NlbmQoc3RydWN0IHB4YTE2OGZiX2luZm8gKmZiaSwgdm9pZCAqdmFsdWUsIGludCBjb3Vu
dCwKKwkJdW5zaWduZWQgaW50IHNwaV9ncGlvX2NzLCB1bnNpZ25lZCBpbnQgY3NfYWN0aXZlLAor
CQl1bnNpZ25lZCBpbnQgaW50ZXJ2YWxfdXMpCit7CisJdTMyIHgsIHNwaV9ieXRlX2xlbjsKKwl1
OCAqY21kID0gKHU4ICopdmFsdWU7CisJaW50IGksIGlzciwgaW9wYWQsIHJldCA9IDA7CisKKwlp
ZiAoZ3Bpb19pc192YWxpZChzcGlfZ3Bpb19jcykpIHsKKwkJcmV0ID0gZ3Bpb19kaXJlY3Rpb25f
b3V0cHV0KHNwaV9ncGlvX2NzLCAhY3NfYWN0aXZlKTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gc3Bp
X2V4aXQ7CisJfQorCXNwaV9ieXRlX2xlbiA9IHJlYWRsKGZiaS0+cmVnX2Jhc2UgKyBMQ0RfU1BV
X1NQSV9DVFJMKTsKKwlzcGlfYnl0ZV9sZW4gPSAoc3BpX2J5dGVfbGVuID4+IDgpICYgMHhmZjsK
KwkvKiBBbGlnbm1lbnQgc2hvdWxkIGJlIChzcGlfYnl0ZV9sZW4gKyA3KSA+PiAzLCBidXQKKwkg
KiBzcGkgY29udHJvbGxlciByZXF1ZXN0IHNldCBvbmUgbGVzcyB0aGFuIGJpdCBsZW5ndGggKi8K
KwlzcGlfYnl0ZV9sZW4gPSAoc3BpX2J5dGVfbGVuICsgOCkgPj4gMzsKKwkvKiBzcGkgY29tbWFu
ZCBwcm92aWRlZCBieSBwbGF0Zm9ybSBzaG91bGQgYmUgMSwgMiwgb3IgNCBieXRlIGFsaWduZWQg
Ki8KKwlpZiAoMyA9PSBzcGlfYnl0ZV9sZW4pCisJCXNwaV9ieXRlX2xlbiA9IDQ7CisKKwlpb3Bh
ZCA9IHJlYWRsKGZiaS0+cmVnX2Jhc2UgKyBTUFVfSU9QQURfQ09OVFJPTCk7CisJaWYgKChpb3Bh
ZCAmIENGR19JT1BBRE1PREVfTUFTSykgIT0gUElOX01PREVfRFVNQl8xOF9TUEkpCisJCXdyaXRl
bChQSU5fTU9ERV9EVU1CXzE4X1NQSSwgZmJpLT5yZWdfYmFzZSArIFNQVV9JT1BBRF9DT05UUk9M
KTsKKwlpc3IgPSByZWFkbChmYmktPnJlZ19iYXNlICsgU1BVX0lSUV9JU1IpOworCXdyaXRlbCgo
aXNyICYgflNQSV9JUlFfRU5BX01BU0spLCBmYmktPnJlZ19iYXNlICsgU1BVX0lSUV9JU1IpOwor
CWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7CisJCXNwaV9ncGlvX2Fzc2VydChzcGlfZ3Bp
b19jcywgY3NfYWN0aXZlKTsKKwkJdWRlbGF5KGludGVydmFsX3VzKTsKKwkJc3dpdGNoIChzcGlf
Ynl0ZV9sZW4pIHsKKwkJY2FzZSAxOgorCQkJd3JpdGVsKCpjbWQsIGZiaS0+cmVnX2Jhc2UgKyBM
Q0RfU1BVX1NQSV9UWERBVEEpOworCQkJYnJlYWs7CisJCWNhc2UgMjoKKwkJCXdyaXRlbCgqKHUx
NiAqKWNtZCwgZmJpLT5yZWdfYmFzZSArIExDRF9TUFVfU1BJX1RYREFUQSk7CisJCQlicmVhazsK
KwkJY2FzZSA0OgorCQkJd3JpdGVsKCoodTMyICopY21kLCBmYmktPnJlZ19iYXNlICsgTENEX1NQ
VV9TUElfVFhEQVRBKTsKKwkJCWJyZWFrOworCQlkZWZhdWx0OgorCQkJZGV2X2VycihmYmktPmRl
diwgIldyb25nIHNwaSBiaXQgbGVuZ3RoXG4iKTsKKwkJCXNwaV9ncGlvX2Fzc2VydChzcGlfZ3Bp
b19jcywgIWNzX2FjdGl2ZSk7CisJCQlyZXQgPSAtRUlOVkFMOworCQkJZ290byBzcGlfZXhpdDsK
KwkJfQorCQljbWQgKz0gc3BpX2J5dGVfbGVuOworCQl4ID0gcmVhZGwoZmJpLT5yZWdfYmFzZSAr
IExDRF9TUFVfU1BJX0NUUkwpOworCQl4IHw9IENGR19TUElfU1RBUlRfTUFTSzsKKwkJd3JpdGVs
KHgsIGZiaS0+cmVnX2Jhc2UgKyBMQ0RfU1BVX1NQSV9DVFJMKTsKKwkJaXNyID0gcmVhZGwoZmJp
LT5yZWdfYmFzZSArIFNQVV9JUlFfSVNSKTsKKwkJd2hpbGUgKCEoaXNyICYgU1BJX0lSUV9FTkFf
TUFTSykpIHsKKwkJCXVkZWxheSgxKTsKKwkJCWlzciA9IHJlYWRsKGZiaS0+cmVnX2Jhc2UgKyBT
UFVfSVJRX0lTUik7CisJCX0KKwkJeCA9IHJlYWRsKGZiaS0+cmVnX2Jhc2UgKyBMQ0RfU1BVX1NQ
SV9DVFJMKTsKKwkJeCAmPSB+Q0ZHX1NQSV9TVEFSVF9NQVNLOworCQl3cml0ZWwoeCwgZmJpLT5y
ZWdfYmFzZSArIExDRF9TUFVfU1BJX0NUUkwpOworCQlzcGlfZ3Bpb19hc3NlcnQoc3BpX2dwaW9f
Y3MsICFjc19hY3RpdmUpOworCX0KKworc3BpX2V4aXQ6CisJaWYgKGdwaW9faXNfdmFsaWQoc3Bp
X2dwaW9fY3MpKQorCQlncGlvX2RpcmVjdGlvbl9pbnB1dChzcGlfZ3Bpb19jcyk7CisJaWYgKChp
b3BhZCAmIENGR19JT1BBRE1PREVfTUFTSykgIT0gUElOX01PREVfRFVNQl8xOF9TUEkpCisJCXdy
aXRlbChpb3BhZCwgZmJpLT5yZWdfYmFzZSArIFNQVV9JT1BBRF9DT05UUk9MKTsKKworCXJldHVy
biByZXQ7Cit9CitFWFBPUlRfU1lNQk9MKHB4YTE2OGZiX3NwaV9zZW5kKTsKKwogc3RhdGljIGlu
dCBkZXRlcm1pbmVfYmVzdF9waXhfZm10KHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyKQog
ewogCS8qCkBAIC03MjgsNiArODA2LDkgQEAgc3RhdGljIGludCBfX2luaXQgcHhhMTY4ZmJfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAl3cml0ZWwoMCwgZmJpLT5yZWdfYmFz
ZSArIExDRF9TUFVfU1JBTV9QQVJBMCk7CiAJd3JpdGVsKENGR19DU0JfMjU2eDMyKDB4MSl8Q0ZH
X0NTQl8yNTZ4MjQoMHgxKXxDRkdfQ1NCXzI1Nng4KDB4MSksCiAJCWZiaS0+cmVnX2Jhc2UgKyBM
Q0RfU1BVX1NSQU1fUEFSQTEpOworCWlmICgobWktPnNwaV9jdHJsICE9IC0xKSAmJiAobWktPnNw
aV9jdHJsICYgQ0ZHX1NQSV9FTkFfTUFTSykpCisJCXdyaXRlbChtaS0+c3BpX2N0cmwsIGZiaS0+
cmVnX2Jhc2UgKyBMQ0RfU1BVX1NQSV9DVFJMKTsKKwogCiAJLyoKIAkgKiBBbGxvY2F0ZSBjb2xv
ciBtYXAuCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmggYi9kcml2ZXJzL3Zp
ZGVvL3B4YTE2OGZiLmgKaW5kZXggZWVlMDkyNy4uNTVlYzRkYyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy92aWRlby9weGExNjhmYi5oCisrKyBiL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuaApAQCAtMTcw
LDI5ICsxNzAsNyBAQAogI2RlZmluZSAgICAgRE1BX0ZSQU1FX0NOVF9NQVNLCQkJMHgwMDAwMDAw
MyAgLyogVmlkZW8gKi8KIAogLyogU1BJIENvbnRyb2wgUmVnaXN0ZXIuICovCi0jZGVmaW5lIExD
RF9TUFVfU1BJX0NUUkwJCQkweDAxODAKLSNkZWZpbmUgICAgIENGR19TQ0xLQ05UKGRpdikJCQko
KGRpdikgPDwgMjQpICAvKiAweEZGfjB4MiAqLwotI2RlZmluZSAgICAgQ0ZHX1NDTEtDTlRfTUFT
SwkJCTB4RkYwMDAwMDAKLSNkZWZpbmUgICAgIENGR19SWEJJVFMocngpCQkJKChyeCkgPDwgMTYp
ICAgLyogMHgxRn4weDEgKi8KLSNkZWZpbmUgICAgIENGR19SWEJJVFNfTUFTSwkJCTB4MDBGRjAw
MDAKLSNkZWZpbmUgICAgIENGR19UWEJJVFModHgpCQkJKCh0eCkgPDwgOCkgICAgLyogMHgxRn4w
eDEgKi8KLSNkZWZpbmUgICAgIENGR19UWEJJVFNfTUFTSwkJCTB4MDAwMEZGMDAKLSNkZWZpbmUg
ICAgIENGR19DTEtJTlYoY2xrKQkJCSgoY2xrKSA8PCA3KQotI2RlZmluZSAgICAgQ0ZHX0NMS0lO
Vl9NQVNLCQkJMHgwMDAwMDA4MAotI2RlZmluZSAgICAgQ0ZHX0tFRVBYRkVSKHRyYW5zZmVyKQkJ
KCh0cmFuc2ZlcikgPDwgNikKLSNkZWZpbmUgICAgIENGR19LRUVQWEZFUl9NQVNLCQkJMHgwMDAw
MDA0MAotI2RlZmluZSAgICAgQ0ZHX1JYQklUU1RPMChyeCkJCQkoKHJ4KSA8PCA1KQotI2RlZmlu
ZSAgICAgQ0ZHX1JYQklUU1RPMF9NQVNLCQkJMHgwMDAwMDAyMAotI2RlZmluZSAgICAgQ0ZHX1RY
QklUU1RPMCh0eCkJCQkoKHR4KSA8PCA0KQotI2RlZmluZSAgICAgQ0ZHX1RYQklUU1RPMF9NQVNL
CQkJMHgwMDAwMDAxMAotI2RlZmluZSAgICAgQ0ZHX1NQSV9FTkEoc3BpKQkJCSgoc3BpKSA8PCAz
KQotI2RlZmluZSAgICAgQ0ZHX1NQSV9FTkFfTUFTSwkJCTB4MDAwMDAwMDgKLSNkZWZpbmUgICAg
IENGR19TUElfU0VMKHNwaSkJCQkoKHNwaSkgPDwgMikKLSNkZWZpbmUgICAgIENGR19TUElfU0VM
X01BU0sJCQkweDAwMDAwMDA0Ci0jZGVmaW5lICAgICBDRkdfU1BJXzNXNFdCKHdpcmUpCQkJKCh3
aXJlKSA8PCAxKQotI2RlZmluZSAgICAgQ0ZHX1NQSV8zVzRXQl9NQVNLCQkJMHgwMDAwMDAwMgot
I2RlZmluZSAgICAgQ0ZHX1NQSV9TVEFSVChzdGFydCkJCShzdGFydCkKLSNkZWZpbmUgICAgIENG
R19TUElfU1RBUlRfTUFTSwkJCTB4MDAwMDAwMDEKKy8qIEZvciBTUEkgcmVnaXN0ZXIsIHBsZWFz
ZSByZWZlciB0byBpbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmggKi8KIAogLyogU1BJIFR4IERhdGEg
UmVnaXN0ZXIgKi8KICNkZWZpbmUgTENEX1NQVV9TUElfVFhEQVRBCQkJMHgwMTg0CmRpZmYgLS1n
aXQgYS9pbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmggYi9pbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmgK
aW5kZXggYjVjYzcyZi4uMDFjMThiYyAxMDA2NDQKLS0tIGEvaW5jbHVkZS92aWRlby9weGExNjhm
Yi5oCisrKyBiL2luY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaApAQCAtMTQsNiArMTQsMzIgQEAKICNp
bmNsdWRlIDxsaW51eC9mYi5oPgogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogCisvKiBT
UEkgQ29udHJvbCBSZWdpc3Rlci4gKi8KKyNkZWZpbmUgTENEX1NQVV9TUElfQ1RSTAkJMHgwMTgw
CisjZGVmaW5lICAgICBDRkdfU0NMS0NOVChkaXYpCQkoKGRpdikgPDwgMjQpICAvKiAweEZGfjB4
MiAqLworI2RlZmluZSAgICAgQ0ZHX1NDTEtDTlRfTUFTSwkJMHhGRjAwMDAwMAorLyogU1BJIFJY
L1RYIGJpdCBsZW5ndGgsIDB4MUZ+MHgxLCAweDE6IDJiaXRzIC4uLiAweDFGOiAzMmJpdHMgKi8K
KyNkZWZpbmUgICAgIENGR19SWEJJVFMocngpCQkoKHJ4IC0gMSkgPDwgMTYpCisjZGVmaW5lICAg
ICBDRkdfUlhCSVRTX01BU0sJCTB4MDBGRjAwMDAKKyNkZWZpbmUgICAgIENGR19UWEJJVFModHgp
ICAgICAgICAgICAgICAoKHR4IC0gMSkgPDwgOCkKKyNkZWZpbmUgICAgIENGR19UWEJJVFNfTUFT
SwkJMHgwMDAwRkYwMAorI2RlZmluZSAgICAgQ0ZHX0NMS0lOVihjbGspCQkoKGNsaykgPDwgNykK
KyNkZWZpbmUgICAgIENGR19DTEtJTlZfTUFTSwkJMHgwMDAwMDA4MAorI2RlZmluZSAgICAgQ0ZH
X0tFRVBYRkVSKHRyYW5zZmVyKQkoKHRyYW5zZmVyKSA8PCA2KQorI2RlZmluZSAgICAgQ0ZHX0tF
RVBYRkVSX01BU0sJCTB4MDAwMDAwNDAKKyNkZWZpbmUgICAgIENGR19SWEJJVFNUTzAocngpCQko
KHJ4KSA8PCA1KQorI2RlZmluZSAgICAgQ0ZHX1JYQklUU1RPMF9NQVNLCQkweDAwMDAwMDIwCisj
ZGVmaW5lICAgICBDRkdfVFhCSVRTVE8wKHR4KQkJKCh0eCkgPDwgNCkKKyNkZWZpbmUgICAgIENG
R19UWEJJVFNUTzBfTUFTSwkJMHgwMDAwMDAxMAorI2RlZmluZSAgICAgQ0ZHX1NQSV9FTkEoc3Bp
KQkJKChzcGkpIDw8IDMpCisjZGVmaW5lICAgICBDRkdfU1BJX0VOQV9NQVNLCQkweDAwMDAwMDA4
CisjZGVmaW5lICAgICBDRkdfU1BJX1NFTChzcGkpCQkoKHNwaSkgPDwgMikgLyogMTogcG9ydDE7
IDA6IHBvcnQwICovCisjZGVmaW5lICAgICBDRkdfU1BJX1NFTF9NQVNLCQkweDAwMDAwMDA0Cisj
ZGVmaW5lICAgICBDRkdfU1BJXzNXNFdCKHdpcmUpICAgICAgICAgKCh3aXJlKTw8MSkgLyogMTog
My13aXJlOyAwOiA0LXdpcmUgKi8KKyNkZWZpbmUgICAgIENGR19TUElfM1c0V0JfTUFTSwkJMHgw
MDAwMDAwMgorI2RlZmluZSAgICAgQ0ZHX1NQSV9TVEFSVChzdGFydCkJKHN0YXJ0KQorI2RlZmlu
ZSAgICAgQ0ZHX1NQSV9TVEFSVF9NQVNLCQkweDAwMDAwMDAxCisKIC8qIER1bWIgaW50ZXJmYWNl
ICovCiAjZGVmaW5lIFBJTl9NT0RFX0RVTUJfMjQJCTAKICNkZWZpbmUgUElOX01PREVfRFVNQl8x
OF9TUEkJCTEKQEAgLTEyMiw2ICsxNDgsMjcgQEAgc3RydWN0IHB4YTE2OGZiX21hY2hfaW5mbyB7
CiAJdW5zaWduZWQJcGFuZWxfcmJzd2FwOjE7CiAJdW5zaWduZWQJYWN0aXZlOjE7CiAJdW5zaWdu
ZWQJZW5hYmxlX2xjZDoxOworCS8qCisJICogU1BJIGNvbnRyb2wKKwkgKi8KKwl1bnNpZ25lZCBp
bnQJc3BpX2N0cmw7CisJdW5zaWduZWQgaW50CXNwaV9ncGlvX2NzOworCXVuc2lnbmVkIGludCAJ
c3BpX2dwaW9fcmVzZXQ7CisJLyoKKwkgKiBwb3dlciBvbi9vZmYgZnVuY3Rpb24uCisJICovCisJ
aW50ICgqcHhhMTY4ZmJfbGNkX3Bvd2VyKShzdHJ1Y3QgcHhhMTY4ZmJfaW5mbyAqLAorCQkJdW5z
aWduZWQgaW50LCB1bnNpZ25lZCBpbnQsIGludCk7CiB9OwogCisvKiBTUEkgdXRpbGl0eSBmb3Ig
Y29uZmlndXJlIHBhbmVsIFNQSSBjb21tYW5kLgorICogdmFsdWU6IGNvbW1hbmQgYXJyYXksIGVs
ZW1lbnQgc2hvdWxkIGJlIDEsIDIgb3IgNCBieXRlIGFsaWduZWQuCisgKiBjb3VudDogY29tbWFu
ZCBhcnJheSBsZW5ndGgKKyAqIHNwaV9ncGlvX2NzOiBncGlvIG51bWJlciBmb3Igc3BpIGNoaXAg
c2VsZWN0CisgKiBjc19hY3RpdmU6IENTIGFjdGl2ZSBwb2xhcml0eSBmb3IgU1BJIHRyYW5zYWN0
aW9uCisgKiBpbnRlcnZhbF91czogdGltZSBpbnRlcnZhbCBiZXR3ZWVuIHR3byBjb21tYW5kcywg
dXMgYXMgdW5pdCAqLworaW50IHB4YTE2OGZiX3NwaV9zZW5kKHN0cnVjdCBweGExNjhmYl9pbmZv
ICpmYmksIHZvaWQgKnZhbHVlLCBpbnQgY291bnQsCisJCXVuc2lnbmVkIGludCBzcGlfZ3Bpb19j
cywgdW5zaWduZWQgaW50IGNzX2FjdGl2ZSwKKwkJdW5zaWduZWQgaW50IGludGVydmFsX3VzKTsK
KwogI2VuZGlmIC8qIF9fQVNNX01BQ0hfUFhBMTY4RkJfSCAqLwotLSAKMS41LjQuMwoK
--0016e64907d2478947047879b62d--
