From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Date: Wed, 06 Feb 2019 10:14:44 +0000
Subject: [PATCH] fbdev: mxsfb: implement FB_PRE_INIT_FB option
Message-Id: <20190206101444.26594-1-martin.kepplinger@ginzinger.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----46D0EB028F22567A8985A116AEDE7F0C"
List-Id: <linux-fbdev.vger.kernel.org>
To: b.zolnierkie@samsung.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Melchior Franz <melchior.franz@ginzinger.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

This is an S/MIME signed message

------46D0EB028F22567A8985A116AEDE7F0C
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Melchior Franz <melchior.franz@ginzinger.com>

The FB_PRE_INIT_FB option keeps the kernel from reinitializing the display
and prevents flickering during the transition from a bootloader splash
screen to the kernel logo screen.

Make this option available for the mxsfb driver.

Signed-off-by: Melchior Franz <melchior.franz@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
---
 drivers/video/fbdev/Kconfig |  2 +-
 drivers/video/fbdev/mxsfb.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 58a9590c9db6..0e7ab29c9c70 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2183,7 +2183,7 @@ config FB_EP93XX
 
 config FB_PRE_INIT_FB
 	bool "Don't reinitialize, use bootloader's GDC/Display configuration"
-	depends on FB && FB_MB862XX_LIME
+	depends on FB && (FB_MB862XX_LIME || FB_MXS)
 	---help---
 	  Select this option if display contents should be inherited as set by
 	  the bootloader.
diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 12c8bd1d24d5..a017200a16b3 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -181,6 +181,7 @@ struct mxsfb_info {
 	const struct mxsfb_devdata *devdata;
 	u32 sync;
 	struct regulator *reg_lcd;
+	int pre_init;
 };
 
 #define mxsfb_is_v3(host) (host->devdata->ipversion == 3)
@@ -419,6 +420,12 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 
 	fb_info->fix.line_length = line_size;
 
+	if (host->pre_init) {
+		mxsfb_enable_controller(fb_info);
+		host->pre_init = 0;
+		return 0;
+	}
+
 	/*
 	 * It seems, you can't re-program the controller if it is still running.
 	 * This may lead into shifted pictures (FIFO issue?).
@@ -931,6 +938,10 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (IS_ERR(host->reg_lcd))
 		host->reg_lcd = NULL;
 
+#if defined(CONFIG_FB_PRE_INIT_FB)
+	host->pre_init = 1;
+#endif
+
 	fb_info->pseudo_palette = devm_kcalloc(&pdev->dev, 16, sizeof(u32),
 					       GFP_KERNEL);
 	if (!fb_info->pseudo_palette) {
@@ -963,6 +974,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 		mxsfb_enable_controller(fb_info);
 	}
 
+	host->pre_init = 0;
 	dev_info(&pdev->dev, "initialized\n");
 
 	return 0;
-- 
2.20.1


------46D0EB028F22567A8985A116AEDE7F0C
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOHAYJKoZIhvcNAQcCoIIODTCCDgkCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggshMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
hkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYh
UPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6
fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1
KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI
03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqc
k39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0
cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
AAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwR
GiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDc
ZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwp
WZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNm
NppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztve
BdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDA
fd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/
cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe
2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxh
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUzMIIEG6AD
AgECAhBNQrEzGzrZ6FVYh1EEYH4+MA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAe
Fw0xODA3MTgwMDAwMDBaFw0yMTA3MTcyMzU5NTlaMDAxLjAsBgkqhkiG9w0BCQEW
H21hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDsMC77L0D+2D8I8X5ubnBhADLgU+HtlwMTFt/WJIhc
kgbvnawYXWrCIpk8F6BJ0R/iFCykPdG7741EmlcHRKOJfhVxjXhwnoGFqnYmurCt
fvZLR3+mT3FWnVv2RAdrXscXH3BpijqqWabdtTbiTvmcl86Zc6mNlVhYZSbDul/E
voIGZotGcGIWrgZxN+8MQJQHKb0KHyWlPVPkrjvEfOJHKKLFsBNSnNMR95Ijg3Sp
h8/8RG490/zRHflGzUlxDSlLyY9YJGzSdDzcFKoYcc4oaaUY5N3uhRna43TLUIQh
6ybt3DKVz1Pw/ikwYJrOsulJrVr3D8KVHdGxq7HYl7jnAgMBAAGjggHfMIIB2zAf
BgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQU/GtSUbHg
14sPDlmo27eQYwtjaS0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYD
VR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEYGA1UdIAQ/MD0wOwYMKwYBBAGy
MQECAQMFMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQv
Q1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NP
TU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmww
gYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5jb21vZG9j
YS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCoG
A1UdEQQjMCGBH21hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20wDQYJKoZI
hvcNAQELBQADggEBAGEuG01K1tt5i3gUdQkYem/KpbJUYBZd43QwmoTa0TGXUiYq
b+g/TeGG9QQ1yq+73xOr8fu6oT2608C7EiJc6JmjTs485/OZmTqgYkrLfs71F1kB
3Z59WPf5aoR/pnn5vdfkkoO29V1cKPJR4z+iOG2hOlcK/dXrX8i6mnL5DGIe8l5n
udUPvIbUhbMavrDd6kwhs0oCjylwdKGlFkCpKMn3HPflfDeHuV9Z8Nrpeq/7+Pm0
I/fLPkaYlULASJoJCucMYcedY9rmuro9JhV+NuVXaqLIrQPc1vyKFeRuLHh84M6c
1h1DArdGTykXZUwjXnnHtuOtzjIAzkx2Ns43vEsxggK/MIICuwIBATCBrDCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMT
NENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEE1CsTMbOtnoVViHUQRgfj4wDQYJYIZIAWUDBAIBBQCggeQwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwMjA2MTAxNTAy
WjAvBgkqhkiG9w0BCQQxIgQgVYeaCVB1tQ4OyB4yMHmSVmknYJv7TLdvfLnINA9k
Vj0weQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEA
0cgq8r+mJ0bYaUlj/TlR3Mnoe0GnXPhHqmv/vWYgiuEK3CfTmMidD2Ku0NqLUCHQ
I96JpMMAcRbh7FXAbndiB7N7L+tfCJbnTvZOrM9tH1JhoSqQ4MNZjcLvtaoxbVlp
cR7ZLszm70rip59gUrGdtthuOKs3pvCbLjSpRpVCv1WzXSJHHIT+cwV/azFeRaIL
wDTsgFzZ5NgP4h3a8gtvRGqeWrQLavC0C8KLt+T9Uxt+3M8rcPAK5E3EAx5YnZnq
+6Ii1FhmKu8O1E2VSn6Fl/eFlFoi7URQOh3dMNRPS+YuzH4/NtQIPboOeCISQcfs
W6h2KW1vwfDyImbHLXZnlg==

------46D0EB028F22567A8985A116AEDE7F0C--
