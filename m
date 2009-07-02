From: InKi Dae <daeinki@gmail.com>
Subject: [PATCH] fixed clock setting for Samsung SoC Framebuffer.
Date: Thu, 2 Jul 2009 18:58:14 +0900
Message-ID: <90b950fc0907020258r4b690e23l11543cc37f5ed4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd183941168d3046db614db
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756229AbZGBJ6V@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Kyungmin Park <kmpark@infradead.org>

--000e0cd183941168d3046db614db
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch corrects CLKVAL_F field value of VIDEO MAIN CONTROLLER 0 REGITSTER.

Frame Rate is 1 / [ { (VSPW+1) + (VBPD+1) + (LIINEVAL + 1) + (VFPD+1)
} x {(HSPW+1) + (HBPD +1)
+ (HFPD+1) + (HOZVAL + 1) } x { ( CLKVAL+1 ) / ( Frequency of Clock
source ) } ] and VCLK = Video Clock Source / (CLKVAL +1).

therefore CLKVAL_F should be "CLKVAL_F = Frequency of Clock source /
pixel clock * refresh".

for this, I added refresh value in platform data like below.
static struct s3c_fb_pd_win xxx_fb_win0 = {
	/* this is to ensure we use win0 */
	.win_mode = {
		.refresh	= 60,
		.pixclock	= (66+4+2+480)*(15+5+3+800),
		.left_margin	= 66,
		.right_margin	= 2,
		.upper_margin	= 15,
		.lower_margin	= 3,
		.hsync_len	= 4,
		.vsync_len	= 5,
		.xres		= 480,
		.yres		= 800,
	},
	.max_bpp	= 32,
	.default_bpp	= 24,
};

static struct s3c_fb_platdata xxx_lcd_pdata __initdata = {
	.win[0]		= &xxx_fb_win0,
	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC
			| VIDCON1_INV_VCLK | VIDCON1_INV_VDEN,
	.setup_gpio	= s5pc1xx_fb_gpio_setup_24bpp,
};

xxx_machine_init()
{
                   .
                   .
                   .
               s3c_fb_set_platdata(&xxx_lcd_pdata);
}

platform data defined in machine code should be setting using
s3c_fb_set_platdata().

I have tested this patch on boards based on s3c6410 and s5pc100 and worked fine.
I attached the patch for s3c-fb.c file.

thanks.

signed-by-off : InKi Dae. <inki.dae@samsung.com>

--000e0cd183941168d3046db614db
Content-Type: application/octet-stream; name="lcd.patch"
Content-Disposition: attachment; filename="lcd.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwnaq5d80

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vczNjLWZiLmMgYi9kcml2ZXJzL3ZpZGVvL3MzYy1m
Yi5jCmluZGV4IDQzNjgwZTUuLmJiNjNjMDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vczNj
LWZiLmMKKysrIGIvZHJpdmVycy92aWRlby9zM2MtZmIuYwpAQCAtMjExLDIzICsyMTEsMjEgQEAg
c3RhdGljIGludCBzM2NfZmJfY2hlY2tfdmFyKHN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFy
LAogCiAvKioKICAqIHMzY19mYl9jYWxjX3BpeGNsaygpIC0gY2FsY3VsYXRlIHRoZSBkaXZpZGVy
IHRvIGNyZWF0ZSB0aGUgcGl4ZWwgY2xvY2suCisgKiBAaWQ6IHdpbmRvdyBpZC4KICAqIEBzZmI6
IFRoZSBoYXJkd2FyZSBzdGF0ZS4KICAqIEBwaXhjbG9jazogVGhlIHBpeGVsIGNsb2NrIHdhbnRl
ZCwgaW4gcGljb3NlY29uZHMuCiAgKgogICogR2l2ZW4gdGhlIHNwZWNpZmllZCBwaXhlbCBjbG9j
aywgd29yayBvdXQgdGhlIG5lY2Vzc2FyeSBkaXZpZGVyIHRvIGdldAogICogY2xvc2UgdG8gdGhl
IG91dHB1dCBmcmVxdWVuY3kuCiAgKi8KLXN0YXRpYyBpbnQgczNjX2ZiX2NhbGNfcGl4Y2xrKHN0
cnVjdCBzM2NfZmIgKnNmYiwgdW5zaWduZWQgaW50IHBpeGNsaykKK3N0YXRpYyBpbnQgczNjX2Zi
X2NhbGNfcGl4Y2xrKHVuc2lnbmVkIGNoYXIgaWQsIHN0cnVjdCBzM2NfZmIgKnNmYiwgdW5zaWdu
ZWQgaW50IHBpeGNsaykKIHsKKwlzdHJ1Y3QgczNjX2ZiX3BkX3dpbiAqd2luID0gc2ZiLT5wZGF0
YS0+d2luW2lkXTsKIAl1bnNpZ25lZCBsb25nIGNsayA9IGNsa19nZXRfcmF0ZShzZmItPmJ1c19j
bGspOwotCXVuc2lnbmVkIGxvbmcgbG9uZyB0bXA7CiAJdW5zaWduZWQgaW50IHJlc3VsdDsKIAot
CXRtcCA9ICh1bnNpZ25lZCBsb25nIGxvbmcpY2xrOwotCXRtcCAqPSBwaXhjbGs7Ci0KLQlkb19k
aXYodG1wLCAxMDAwMDAwMDAwVUwpOwotCXJlc3VsdCA9ICh1bnNpZ25lZCBpbnQpdG1wIC8gMTAw
MDsKKwlwaXhjbGsgKj0gd2luLT53aW5fbW9kZS5yZWZyZXNoOworCXJlc3VsdCA9IGNsayAvIHBp
eGNsazsKIAogCWRldl9kYmcoc2ZiLT5kZXYsICJwaXhjbGs9JXUsIGNsaz0lbHUsIGRpdj0lZCAo
JWx1KVxuIiwKIAkJcGl4Y2xrLCBjbGssIHJlc3VsdCwgY2xrIC8gcmVzdWx0KTsKQEAgLTI2Nyw2
ICsyNjUsNyBAQCBzdGF0aWMgaW50IHMzY19mYl9zZXRfcGFyKHN0cnVjdCBmYl9pbmZvICppbmZv
KQogCXN0cnVjdCBzM2NfZmIgKnNmYiA9IHdpbi0+cGFyZW50OwogCXZvaWQgX19pb21lbSAqcmVn
cyA9IHNmYi0+cmVnczsKIAlpbnQgd2luX25vID0gd2luLT5pbmRleDsKKwl1MzIgb3NkY19kYXRh
ID0gMDsKIAl1MzIgZGF0YTsKIAl1MzIgcGFnZXdpZHRoOwogCWludCBjbGtkaXY7CkBAIC0zMDIs
NyArMzAxLDcgQEAgc3RhdGljIGludCBzM2NfZmJfc2V0X3BhcihzdHJ1Y3QgZmJfaW5mbyAqaW5m
bykKIAkvKiB1c2Ugd2luZG93IDAgYXMgdGhlIGJhc2lzIGZvciB0aGUgbGNkIG91dHB1dCB0aW1p
bmdzICovCiAKIAlpZiAod2luX25vID09IDApIHsKLQkJY2xrZGl2ID0gczNjX2ZiX2NhbGNfcGl4
Y2xrKHNmYiwgdmFyLT5waXhjbG9jayk7CisJCWNsa2RpdiA9IHMzY19mYl9jYWxjX3BpeGNsayh3
aW5fbm8sIHNmYiwgdmFyLT5waXhjbG9jayk7CiAKIAkJZGF0YSA9IHNmYi0+cGRhdGEtPnZpZGNv
bjA7CiAJCWRhdGEgJj0gfihWSURDT04wX0NMS1ZBTF9GX01BU0sgfCBWSURDT04wX0NMS0RJUik7
CkBAIC0zNTksOCArMzU4LDYgQEAgc3RhdGljIGludCBzM2NfZmJfc2V0X3BhcihzdHJ1Y3QgZmJf
aW5mbyAqaW5mbykKIAogCWRhdGEgPSB2YXItPnhyZXMgKiB2YXItPnlyZXM7CiAKLQl1MzIgb3Nk
Y19kYXRhID0gMDsKLQogCW9zZGNfZGF0YSA9IFZJRElTRDE0Q19BTFBIQTFfUigweGYpIHwKIAkJ
VklESVNEMTRDX0FMUEhBMV9HKDB4ZikgfAogCQlWSURJU0QxNENfQUxQSEExX0IoMHhmKTsK
--000e0cd183941168d3046db614db--
