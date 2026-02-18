Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9A248F73
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437935; cv=none; b=DTEbwc8buIN5iQsmC2oATKJfBsZ9UtgMZeEDVSNTUh6+tp1DoqsmNi67KQefa55+V4iM3lj6Vd6q3/d9GarLfDYLF6X5hq8YVSymi6s9UjLNevagqLhnmblzHqlT5NqK0fIlCNB3akuPAzLpdGeyCCDxPd9cKBsJqns3yi6sNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437935; c=relaxed/simple;
	bh=4OjeIzluLTFXfIPZYQh8T7dB75J9bPfIcpAY9c4NwLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=rksna9ZI+6LAEsvhrFjKFKG52+EbeTd/SXysPqvNYlGFqWifzu5As4xQOj8nuqXlDYCRJKND5xQchLuLMwZxnj6RTDEm3B4VdQMAQd+vQsMzUJdeEbwZ6FhBKOcWt4DLZX/Ohq8QdFmDKNnMtXRimUNQEWORGE5psp9c+q41tYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=NI39DuKb; arc=none smtp.client-ip=77.238.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="NI39DuKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771437932; bh=W+sJ3VNDowmOBUMcqspMoPWR8FdjjCPVp2YqC2j+X9M=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=NI39DuKbYqj0tUNFnGy8YXooTwFjDhh2nDSmu6tJS7H7lXsTwkKjb8FfIoGp5d0ax8B1SZY2M3rg2yiTBIrCDvu6wE3sZR0hnZVA6wKlUYJSEm3zoYh9Iwr2KDsL2wk7O9h+WzcjaKeL+OoIFn1R8m8YOWp7/B1AVegGVG5WGIUPFjukmt/RR+XO+brlANiOGpi1UlaBxViTcpuQCOYk6F4dLNO0obS5N93CCuITqcOojSGmSDfRwxXjnAsuU9o2EkLW2QD+q3xhyjx62epnQq0GJwBOJe6pYcJ6MT77dn85XRtlNo7R5nIvexz6yfkFNAjTzE8S42/miLWCxCAbZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771437932; bh=LCHsg8bWQJri9hJ4tvxtPgVcuV04z4CidyZyfDpR1xL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZAlYlq1YN0ZkQWihZMdOCqkpex7RAePG8yO/hY8DsULeS9soCVDo26yJ8C97v1E1CLScAKYng3Cx9cQUdIBSMHnhewzVSO5N4IZPgw3ulkeIa2mPtqEo8vMdsl4/C+YkUPUfcluN2v/8mjVbPtt9qqaO2Y0mkAC8cys9iS/oTvBcNks+k1oQlDdoOr5yQWPJ6OE9kZERE+tN2mPE0BOt/aVmPt0E9WBQOWbVCHoX6Tb2kpCw9pMea/n8Uy6dT/lMycmbZyr5S4Q8Aq3uALrJEz4WyytS/drN8h5Yi8cDcO3RJQz/QFnAyxNCnSxbtASh41NTAiWi/XsZSz1m/e+VxA==
X-YMail-OSG: 4sEOnZ0VM1mbcZht71G0dFrGEjLDtJmK5ZLiamtq6ezmjcvmGlxK1R6Pe0Gc91C
 71WLMqd5mQbAyq46rzW2xdMjGhl7ZWhjCAAELhnwyMCWggH6zEeM0VuokELTOd5HWkX2U9eaf4VU
 jP9rQZ8ADmlCdEzoYrv4hQnR1O0dGl0mQsfMITS4iT339S0YKyomc6Moye3UUowLxmN14t0L3lhZ
 rtFgWEOZp50hHd9IBZiavhOcr0LULAHuXde3Xet4ugymrZ85ZY70TTWJHXlYFFFALG8ePG7sxSKm
 prfEeXC9H99PuwZa_Rb2p149khwEGmQv6.KBjND4mDB_LauqUpQbDS783QkCUC_UgNbPDcA5hBNa
 E5SW7hEIj2wMZt07TLMqAxSWnwa_hZWFk1NFF1tfPIoVtzHKdtTPYU2KfyTz0p9rKuFhg7GtECw2
 FBGsrQ9ea80JugojVNRAWLXsAF1dFsv7CmqbRhqToLFMfOE0HtAKZDj1P806tdlA3bKEIeZJvIYi
 a1MKnBhLS0aLSM408pc2U1ALIKx.Xr5nTkyH5ZHkPkeWoBCLZJ5BbYRlyescA.vm4JJut0quO8Nq
 .9L0Tmshz68bdl2zZIMUMuUFnIazNTtsMfr_dQQnSQlFvGFJqTqI6yiripcaBR9iM890nzzAJZ9_
 ktptBrKhgIj5EdDJveFwqqRsdXGu80ppD.sJgmBUvxtSvdWHC_5NS6NcYS8wWfJdsLLUTV9wqmGs
 PF76RjnFhKdRU1qBkHiC.MeCdeLOh1hhxA8zsQH8zsC5.AYn0NXHMQSS41FzPHxi3SOoWrv4p9Gy
 b.ScV_tjEGrlRT2iZ_gOlcQWb1tZtho6rYZpSWFtxSxHMqpAEa7vrbKEnIHJ9Cdu2uRF04Rny57F
 ZTCw9hrPB9W24lpnGxhcTHz3P8VN8Ltz6B1PdkhIt_L7rSUBUT5oKm3Odv3425vPzR3CRQMaOCig
 irwAGsmcBCQNhWw1m_Z10W3xjYdqlfDqQHzVR.PCM8Oo5dPJnMf7HtZ3yCIZN0lM8uzItjm7j2WQ
 zWWcONiSsneBOX8.NvMWq9qTvVjwQtq8ttT0OG8hI2ytVd8uCFdt3_bsC7C1ZMDHSu5.OLejmZVW
 vwHUarc7j2SeUAnAAO8_R795nloFRTgRYcrPw8qBQOtXdSAbvIabEut4jzejPw_mDEVPrRw2ytkq
 rGGZobR3lDX.wOL4QiP320tBqg..0U1kAQ0TeCx.P3ACWiOjAdj3eC3FGhbj9n8kNNaQaAlR36Ku
 YGGgekb7w8kdWqbcrCSpKC4lfPJnnIfC7CMPnJtGZOmvrIo88kSeSveJ.0ziKQ7FUoqvmAlLCxkV
 nf4mizBjZJYcJpyiZwYZYjQwC6tkSlr305WEKbg7053HNw9tVKqqW40z_RFPzXZRoLcMLcHibRf4
 om9DRknk9Yo68mdJvEjwhKPpXTepVDLx12E.PchpTxtjRJLvAMQxGw4UwllsaiHLKiPElRieob7H
 XQF9rCNzMbF7Rn084tVj.Eqo8F4QWIFIjFQCBwDvTkzlJKGMxakVBNWPGoQ1Xrru3n8AUZLFPJYg
 RYA7VXAG0Cbjw4ZAvrNuZ_aO9TrFEwumx0nm6A0TNCHs_KzlYAno9OFSRpUReqAgQFH8O4Zu6B32
 ntUCr6yB2pLG3rF0L9fzoRkRUWKqG2U0jgriE2phi8AI1qAAupPeBNRCzyRhoSS_CUZPmcxU2YOZ
 l.ZslBwgJyLrIe.kG0m1t6sd9n5SePlhDsH65CSRdZYYPwwfJtiNfK6NCE76MBiEpZkF7kIpEn_I
 U.h.eUzmtfWWuDGZTTjFOFRncPB4ORqUJ3ndZ6lnD9JCsG0.tXvhYIxaOt4MhYy_BhmpxuzoEwf7
 lIkRhnMpwjZ3IZlzH.k0vwc5z6U0P4q4_PuyjUvf1F_ZFt0pskF_h.YbX3G9I4sJELXaA13vbNe4
 ckfijTGBM87z7XVMFl6v6Q9lqR4wlhryjv2uuBJaznS08Cj0qLLhvJT0mlNrYDo_MSp3GbjgeYsp
 LfDz_Ur1Gvyo361fpvIDBNSR_GBCWm3ZmTm2CCLn_LLPX2_TMOcXM9D4led70sj0aLyRCXjOSGTb
 Bw.ETulnd3khi49yZmptgRmUkEhzwnkSZ3kRH4xsx9U9nAn7AruGoqyTwXCNyHurcNoEImOkGbN7
 3tUgHg8Z3Y_LG8iYF.1ARNY9ywF1Fe2I4V8tiuav8vHEvZkdF_Ki48gen_RgL8qTBDz6joAAZTWe
 VpKY3VNrw0h8jzMYAQnnfTeBYwFl3FYsOgsXa5rviruiDLQy88P5QmPdB1K31su.rOQkDhsWIell
 tpcow_ux7pjE-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: e8bec533-c71c-4e69-84ef-a68bd4914449
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Wed, 18 Feb 2026 18:05:32 +0000
Received: by hermes--production-ir2-bbcfb4457-jfg7j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 629fff2e81fd17e3702ad5303f037aa4;
          Wed, 18 Feb 2026 17:55:22 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] staging: fbtft: fb_tinylcd: replace udelay with usleep_range
Date: Wed, 18 Feb 2026 18:55:17 +0100
Message-ID: <20260218175517.87544-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260218175517.87544-1-tomasz.unger.ref@yahoo.pl>

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..89ee7b9d621e 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
 		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	usleep_range(250, 275);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
-- 
2.53.0

