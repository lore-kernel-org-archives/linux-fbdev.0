Received: from sonic308-10.consmr.mail.ne1.yahoo.com (sonic308-10.consmr.mail.ne1.yahoo.com [66.163.187.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2A12E78
	for <linux-fbdev@vger.kernel.org>; Fri,  3 May 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702359; cv=none; b=O0xWCJuZOtqvFvQrkIe66YUcWKOebzVU7DHdsjLUV94rlKEWMXEe12WzBA1baIb9jf2b/q4tctvHGvcy24Q/Q0Dfsg4L7hEXJUrqEIYDKDyveJ9TbCOdwYjEDqeloh8qv52fwAMNScno8pJd2bhiuugjUTpmnpQ9FTr0tiIdMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702359; c=relaxed/simple;
	bh=m6gVHnpDv94OtQb1WzCQEDhgWX+/rpjohINTSTQBcqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=NSr5X9/1XQPe08mxx5kuvbTrpBS6tl50Ipf+y2V5wwpiHhEfK6lNyyBUaebBKaWMu697UegGyZXBGQkXeWSRWj4LNeGcoo+hvRbRKvXiDaqqa5e5YCkKdK4sB3LY+B+nfOapFpq2Lq4oUdbiRwq6VGCgXL/ZN+JW4vHdbt5o77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IdMvGkBH; arc=none smtp.client-ip=66.163.187.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IdMvGkBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714702357; bh=wZFvjf7RvGdDPgjEKbgS98RbOprhqvsUijRsQOl4YtQ=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=IdMvGkBH0nWV/3oAL3oIKwD25uotdSlS/PuXFfv9k4YwLcMJBPwe8xBFPOtBnvp5BXA3ww2kAfoGhoQw9MQHposajIMf12ylMSc9q77a9oqKA75jC6WJXS1GTDYVOQjjWZMniN41xci/G13A94xwMxowhk9QnUYa6zf6ZdpWG/MaOHzuJK8v9OJ9ENXcxo6dXdWLVsLQSaKFqNrb+hnllp07TBfLqYU+Ou69+BE/ucrCV2Z+4EJxCwgXSQ6dq2OGZBg3ATCZzKsay9XbhXIcFnigv/j19MQ7GZuCfMrt1o0sTBVQaQHBk58Va/ykOquNM87X5AU9itlJdbsR8x+GfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714702357; bh=beo+Z3A9+pIxYbky3Na2D+Ii/tI+7gLWYyYN1JVRcWZ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Z/4Hz7uLKurjpgFGhJb4DJ+5EYuDzyEn4e90XWKlGBeVVwKNSEw4bSkCyiir5+m2Pw5UwyNeTP8ZvoEj3bOVWVW0J2+Zq0gNTnK5oa4Oj1+uwrqTL5afBcDVAMHzeO6DuDQ7HgQWgGi/QrQTrwbc0Qf76HyjMGgVn+NkKywK1N9EH1m/sgKCSfMRXPfFa7ZufpWC0gBs7eyvHbQtlNHsffiEYBhzxxziUmnZztI0O4csKEbJkUxEcNvn2GM81judYlcJVxGWoe9BPYJuxzEjk07svqPELuCetzqoaM+cZw65cNa837UcZD2mse+eyVtBosTmweZKdKpEW+ocCFlhhg==
X-YMail-OSG: i4heJ40VM1m_KJzltkzucO2ER1ebgjMXpP9ji3gk2lEsQW790DetMDaqeczECj_
 I50qrDUDSbbwfcGiHVEx34C3vwRb6dvvxYHWZliLmy6IUJV3echC245Vi0fJ6LrWh82bHrZupv5I
 9ygoSZjkx6jZFhPcZT1HcN9fKHIRgl8frlxqmsfyDpSw3DozAYzio_qxHaC_jnA5NFoj4n0GQO_8
 YSOnOwA_4vgcJZLg5KihVV0q9oCNNbI3BETspiD3fWd7OU5aWjYIxKYh19_cpPaP6BZ3kkZ_Afs9
 sd2joKEzpKtnv.9YYpdvXNZZ33LfZL9yc.6w4g2cDjNo0dgVB5cUwizCRKohLTzUXmbqBHO_BryU
 NTCCvIovFBCfELKARoxEk.ZGPPa5VBse7cP4cKcHwy0j05f1QdqYQUkxH7Lbv6meWKTvbawtmgvv
 fnluzb4fqrWlsAP3e0h0kmP4WjVsTrGtt3990wk0as2NbBCbRoSB5T86sScUpS8cShWmz1.PKROF
 FQzgQl6nTSTbHatrORrI2Hiuc_8MPfXUoHEvDmtn5Ylgcokz_GNU2mEu9O3FRJbsUsnriZgrGLp.
 aMxVW_vfV_XIgHxo3LmkWNEzD3MrSXqr42z_wybmrwVjpsGiZvvnnVfcRh6ztEyzNQlLh1ADhuVw
 RReGbR6pBZUPIz8AIiECLH3rdjCDtNpA1uwGsiiLPsTEoRgGAyasxGfJsNdn_I4xKr2dWUdug58E
 VhobfxYTZ36aNbvCdE1lIHt0z5EuPzTWw_oif9TWSCu9c0slfJAgf4QGqC5uTXnfmoT11XrIhio.
 2I6OhHGYmFoiAHJsiLPgTYbV60Mp0vlMhiaK_veAEuSpi4QSOw669UPSQQ97c8JLLgPxJsl9irjY
 39poMhvQQNlax2M0JwxEx3L_E9FAfvPv9uGc9FlLjTaIJq8L_o365u0uhvQm5TJbbVBuIt_FEsSL
 xcu1KFha4jGyGwmY1Cp7YxgDprax6lYkiCl5K_vJ._qLTqzTarXF1QpsY3.QnfT0nGT7OtzfZkYr
 gydSGtk1SxICOP7PWuP6xwjKesTd4HBw0coXbGoNEuM8UV7gW5.C3m74Sm.hpt2eF40f0XkhyEAS
 U0H5YupQTeGjJuCYASEJdlmoPYbSz3IpL1DjeVNSwcZI6oWUiJgjkHtRSMiSQfEjYrAX7jBWOR73
 dlgMafL6_5hTITA0GvO8l.y0_yeiKSGHBtFt00e.WMmdycMuYDz9bwLxXf8bgldgQg3Yjddcgq_E
 Roknb9X0xZ1E2RmTtWfaDDUF7QU128wfZPowThgfXGHKiYlEDIlqyEuY9bWAyMzO.zKEINJNEozr
 TCHJB.nPCBmuBr2YT36Qza2T3WfB7Fs1VNjkp7FXEB_WjjUFBHHfHHTGHazN0GsGXr.V3sCwSClL
 pzvV8jP1TnDzUp4kOvJZirGKD_9GmYcRDkbQ4_VN4dQjnqDdsuxIkq_10DXFzN2x_OHNaJqNdp49
 gFgd_xOOQnbssGzudO84cizrCN2voih47nVycusDFw7mlO8bTV8RWA5E7wNgWtWA5h4ZwS.HkTWL
 veM9Xw8L0asLPfs6Nf4URGvuaRQk10FkwBcHJMWtl9v8HK33Yk5FRCdrmyCTsUECLfgV34aVF.t.
 .bxa7ZyvatYhvFvRQpf09cGzscegTzWcip.V6I5NcbdPhsde0Vg2kE5coV.l7dX5aoMkSPQ4eLLT
 REkNM2cOzQ5grXmRZPzAJHzWBoI273P6hgrQsubgoID33969IG0cfUd8OwyloOJ4ohB4KwO0Db_Y
 hlGjY9gydLZajXgNndM5roe6uSDtRTn3kWfQTDc4sPvDM64LLH35SzwqDYCht.JM0gJ1w8wTPDGA
 7Ym2_xQGrlfs1LCYTDiYsfJUQD27dhrI6xUf9mdTGYeMfTAq8wrCQ_houkmM0ObTCCpfzLAHuyqt
 5HHcLTmpJMZbzcbKBe_IS19GeNdXgbwCOHEuui9_TWcE5osO8EVqXWi9OyxRL6RJJPK0s6AmdU5p
 FfE6Rfo.fOB.PFX6kgdLq3MJ524jddI468avFD6eH6l5fLVqZKCwEU6S554TfpUSsYlSfqtd_ygE
 vgVHq8GeWtg3v.w.XN6tz8ISKQOEvoX2Rhf6lXgJgW6a5nBFMRCYQDzHFw6Qh5MG5B_VE8ApcNnl
 i9Tm_puz_js41P.lB2Xw_QsLTYgdgCSN.7_5utEy6m_gEqwf3Hxdph3rgVjkIehi2HnQr7lrNIy4
 Oi7pkuF_rVp_agcOlky5amx_IGQPgWFvT4Fy60d3yhD3HHLOA6l.C19BeyxEuWtHd2PmhfK4x.Uj
 jtZ655w--
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: 31c30ff9-4da8-4db6-9f97-f559213ed16e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 May 2024 02:12:37 +0000
Received: by hermes--production-bf1-5cc9fc94c8-df4vd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ab2e3e683b80a82edced05c4a0938865;
          Fri, 03 May 2024 01:52:19 +0000 (UTC)
Date: Thu, 2 May 2024 18:52:16 -0700
From: Ashok Kumar <ashokemailat@yahoo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: ashokemailat@yahoo.com
Subject: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Message-ID: <ZjRDUO6/M+RDCcQJ@c>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <ZjRDUO6/M+RDCcQJ.ref@c>
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Corrected coding style CHECK: Alignment should match open parenthesis

Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..60cda57bcb33 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
-- 
2.34.1

