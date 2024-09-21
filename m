Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A751E885
	for <linux-fbdev@vger.kernel.org>; Sat, 21 Sep 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726932099; cv=none; b=dpaEK7kmxu7y2lHLt9H2Vq2bCUmQMcQXQKG3t30KpdeuBGSR9AS6snqWNfqNoVEiZaD73LdX5rHOs7AOeRD67Y9iOg2trypDhdI0bGqBJK1b/0IyLMd3PZnkwKF+L2coEbziiVyymcgRH3tdAym0RFCimLdC+FfrcoY2cs+EWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726932099; c=relaxed/simple;
	bh=KyRjIzM1W2kjn+/WCTJVr2GkiXEvVOnoeIOZ4YVM2ko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIwcuzlIHE43TxwL4qXUgGruwi2cP6SowjVK0sJMucs+y7ceGNElTIUrFdcNSHE/VUQTGBzExOLlqGN5DHpJc+eEd4zAnuNgmn8e1GvuTnlQr8ayBMOVPrRMi4eYDVNnqOChnvxJ+BUu7FNBMCgRAofLzEpQ6Lp377tIaQvlrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=jNW9O59q; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Z9mB0nPC; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="jNW9O59q";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Z9mB0nPC"
DKIM-Signature: a=rsa-sha256; b=jNW9O59qY/RBdWjNRSrunnxudSNeIRNL0Yp0XhS7dxBBoixNxrww/VMqtEoVAGpEKJ/kJUfnI5npCpverV8ub8T1DG8zeh6Z8CRsuFxp5Raad2K2jQCvfYBZNeptdvMD1CYujhP9zzlW1M3LSEcZWWjj83UQlIVWVx9RoZOro4jTo8WYZynoI5ei6BwIgnnnftJvyiw7NffeQfvZr45op8JRd6hsazT6D2uB6kRwq+X1aMKMsvedYN5Scua4epxcWI6hF1VEXvqCr3/CZAwuSF1y7BVVlk3iBGXZ1uvjKvMxdW6rCfc2qx2m45Dst6YACXh5a36/jiYanKRpj97NUQ==; s=purelymail3; d=lkcamp.dev; v=1; bh=KyRjIzM1W2kjn+/WCTJVr2GkiXEvVOnoeIOZ4YVM2ko=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Z9mB0nPCAlD7dZGekf/tzG2KQrRyyQGQ5NrLP2gaGo3pUm6/bgMDOZoSYItZ1zlREoHM+df3q0q6iax3SCCJ4HYTsUSoFfL5cDx1xgtTcRx/Zhb9rrML9FPcub3R8ydQyWvqaIGXF5oaVia1CKK6ClDd7xckhXyHwLvAcGXYpx4U7k1Hcdj15EyqyD7D9SLo/pTJZAi/8WNgXmDsGgtID2X6O1bdLN/9kDm5kD19fyNM+z5MxOw+yKIaByp3k9i0vqhuw1FVomIWvkvsHNAowJmXz2upFESjQs1KzxIyC2Ft6LWQan3YDBsI7zX7iCOrlIqr+INHxAenXBufaSCmcA==; s=purelymail3; d=purelymail.com; v=1; bh=KyRjIzM1W2kjn+/WCTJVr2GkiXEvVOnoeIOZ4YVM2ko=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48547:7130:null:purelymail
X-Pm-Original-To: linux-fbdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1277823884;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Sep 2024 15:21:27 +0000 (UTC)
From: Fabricio Gasperin <fgasperin@lkcamp.dev>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: sm750fb: Rename variable sm750_hw_cursor_setData2
Date: Sat, 21 Sep 2024 12:21:22 -0300
Message-ID: <20240921152124.11560-1-fgasperin@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Rename function sm750_hw_cursor_setData2 to sm_750_hw_cursor_setdata2

Change made in order to silence the camelCase warning from checkpatch.pl

Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
---
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750=
fb/sm750_cursor.c
index eea4d1bd36ce..e95f39b51a2f 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -131,7 +131,7 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor=
, u16 rop,
 =09}
 }
=20
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
 =09=09=09      const u8 *pcol, const u8 *pmsk)
 {
 =09int i, j, count, pitch, offset;
--=20
2.46.1

