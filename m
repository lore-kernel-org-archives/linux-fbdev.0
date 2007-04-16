From: <vignesh.babu@wipro.com>
Subject: [KJ] [PATCH]vfc_dev.c-kzalloc
Date: Mon, 16 Apr 2007 11:35:28 +0530
Message-ID: <1176703528.13066.9.camel@wriver-t81fb058.linuxcoe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808680994=="
Return-path: <kernel-janitors-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.linux-foundation.org>
List-Help: <mailto:kernel-janitors-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.linux-foundation.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.linux-foundation.org
Errors-To: kernel-janitors-bounces@lists.linux-foundation.org
To: adaplas@gmail.com
Cc: kernel-janitors@lists.osdl.org, linux-fbdev-devel@lists.sourceforge.net


--===============1808680994==
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/x-pkcs7-signature";
	boundary="=-sn7SySsS40V7zNNCGs+G"
Content-class: urn:content-classes:message


--=-sn7SySsS40V7zNNCGs+G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Replacing kmalloc/memset combination with kzalloc.

Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
---
diff --git a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
index 8bfb67c..c3135e2 100644
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -259,11 +259,10 @@ static int vfc_debug(struct vfc_dev *dev, int cmd, vo=
id __user *argp)
 		if (copy_from_user(&inout, argp, sizeof(inout)))
 			return -EFAULT;
=20
-		buffer =3D kmalloc(inout.len, GFP_KERNEL);
+		buffer =3D kzalloc(inout.len, GFP_KERNEL);
 		if (buffer =3D=3D NULL)
 			return -ENOMEM;
=20
-		memset(buffer,0,inout.len);
 		vfc_lock_device(dev);
 		inout.ret=3D
 			vfc_i2c_recvbuf(dev,inout.addr & 0xff

--=20
Regards, =20
Vignesh Babu BM =20
_____________________________________________________________ =20
"Why is it that every time I'm with you, makes me believe in magic?"

--=-sn7SySsS40V7zNNCGs+G
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

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
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEBRBWlnPDDQELOU4iM67
/5AwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDcwNDE2MDYwNTI4WjAjBgkqhkiG9w0BCQQxFgQUr0bHT/+LO7NtNIcSdLl3hLnWZ68wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhAUQVpZzww0BCzlOIjOu/+QMIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhAUQVpZzww0BCzlOIjOu/+QMA0GCSqGSIb3DQEBAQUA
BIIBAIlCrCqbWZUS9P7UvvhEyEFRimNjCmnc1uAWzlPBDHS5v5VGE7hA0OzUp6zp9ypmt9SkbXhv
prqAFUJCluelQ/Z77HPCf/z7d2UOThsEkW80OwiuIdo6pjCAJzJCyVxY6wlpNZ7QorrQPupV71J4
f0rbx0FtlRTzGe7dvUiwfN7OsN2DZ6xf4u6evAHmMYNubzXVBjF+tRH1cfjV63GL/JimkNTcoLew
G2WRxuH/RFbI9OsszatvKXGXkXd6Ea6YX+NawD6sON3dUPjG/DT4vN2wgWvfC3bWKQkqlUp6HpAd
misdeKhW0ejTK2rrRQlWdf6AoFR4rbx8JroYFjwmgUMAAAAAAAA=


--=-sn7SySsS40V7zNNCGs+G--

--===============1808680994==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/kernel-janitors

--===============1808680994==--
