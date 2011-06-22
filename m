From: "Katsak, William Alexander (Bill)"
Date: Wed, 22 Jun 2011 17:15:38 +0000
Subject: [PATCH] udlfb - Fix for problem with monitor resolution detection /
Message-Id: <76676AFCFD6F05458E27320F9BB714A825120FC640@USNAVSXCHMBSD1.ndc.alcatel-lucent.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_002_76676AFCFD6F05458E27320F9BB714A825120FC640USNAVSXCHMBSD_"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--_002_76676AFCFD6F05458E27320F9BB714A825120FC640USNAVSXCHMBSD_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

This is my first contribution on this list, so please let me know if I am o=
ff with any procedures or anything.

This patch fixes a problem where a DisplayLink device autoselects a subopti=
mal framebuffer resolution. The problem occured with a Plugable UGA-2K-A co=
nnected to a Samsung EX2220X display. In this situation, the driver always =
allocates a 1600x1200 framebuffer, even after it indicates in its output th=
at 1920x1080 is a valid mode. If my interpretation of the code is correct, =
the problem was in the block that selects the best mode. The existing code =
unset the FB_MISC_1ST_DETAIL flag if ANY of the modes is determined to be i=
nvalid (on my adapter, 1680x1680 is invalid). This in turn causes the fb_fi=
nd_best_display() function to disregard the first mode (1920x1080). The com=
ment for the line that unsets the flag implies that this should happen if w=
e have removed the top/best mode...however, this else block is not qualifie=
d, and happens if we remove any mode. I simply put in a condition so that w=
e only unset this flag if the first mode is invalid.

Thanks in advance for your feedback.

Bill Katsak
Bell Laboratories
Alcatel-Lucent, Inc.
william.katsak@alcatel-lucent.com


--_002_76676AFCFD6F05458E27320F9BB714A825120FC640USNAVSXCHMBSD_
Content-Type: text/x-patch; name="udlfb_resolution_fix.patch"
Content-Description: udlfb_resolution_fix.patch
Content-Disposition: attachment; filename="udlfb_resolution_fix.patch";
	size=1499; creation-date="Wed, 22 Jun 2011 11:59:46 GMT";
	modification-date="Wed, 22 Jun 2011 11:59:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjMzMyN2M0MTg3NzYzN2U4MGY5ZjA2YThjZTNiZGNmZThiNGU2ZmE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXaWxsaWFtIEthdHNhayA8d2lsbGlhbS5rYXRzYWtAYWxjYXRl
bC1sdWNlbnQuY29tPgpEYXRlOiBXZWQsIDIyIEp1biAyMDExIDEyOjQ4OjExIC0wNDAwClN1Ympl
Y3Q6IFtQQVRDSF0gVGhpcyBwYXRjaCBmaXhlcyBhIHByb2JsZW0gd2hlcmUgYSBEaXNwbGF5TGlu
ayBkZXZpY2UgYXV0b3NlbGVjdHMgYQogIHN1Ym9wdGltYWwgZnJhbWVidWZmZXIgcmVzb2x1dGlv
bi4KClRoZSBzaXR1YXRpb24gaW4gd2hpY2ggdGhlIHByb2JsZW0gb2NjdXJyZWQgd2FzIHdpdGgg
YSBQbHVnYWJsZSBVR0EtMkstQQpjb25uZWN0ZWQgdG8gYSBTYW1zdW5nIEVYMjIyMFggZGlzcGxh
eS4gVGhlIGRyaXZlciBpbmRpY2F0ZXMgdGhhdAoxOTIweDEwODAgaXMgYSB2YWxpZCBtb2RlICh0
aGUgZmlyc3QgbW9kZSBhdmFpbGFibGUsIGluIGZhY3QpLCBidXQKcHJvY2VlZHMgdG8gc2V0IHRo
ZSBmcmFtZWJ1ZmZlciBzaXplIHRvIDE2MDB4MTIwMC4KClRoZSBwYXRjaCBjb3JyZWN0cyB3aGF0
IHNlZW1zIHRvIGJlIGEgbG9naWMgZXJyb3IsIHJlZ2FyZGluZyB1bnNldHRpbmcKdGhlIEZCX01J
U0NfMVNUX0RFVEFJTCBmbGFnLCBpZiB0aGUgZmlyc3QgKHRvcC9iZXN0KSBtb2RlIGlzIGludmFs
aWQuClRoZSBleGlzdGluZyBjb2RlIHVuc2V0IHRoZSBmbGFnIGlmIEFOWSBtb2RlIHdhcyBpbnZh
bGlkLgotLS0KIGRyaXZlcnMvdmlkZW8vdWRsZmIuYyB8ICAgIDggKysrKysrLS0KIDEgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlkZW8vdWRsZmIuYyBiL2RyaXZlcnMvdmlkZW8vdWRsZmIuYwppbmRleCA1MmIwZjNl
Li44MTZhNGZkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL3VkbGZiLmMKKysrIGIvZHJpdmVy
cy92aWRlby91ZGxmYi5jCkBAIC0xMjMzLDggKzEyMzMsMTIgQEAgc3RhdGljIGludCBkbGZiX3Nl
dHVwX21vZGVzKHN0cnVjdCBkbGZiX2RhdGEgKmRldiwKIAkJCWlmIChkbGZiX2lzX3ZhbGlkX21v
ZGUoJmluZm8tPm1vbnNwZWNzLm1vZGVkYltpXSwgaW5mbykpCiAJCQkJZmJfYWRkX3ZpZGVvbW9k
ZSgmaW5mby0+bW9uc3BlY3MubW9kZWRiW2ldLAogCQkJCQkmaW5mby0+bW9kZWxpc3QpOwotCQkJ
ZWxzZSAvKiBpZiB3ZSd2ZSByZW1vdmVkIHRvcC9iZXN0IG1vZGUgKi8KLQkJCQlpbmZvLT5tb25z
cGVjcy5taXNjICY9IH5GQl9NSVNDXzFTVF9ERVRBSUw7CisJCQllbHNlIHsKKwkJCQlpZiAoaSA9
PSAwKQorCQkJCQkvKiBpZiB3ZSd2ZSByZW1vdmVkIHRvcC9iZXN0IG1vZGUgKi8KKwkJCQkJaW5m
by0+bW9uc3BlY3MubWlzYworCQkJCQkJJj0gfkZCX01JU0NfMVNUX0RFVEFJTDsKKwkJCX0KIAkJ
fQogCiAJCWRlZmF1bHRfdm1vZGUgPSBmYl9maW5kX2Jlc3RfZGlzcGxheSgmaW5mby0+bW9uc3Bl
Y3MsCi0tIAoxLjcuMy40Cgo=

--_002_76676AFCFD6F05458E27320F9BB714A825120FC640USNAVSXCHMBSD_--
