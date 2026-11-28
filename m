Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795824947;
	b=lfrbHfgGkHJuwXo/bZQzilifPUR+gKKQKlZs5Zkb5gF/zEZZSvF+RtO0WIxechUazRSz
	 BkxsC0vEtBO0cvR1eb2Im0BxgmqIx+5Rik/jKF6xqUc+4pDmmV/3g08K3efXYYv2Y1mv5
	 6gc45HkvLBcI1X8KPjZbriMBFnGLxs8uJWRs+iDJWrfV2RoIxxmb+74FY6S0KRiHta+Zw
	 KgZf0QAXIwnUosory69bX64HWKnJ+o1/BZhAuy7RJIQH1KXsUA6/Wl+VxlLunmWCqwzRh
	 ldsfW0sLHL6dSOs0uK/mvaAsSsPYLD1vzPDWBT0IkxKaDZPzhAJIXxVjNpCKpxHFPiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795824947;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EkG+Dr/aMoMzUSj5tk5nyxA5r22ol56pbCQ3Z9eMFeE=;
	b=RVcZsN6bMmOMio3tjDj/Z4O2qAOcDOzOqNDaphcEkNHwRMvJQJEpdoHPW5IsjeZWu4D1
	 lf8JU34aLgP8dUjoXAmWS55odZrlItWP3qxx40If+bH9WelbstEWhpbfi3PAizCUuqzpV
	 saH1s7pNUW1Wmxs4xP5HKGeq9BHakX2PX1We0gtvs38MfkZmCpeheYcJWV1xpBE+Z1sHs
	 jDWNZGcOQ5hG8J1Za5VsHvSTXUru8+Q4X5+AX39Dk1T0tkxMN3PTu3G45FpNadmDpeRXq
	 OIv+4awh3vPcXkyxP8A4wS9rV9lS2EipMHF2m47K4LG0akEUL6ApXM5MY+xRCBUaQZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5KSnCc3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF97606A31C;
	Sat, 28 Nov 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5KSnCc3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795824946;
	b=0G1kl51kUIBufk8zyKl2SAzsy1WvmNI7UFnAsTeZCxvB7sQ9a6htL9K2TuA2NuVO4any
	 xDqWuyqr6b65Da7nhUs9Tr68Hynvb1C/FZpJlip5X2O2VSOuQv1v8WW7c9y5uoYQtZBmb
	 afDvor+zdGxpJ+GsV30CHIj/9RW8/WL1zJUHDpF+YXJ46R2wheZPKfpEBDQPQjg/4NAcb
	 NiVWV+56SpQM00H0RazITZkQcjrcvuo+s/EAZqTGOtQ8KTBUsuQ+poKCdj9PM/zGemYzL
	 Ta46xeqC0MStz71YJBAL147LwAx2uGzHOX/52BPTAoPtg+pLecDLMrmYl687fXtcacQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795824946;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EkG+Dr/aMoMzUSj5tk5nyxA5r22ol56pbCQ3Z9eMFeE=;
	b=HFcgasndquT2PBlmAW6uJ8QAi5DtjcLIDB0aVfdB2UHwjbORsN0U8IazmQj8b8SlkGxg
	 ei+H9ix3ltYHoGErEk7yOEXDqqVyqSabC8P+kn1I5psv/0Lr6J5AKG1M/b3bFadIqEXhJ
	 y5Jo4ExdfCuL0cnJsGnz0i5++2UD84hQumm5JgSqjJvAc7zu3pvMmftnxsAlz3MDLif3c
	 uvwwU+jfywK+USqPaiVKdCoNOjDF/A2Lxvqrg0oBZYxUzWOMObXQN8xw0bPLVllkoD3aR
	 +qWlxuwHwBudx0jhA3kXFoQqmNPO9wlu4waHWdeHN+CV47sUxug4oc9Zl4jxuEp740w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 557E91F000C1;
	Sat, 28 Nov 2026 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795824946;
	bh=EkG+Dr/aMoMzUSj5tk5nyxA5r22ol56pbCQ3Z9eMFeE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=X5KSnCc3RR5u9MtXkP5u6O66AlVgZNLqKGyvC3Gxpr0NoHSPrA1vQ9Tu5h4N5M2a4
	 EYF9p9APgQMlLakThl6BihyrKLVHfZwJhMC6oZjsfHZcNr4SDmZKorpvudQuSzPmpR
	 J8AznDSoGXwuwlkE1wmm3H6380uv8d1YGDo/ogHhBCoUHiy8hxyQPBNajG4uVp36wP
	 CclKdQDZSTR72+OdYiY22RPWVKUnFrmhPYVj5oE130QFJJKh9WHteSCuoRiGw5AHb7
	 jupn9/gp+Hp/t6YuckcoT8biTQ6uv2Hg/ugKoDiWTwuLpA+aIkLrSTocmN44YwD+0F
	 CBWHYQHl18etA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D78BC4DEA9;
	Sat, 28 Nov 2026 00:15:44 +0000 (UTC)
From: Felix Huang via B4 Relay <devnull+akafelixab.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:16:55 -0500
Subject: [PATCH] staging: fbtft: fb_tinylcd: align arguments with open
 parenthesis
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-fbtft-align-v1-1-92de6f92ebe8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNz3bSkkrQS3cSczPQ8XdNks8TkZEtzY4ukJCWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgBeq9lObwAAAA==
X-Change-ID: 20261127-fbtft-align-5c6acc9738bb
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Felix Huang <akafelixab@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795825022; l=1084;
 i=akafelixab@gmail.com; s=20261128; h=from:subject:message-id;
 bh=I+0cYZeTLzqxiZSLHzV9PNt605lEdXdHOIenXaZROZ8=;
 b=JmL5hJ8fJbaXQJtTCdgX3n0mKDHm2kGaJuFYf4Oa/FIgQJFLQTK1Mgd97AahsOxXSa/QS/nvK
 lZUCN+x83s7AA+GfI4FqTaz/m1ZQyf/tPe4Bc4ogDfbSW8kAEgh1B2z
X-Developer-Key: i=akafelixab@gmail.com; a=ed25519;
 pk=Axl3BM1UWa+m0/AWcEhRIdIk/WY9FnY4wZkyQn64uVY=
X-Endpoint-Received: by B4 Relay for akafelixab@gmail.com/20261128 with
 auth_id=1670
X-Original-From: Felix Huang <akafelixab@gmail.com>
Reply-To: akafelixab@gmail.com
Content-Transfer-Encoding: 7bit

From: Felix Huang <akafelixab@gmail.com>

Align multi-line function call arguments with the opening parenthesis
to adhere to the Linux kernel coding style and fix checkpatch.pl
alignment checks.

Signed-off-by: Felix Huang <akafelixab@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c74..d58b12472 100644
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
 	fsleep(250);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261127-fbtft-align-5c6acc9738bb

Best regards,
--  
Felix Huang <akafelixab@gmail.com>


