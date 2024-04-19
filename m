Received: from sonic302-22.consmr.mail.ne1.yahoo.com (sonic302-22.consmr.mail.ne1.yahoo.com [66.163.186.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB213A871
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Apr 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550481; cv=none; b=HUPHkyiHsvneyk/E34DyZvMQGCTunqU93ECEfQIj/QlMRtiQkP2O559yMhVSVPRvBm3nhlt2O8HlOOJZFwpmuQC226iOtIumsgZmKrM4Ef1mGVTSdV0WZL3Tj2ksnxc5N8959fGJYikOK9L9QwoqAMJeBZSx4Pr9RQwiDOgTxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550481; c=relaxed/simple;
	bh=blljeHd9x0gxpn93U2C8DaW0yA8kvS6g/Q5C5nSZpfE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version:
	 References; b=swmlC1XPJ4pwwgWfppjvqdDgyJDg+znWTi/VokD/lPyEBJAhJn410wGnKft+MhQ47j+lck+UGTz9beMonhrJexB+iehRTkFlg7eWVqtN6BxrpWlqd78yFxsKl1fM8KYra6YDVKWHoUMMPjUvqvF33/7rHdUnlGHUkb1zMheSp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=U2J+heSV; arc=none smtp.client-ip=66.163.186.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U2J+heSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713550472; bh=RG/96UbEdQ52BT0k7TkxJ3eNd7aF8qeJn1MJEz+axZc=; h=Subject:From:To:Cc:Date:References:From:Subject:Reply-To; b=U2J+heSVn22zgiy3gd/X4M6nStUwNs2orl0ZbKREUZjXkU0SxEDtRLKs4+FLnzV8yQNDmZmZqFWYVPs1PoRkh4Kbm/NDHa/c4YuqWmXCOWH9c64HNlHrB2mrb6VqiuBU1E8HuZXYzkGJYoiewpbWmig268bee9FYLMx0HChct1uOioxypYcz/S2RKYRMjSYT8ADe6/hhj9e/6D+Uw3u5l2Ge4NqR2emqukxUuMR+wEsj4FYCdOPlRuEdZaRH29g/Ux5gMnes1SRsQOCPLZB23cIivhWPBPK4aqTgu3N9Dio9nZchCgH1k5aUl7ebao0O3oCLDAx5wKCo9f02wM069Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713550472; bh=52EeZNcVeydDfVmho0x49q2csL5NOoSPeXTRUU9Gu2K=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=WZdFtzE/6wkSfYusokCS8j0XtOa5e8IQQACyei3StN+kZvxw1899h18QWp1yATh65Pl9ynp4ib8ZgZb86fn85heSbTlIFm0uINeXjDX18Y3ExRQ1wQ49RlZ0LnVKnLojxxqk/aITUHSQUWUd9CV18Tq5zugkrosgyMkIMPBnq7m/X+fRSTH82NiF+8QmH22+VaiWWRsjJHOE1LQZ3W0zqoyKwzg9LCzpadr3kuCDykxl/wVTHUssU/yDkwtprmdefjdNX+s4HpCufTWPWLHiNzP5f3pNHBUvO4+SxvVz9/rWcP52mKiqmk2KKTheOBocRjOvcx45LMEkpkf/sR2Nqg==
X-YMail-OSG: e3gt4eoVM1nSYo.FK8LfKpIhGX4b9fecFRCvCnUBSr0WQrciss7EyRTloalubBa
 evlFHT1GrinFRAOhXeHK6yXFR.q8TqByobyZ11NzOg6wwQ0FsTelCw6FtrXZKHuOh09v7T65XcXG
 c93m_oaHdaJOPm89vxLvFrAIMsYH5CbxvKnDvU44_Jl_j_jxQvnh7m37Z_fTR6m54PEkclTr9B9l
 Tw8Q48bda4f4QPNuwjgIyuAQkBd61EEx2qqjEuvCyfHLprAnbdq4KWJrkX09d1xBK1PBcNCLmVDd
 AzCxEwBSoi6y59gfRxqNcjow7Q4g9_.o1Sff4TuTE6nlmRew_kKTsAWsFqgavvtFysIF2gFzNzTC
 XLFfU0JPEw_sG0nYSTRQEv0wDbYayEiKJNnoC.Ms9DcyK5R_jqMYFYA4rHbw2OopW.1M_6JHaUrF
 U5SMAz4oRHdpWvFqdzp7I1A65IQjFOL1QeF2FQO3QeUDvy9nUfQuLFq88RCz4iJIsLl8mtIl9buT
 cE.2BAwy4V7XA1i4jcBmIUMB92KItRoTaR37dmPXoIlWStIG.EOypwwj1eYOYSZNcGBVchYUkMUe
 kDXD2tMq0c_Ho6a82R2Hor8u_CBAkwpVXUY0uVcXEcEN2ej1PGE6BN3DYh97If3nxlqzf8b4sHLc
 aRVacWi9wq7iDDiqURn5l1jcX7wXLzD3hoU5MXntdqZtk.yelaxVh5S6sEpEQdoMdiqLckqANI.f
 YAhcSoK2RMkFIrB69QYqwIdr7k9cl2wvdsznB3SiyZ1T2FVpkg6YdGVNYCjDespEdHvVe10ijW_6
 mRfuSt_IKyawsHyb5xGsOh3x7pLxmZL6iecezqknA9XMyjJzHsdZk7Ra5KcawBnSqLnXZzYpROH4
 3h_Pzq8TK8S4i.qREWgedGl6l.LYZ2Lha_yLgXSWZnLTqp1tALivXx5nxLedBIxXhhFst4cnjSdA
 Wx6YQQt6JZTBA9QtCZtRE02WJdzw8J.5TMQOpI1DT5f847IO9GDw682jYZVs.2VasAp7E54O8In4
 PObCWFYlKVYxLgOmZ0I3rkWwtJmfsPbwsPUHeCajcl5EsU5i._nQKSbKhnDNhH2PInAAVVoo_hvg
 hgloVBRhKwHPi8uoXGWYSfqiXTHFohfNdfYYmkTf5tJOPU5d0D_FyA3W922IwfQBm3T_hBJJ4sew
 qhHbOAwRQ6T58c9lw5o3X7TxxMUJbBcdYHUMvpl1m2G_Xczg5BNyxu8oZAvudKoo7kCBFuGcETCw
 PPttj7ZQmBSLQSAhGho5BWIhKzSLGuXEU7lXp7A74.k99PG0NpKrWbzLVZPffeOtSGzSgLS51dex
 rWderropquae7ISoo51qrxjTTyolWecnHUWPhnP6_tKus_jWP5UXYvqpV2VyRSSkZ9E5eSDHhVAS
 gGFOhPFC.mCGdK671VM0S_riM3ZNY3UbgY.R2GfEx1LqAB2M.bwn068M.6ABKCXkqXQQq2c8rAYX
 GxXaiTUjvV3i_b9W.s_qE._Lh3NAKzCaSJQ.mE8oRcBHjfebbbHbE9clOXHA1QIhYUSPDMVoijyL
 llzYG8.MQv2zbJLOwRceXXJwH5flSChhkpcbKZ_yIwYf6.hQG.YJSdjSJP6EEHdu_6AOhdsiBGUG
 m63ulRslibRTGsZV3wpf.gjA_rWOfhD.nS4S5tG5pv2OAZcccg9brpbgeSI2Idy4T5Z1ufiptbv7
 94.CjaaV7EIxzEGNedmQOn_eaHHSVu8HHNZpusGmWMRDbYSd1QK.UzZd6CFdCzorg.boPTh1bAN_
 8nQqhyUb.MnSQ1xro31c2N2AoM_uNN3DmDEdxuQN3.Fz0fLdKRHCq78yxYI75IbXjbO8JDs1eM_G
 yvCztbZiXrCFzVRtFbZV_7DSR.Y5VN8_hSJBM4ddhFOdnEjhmSlAk_2XANNsBh.AUgmr4dPEemZW
 aK_lCKLjbIqETWwvN8QheQM2c.emmT6bBtXbY7Q4k0ZEcmQ4Vlz7g2qvEPdqS7LaU2dVo4V7O_N.
 HiCv5vUO5a0arvHwIHKlfRaLbizTTfNgx4AWFTcNcNSpZ3nyjgxBC7GdLKO0Uz930ZefL0OONtHj
 zK8Ee9qDnmseHDnodSr9i5NJpSwLUU5tpZzDnn0Yfi8BGNaFaCMD.5HNoR8tt05KuY4gXix2eS1y
 Wt.vx0U696NEOp6FCH1VTVMoGYx3HEKjayiof6oN76uWrGLGPyFNvtAGSY9M3KTz405aOstV_t5Q
 SqM9QJ_7zgjlFnON_5wka2ih2VZS7mMXe4oT4QDlPfGB01oaR9_mjS5JkhfGXEFhWfePTWuVS6MC
 _SnW3Opp0fjXXNM_iRGoMF.5LGjluVfQydZFxg99f
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: 78246457-ecc3-42ca-977f-d023cbde13c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Apr 2024 18:14:32 +0000
Received: by hermes--production-bf1-5cc9fc94c8-2vdn9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee5c49b4a47ca886366b559aa52960a3;
          Fri, 19 Apr 2024 18:04:23 +0000 (UTC)
Message-ID: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel@yahoo.com>
Subject: [PATCH] staging:fbtft:fb_ili9320 Removed redundant Parentheses
From: A <ashokemailat@yahoo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	outreachy@lists.linux.dev
Cc: ashokemailat@yahoo.com
Date: Fri, 19 Apr 2024 11:04:21 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel.ref@yahoo.com>
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

From 51e98164e314a2d1d834d2a9baea21a9823650bb Mon Sep 17 00:00:00 2001
From: Ashok Kumar <ashokemailat@yahoo.com>
Date: Fri, 19 Apr 2024 10:32:48 -0700
Subject: [PATCH] staging:fbtft:fb_ili9320 Removed redundant
 Parentheses

Adhere to Linux kernel coding style.
Reported by checkpatch

CHECK: Unnecessary parentheses around 'devcode !=3D 0x0000'
+       if ((devcode !=3D 0x0000) && (devcode !=3D 0x9320))

Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c
b/drivers/staging/fbtft/fb_ili9320.c
index 0be7c2d51548..409b54cc562e 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -37,7 +37,7 @@ static int init_display(struct fbtft_par *par)
 	devcode =3D read_devicecode(par);
 	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code:
0x%04X\n",
 		      devcode);
-	if ((devcode !=3D 0x0000) && (devcode !=3D 0x9320))
+	if (devcode !=3D 0x0000 && devcode !=3D 0x9320)
 		dev_warn(par->info->device,
 			 "Unrecognized Device code: 0x%04X (expected
0x9320)\n",
 			devcode);
--=20
2.34.1


