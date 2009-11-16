From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:34:32 +0000
Subject: [PATCH 3/8] pxa: fix offset setting at initialization
Message-Id: <7c34ac520911160134t3e378b28q45c2a662fabfb8d0@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64af4a8985758047879b718"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012w3b441c50w9dffaa1100bcd5b7@mail.gmail.com>
In-Reply-To: <7c34ac520911100012w3b441c50w9dffaa1100bcd5b7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64af4a8985758047879b718
Content-Type: text/plain; charset=ISO-8859-1

From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 09:33:49 +0800
Subject: [PATCH] pxa: fix offset setting at initialization

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index e728be3..6283c16 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -765,6 +765,7 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	info->fix.smem_start = (unsigned long)fbi->fb_start_dma;
+	set_graphics_start(info, 0, 0);

 	/*
 	 * Set video mode according to platform data.
-- 
1.5.4.3

--0016e64af4a8985758047879b718
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0003-pxa-fix-offset-setting-at-initialization.patch"
Content-Disposition: attachment; 
	filename="0003-pxa-fix-offset-setting-at-initialization.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g23198vw0

RnJvbSBjYmZmMTdkZmViMjc1ODQxMTBiMjBlZmVkOTAwYWRkOTg5MWNjMmZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDA5OjMzOjQ5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBmaXggb2Zm
c2V0IHNldHRpbmcgYXQgaW5pdGlhbGl6YXRpb24KClNpZ25lZC1vZmYtYnk6IEp1biBOaWUgPG5q
dW5AbWFydmVsbC5jb20+Ci0tLQogZHJpdmVycy92aWRlby9weGExNjhmYi5jIHwgICAgMSArCiAx
IGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMgYi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMK
aW5kZXggZTcyOGJlMy4uNjI4M2MxNiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9weGExNjhm
Yi5jCisrKyBiL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYwpAQCAtNzY1LDYgKzc2NSw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IHB4YTE2OGZiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiAJfQogCiAJaW5mby0+Zml4LnNtZW1fc3RhcnQgPSAodW5zaWduZWQgbG9uZylmYmktPmZi
X3N0YXJ0X2RtYTsKKwlzZXRfZ3JhcGhpY3Nfc3RhcnQoaW5mbywgMCwgMCk7CiAKIAkvKgogCSAq
IFNldCB2aWRlbyBtb2RlIGFjY29yZGluZyB0byBwbGF0Zm9ybSBkYXRhLgotLSAKMS41LjQuMwoK
--0016e64af4a8985758047879b718--
