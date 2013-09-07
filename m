From: David Herrmann <dh.herrmann@gmail.com>
Date: Sat, 07 Sep 2013 12:25:47 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CANq1E4RAG+sJWbMShs5te89NAEQ6d=JRRry5NxG690VJTc4zmQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="047d7bd76dac434a1b04e5ca410d"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--047d7bd76dac434a1b04e5ca410d
Content-Type: text/plain; charset=ISO-8859-1

Hi Tom

On Sat, Sep 7, 2013 at 1:47 PM, Tom Gundersen <teg@jklm.no> wrote:
> On Sat, Sep 7, 2013 at 1:18 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> On Sat, Sep 7, 2013 at 11:26 AM, Tom Gundersen <teg@jklm.no> wrote:
>>> On Fri, Sep 6, 2013 at 6:11 PM, Tom Gundersen <teg@jklm.no> wrote:
>>>> The driver seems to load ok, but sadly it does not give any output. If
>>>> I boot via the gummiboot menu the screen remains black, and if I don't
>>>> enter the gummiboot menu the screen remains grey (it is a Mac).
>>>
>>> My apologies, this was a config error (I somehow ended up with
>>> FRAMEBUFFER_CONSOLE=m, which works fine with inteldrmfb, but obviously
>>> not with any of the compiled in ones).
>>
>> Good, I almost went crazy looking for an error. Does that mean
>> simplefb works for you?
>
> Sorry about that! Yes, it now works.

No worries. Going crazy is part of working on the kernel, I guess.

>> I guess the x86-sysfb patch is still needed?
>
> Yes, that is still needed.

Ok, I will keep watching it then.

>> Now I only wonder why the i915 issue showed up. Is it also solved with
>> a built-in fbcon?
>
> Sadly, no, that problem persists.

I will let Daniel know on IRC.

> A related question: is it expected that simplefb should be
> significantly slower than efifb, or is that something worth looking
> into? My boot with simplefb is roughly five seconds slower than with
> efifb. Coincidentally, I notice the same (or similar slowdown) with
> inteldrmfb when I see the oops (but not otherwise).

That is probably related to the missing write-combine tag in ioremap.
Stephen, any objections to this attached patch?
Tom, if this solves the speed-issues, I will send it out once I get home.

Thanks
David

(Patch also attached in case of new-lines issues)

From dbfb8e12166d494cd60823cbe84134d5d1a73ec8 Mon Sep 17 00:00:00 2001
From: David Herrmann <dh.herrmann@gmail.com>
Date: Sat, 7 Sep 2013 14:22:01 +0200
Subject: [PATCH] devm/simplefb: introduce and use devm_ioremap_wc()

We want to use devm_ioremap_nocache() or even devm_ioremap_wc() to speed
up fbdev writes _a lot_. As devm_ioremap_wc() doesn't exist, yet,
introduce it along the way. Note that ioremap_wc() is aliases to
ioremap_nocache() in asm-generic/{io,iomem}.h so we can safely expect all
architectures to either provide it or use the same alias.

Reported-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/video/simplefb.c |  4 ++--
 include/linux/io.h       |  2 ++
 lib/devres.c             | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d78106..a29f1c4 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -212,8 +212,8 @@ static int simplefb_probe(struct platform_device *pdev)

  info->fbops = &simplefb_ops;
  info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
- info->screen_base = devm_ioremap(&pdev->dev, info->fix.smem_start,
- info->fix.smem_len);
+ info->screen_base = devm_ioremap_wc(&pdev->dev, info->fix.smem_start,
+    info->fix.smem_len);
  if (!info->screen_base) {
  framebuffer_release(info);
  return -ENODEV;
diff --git a/include/linux/io.h b/include/linux/io.h
index f4f42fa..c529410 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -62,6 +62,8 @@ void __iomem *devm_ioremap(struct device *dev,
resource_size_t offset,
     unsigned long size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
     unsigned long size);
+void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
+      unsigned long size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
  const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index 8235331..34af7a9 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -72,6 +72,34 @@ void __iomem *devm_ioremap_nocache(struct device
*dev, resource_size_t offset,
 EXPORT_SYMBOL(devm_ioremap_nocache);

 /**
+ * devm_ioremap_wc - Managed ioremap_wc()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_wc().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
+      unsigned long size)
+{
+ void __iomem **ptr, *addr;
+
+ ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+ if (!ptr)
+ return NULL;
+
+ addr = ioremap_wc(offset, size);
+ if (addr) {
+ *ptr = addr;
+ devres_add(dev, ptr);
+ } else
+ devres_free(ptr);
+
+ return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_wc);
+
+/**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
  * @addr: Address to unmap
-- 
1.8.4

--047d7bd76dac434a1b04e5ca410d
Content-Type: application/octet-stream; 
	name="0001-devm-simplefb-introduce-and-use-devm_ioremap_wc.patch"
Content-Disposition: attachment; 
	filename="0001-devm-simplefb-introduce-and-use-devm_ioremap_wc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hlat5iui0

RnJvbSBkYmZiOGUxMjE2NmQ0OTRjZDYwODIzY2JlODQxMzRkNWQxYTczZWM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIZXJybWFubiA8ZGguaGVycm1hbm5AZ21haWwuY29t
PgpEYXRlOiBTYXQsIDcgU2VwIDIwMTMgMTQ6MjI6MDEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBk
ZXZtL3NpbXBsZWZiOiBpbnRyb2R1Y2UgYW5kIHVzZSBkZXZtX2lvcmVtYXBfd2MoKQoKV2Ugd2Fu
dCB0byB1c2UgZGV2bV9pb3JlbWFwX25vY2FjaGUoKSBvciBldmVuIGRldm1faW9yZW1hcF93Yygp
IHRvIHNwZWVkCnVwIGZiZGV2IHdyaXRlcyBfYSBsb3RfLiBBcyBkZXZtX2lvcmVtYXBfd2MoKSBk
b2Vzbid0IGV4aXN0LCB5ZXQsCmludHJvZHVjZSBpdCBhbG9uZyB0aGUgd2F5LiBOb3RlIHRoYXQg
aW9yZW1hcF93YygpIGlzIGFsaWFzZXMgdG8KaW9yZW1hcF9ub2NhY2hlKCkgaW4gYXNtLWdlbmVy
aWMve2lvLGlvbWVtfS5oIHNvIHdlIGNhbiBzYWZlbHkgZXhwZWN0IGFsbAphcmNoaXRlY3R1cmVz
IHRvIGVpdGhlciBwcm92aWRlIGl0IG9yIHVzZSB0aGUgc2FtZSBhbGlhcy4KClJlcG9ydGVkLWJ5
OiBUb20gR3VuZGVyc2VuIDx0ZWdAamtsbS5ubz4KU2lnbmVkLW9mZi1ieTogRGF2aWQgSGVycm1h
bm4gPGRoLmhlcnJtYW5uQGdtYWlsLmNvbT4KQ2M6IFN0ZXBoZW4gV2FycmVuIDxzd2FycmVuQHd3
d2RvdG9yZy5vcmc+CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPgpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0t
CiBkcml2ZXJzL3ZpZGVvL3NpbXBsZWZiLmMgfCAgNCArKy0tCiBpbmNsdWRlL2xpbnV4L2lvLmgg
ICAgICAgfCAgMiArKwogbGliL2RldnJlcy5jICAgICAgICAgICAgIHwgMjggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vc2ltcGxlZmIuYyBiL2RyaXZl
cnMvdmlkZW8vc2ltcGxlZmIuYwppbmRleCA4ZDc4MTA2Li5hMjlmMWM0IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3ZpZGVvL3NpbXBsZWZiLmMKKysrIGIvZHJpdmVycy92aWRlby9zaW1wbGVmYi5jCkBA
IC0yMTIsOCArMjEyLDggQEAgc3RhdGljIGludCBzaW1wbGVmYl9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQogCiAJaW5mby0+ZmJvcHMgPSAmc2ltcGxlZmJfb3BzOwogCWluZm8t
PmZsYWdzID0gRkJJTkZPX0RFRkFVTFQgfCBGQklORk9fTUlTQ19GSVJNV0FSRTsKLQlpbmZvLT5z
Y3JlZW5fYmFzZSA9IGRldm1faW9yZW1hcCgmcGRldi0+ZGV2LCBpbmZvLT5maXguc21lbV9zdGFy
dCwKLQkJCQkJIGluZm8tPmZpeC5zbWVtX2xlbik7CisJaW5mby0+c2NyZWVuX2Jhc2UgPSBkZXZt
X2lvcmVtYXBfd2MoJnBkZXYtPmRldiwgaW5mby0+Zml4LnNtZW1fc3RhcnQsCisJCQkJCSAgICBp
bmZvLT5maXguc21lbV9sZW4pOwogCWlmICghaW5mby0+c2NyZWVuX2Jhc2UpIHsKIAkJZnJhbWVi
dWZmZXJfcmVsZWFzZShpbmZvKTsKIAkJcmV0dXJuIC1FTk9ERVY7CmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2lvLmggYi9pbmNsdWRlL2xpbnV4L2lvLmgKaW5kZXggZjRmNDJmYS4uYzUyOTQx
MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pby5oCisrKyBiL2luY2x1ZGUvbGludXgvaW8u
aApAQCAtNjIsNiArNjIsOCBAQCB2b2lkIF9faW9tZW0gKmRldm1faW9yZW1hcChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHJlc291cmNlX3NpemVfdCBvZmZzZXQsCiAJCQkgICAgdW5zaWduZWQgbG9uZyBz
aXplKTsKIHZvaWQgX19pb21lbSAqZGV2bV9pb3JlbWFwX25vY2FjaGUoc3RydWN0IGRldmljZSAq
ZGV2LCByZXNvdXJjZV9zaXplX3Qgb2Zmc2V0LAogCQkJCSAgICB1bnNpZ25lZCBsb25nIHNpemUp
Owordm9pZCBfX2lvbWVtICpkZXZtX2lvcmVtYXBfd2Moc3RydWN0IGRldmljZSAqZGV2LCByZXNv
dXJjZV9zaXplX3Qgb2Zmc2V0LAorCQkJICAgICAgdW5zaWduZWQgbG9uZyBzaXplKTsKIHZvaWQg
ZGV2bV9pb3VubWFwKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCBfX2lvbWVtICphZGRyKTsKIGlu
dCBjaGVja19zaWduYXR1cmUoY29uc3Qgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICppb19hZGRyLAog
CQkJY29uc3QgdW5zaWduZWQgY2hhciAqc2lnbmF0dXJlLCBpbnQgbGVuZ3RoKTsKZGlmZiAtLWdp
dCBhL2xpYi9kZXZyZXMuYyBiL2xpYi9kZXZyZXMuYwppbmRleCA4MjM1MzMxLi4zNGFmN2E5IDEw
MDY0NAotLS0gYS9saWIvZGV2cmVzLmMKKysrIGIvbGliL2RldnJlcy5jCkBAIC03Miw2ICs3Miwz
NCBAQCB2b2lkIF9faW9tZW0gKmRldm1faW9yZW1hcF9ub2NhY2hlKHN0cnVjdCBkZXZpY2UgKmRl
diwgcmVzb3VyY2Vfc2l6ZV90IG9mZnNldCwKIEVYUE9SVF9TWU1CT0woZGV2bV9pb3JlbWFwX25v
Y2FjaGUpOwogCiAvKioKKyAqIGRldm1faW9yZW1hcF93YyAtIE1hbmFnZWQgaW9yZW1hcF93Yygp
CisgKiBAZGV2OiBHZW5lcmljIGRldmljZSB0byByZW1hcCBJTyBhZGRyZXNzIGZvcgorICogQG9m
ZnNldDogQlVTIG9mZnNldCB0byBtYXAKKyAqIEBzaXplOiBTaXplIG9mIG1hcAorICoKKyAqIE1h
bmFnZWQgaW9yZW1hcF93YygpLiAgTWFwIGlzIGF1dG9tYXRpY2FsbHkgdW5tYXBwZWQgb24gZHJp
dmVyIGRldGFjaC4KKyAqLwordm9pZCBfX2lvbWVtICpkZXZtX2lvcmVtYXBfd2Moc3RydWN0IGRl
dmljZSAqZGV2LCByZXNvdXJjZV9zaXplX3Qgb2Zmc2V0LAorCQkJICAgICAgdW5zaWduZWQgbG9u
ZyBzaXplKQoreworCXZvaWQgX19pb21lbSAqKnB0ciwgKmFkZHI7CisKKwlwdHIgPSBkZXZyZXNf
YWxsb2MoZGV2bV9pb3JlbWFwX3JlbGVhc2UsIHNpemVvZigqcHRyKSwgR0ZQX0tFUk5FTCk7CisJ
aWYgKCFwdHIpCisJCXJldHVybiBOVUxMOworCisJYWRkciA9IGlvcmVtYXBfd2Mob2Zmc2V0LCBz
aXplKTsKKwlpZiAoYWRkcikgeworCQkqcHRyID0gYWRkcjsKKwkJZGV2cmVzX2FkZChkZXYsIHB0
cik7CisJfSBlbHNlCisJCWRldnJlc19mcmVlKHB0cik7CisKKwlyZXR1cm4gYWRkcjsKK30KK0VY
UE9SVF9TWU1CT0woZGV2bV9pb3JlbWFwX3djKTsKKworLyoqCiAgKiBkZXZtX2lvdW5tYXAgLSBN
YW5hZ2VkIGlvdW5tYXAoKQogICogQGRldjogR2VuZXJpYyBkZXZpY2UgdG8gdW5tYXAgZm9yCiAg
KiBAYWRkcjogQWRkcmVzcyB0byB1bm1hcAotLSAKMS44LjQKCg==
--047d7bd76dac434a1b04e5ca410d--
