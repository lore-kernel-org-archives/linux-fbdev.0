Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com [34.2.82.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1612BCF46
	for <linux-fbdev@vger.kernel.org>; Sat, 22 Aug 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.82.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406419; cv=none; b=Q8YaIsNIukNlUCQ5tbjcgfLaMAjapx6cN13/8LZMTDPAI4VXPjEMN1JB4Q4+OcZmhILN8LrvY83PK5HmqSWDNt5Q01MDUC/kNdKU2el5b2gom4yWmV25m1nog5giyxWxem/c1S3+pMJW0lRJ4u+h1I2p8U24ThiQRlAsKwZjsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406419; c=relaxed/simple;
	bh=5Y6E8rVhWotWLkn2qTETrnAkw98SA8hvxNOi6g7VXzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 References; b=CfqRuBUfOEwOOefLqUpGu4RsE4xZcu36NDGN15rH+JgdFycWTdJewmf0PjUAkw3zGux7Xw+43TwW9QOcL1jmjzgJ4lIrXSyQjbeJhzHZHZOrl9199rcwnBiNXYDMUjbogGpV66/ju0oWScURonGfFOapby81LyYcHGiXf1rKnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=q4g9AV6m; arc=none smtp.client-ip=34.2.82.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="q4g9AV6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1787406415; bh=FmtPaIAyL/Qmq2MEAEdmsB+XwwYaOOeBDCzMU/8KT9Q=; h=From:Date:Subject:To:Cc:References:From:Subject:Reply-To; b=q4g9AV6mNkjWGO8N+6iBdkIiA3TdAM6euaxRvmMOg3zOw3B5UuR6a+a5ezq1GDrYeATDO8p51oqNxVdlR7W57RiLRzmtBGQ0Lu4mgH3LimEDa2mkxPgBDW0rNy6glIcK0Cupm3a4DrspxHVfoWrNKftoB0iXLoJIh82VLx21Pxia5bLjIxTf23rzD1OjaWpHG7sdnMYKcAQbCuVJanQooiSwZLOr4Tw1h6xGahuy1QED+HHCO4FDUGOKS59vUA+Wji/2ed7yhuu1cguSz4ln2u76h2BsW/UJn4842m9Jm1yLHqZrzrdmZBVXIKn9v7ziOe7LfKXfNDoM5FITEMs6Zg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787406415; bh=CJu70w6VTxaBejQiDUm/YIXHHI9U7xHy3wk8owf2cWb=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=OuXftqQ3RgCpLURzwfis4Y5aUC6XFzVYa8MnJpEmLNAINEPe8OMz8Uh4jLBQAwKLlozbcQpxbnN0o3mFF9AGJHCvB8PDPIqR0ZwI88qHYzQDSqPb8WC0AGn55UE43meGEw2O1nIk4lVCbIFLCiTcYi8k6rh2XG/WXkWetedLsLBqaVBQDCMI/deFrH8iwzpmCFP7UeyuAeHx2sYgrK9ulpUuy5yx1Qj4nfO/MFeQ6NverOQXMJbEah4HfdvCvs8QA0CPpg492O7yFrM0nxApAe2S4oCZy0nRjZcBDWiVf6/CMn2g+QWquA3bson6Z2KzDLJoQ7z6n+vEVKpHBUnxpg==
X-YMail-OSG: 29DD7o8VM1nuXiwExgVSrsphvxCzSUY_PzKCL6XsMc0vEwjlIjYkUQ.xNIG2Kys
 codtjA0Vm_c8gyVt_kD2QkAapf0y5uz3qntJnBlU6FsccPs1XRvVmpbImnSgTtmJtQ7vL7ENcsvx
 zmCT9t.qZEWhRyG4N1giimwdP121AYb3BdCG3VHhxSjjzCcdW5h7RXnOAfzpn00T7oA5CtMloEEG
 iajpLSDt5uxYruODBy4coibQemVdFULw8OITExDpZQrzXtikG_OdfBUvF8PRJQvZMjSZfEm2RNxd
 WZHD73fIQAuqM3I_T2uDElXa0SgLTE.cBKYtt97Bh7EBJ0QKuuaP5ubmqEn9GF2UzrVK71wH.hvm
 F25TJQivC6Gw2g0LVIIhvKO0yJzu9LH6bhO51zBlWz2drMYNxTXWfjPfWlA7X2CoK9FtMwtXcwyD
 IjZFIvHkt2tRaquOyLxFyh3yFFRz2PswqtpBxDpwomrM79wowO.qfosgwQsF43NzHXD1TQhtv8hJ
 WWYwiaA0hSgGeKwvIu5fNJYUM85Wi5R6kUaVrMef_UhgfRQNMmyx2lq8zSa7Fy6Lj9EVyOz8M0X6
 xlbVuEMok2wQDnYk5X6zibeaMI4RcJUCQp.85fY6zBKqmJVLi_zIrWghZa9GvyGTWVzL2S.iizFN
 G6dpSdNzPMBBB.HZsgPON0hMlVaZBQFyvctD8v0OiIufk2fHjTgC4UkyFRpZKGiXMG7wifBZbD4q
 jbkf4yDr6XxG2BJ6dNZSKO_SxBfgJglOB0mcshjCphGezLw9o7HwY5y.jwhNkwDABM3wzI3wq.zc
 Sr1Wlv9nMGMEmtcsCIE0P3Mwy3RjtmQFyZ.UK_U_Zq7qUk7hew.XLW6pbuT3V4IpDHdclwv9pxpX
 XFLGNDzwm0.87zRPdq1RrdP_jFafhbjaFkhNl5I1IVwNM77c9ZHxqT3g5VXtjLVThLnJcj1r_2yW
 BLgmOpbC1IhpO8wzfmul.8q0Z7_84RN.SSDvqRT1ZM5UDbRSgGKTnT0yJT1.7oimKWv.Kd4gHDPV
 fUr.20zg.MgkET5aR8AwUVKNyO5Td4LnzYGU3xxLujv4cQNKBwZ1F6AyzZpVjBSzWrdbD.rVTIOK
 LilMee7Ed8uytxr_iA0vBU2Zq519UP9_uzDwtNwXx1RdXAjlfnjAgUkN1jWfxwhFinhhhpU5wx3i
 tlxveo0FXF_KOIWdofMbex.0_3r1PhzTFwB1U25pbEFDNcp9kR5bWg7FYpuihYEwbGxANOxWZlxq
 twNIU.08Ou8LbIzMWLaSi3qwuPTF_XbObIHzOGwXyKY7dc0hfoDu1TJgxOMtXON9WUnxCNXKZWqn
 SXMOR7YjBwmnu6mxxQ6VFO2Zh.7cGdMG6imndbF8SaAYXhu6gJTde1UW04IuK3SqORPlPjlLj8C6
 gdQe05PqzuVF9ottJRwPiCrF7Ft5R7bPmu6J979pbAvHlJOlixb8XfZUolTHn.m_El9iemierVAK
 .saFy9ejasMbxpcpLof_zuYZZtoo2KHxLNQ2.vJ1AgZ0DtREDHNm_1IlCIjLdlrmL8CwXFiYWrTo
 cw7WwQq0e836nvns7Bh9iSTklfmUg75ntaeNoAj1xnsSGO3118fqRQyoD9ZCSE_9fLzpXK3RNCY8
 rm9bFo0ZBRKskvv40hdvnBpU9ep73h7R7oq.xg7iSfDmyaSflJz51Zy0GpJFzFBMLyKOVcP_EYY9
 vHx42mXPVn1SDfjs_rdc_ni3ic8i9TJ4wInj8690K8PHiVzpHnThBPHz5RWWzWv.oRRDwueLMWRJ
 3W0v8fG9nw42KQ3vaoDDdTOE.4kV3Ex6PwP71BQ2zy8Vmy3J9Mw6a41UAmseCVqSKJRUCCTKzKmX
 1Ld6mQFOLM0pYgFMs9pNRxGeo_YuZfbe.wMO4z.NW1GfcNxrGEj5zErEPWaDpttzme8bbzPW4p82
 orG5rfTKeDf_4Lk7DI9uv6AC70uU47vRNaqxFdqQpH5mH5_Te3IbdXKChmgDpOFbJ2fkTjJ_DD9U
 Er.KkMwrK1hwjExOm88Ug8A--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 04b4a139-9e57-4601-b5ce-b610a2a9cc75
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-101 with HTTP; Sat, 22 Aug 2026 13:46:55 +0000
Received: from dip123.lsn.ir2.yahoo.com ([87.248.99.132])
          by hello (SMTP) with SMTP ID 0619e259233a5150a8906f0b26521e3d;
          Sat, 22 Aug 2026 13:46:53 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
Date: Sat, 22 Aug 2026 15:46:51 +0200
Subject: [PATCH] staging: sm750fb: fix typo in comment
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-sm750fb-defaulty-typo-fix-v1-1-d2f668b1ccca@yahoo.pl>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQrm1Sq4B6FeMCZjpao0Cmg5EQ7
 s6gy+8l75/BJKoYXIoZonzUtO8y9rsC3KPp7oLqs4GJKzoxo73rkkKLXkIzvtKEaRp6DPpF8lT
 6qj67Ix8g/4coef61r7e/bWyf4tIWhGVZARDxP9R9AAAA
X-Change-ID: 20260822-sm750fb-defaulty-typo-fix-0d05d679c423
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
 Teddy Wang <teddy.wang@siliconmotion.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Tomasz Unger <tomasz.unger@yahoo.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787406412; l=1172;
 i=tomasz.unger@yahoo.pl; s=20260311; h=from:subject:message-id;
 bh=5Y6E8rVhWotWLkn2qTETrnAkw98SA8hvxNOi6g7VXzw=;
 b=Izb9AsfwZoP5MgJPfGrPwbRwzhq5e66gfWnSGznUxKf1cfGFE6n/qWhecrFxb8yDQu3ZGPN4V
 Vy8oPdNikw+AXExRMo6IDXIpzCtmvF9+uR5s3Q1UG4s1aL00cic6zzS
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519;
 pk=EPPsO91uz/0J2cTQ6ol+dgxYaieEc9dKSXWUb51n46c=
References: <20260822-sm750fb-defaulty-typo-fix-v1-1-d2f668b1ccca.ref@yahoo.pl>

Fix a typo in a comment: "defaulty" should be "default".

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Verified with checkpatch.pl - no new warnings introduced by this change (one pre-existing WARNING at line 15, unrelated to this patch, confirmed via git stash).
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 039e2033f84e..725d82d2220c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -479,7 +479,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 
 	/* check if current fb's video memory big enough to hold the onscreen*/
 	request = var->xres_virtual * (var->bits_per_pixel >> 3);
-	/* defaulty crtc->channel go with par->index */
+	/* default crtc->channel go with par->index */
 
 	request = ALIGN(request, crtc->line_pad);
 	request = request * var->yres_virtual;

---
base-commit: c6eb4dc5964fdf4086b73b7f0f5dc0d595fb5cf3
change-id: 20260822-sm750fb-defaulty-typo-fix-0d05d679c423

Best regards,
--  
Tomasz Unger <tomasz.unger@yahoo.pl>

