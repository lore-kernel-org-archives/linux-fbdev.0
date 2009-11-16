From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:34:39 +0000
Subject: [PATCH 4/8] pxa: delete redundant vsync/hsync revert flag
Message-Id: <7c34ac520911160134r736e78cfh1d968fcf1d70e123@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64e575eee8090047879b788"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
In-Reply-To: <7c34ac520911100012x3dfa948bn3e5106fc4c7c04f9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64e575eee8090047879b788
Content-Type: text/plain; charset=ISO-8859-1

From: Jun Nie <njun@marvell.com>
Date: Tue, 10 Nov 2009 15:11:36 +0800
Subject: [PATCH] pxa: delete redundant vsync/hsync revert flag
var.sync can cover its function

Signed-off-by: Jun Nie <njun@marvell.com>
---
 include/video/pxa168fb.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index 01c18bc..53919fe 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -143,8 +143,6 @@ struct pxa168fb_mach_info {
 	unsigned	invert_composite_blank:1;
 	unsigned	invert_pix_val_ena:1;
 	unsigned	invert_pixclock:1;
-	unsigned	invert_vsync:1;
-	unsigned	invert_hsync:1;
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
-- 
1.5.4.3

--0016e64e575eee8090047879b788
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0004-pxa-delete-redundant-vsync-hsync-revert-flag-var.sy.patch"
Content-Disposition: attachment; 
	filename="0004-pxa-delete-redundant-vsync-hsync-revert-flag-var.sy.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g231a29w0

RnJvbSBhYjgzYTU2NzVjMzY0NDYwNDVjYmFmMTI0ZjdhYTg2ODg1Y2I3NzM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDE1OjExOjM2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBkZWxldGUg
cmVkdW5kYW50IHZzeW5jL2hzeW5jIHJldmVydCBmbGFnIHZhci5zeW5jIGNhbiBjb3ZlciBpdHMg
ZnVuY3Rpb24KClNpZ25lZC1vZmYtYnk6IEp1biBOaWUgPG5qdW5AbWFydmVsbC5jb20+Ci0tLQog
aW5jbHVkZS92aWRlby9weGExNjhmYi5oIHwgICAgMiAtLQogMSBmaWxlcyBjaGFuZ2VkLCAwIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS92aWRlby9w
eGExNjhmYi5oIGIvaW5jbHVkZS92aWRlby9weGExNjhmYi5oCmluZGV4IDAxYzE4YmMuLjUzOTE5
ZmUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaAorKysgYi9pbmNsdWRlL3Zp
ZGVvL3B4YTE2OGZiLmgKQEAgLTE0Myw4ICsxNDMsNiBAQCBzdHJ1Y3QgcHhhMTY4ZmJfbWFjaF9p
bmZvIHsKIAl1bnNpZ25lZAlpbnZlcnRfY29tcG9zaXRlX2JsYW5rOjE7CiAJdW5zaWduZWQJaW52
ZXJ0X3BpeF92YWxfZW5hOjE7CiAJdW5zaWduZWQJaW52ZXJ0X3BpeGNsb2NrOjE7Ci0JdW5zaWdu
ZWQJaW52ZXJ0X3ZzeW5jOjE7Ci0JdW5zaWduZWQJaW52ZXJ0X2hzeW5jOjE7CiAJdW5zaWduZWQJ
cGFuZWxfcmJzd2FwOjE7CiAJdW5zaWduZWQJYWN0aXZlOjE7CiAJdW5zaWduZWQJZW5hYmxlX2xj
ZDoxOwotLSAKMS41LjQuMwoK
--0016e64e575eee8090047879b788--
