Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531385;
	b=lLQkyQRwEuKB1bAjIdFPcrO1+chAs5PHvc0IO8IHoIvT+fHuBJej2ZtYCbUujYEXdcvT
	 TxqzEd0QOGN10a4tFaPCsswrhzN9VBr9xvau/0GS0SjcG1G9AdA7KFTz7U2vH6tyZ6YWb
	 /KRnh77CfO4wzVPAoqEtFehkjkfrBnZ8Mc3rJVJM7BUo15da6KZdysMHAHPfQk9w5RYUJ
	 KCovTfmoFDGXkuWOWhk+XQMVasbjbNn7Lan/B993h5pjat58Y9FxRC80l+E13WDOHP+x9
	 SAy7NJ3wkmhH9+DN1wmLPqqpxHysIdZXrvHmlsM1o5MEjlHgvseSJPMR/a6OeUkzbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
	b=KUVMQ195DfreoyUagVV9nv5v8Rk3jRsBSioXkKT8/UMe4Rji7JAH9LmslcXveNoOpq4Z
	 SE5Papc1T+K0oMukJ1GsEghAhBPMUIVhn8bXHiWyhmUaRblocsVrc7AB+XwWWgcoUHYBu
	 7W4boaHjjsOYvlG+tYMNC2riGATbFVVcuTyZN/VjCgHK79o+n/e58iUuTvjvdj//FlYBs
	 xq1YynS2mdBhfd8VpJdP9ah+9UIzByfMMRhuJ5W0d29LC57DOXBhRuuCQq/W+fiEXe4R9
	 4FgujMp7EbPDTFegY8o2MbJqEA2BOiPT8pB5zJY11+4pUZLTnBNRbJmt90OFyE+909A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU4YwV6e;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65E606A327
	for <linux-fbdev@vger.kernel.org>; Fri, 13 Nov 2026 00:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A65E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU4YwV6e
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so365624a91.1
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 16:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794531383; x=1795136183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
        b=jU4YwV6etKf8umE12U/D8ulvXvMFFk+wVQjTZKhg8yB4tuEr3cGD/RHs+s18XN4nyu
         UXTkAeqNrsRPCSx3BsOQeMLuDMG6sfaH8eC6QKINMRcr1epCtDlf7GvhmxBIsXHzTk9+
         tImPdyFkqB+PRDhwRTRqFlS90dCTQVr+Wnwa7aHZeyQNlf308fXtlTo6nPOHJXBDjEet
         WVz/KepZuzbdjes+qitSxLKPRufrachLMbALur0VTLDmuS2wrvvJQEgyE3ISSPHjUow2
         r93LC7GxvaRl4LiLzmwAdutBqGLclM8zhIIdfxdKbg2Rsyx0me4Jh/Mk761IQ+VxPknj
         BbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531383; x=1795136183;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CtRGBfCvPjk6NMUwk6EELxmj4aN2F/fvH5mMHwm0bys=;
        b=gm5opl3FKsFt/rrJugaoohBADq092h4Ubr5PVwB12e6FBovYMq5KxaUhOUa4ziR7+D
         /IPYPwUgonFIhvgFsIGhuMWw/M1JRRYXIicCiYKuPL+dpvLKSUCauqoUVL7B+Ylfgbuu
         jsLHlMP05NqYqeLdq7M1ILiGGBvNrtozk9HCk0QwITjsfqRuuU28/dt5ZzpMiMmEmGaH
         RIM71aNRs+LA1IpE4WDKOViCHhrKKnrf2PlKFh9lnpmk07igw0rl8fMDjIZG0rzbnm4P
         d7kFzcySC2uClfPr4eE8keAsVU6SeARcZ9pEVjRf7LaURGS2Xud84aHiBzAQNxzbmcTg
         Y9nQ==
X-Forwarded-Encrypted: i=1; AL+hErF5fiDm0WtyOeGrdvc9EKvwkb8Uor4/biIPF858rdnUcml6VTnMEnEX6TIxclzsq38kpxkG5vU1SzJCVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+UZbV4Uanr2elc5P8Is3eyxK2qjMHCKTEhEUvJesBtOuL++x55
	IUgWX3pq23V+YyEIC3Bwae+nsV+Q88tJnuU9kQQ7iirgKq90L9Sc+bqx
X-Gm-Gg: AYBFou2YCubo5wzWI8aJ7Z4UP/Br9zKLcuZJsMuKJApjIhGvK3pzTaVONjPH2DCQ/Zp
	oQt5Ts0tfzPFpvlj+d+CBA2LnK/hhUU0/UR0EZLNw3/iUSs2gE952LI1SxKK/Kh9wIDHIz6TJCL
	HG0bIhhd29/14G4ebT3TAWb5cE2NMihvV7WTMyUUxxlcTjgvf+jNMrX5Kr+HsJsvKCzyzxATtYS
	GsImxgmYZJAr4s1xiIKwJKAtYxTrjplOaWkiOj4WN+HYzOcwUV578uiLJQnU7/3TZgZcsyduh/N
	+3R004ulw5mHK9JzTFMdtpKSzMVxszv4A0izGsrLpzdbPX6j4r6xsNGDzvXEjK8LEATrosgnQV3
	OtyJ0WtWKpqq/5SAaTEYbDDHftlHUCvGdsshYIn9CG1awci8OE+l16MVVNgxRqtu8Mcysh/eT2/
	fQ5H/e20scYlidLLXaC02pBAnxHX9m2VNCGEnZDiyLIonqZEYFrXnkP2bQpMWv2dbJzJvTfX3ld
	VnoovNA5XqeCqvlMR1GrPnLuZ2dbE94no6IoTHTKJt+3SnHpS9SsCZaiNrmkNLbzVW5GV4i9mPt
	LlNSs7S/CzRAc7EAU7o8IsSNtg7hObyv0crCUh1X9PD9g76fzkbEHbz33JLTYNT11NcV7C6OWnr
	t5YDQRpxGCEoSg3gHzNYriFyqoReFC2Uzlw8CeS6QsS59PPm88FXsKxpcMuglmRAEnkqNXRCd1Z
	k1F50CKOirGORV/uTOfHvATcd7K8vBhPXlqu1WU4q3qXXpekAAfgrusQDeNWJraZHx2DvmE30uE
	wF6u0/xDLeCACl5jOfbUVIP
X-Received: by 2002:a17:90a:d883:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3b1b09f3b50mr619305a91.16.1794531383375;
        Thu, 12 Nov 2026 16:56:23 -0800 (PST)
Received: from lenovo.localdomain (42-155-215-210.ipv4.nexon.net.au. [210.215.155.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c86asm2351735ad.23.2026.11.12.16.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:56:22 -0800 (PST)
From: Miro Kropacek <miro.kropacek@gmail.com>
To: deller@gmx.de
Cc: geert@linux-m68k.org,
	schmitzmic@gmail.com,
	lilinmao@kylinos.cn,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Miro Kropacek <miro.kropacek@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: atafb: Restrict SuperVidel handling to the Falcon
Date: Fri, 13 Nov 2026 10:56:16 +1000
Message-ID: <20261113005616.402721-1-miro.kropacek@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A framebuffer at 0xa0000000 or above is taken as being in SuperVidel
RAM. A TT with a VME graphics card such as the Nova has its framebuffer
there too, so in 8bpp it gets the Falcon palette registers instead of
the card's VGA DAC, and in 8, 16 and 32bpp the SuperBlitter, which it
does not have.

The SuperVidel exists only for the Falcon, so check for the Falcon video
hardware as well.

Fixes: 51df976c3268 ("fbdev: atafb: Add support for further video bit depths on atafb:external")
Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
Cc: stable@vger.kernel.org
Reported-by: Christian Zietz <czietz@gmx.net>
Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
---
 drivers/video/fbdev/atafb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index c32576cb1720..5d9265caa9ab 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2065,6 +2065,15 @@ static void st_ovsc_switch(void)
 
 #ifdef ATAFB_EXT
 
+/*
+ * Only a Falcon can have a SuperVidel; a TT with a VME graphics card can
+ * have its framebuffer in the same address range.
+ */
+static bool ext_is_supervidel(void)
+{
+	return ATARIHW_PRESENT(VIDEL_SHIFTER) && external_addr >= 0xa0000000;
+}
+
 static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 {
 	strcpy(fix->id, "Unknown Extern");
@@ -2083,8 +2092,7 @@ static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 		 * SuperVidel 8bpp chunky (fb in SV RAM) uses the Falcon palette
 		 */
 		int visual = (external_vgaiobase ||
-			      (external_depth == 8 &&
-			       external_addr >= 0xa0000000)) ?
+			      (external_depth == 8 && ext_is_supervidel())) ?
 					 FB_VISUAL_PSEUDOCOLOR :
 					 FB_VISUAL_STATIC_PSEUDOCOLOR;
 		switch (external_pmode) {
@@ -2181,7 +2189,7 @@ static int ext_encode_var(struct fb_var_screeninfo *var, struct atafb_par *par)
 		var->transp.offset = 24;
 		var->transp.length = 8;
 	} else if (external_pmode == FB_TYPE_PACKED_PIXELS &&
-		   external_depth == 8 && external_addr >= 0xa0000000) {
+		   external_depth == 8 && ext_is_supervidel()) {
 		/* SuperVidel 8bpp chunky: palette has 8 bits per channel.
 		 * Without this, fb_get_color_depth() sees length 0 and
 		 * fbcon falls back to its 2-color palette — the console
@@ -2245,7 +2253,7 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 		return 0;
 	}
 	if (external_pmode == FB_TYPE_PACKED_PIXELS && external_depth == 8 &&
-	    external_addr >= 0xa0000000) {
+	    ext_is_supervidel()) {
 		/* SuperVidel native 8bpp chunky scans out via the Falcon
 		 * palette registers, honoring all 8 bits per channel
 		 */
@@ -3336,7 +3344,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 		memset (screen_base, 0, external_len);
 
 		/* framebuffer in SV RAM: enable the SuperBlitter */
-		if (external_addr >= 0xa0000000 &&
+		if (ext_is_supervidel() &&
 		    ((external_pmode == FB_TYPE_PACKED_PIXELS &&
 		      external_depth == 8) ||
 		     (external_pmode == -1 &&
-- 
2.43.0

