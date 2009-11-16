From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:34:27 +0000
Subject: [PATCH 2/8] pxa: support PXA168 LCD platform dependent power on
Message-Id: <7c34ac520911160134w531a2c0aq3f1ee81b93049dd3@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e649c1863bef59047879b753"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
In-Reply-To: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e649c1863bef59047879b753
Content-Type: text/plain; charset=ISO-8859-1

From: Jun Nie <njun@marvell.com>
Date: Mon, 16 Nov 2009 17:16:35 +0800
Subject: [PATCH] pxa: support PXA168 LCD platform dependent power on

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index aec95c4..e728be3 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -845,6 +845,23 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	platform_set_drvdata(pdev, fbi);
+	if (mi->pxa168fb_lcd_power) {
+		if (gpio_is_valid(mi->spi_gpio_cs)) {
+			ret = gpio_request(mi->spi_gpio_cs, "LCD_SPI_CS");
+			if (ret) {
+				dev_err(&pdev->dev,
+					"failed to request GPIO for LCD CS\n");
+				return -EIO;
+			}
+		}
+		ret = mi->pxa168fb_lcd_power(fbi, mi->spi_gpio_cs,
+				mi->spi_gpio_reset, 1);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to power up pxa168-fb\n");
+			goto failed_free_irq;
+		}
+	}
+	dev_info(fbi->dev, "frame buffer detected\n");
 	return 0;

 failed_free_irq:
-- 
1.5.4.3

--0016e649c1863bef59047879b753
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0002-pxa-support-PXA168-LCD-platform-dependent-power-on.patch"
Content-Disposition: attachment; 
	filename="0002-pxa-support-PXA168-LCD-platform-dependent-power-on.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2317zbp0

RnJvbSAwZmU0MWQ2N2EyOWQ2YmFjMTE2ZDVkNTk0MzBmZmQ2ODExOTZlMWY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBNb24s
IDE2IE5vdiAyMDA5IDE3OjE2OjM1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBzdXBwb3J0
IFBYQTE2OCBMQ0QgcGxhdGZvcm0gZGVwZW5kZW50IHBvd2VyIG9uCgpTaWduZWQtb2ZmLWJ5OiBK
dW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYyB8
ICAgMTcgKysrKysrKysrKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMg
Yi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMKaW5kZXggYWVjOTVjNC4uZTcyOGJlMyAxMDA2NDQK
LS0tIGEvZHJpdmVycy92aWRlby9weGExNjhmYi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vcHhhMTY4
ZmIuYwpAQCAtODQ1LDYgKzg0NSwyMyBAQCBzdGF0aWMgaW50IF9faW5pdCBweGExNjhmYl9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCX0KIAogCXBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIGZiaSk7CisJaWYgKG1pLT5weGExNjhmYl9sY2RfcG93ZXIpIHsKKwkJaWYgKGdw
aW9faXNfdmFsaWQobWktPnNwaV9ncGlvX2NzKSkgeworCQkJcmV0ID0gZ3Bpb19yZXF1ZXN0KG1p
LT5zcGlfZ3Bpb19jcywgIkxDRF9TUElfQ1MiKTsKKwkJCWlmIChyZXQpIHsKKwkJCQlkZXZfZXJy
KCZwZGV2LT5kZXYsCisJCQkJCSJmYWlsZWQgdG8gcmVxdWVzdCBHUElPIGZvciBMQ0QgQ1NcbiIp
OworCQkJCXJldHVybiAtRUlPOworCQkJfQorCQl9CisJCXJldCA9IG1pLT5weGExNjhmYl9sY2Rf
cG93ZXIoZmJpLCBtaS0+c3BpX2dwaW9fY3MsCisJCQkJbWktPnNwaV9ncGlvX3Jlc2V0LCAxKTsK
KwkJaWYgKHJldCkgeworCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIHBvd2VyIHVw
IHB4YTE2OC1mYlxuIik7CisJCQlnb3RvIGZhaWxlZF9mcmVlX2lycTsKKwkJfQorCX0KKwlkZXZf
aW5mbyhmYmktPmRldiwgImZyYW1lIGJ1ZmZlciBkZXRlY3RlZFxuIik7CiAJcmV0dXJuIDA7CiAK
IGZhaWxlZF9mcmVlX2lycToKLS0gCjEuNS40LjMKCg==
--0016e649c1863bef59047879b753--
