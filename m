Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDD4A64DB
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551598; cv=none; b=tqJ6BXB1LtSpo48yQ5uuYmbdUJE+qxwllJaWQPBQ4oLJraCYNdBNKIXwb8H7joImGkIAYUj+PJ/eXrNTlBhs8vpFcqRaNHL9v6ltRMCjiyg41AA0SSm9FQOI3zqSQMtkq/0acYcY3y1wqkR+d7FjnnQNHaMzXjuCTQckjD3jZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551598; c=relaxed/simple;
	bh=b7fdcAmW6lzIWiw+Ww6DahHQLZ+/EizToms+bmRTlHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iADxYgzgS4nUSEYa5HdF8Zc53pLrFZ/ry0CDXspADCHIsmg1BtHtzAsMurEiT44sOzgTvgGAVMf749DVctwDmjtErJsIvHN1HZtKOJl5Nhd1e9wFSx5oRuZP2yrf1aTJJK2d9ijk83V9Q+R/nixHG3GQ3CtggDFjD95fHiHZd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZuCOWGN; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZuCOWGN"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso5271575e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789551579; x=1790156379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FK0BAI5zlwK5WHRW3pCb1OR6vOTCwaSaqw4lIuR/t0I=;
        b=gZuCOWGN1XbZjNnwv5QyX6cTVrfYXLMp+THnBp3a2tntmmBJbkxOhNBiB60rssrM32
         n/9+RyzXnNbOdLJFN+WvHJ5cvRVLa69NbKjLTl+8d2BfuJsTNaFT96vpqH2T5uY2gHCq
         srMXenrDEsrIEj4IMzxftUeXobNmvvSEtQC1fAmHZu+y3r2BsEHATPS5TDLS3CuBL83U
         5ZllPF74UsCCQm/nEHhLqYBDEC/DpxAxUfGAmBob/KzmHUYtOuns4alwci3Thw31WlbS
         XDXrsmDlncDDBHXBwyymfIX2vEk79Z7YLPWEaeX5lhkXIZMAy8gxMHugumLOWWB7nB+H
         i2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551579; x=1790156379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FK0BAI5zlwK5WHRW3pCb1OR6vOTCwaSaqw4lIuR/t0I=;
        b=rxFWTWLc9ltBXFXzkPa5ykAq4u8eae1yErMF/zC1EXEfl/89LaqdviU0V+k6kuiMpN
         AV5J57psYNzlIrzElC0Kj4gMMl03iUadTGq0Ri6hy61gApQ4yW1qcFL5zedjgZyZiM/5
         9iT1W77V75eXPMv1XnJA3r2CfS3FP0SG2Brk5wgmcupc6m6On67X+GdVwxtqVaRD/tpi
         Gnu2InDP2UhlKwx8ac++rIwhsIeJSCpkpvgcOFIJB7xXI10J3podmgSdVVyAv2r4LLAH
         4h4iySws4t8J/EifXlUY3qwxIs1PK5UURR5ncF8mR7SYCS7VYYe4PLA4DNYRD/3NIhnO
         e+FA==
X-Forwarded-Encrypted: i=1; AKwUvBwdBQqlKwqiS/vDFQ4ujiuC5fcuvWiwZxlKTv4d/QI/Web7JmvCRPUcY+Js5an8GVN0lwdo9u62S0x3dQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kZpdm9C/JHl0r9v1Bl7t4yUImuFcwIVxgwZKKnHj777ibfsTMw
	hm685E79bkk0AJBSkQ37OeDHTPR/Xp0JeYN/G6Jd5ibTpuZaGNLAYCpt
X-Gm-Gg: AYBFou00WeMRqCwPGU18FgPaG0SHRJ3CvKSdf9/W+zIbJ5sNsHC7/J7mVN4p9kn6+5q
	hvUhLu7VTykNa1VD5/4lbLoC0Rad+NL0CDpyHwjdtdFSPoEYSrAl3yFcRLlAkmRfonylVJV8WXG
	1JPsK79Awnsclwe23pl5qvwPqtTHVMtTDI+1rS4yY+lkWYC5gszzb8JdkW+73iF4VunregsOrM0
	5O/i8W+qx9iS/kr7yxs8IZPYdy2nD5JYOu5ZKFGeAcvIpsnb36e6V4avpDUJ/zTr2R/wK5IZeSY
	xLJSU7cDask+8TXCmJqZV9kkONClWqSKTpH/0fkJmmkVwpKYcgEy1D0kb9s2cB2UXoIxNcHEZjG
	b2bnjvxbm3NW+OZdvT3NMQwOYxGDB6z86DRycZ4uEvYknXvRt7bArRmfmqcAKvIkRM6kF0uPrCX
	Alo/SvGtq8/y+FJ5Is7u3jFfn1ld2hbUnRha2pmX93/13ZHS+ndLWCovaXsFbbnk/qQPbbCr18K
	gErNNI=
X-Received: by 2002:a05:600c:3596:b0:49c:dcec:bd27 with SMTP id 5b1f17b1804b1-49eb72f2c40mr23366615e9.8.1789551578513;
        Wed, 16 Sep 2026 02:39:38 -0700 (PDT)
Received: from omermac ([82.222.238.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83da9a7csm61728415e9.11.2026.09.16.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:39:38 -0700 (PDT)
From: Omer PALA <palaomer100@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fb_upd161704: replace udelay with usleep_range
Date: Wed, 16 Sep 2026 12:39:28 +0300
Message-ID: <20260916093928.52057-1-palaomer100@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() calls with usleep_range()
to avoid busy-waiting and allow the
scheduler to sleep during delays.

Signed-off-by: Omer PALA <palaomer100@gmail.com>
---
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index 7288140e7..f66dfad1d 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	usleep_range(100, 200);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	usleep_range(10, 50);
 	write_reg(par, 0x0066, 0x0010);	/* adjustment V61 negative polarity */
 
 	/* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	usleep_range(200, 300);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.55.0

