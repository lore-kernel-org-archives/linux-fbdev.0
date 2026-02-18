Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21A2F5A06
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438086; cv=none; b=sXt4eYeD3mT7RofSvakMTesE/UcIxpwTsqF1AoLs/eI+WCVGTIZea3XhSN/Qq9stZ5enEj98QVvc6tzqgoJirwuyQpub+2JsWh7WqMS9Ft8JxP7DkE0EoRPh+cJOjC8vwI9q4sO1P0H654Pe7ty+55pvI/U2HUKhhjKLHodXO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438086; c=relaxed/simple;
	bh=tj3fDLu9j+j/1D3Ns5QM27VBtcvoJcEDv94CX7fnhHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=kASk+73+WmcYojF/B9ZCjgN+Py+t3P/8FQli33/j8hSdv4png+Wdh9JttwYIqgQylV7DWaRgBzcrKI5r4/aS5vCnnu/Lk/6CyrTvOCdOIsJKZb1fVGBeHOfrZoKsWO75UbXMvb8u+nIiShB2nx9PJFCPNBv3nZ+y8FdrhGDgktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=lekcxDf+; arc=none smtp.client-ip=87.248.110.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="lekcxDf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771438082; bh=5+8LH/ttBDhQzOQTNsiHdkZH9I0ew9FiefVOo+uK+Xs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=lekcxDf+hxa60iLLYyXKFSMq7SzgYCqfathrTL4BUFzOaL42rfVX+6PECVvy5ESA138a4XCSkvStF4FiZtX/vXbNQwnS0/UlDFQrCJN95e834H3f5O56bjdKLzN1k5jH6YD9ddUDDdQ1jsApH5rWXvbKXWAjmJOn50botVg1BAxjuHNG73c05XQvdT1njWSKrDES33cstiWuj3r2WkiFVkwtX67A6Ch0mJJGTOM0o0ph+PeNHTfXvIN9Phr58XI3s/STNRbBD6H+e8pyF72yDINT9DIyH0dobh6RT35XMzEC3wW44CwnqhhV9L50pCzxBQQr/RhtDlqZAEG4eQbcTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771438082; bh=eSEPC5iwR5LBVw3em89sLXMYeWJmq+ZSChr4jbTW7dO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lKU6DCJPgrkwSmPd82nmKXAwB6dj+AcY5unreldu2zXv81gr4zi5mqu5DEK8PVj3Da5hYhoqB9+Cwlop4fmz7jcmfI/HT3amPs1yp5aSq2NsT0SMYoqOL4sKORjOrJGIrAuFPocN8lXIB34DG9mZpTj06Z/v3EJA0PEZ2mUyQuuEPddDGUZetIi9dzA5pGM/jx0roTJcH2l/t+H+yiGi1QC7do/ycpd1Jexayk92hNcZ57me8yM1RowI1snUfY+EZdOcjby79VfLetpnvByJbw+mvNZm39VoY7GMX0ARxM1SCK44Pg03JaaI+UjYwIpi6exXfY3KjJ9agbjJPB13Xg==
X-YMail-OSG: OvZt89oVM1mPoTQrGIR9vJqkCQTriIgDK7pSx5FFBGBejYmvOukNlm7ern5lQI3
 jivIRjy5djehEf8AymmGgv9Wam1P9LCvUVVF2VmBwRAg8woYImSXk5PCw1ZPYLsEOykXSAsjRj6d
 XWA1za4ZtAoT8_ZFD9PuySuL1j_BcjVW4bgU0dqSMS519Jb12lIm37Oivady3LtRdR7.vnrSGSFk
 cHEEgncYxFS.HZRTo6q9Amc2tYZX_nUU.Vtk389suhrrAhqwBZ3u79DU_NPlYCdq6Ow1ad57kFas
 ob2zLOEWCOL0cpF6Yoc0FebTT9HZwafYwbsNWlEWGdJFxBqH.OsHqTMU.oxMt1kh68DYaZImDN.M
 vAe6.leZ.oS4.uAtlQAxvbXfJN21s0HIamz9K1Nomx6ryESTgoEpSy1o4Vl.PgryMacDueh5OhR4
 a948uVVMXYfSrTHxxn7DguU6q85Ld1x4ahe2OLSH.NYymOYVN5SAS.I7m6L1aPcB0fk2vx8T88u1
 cw8ZvkByFWSvvFUej2qatSeo9KsbyzcSNBBr1YjOf.8iQoHqic3CRfTmIJzIMmKQz0oU5LwV5z6C
 _Fd23IwVi6juoxiijemPiQeDhmcX_mtgasdr.fOXSHRixhHbJlPWzyocuhWVvXxJetCkrUAdxp.f
 4iX3neLoSJiRgsek01jKxD3hRtLEEVctl02YC.x6RUh5Rf4D2ujulDfwC0H4W7XuxhNsICs3X3DY
 PCy_bIz3nsMFaSx1q_c97Kpxjn8gIj1k8ASODqTiOwVGID_QDtyXxiipB2HvN4HwgOzkUFwWbErd
 LSwA3gJBXTmGHD1qTfgzlaDxYza81gYN8AOnRPoLbv7yePHDWxkxeRzrRllMV8HmkD8k29qarnr7
 bSvDgl26g.4Y7onH5TgVq1umbApQWpSeHwRrh7hBp0AVOKvaIVs6rJVVw1DDoQNF_fM6R9u_2dTj
 ZSjfGk11FOK0.rMKrRzDwdl47Tjgcl3GIBkngRhDAa5NGR95PvyAukOiIYNKe2W_y7Talvilioq9
 idwufv3sA0Yc4j.29wROiJvMf_.sKq56Yl.EYBPERshwUVLpswdygBFHDhv70qOFrFd2k1YKqrgQ
 cRJW_kHq1qILgoJBZdDd53eQwpPeTpnhZYrgHYIvGR9a51yMh1RVeZXR6dzgUHyOPnEQKEJMNVab
 ARpp6U7zBBGS9AzQha_Reb2ckMZtT9mlT410iTT82ce2cNIntbSh9hklhM5wYcwem6K6ARV2EsKi
 GNoAxH5EttxApPs9jaVwdt.t_0dvZPv7mw4V9xczkvFY6sz5XL5W_tz2YJs2iY16RiGH.VfUS1N6
 0ICTLgIikxGmtijK1qDuYSIEit6jWgIpf5ckTt1MaisORxbjHhEfsMOVh1O_mPh1JXa36pSgd1lm
 861WtPADJTaGGgxCKrKG9bKDteRhrYxrLb0ZI1BD.yN4aCoGn4evuqwyqqgoadM6LZWTSq2Q1DY5
 jFskUqNmpnwoByLgXJw5mSzPQ3StkzxbyPZFlyd4C9U9sThabuOnuDTynOM6flQ3SaNHYWEyVz3d
 jwIzjP1sLm2UAqam15QJQ5fpKz3ue1sQKryPPWI7QV51Sn17rDvmsKGzTIW2zJ8dwTIMMRqzyOxL
 638yGK4LXxe8sWfPMLG87x7H.XkxoTvK9E4HSE3Yn7k.yB3seAHok4iV3BACKYARU65K0cQSWYim
 145spClqc58yo86jR5C_yqMwlo.KQ5Dj9V9216iHCrgikIZKKiA2rsErhqhXZjNP08Su_r0SxMua
 6jJ86dqCK4MqcSdvhfGIGjawDQmE7AVTnc7u3nQws1QXhldLXJDJwxhUCqsd2kCcGorAJrAcj4Ey
 OZCNKI3HEuP7Ui6KVAys3znMMhMpRgNxtn8ComO9lJDalDu7s_li5r8pQ3pU4_atzl8mbJ.FH4Dz
 IUECH6Djd.aYu7lhE8870vUj1fQ0VNlvZEPSVpcjHuI8tuP4X0NdB_GMmLUU9Dpr__9e34ltQAA1
 Bus8dHOIFsliQCi9LBkKZX6_5UABVjrslhlTv4VuH9uA.KoJEoLuCjoN5fmTNNjTXkUo39CcwLlP
 Zq25pVCllKPLrfTFLPvnt238Mes7DZa8M2cdGyT5XuZtvEhXpM4f4hm5.9Vi9I1FKT0r2_j4EVXU
 T55iAkPu_LhI1gKzaNlfwBIuojgcJGusvpzxTz9FvshP7QJexkSzdQKOaq3bfooys2ko9BQa1x.E
 .T6UhtjYy.mRFH_HwC2o6B4LQTc52e_ED4DlCRgtG.4V5qNokEpvJMcuXd6aBFgoaC0wtFlr91Lq
 llA--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 457f293a-9a80-45c0-916e-296272d1d882
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 18 Feb 2026 18:08:02 +0000
Received: by hermes--production-ir2-bbcfb4457-g6b6v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8b8c0de62b821a074fed8fe833a97ce;
          Wed, 18 Feb 2026 17:47:42 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] staging: fbtft: fb_ra8875: replace udelay with usleep_range
Date: Wed, 18 Feb 2026 18:47:37 +0100
Message-ID: <20260218174737.86994-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260218174737.86994-1-tomasz.unger.ref@yahoo.pl>

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..ec4ce534e409 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 110);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 110);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.53.0

