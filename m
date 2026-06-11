Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com [34.2.82.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FA36CE1C
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.82.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164332; cv=none; b=OelsQWuBD0Xsd7i6etEFaYkUFOgFDbj3BM+ibRjal5CbyxFi9iXhxPK7n7AC0cLzeMT9lz30kon6aps+PD81g9vf9RQawEp2OiaPVrlzIHJYBvB36l2yclzKGi2E5gbEo0xJ9TD6CUCqyFk/GNI2rBy25Xeh7yRD/+D4JXDEKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164332; c=relaxed/simple;
	bh=UbHzhBK5ueIVwUpYA1gmOCE4iKkRQO9gwwiEYBEwhF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 References; b=iRuf/Cqmg8WwkvzpbWPPrwNtUih0p77djyAwCCTg5Q1BQx+2DLqPXjPfiNweVVzn394v+y8oaEPZPrAsT2/W0zdl8Jn3PcwCK1VsCqklMR1JwON79DExDpo0bhmPMbi2GnX65kWI4l8KWqVCJOzf0vSBSuQ10fjZnwfV3duF8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=TFULjtqb; arc=none smtp.client-ip=34.2.82.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="TFULjtqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1781164328; bh=td4MoN7K9s24ukzJBlhdtmKhHco6aekAK2zFbF5/+fw=; h=From:Date:Subject:To:Cc:References:From:Subject:Reply-To; b=TFULjtqbZH0RGcCnbEmifhQs7k0BiYdORaRYUTXe/mPCOQ+e0n/B+9znBBQYlQOfA/UvZfFfx9z27U6qc/puZsUJmi2K9PEphWTIWjVSduuugzi1uaUTa2jy/veslp7eNfnPv/sS5+2zhpeF9McklaxnXwGX1KJ+w1tGPtQXgZd73Litv4Xgnz7dlVMo91J1pAhAvvQ2o10SKNBSuUIWn9KmrviqghLtvi2NR1+/LgvyQcRDjHNT7u1+t+CN/fLuZx24j+74Jtjb/K9/GnvpgALoWKXsiRgGYd3+8J1G2o/yBd4eLb2utpKXn0oAOcYDnE9A2dXkoUX1UZ2+IDsAmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781164328; bh=w4nbHAniWsPpZw3LTJfkzAqbqul4CyBdUhwuiMpbcJZ=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=bTpuW2bfHTRybMZLljNOmkBDWkndrnNPm87gpLqUX3v04j7nyGfwiCfzGVB9+E6dw+VhN+eeTEbEoZ31FJBobY6ndNHCBWcLVwb572571OzWOA9SKu+PD57SzeoHxaB3ZTMIeC4mWOuS8pGgVdeWqST4sSsHweenECzhSxHZm0jnjScDgookv836A+ME2swyYep+f6uEoam2kx8A3UBfX8Ud96QjyglnHs98ylFsA12f+5JQNYRS5HF1DbWzFQsg/v7LJ0tWv6L7fnvg4hwM9gqsfXEzWRzBU2jciOye0o5EG4+WGf6tK5bp6Ue2PTP91v+tTFakDr+4Cl4t2cN+7g==
X-YMail-OSG: NQ25FvoVM1kus0RK0Sbd.m02M9JBeOVn0mkRwdvjJebtoet14qwW3rAK99g7z.R
 LODd48Z3v4y_RgKl6AzItN.Zhpj_eRe.GGotwDTfJQkbpWSsFsJnRAK_gNft6X.3Pji5RNsn5tNX
 33XhFrrxrHuvhZ62g_AEUDkiOuBrfl_rILwVBjiuoh2nFjzN4sMkukASc6FJdKzkHvV_FLk5rcc3
 r0LscfUBGDV4WTENpLSVd4TMqgBRbm545iSi43QtECHds9ZoXL2WhoDAjfbrKfCld0mwPWMJo0pD
 KfhCMNMZM3gvAoKo3ekN1RS.dZ.GKNWUeOdmy4mfRpRuBBbuzLMdPHuf.80eKUpaKQL43g0IeUae
 hJCmlo8o2ZvQO7TAvrwLu0ABMWWA1o_sY8NW05OMlAu.7LvDgjGOfsuAEMWoGJApErEG6JN7ycwj
 9TM.GA8zC3bwIQQdm2AZYxEb2kRTvDsbCtJDtYWRZHa0joi2362EFD5GVkkuGyEweJu.HHULV3bD
 g7CpymfLuLqoxZDY_X6qdDEx0MP5PtPdgFnUmwuKEvBwICgJdOkSpsZA99pURp9cTMlNXbWEyJcj
 Kt0jMF8b__2_qr.U.Zc76IUn7yKkJMsvDeYVlLXI2kPofGjX8jcTsBuHRZilqqwWwa_zr5spxUBY
 FHmULrUNVUZci9EiuVxIEYqZ9ufAvGAkcHCimPim9Tl2TzgOPf5M8hyGwHv3yYOHkWUKfl7CXZu.
 Tr0E9VRp9NVMjL8t1wdd3a3QjbUiqoA6It698htPbdeqB3J3WOVdlh4qvKW2vtps7ZHpYJcKvXSD
 KJeVvNW1ShvWZgOxnadDOiIqBFNncnOl.e61WSYo4SXHUPSR1CzST7wBRDMGffzBXU9tpLqziEiG
 VAP1qFhhbKNJxX_wuGHxFwQstxryXgxJJIMOkyGvOjX0qX8EdH9B5.NeD0iaVZKrqsLqZk3X4NCO
 svxN4AGzruP37hzrdZmEZ.wb5DUfbF3jcAfhwl_2zp6pOv.k5AXUwZim4G2OQFyezMTYgT0MVmQh
 Lz7DedyjM..a8GVs8DPfSTsporOtQ8n2EL0pyL0bN4l0BTmuWexGgyTj2d7Dj64FmuF_PVZO1cwl
 9L2bf9CeuEhhEEVeFlP5c8WUF9kysftcoJqgHORJlA0XmWs1bdJvXjYuCBkCKZ.ClKfyHkt_DeiY
 LXB4jzpAohCBk3JtQOhWbf6pNvW7_DydDWpfN4r.u4KIDdoVMhyRtfJKoXUTXYd54Rfe2Tv5YuNE
 DMegChmt6RFG.4tRqtcA3EpGWLj8vYHWU6QBtzOHut_2QFn5UMCo4JEvXhkWUto5gdQhb4yTq0Yf
 UL0zXkHxppVn15BOOTm.hFSxoVy6.MqTudBcFR7EcGj2t7zbBuxM0b2Mew2f_1FrJ.8ob1oOnOuQ
 k.mH8zzw5x9lb9Ww9ehHIcor1zE0ntBjnf9N9ln3yU8AiNCQVqtQtybMPwH3ldHS8j1SteLftgJo
 N3hTUZuqMlU2Dr4iGCuKxleIPWKp3XEeruGfDaVrf9xBsKSlwGCR0wd9GhqWDrwjZMba4I8h_Z6d
 Ff9EE8TUYU4dwmv4XaXWTJqGEfO2kV9tkdG8snp6StQAwhaH6m4d18En28yb6AL.rH8juK82rKS7
 bkIYXfeSSBOe3ggLhtaYqHz0kPHKFgtaqq.JkCqEjctJJOolxwCvXkrG53XG9ayrJO9C_Gu8Pu3.
 saUJbiljjYK8kkc_e.Ie5yyZv5fHyfGmKFAdXaX8cTNkxPHQ6buyKCdI8Sb5bBQTwtfzGjgrUhFk
 _4ihdbfznmTFJrONa0OUx2MpPGLxILdjSEO5YJZGMOXXGeK1QZbRFxFlz_um6a1N6LzmLzYncf2Q
 Y74NPP6WhD38RZZRIYe9XqMcW8tYfJoIFNa3mngfcQG0rMLOpeAgXpw0fC.n42x_KQlp5VXzQgvx
 bP3Tqgz0JhbrbWCk57oM0JW2ZxGNgkDTtd9C4VGsgILmXN_GqkE7ypMenSMcsL6sc0dsh8j7I3YQ
 d.vtqiR29k62CCOIhtpCXiDIVW1eOR0NDsb9xilCZuiht.USdWFVgAQdwTrSoMl7tVtrFk0hus8I
 AwKUqIC7QLWSsFGQ-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: d49a8197-82d0-45d2-b752-f7036781b8dc
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-101 with HTTP; Thu, 11 Jun 2026 07:52:08 +0000
Received: from dip97.lsn.ir2.yahoo.com ([87.248.99.106])
          by hello (SMTP) with SMTP ID a80727083dd622cc70cfbd829a387288;
          Thu, 11 Jun 2026 07:52:02 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
Date: Thu, 11 Jun 2026 09:53:40 +0200
Subject: [PATCH] staging: fbtft: fix typo in comment in fb_upd161704.c
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-upd161704-typo-v1-1-2e51387c3b28@yahoo.pl>
X-B4-Tracking: v=1; b=H4sIAINpKmoC/yXMwQ5EMBCA4VeROWsyY2mz+yriQA3GgaZFbMS7K
 47f4f8PCOyFA/ySAzxvEmSeIihNwA711LOSNhoyzDRqIrW6ljQZzNXyd7MyWHQfY1F/8wZi5Dx
 3sj/Dsnod1mZku9wXOM8LtD+0x3IAAAA=
X-Change-ID: 20260611-upd161704-typo-705f37c0694b
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Tomasz Unger <tomasz.unger@yahoo.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781164428; l=1088;
 i=tomasz.unger@yahoo.pl; s=20260611; h=from:subject:message-id;
 bh=UbHzhBK5ueIVwUpYA1gmOCE4iKkRQO9gwwiEYBEwhF0=;
 b=5NupvzPIJeYUQ1C5aeVNom+5T+wmKugKxc+uWGkSC4iwFuoigxDT4hvQkRj1gJDqI8qo9K35j
 lS4i5MF2LqKA5ALnSITMr+XAwYQE5Vu3WRpldOcmVpRWwDq8ZDJskC5
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519;
 pk=elW+gk1cZhyVAkPUfX4QaVHbxERM6w8ByGYxz0Rijl0=
References: <20260611-upd161704-typo-v1-1-2e51387c3b28.ref@yahoo.pl>

Fix spelling mistake found by codespell: "cencter" -> "center".

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/staging/fbtft/fb_upd161704.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..7288140e7c3e 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -67,7 +67,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x001D, 0x0000);	/* Regulator current setting */
 	write_reg(par, 0x001E, 0x0009);	/* VCOM output setting */
 	write_reg(par, 0x001F, 0x0035);	/* VCOM amplitude setting */
-	write_reg(par, 0x0020, 0x0015);	/* VCOMM cencter setting */
+	write_reg(par, 0x0020, 0x0015);	/* VCOMM center setting */
 	write_reg(par, 0x0018, 0x1E7B);	/* DC/DC operation setting */
 
 	/* windows setting */

---
base-commit: 7cb1c5b32a2bfde961fff8d5204526b609bcb30a
change-id: 20260611-upd161704-typo-705f37c0694b

Best regards,
--  
Tomasz Unger <tomasz.unger@yahoo.pl>

