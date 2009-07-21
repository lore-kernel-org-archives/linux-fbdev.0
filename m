From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH] [ARM] pxafb: switch to dev_pm_ops
Date: Tue, 21 Jul 2009 17:54:24 +0300
Message-ID: <f870da180907210754j5ce87c96ke2ae28165b017c18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636416cf72fa422046f386e2a
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

--001636416cf72fa422046f386e2a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/video/pxafb.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index c69d6c4..e9797d4 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1631,30 +1631,30 @@ pxafb_freq_policy(struct notifier_block *nb,
unsigned long val, void *data)
 }
 #endif

-#ifdef CONFIG_PM
 /*
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int pxafb_suspend(struct platform_device *dev, pm_message_t state)
+static int pxafb_suspend(struct device *dev)
 {
-	struct pxafb_info *fbi = platform_get_drvdata(dev);
+	struct pxafb_info *fbi = dev_get_drvdata(dev);

 	set_ctrlr_state(fbi, C_DISABLE_PM);
 	return 0;
 }

-static int pxafb_resume(struct platform_device *dev)
+static int pxafb_resume(struct device *dev)
 {
-	struct pxafb_info *fbi = platform_get_drvdata(dev);
+	struct pxafb_info *fbi = dev_get_drvdata(dev);

 	set_ctrlr_state(fbi, C_ENABLE_PM);
 	return 0;
 }
-#else
-#define pxafb_suspend	NULL
-#define pxafb_resume	NULL
-#endif
+
+static struct dev_pm_ops pxafb_pm_ops = {
+	.suspend	= pxafb_suspend,
+	.resume		= pxafb_resume,
+};

 static int __devinit pxafb_init_video_memory(struct pxafb_info *fbi)
 {
@@ -2246,11 +2246,10 @@ static int __devexit pxafb_remove(struct
platform_device *dev)
 static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
 	.remove 	= __devexit_p(pxafb_remove),
-	.suspend	= pxafb_suspend,
-	.resume		= pxafb_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "pxa2xx-fb",
+		.pm	= &pxafb_pm_ops,
 	},
 };

-- 
1.6.0.6



-- 
	Sincerely Yours,
		Mike.

--001636416cf72fa422046f386e2a
Content-Type: application/octet-stream; 
	name="0004--ARM-pxafb-switch-to-dev_pm_ops.patch"
Content-Disposition: attachment; 
	filename="0004--ARM-pxafb-switch-to-dev_pm_ops.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxeqxpj60

RnJvbSA2MjEyNjVjZjFiNjc0Nzk4NWI3MDkyNjYxYjJiZTI0MDVjMDRiYjVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWtlIFJhcG9wb3J0IDxtaWtlQGNvbXB1bGFiLmNvLmlsPgpE
YXRlOiBUdWUsIDIxIEp1bCAyMDA5IDE3OjUxOjUwICswMzAwClN1YmplY3Q6IFtQQVRDSF0gW0FS
TV0gcHhhZmI6IHN3aXRjaCB0byBkZXZfcG1fb3BzCgpTaWduZWQtb2ZmLWJ5OiBNaWtlIFJhcG9w
b3J0IDxtaWtlQGNvbXB1bGFiLmNvLmlsPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhZmIuYyB8ICAg
MjEgKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vcHhhZmIuYyBi
L2RyaXZlcnMvdmlkZW8vcHhhZmIuYwppbmRleCBjNjlkNmM0Li5lOTc5N2Q0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3ZpZGVvL3B4YWZiLmMKKysrIGIvZHJpdmVycy92aWRlby9weGFmYi5jCkBAIC0x
NjMxLDMwICsxNjMxLDMwIEBAIHB4YWZiX2ZyZXFfcG9saWN5KHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqbmIsIHVuc2lnbmVkIGxvbmcgdmFsLCB2b2lkICpkYXRhKQogfQogI2VuZGlmCiAKLSNpZmRl
ZiBDT05GSUdfUE0KIC8qCiAgKiBQb3dlciBtYW5hZ2VtZW50IGhvb2tzLiAgTm90ZSB0aGF0IHdl
IHdvbid0IGJlIGNhbGxlZCBmcm9tIElSUSBjb250ZXh0LAogICogdW5saWtlIHRoZSBibGFuayBm
dW5jdGlvbnMgYWJvdmUsIHNvIHdlIG1heSBzbGVlcC4KICAqLwotc3RhdGljIGludCBweGFmYl9z
dXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwgcG1fbWVzc2FnZV90IHN0YXRlKQor
c3RhdGljIGludCBweGFmYl9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKLQlzdHJ1Y3Qg
cHhhZmJfaW5mbyAqZmJpID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgcHhh
ZmJfaW5mbyAqZmJpID0gZGV2X2dldF9kcnZkYXRhKGRldik7CiAKIAlzZXRfY3RybHJfc3RhdGUo
ZmJpLCBDX0RJU0FCTEVfUE0pOwogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IHB4YWZiX3Jl
c3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCitzdGF0aWMgaW50IHB4YWZiX3Jlc3Vt
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7Ci0Jc3RydWN0IHB4YWZiX2luZm8gKmZiaSA9IHBsYXRm
b3JtX2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0IHB4YWZiX2luZm8gKmZiaSA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOwogCiAJc2V0X2N0cmxyX3N0YXRlKGZiaSwgQ19FTkFCTEVfUE0pOwogCXJl
dHVybiAwOwogfQotI2Vsc2UKLSNkZWZpbmUgcHhhZmJfc3VzcGVuZAlOVUxMCi0jZGVmaW5lIHB4
YWZiX3Jlc3VtZQlOVUxMCi0jZW5kaWYKKworc3RhdGljIHN0cnVjdCBkZXZfcG1fb3BzIHB4YWZi
X3BtX29wcyA9IHsKKwkuc3VzcGVuZAk9IHB4YWZiX3N1c3BlbmQsCisJLnJlc3VtZQkJPSBweGFm
Yl9yZXN1bWUsCit9OwogCiBzdGF0aWMgaW50IF9fZGV2aW5pdCBweGFmYl9pbml0X3ZpZGVvX21l
bW9yeShzdHJ1Y3QgcHhhZmJfaW5mbyAqZmJpKQogewpAQCAtMjI0NiwxMSArMjI0NiwxMCBAQCBz
dGF0aWMgaW50IF9fZGV2ZXhpdCBweGFmYl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
ZGV2KQogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgcHhhZmJfZHJpdmVyID0gewogCS5w
cm9iZQkJPSBweGFmYl9wcm9iZSwKIAkucmVtb3ZlIAk9IF9fZGV2ZXhpdF9wKHB4YWZiX3JlbW92
ZSksCi0JLnN1c3BlbmQJPSBweGFmYl9zdXNwZW5kLAotCS5yZXN1bWUJCT0gcHhhZmJfcmVzdW1l
LAogCS5kcml2ZXIJCT0gewogCQkub3duZXIJPSBUSElTX01PRFVMRSwKIAkJLm5hbWUJPSAicHhh
Mnh4LWZiIiwKKwkJLnBtCT0gJnB4YWZiX3BtX29wcywKIAl9LAogfTsKIAotLSAKMS42LjAuNgoK
--001636416cf72fa422046f386e2a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--001636416cf72fa422046f386e2a--
