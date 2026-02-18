Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5718DB0D
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438444; cv=none; b=HEZJrR20dFQJ5KVaj6hN2h6D6PYlCusYf5s+efZUdw6SBPK9nCet/EBoWQMCji48zM50GuR7p/9EZnhazip2WaBiRqYyaWwfmnwl2Xfrcd7iIozUZQDBWy5zwxMJSMBYhj2WfWSLVVom8dmoojdQgC5n5OLshCkUyQD+BzRwp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438444; c=relaxed/simple;
	bh=INkQpRulNkTxMCLe72JLOUsMP0YZ5eiTxcqv2eDOkYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=tOdQfanawwFNbXiOgspLB2yAR8ANMvMV2K3qrdMgPMWWO2jR+AtU2za+w5XWTuZAkM/oD4CeRDxtktQI9b5WclrA62dhliAer7TETL1PtwlmL5MGcjaOjccqNKiKvvvWQ+dber0JV+QMH4aFqb7naqVUlehNpmPFkKH5LNSosQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=eFI5viiV; arc=none smtp.client-ip=77.238.176.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="eFI5viiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771438441; bh=cbK30hxiRbkNBexcacpbyQUDpOSeiciDJhpo4iehvfc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=eFI5viiVcf7TpNasa0R/WuuAtwQahCjgvQTAPzOg+Zlr2XLSj0V33sYjXxbxnbrRrzlMarHoQazZinHaQv+PKk84qPQsNh5m9+xYujtcStwwB66esxfRlA3pb13Lgs67gppenH3ent2+6iIu+//F4yTv+DK29l1UMXID0TMEHxagmIqSTUkKJTh+v0IXWZm4L0bE74KDctLSVHmoKLv/+nlY7UEERIqsDN+jZk5zLURfRSal1MhI1VGToNyMms+s3RHqHevCkWGtXJF3L+pWdmMdF728E4WihINlMgRB21YX8FR3Iw3qHl5/HGzUnUlkkqnxLbM82HPQKUBvdoyIHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771438441; bh=RRgyZWV6/vy+YXzNGcBxEcO2vy7Ei36WCEOD/S8ahzb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lRaZt+E9fmY3Is70u95sq9CK03mmFok5Y2Auf3lGeEnjPN2r9Qh/GpzQm8XfKay0CC3NcHBpekeU9Mbu2qGf0aryLeMkq775JC2pdW+amRH6nJ0g1HvEzj3m3kqyazyEiP2EtSB4HL7An83YBIXcHIJro6dpI9+cghCvajYZdxM3MA+WoduBKsqLxHGfmoImVDdG6QxJwommBLs5qR3aTwtUcyxxRYlhWRMZBou6wER4s2UDxR71KaRwmc+F7kAjT4l6E/dnnVDO4CnayPEcz3lZCQklEbuQvAhvHpxHyT4UIVtcy8GxQSl3Sqdl53+9yXDronNWyhOXuJ7omgDt3g==
X-YMail-OSG: qXvIDw4VM1mFpUMsULFTrJU4c9cBr__k.Eobri7affEQtx5enCN8jNRnlfon8LN
 T7Rlipfdg5HQ99BGVgGHAtHkINyN0kf3YGsQILjCBWQnu.ssXKM.wyiIKAyzmRQLf9tU9udG.dHs
 eB6aW_tuZZAuOJLohl90ITHwNMidOueLglgkniQnGIO1Xo3hsixiG03QNe5eReIlxmMiEJHQbiAY
 UZRiow.eojaQIVsrPwLuCbOEkwZPMawr9KdUh_jCXzPQtcEDgkO6BnpPdUhcgakhUWIwXRknNYOG
 ACQ_qEtHTSF_UIfOs91Hdk7_NMiRDK61q4CTUcqw_dS_690WvjJpcXgXHhFiM23J2R8BeesK8PSZ
 qTF1oHtFaQzME_JoIScrvDT3emMJOYydLhTmVUS3eBzClTFMB6Yh72R3yphq15rqW1Kx71BkPuyQ
 hmf6tnSwRA8ARrWwU0Ae417Z5BQzAqKPMNizoJz2yPqVD64T7DxQqAj1An0Le6Y0HdoY2mm.__RF
 eYJAgm0e9LWJcn6TynbQ7W2ZPgspnm1UI98k0fweGlzFM0qUe9rsLWXGwiKsKCGqS_1qSn7fAfOV
 kT_ZpTDTZamIR4vqQaJgP1DJuj5.KLkJp8efTTboebq4fp.nMn0ZHpThn1nmDqECwP2qYOv_t7uQ
 wra1RjxcCtYGJgTdCZefQHybtZrGeaG2YCRV3ubO8jsLVzCK_tThgJHT3s4ORtDroPVgaQv6yrXn
 BTdff3NXBazIKCCmADI5jRMQ9ndAn5oZ9Acbkm6p8fqZ_0_HTGqkuP_T.L3XNtkbMKrVIEXaT9cs
 gO235qMyK8Zc05q__T9yxCMN73FQ0VOHgogWovtEKLLFp6bAveNXPmIetIEwjlqqIvy6QcnMeAqk
 cjDfArogm.pj7rtzBsVsVNf0aPuHFSzu6iBwrBoCXUSQXenp5fjCr3gO1BSM8saRlf.ay6Y2DwSl
 wQqILdovXpLooyC_jQGBE_42l4p1Tn_zExb9solZxlUqRLXDjqPVxyc.k1Adpa3C2VrOfzR4RKdK
 g3FtIa9yF5q.BLY7rvLRI3RUBW28k.aT3QDKQzVYrraETDxOmqnpnO192Wm8hBhVoBhP9JXHkA1a
 R2fhZzP5i0jnigqSOtCIe3WjLm3y.6caaOgrlPvDmGEsW6RgsN5vpBqs4RDAvAwA1VbR2gYNVLj6
 IbiI2l.iO4UINsryzQ00QZpCTqKWQzTgyBMmUFf7tQvrHQlvUno5dsV6ItIRTymGCnBAk8IOO9tP
 0OY7PDq8V1lNIrrE0gsROySXD4oFRTmrR_JaQW9q8XCOTfXoZwEjeekwufjI2FevAb_TZ_viIU4V
 l6kCHqXBmgp0a0mxrmNZndpLamuR8RCYnt5qriOK4p7Y.gMlqvHkcFUaf.JAj8rg5SVdGbmv_7EM
 msyIHGZs5Tvt_IHfEBdW3np6LDEB7wB9v4HNOLf9u5WSdFlWVMO7vXtIbtCro5k9SWYsjexlJTxq
 IR0I7Hf_X_oLTzP3Klya5oSccadBR.FPX3e3dLLHa8avyGL.Fn.IWqDmO2WLoGz9AZTxyvuOwEID
 kYtp2YuoN_eIIIU84ubzxL.cWjRbYh2ZzbBz0RjZWL5Xbk9LcGZR_dpBKYCtE3YflychW0UGwvX9
 4LCeT861v5CV_I_4bXdbNY4nvM4ysr_tjZklN7WRfq3aDQuvyP9zn57Z2Fz5YQLhGKQ9.a5j0BBu
 n.60zwnDJPx2tbIxNgh3F0htkR2ANnE46fjvh2CX7qIwpona28Haav6uoVp6Bd54YCPM8OvadUIx
 iKWZFudWMi5fhWVWUIHE6jqDQm_jf2KLxiiNxkd4gT202fRfgl8dZw8QmCelKBXkph_W.cz6jd72
 luydj5e5PoTtB5l2_zcbRTTQUCNmFF3QjSTZME0_s1FQV6_IVQD8DfDHTIixQyCSzdSOEyhveThx
 wOO3Lznadm7bYMviz1yq_7R6oZ3SOca8LCdki4Nkd7FlrxvXHB8oj0DFO7C_3l15viyhyZsQlAKJ
 moIXl3r8k5I91ySPcT5iSymB3vG0kUFs0ZK5RYLKXLTfmQUxzuAsKKT_vsYelfs2P96LZB8LfQlS
 _ypJHlN1zqgB3eiXm2zVLwiLLQi54x50R.X7iWngkN.4YRNePmUs_Q36S1M0zTLGPZ1.Zn0VVBgH
 srXQCJpeLGl.1pzdUkWATsancW7SBPP4jCqaAKXHSuMooOjcSCaCZZasYalL8CaRJUXSkNL7ZmFl
 gEb.8pruw91F1zCM_ZgbjEzRWQbWvmSDR8Hqn0pO0cRz8gWZJPNhkbeCcQbiV2D6y_lh5HfdGmUl
 s0vyHnA2aUDJ13_ywcQ--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: a14cd034-e18e-4282-9e40-1eb10f74d2c2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 18 Feb 2026 18:14:01 +0000
Received: by hermes--production-ir2-bbcfb4457-g6b6v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa0dd80118d0af9e03c772f1b03d5629;
          Wed, 18 Feb 2026 18:03:50 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] staging: fbtft: fb_upd161704: replace udelay with usleep_range
Date: Wed, 18 Feb 2026 19:03:47 +0100
Message-ID: <20260218180347.88034-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260218180347.88034-1-tomasz.unger.ref@yahoo.pl>

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..62862f021b28 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	usleep_range(100, 110);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	usleep_range(10, 12);
 	write_reg(par, 0x0066, 0x0010);	/* adjustment V61 negative polarity */
 
 	/* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	usleep_range(200, 220);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.53.0

