From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:34:45 +0000
Subject: [PATCH 5/8] pxa: frame buffer support both pxa168 and pxa910
Message-Id: <7c34ac520911160134m16d33fa6p6c43ff2b273e916f@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64be17a50a6ef047879b8b9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012l43680a5fn1ffa2f44d8c27801@mail.gmail.com>
In-Reply-To: <7c34ac520911100012l43680a5fn1ffa2f44d8c27801@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64be17a50a6ef047879b8b9
Content-Type: text/plain; charset=ISO-8859-1

From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 09:43:57 +0800
Subject: [PATCH] pxa: frame buffer support both pxa168 and pxa910

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    6 ++++++
 include/video/pxa168fb.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 6283c16..09ada72 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -882,12 +882,18 @@ failed:
 	return ret;
 }

+ static const struct platform_device_id mmpfb_id_table[] = {
+	 {"pxa168-fb", PXA168_FB},
+	 {"pxa910-fb", PXA910_FB},
+ };
+
 static struct platform_driver pxa168fb_driver = {
 	.driver		= {
 		.name	= "pxa168-fb",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pxa168fb_probe,
+	.id_table	= mmpfb_id_table,
 };

 static int __devinit pxa168fb_init(void)
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 53919fe..da83c94 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -87,6 +87,9 @@
 #define PIX_FMT_PSEUDOCOLOR	20
 #define PIX_FMT_UYVY422PACK	(0x1000|PIX_FMT_YUV422PACK)

+#define PXA168_FB 0x0168
+#define PXA910_FB 0x0910
+
 /*
  * PXA LCD controller private state.
  */
-- 
1.5.4.3

--0016e64be17a50a6ef047879b8b9
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0005-pxa-frame-buffer-support-both-pxa168-and-pxa910.patch"
Content-Disposition: attachment; 
	filename="0005-pxa-frame-buffer-support-both-pxa168-and-pxa910.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g231anvu0

RnJvbSA1NjU4Mjg4NmMyZGQzNTA0NWY2MzNjNWZmNTM4MjRkNjQzNjE0NGIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDA5OjQzOjU3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBmcmFtZSBi
dWZmZXIgc3VwcG9ydCBib3RoIHB4YTE2OCBhbmQgcHhhOTEwCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYyB8ICAg
IDYgKysrKysrCiBpbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmggfCAgICAzICsrKwogMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aWRlby9weGExNjhmYi5jIGIvZHJpdmVycy92aWRlby9weGExNjhmYi5jCmluZGV4IDYy
ODNjMTYuLjA5YWRhNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYworKysg
Yi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMKQEAgLTg4MiwxMiArODgyLDE4IEBAIGZhaWxlZDoK
IAlyZXR1cm4gcmV0OwogfQogCisgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Vf
aWQgbW1wZmJfaWRfdGFibGVbXSA9IHsKKwkgeyJweGExNjgtZmIiLCBQWEExNjhfRkJ9LAorCSB7
InB4YTkxMC1mYiIsIFBYQTkxMF9GQn0sCisgfTsKKwogc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
cml2ZXIgcHhhMTY4ZmJfZHJpdmVyID0gewogCS5kcml2ZXIJCT0gewogCQkubmFtZQk9ICJweGEx
NjgtZmIiLAogCQkub3duZXIJPSBUSElTX01PRFVMRSwKIAl9LAogCS5wcm9iZQkJPSBweGExNjhm
Yl9wcm9iZSwKKwkuaWRfdGFibGUJPSBtbXBmYl9pZF90YWJsZSwKIH07CiAKIHN0YXRpYyBpbnQg
X19kZXZpbml0IHB4YTE2OGZiX2luaXQodm9pZCkKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdmlkZW8v
cHhhMTY4ZmIuaCBiL2luY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaAppbmRleCA1MzkxOWZlLi5kYTgz
Yzk0IDEwMDY0NAotLS0gYS9pbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmgKKysrIGIvaW5jbHVkZS92
aWRlby9weGExNjhmYi5oCkBAIC04Nyw2ICs4Nyw5IEBACiAjZGVmaW5lIFBJWF9GTVRfUFNFVURP
Q09MT1IJMjAKICNkZWZpbmUgUElYX0ZNVF9VWVZZNDIyUEFDSwkoMHgxMDAwfFBJWF9GTVRfWVVW
NDIyUEFDSykKIAorI2RlZmluZSBQWEExNjhfRkIgMHgwMTY4CisjZGVmaW5lIFBYQTkxMF9GQiAw
eDA5MTAKKwogLyoKICAqIFBYQSBMQ0QgY29udHJvbGxlciBwcml2YXRlIHN0YXRlLgogICovCi0t
IAoxLjUuNC4zCgo=
--0016e64be17a50a6ef047879b8b9--
