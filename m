Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792938166;
	b=YZUGcdeao2CIVMyi2UcX7gt1CwVPnNLGj5l9h0dpO0waTVJtQQhqvGAkSyG+PvFfKQah
	 YU6zcOWj9kJ/bzAcwyNCRHNMRMT+tBxMHOjXSgdf3bG0ixgjeH6cLM5BfU6mmg0FYn+3/
	 S7hgefTjQ3MIxcyWpxq2R1UG3zT4Raj+8vkhLLE0UhGr6+eHNXH8mpsqpjt2XfC8+0ji1
	 nfIfy5HD3yV1g1ppLENiII1HKx0vDO6R7Xq9wUDcPLhiCqrKI6W/xthQFWG99nE61Qtea
	 ANdQxPWmwnz1n4k7t4mLdHpVI3zw1aqqSIR+qcrIvYtWlk5SAf4JqVpj9GYBFtrK1NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792938166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=GWA3ILffVhGa4FkzQXQubKTR5QBs74w5VthahbifZWg=;
	b=ERa5gy0UHZWN6AkevhMZM+PpwV6o8erjK2g6QFryWBfgG5hU+MlpEeRKP+ATobpqr9Qn
	 t1nuyxmIwPysxpAQE8zdfR/tYWb8eklDTJKS1JDPnXXOlIA7PnImUhHpeXR+0S+DZuY3c
	 Zs+9naYWAawiQEu81z+PPrLTgsdLfIiQ8MIeE5r4rM5ttv9atpvAIKs9My0ZEU1vL/O8g
	 VHcuPLDBm7p6NzFNF1Ub6Ot86NwgJrPW6z/G4Ucdl13AJd8qpZOGaDfJl3nVztaAk2NVB
	 c0dGijk1B/SIfP6okUis9T8f/K4MifJ+h+ropK5OyrDEif8Y+2DhOvjryGUa5OqzRTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YvB1UI7z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE424606A31A
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 14:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE424606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YvB1UI7z
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c468bd799ecso276741866b.1
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 07:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792938164; cv=none;
        d=google.com; s=arc-20260327;
        b=Xl7FdK7afxLXSh2a6BOzee3IyFHl3W7OarWo7Pi4fsRL6mnHtVszP7BXoLb9jxLmTJ
         0ZvCgSNOvNdOrpf88tUx0thkDf43jF8RMRbCvvtnU5Hp4Rq1mQrPW10/tRHibjpj2xWQ
         ts3tZiaVWV1ri4yLP6pbfpqtmMlnMVEuWCx7I29t5IKsXeZldsu0MjUv6V2FtCH9O4rc
         o631j/ncfMNpOiZh6mAGPw0uomv3O8l0IbZuHU+js0IcsbSlkaHjiBtriEWBIkpg1Wl9
         BDd4xBDnrcxUD6odx4ORboHlFSQccEpRMNI/5aReBfpY3GSudYKr3+yhJti+ttSv6t1h
         y3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GWA3ILffVhGa4FkzQXQubKTR5QBs74w5VthahbifZWg=;
        fh=LWcN40btpwh8wS6lmc2BCmA/cgV2crD186IgMycXWP0=;
        b=UJXEjDh2NSJCw3h71wvMJ9K8WaeDTh0qfoIrhEh3vvpyBUNsyr3pM+XTjSRtkxEcmW
         z7kTdzn2+egQJzhFHxoS+Me3XWO7oFR4gQUzBdg3uNYEK3rYQkOP+bxx9zHtVbkmmH1n
         sNpyLfEGiZqMdTb9EG1rdkaIShJ8kYbLax/bMeRutHq03R78AjJyEJh843kUE23vJnUa
         duxeNPCV4E6f9c0/XxKOeGmWDNcOgOBry9Mr0YfkVCpbDZ8e1fFcbe+WsRZgX8PT18l4
         Hhm5eKA9av1be2E2PEIdJgOtVwzsZzTJCuCpIlwJWIpiPk2NinudoVUtXrvP5wDi7Caq
         MkRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792938164; x=1793542964; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWA3ILffVhGa4FkzQXQubKTR5QBs74w5VthahbifZWg=;
        b=YvB1UI7zCPwKzfQoNIOP8u+7sxd+2SekPsPaL4cz4Caz6iuwhzKHqH265iPli9K7j7
         yWZKKZ7VDNLkeXwsrP3lYpbwRVnnpiUOSn7zDtyUcTMybO0wRTewjTdwepTKl/oBtsgM
         ON5FBxXXm1fJdNZ7FNaobq2wGyrOYOkRB+P6wYnmw8L5tUAFUx+ashFou2TA6xTmD89U
         tyi1beDT6fEv77Y9ro9lMTkZEQnxxMbAtvX/EIn3YdpMqUo9T4DSv0an7twk4RDd22CT
         aKblOnnVwPP+MUHmIR8niaNwjciFPotrSrAnqLCfcXEu8F9B//nV1sMXpgxneeA97cDN
         zzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792938164; x=1793542964;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GWA3ILffVhGa4FkzQXQubKTR5QBs74w5VthahbifZWg=;
        b=vWzGayTFqsb9CGd4Vj1Dz8A9LkokcyyC+PTaEJLwG9AAcZ58FGqD/S14XJA3KRUls5
         8tvuPm6XRabSK0qb9oyPXJyT3CW+dcb1W70zjeiEP2hnZ/w6UuSsS4nNwxZ1EPR6vpb7
         lOFCAl5VNvU5QTfORCFFK0L4MLCZ478T8Yd+k9TBGLqEi+T4EfAPcBov2b0jH4HML7d+
         5DYCqMsFutyJ37CXDwWmWUFfvSJ3JPSApByAQqPrmq7Y/8+STWoMGA3NwCU82jqWOhcH
         F0lSWl0Cahd0BIjOfvGJ7DO410Jj0h+MgVwOzhgk/uN4ecUy/FwY9WHvSAkMj9nwCem9
         2CLA==
X-Forwarded-Encrypted: i=1; AKwUvBxgiWVAvdO7IkN7QLJpP9eutfXAzYni0RuYmuteKCjGgAukeZ3Sz4pkwxCqKFCkCk93s2QGiAlPCKrGmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJcDNoGw6/v9ClY3+QLFzIEPdo7ePQb2wwHjTmHM105uUiNmeDZ
	+PENxXGKTY1/bwbqPA7Sx6/gr5dNMCuvTZDQomYJf94pdM1jDEGol/RBAVKwgxVrw80S/nR1dvb
	bghdnHbx44HhJqdjV47qKVrET70Zjb8M=
X-Gm-Gg: AYBFou2l5eq0889i2WBwarxwvjQKx3+DA0wMnD2kufH7LzBU5OMlSkFDLMgi38o/bzp
	x6fy+Ioq6IIQ6cF44FNMhLSHLZHwgKic5pKR9nwfRWC163lBbx1jA/AdQtGZH4Fo7ZCJVzdgvEQ
	Icmy5q6gDRA3o8p7BDOetnyjCYs222vxa5i2ZEeKJkdQ8yglBiMDZiIqoHNFAf+vUd7AfEb0Q8t
	qfwkGky5uyK5eQEXPM2tnDyXBfedyc507tz2goNxvhHDkeLwehalROeeHAzhgZZ0FJ4h1WFcm33
	Tjuyon2aGuthG46xQlQH7JdIs+rynWSWAmOTdE3+j3qQ2l6m4vMrr+V5hkvm9X2lYVDkS38Tio1
	f6T+0Odu+gX2DWFFNPNYTvEEmy4GouGD0lAitBpP/GxyurJJ/M+lzmNqgNBb+2X+K+g==
X-Received: by 2002:a17:907:dac:b0:c31:e9b7:f10b with SMTP id
 a640c23a62f3a-c46bdea43dfmr530904366b.42.1792938163869; Sun, 25 Oct 2026
 07:22:43 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
Date: Sun, 25 Oct 2026 15:22:30 +0100
X-Gm-Features: AclHuK9wgskeKFnwTz3UroDZd-FWWYPOLCNifdGibJ7BV5fPBFLMKtRw3_x8_lk
Message-ID: <CAHxSwT_bdBdiwwXpGpr9+rGizZU3p+RsB18hPH5TxqMuMZOsQw@mail.gmail.com>
Subject: [PATCH v3] staging: fbtft: fb_upd161704: Replace udelay() with usleep_range()
To: julia.lawall@inria.fr, gregkh@linuxfoundation.org, andy@kernel.org, 
	outreachy@lists.linux.dev
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Replace udelay() calls inside the init_display() initialization
sequence with usleep_range() to avoid CPU busy-waiting. Since
init_display() runs in a non-atomic context, sleeping allows the CPU
to yield, improving power efficiency and system responsiveness.

Signed-off-by: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
---
v3:
- Remove raw git headers from the email body per maintainer feedback.
- Add a descriptive commit message body explaining the rationale for
usleep_range().

v2:
- Send patch inline in the email body rather than as an attachment.
- No functional changes to the code diff itself.

v1:
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c
b/drivers/staging/fbtft/fb_upd161704.c
index 7288140e7..94ae5bbf0 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)

        /* oscillator start */
        write_reg(par, 0x003A, 0x0001); /*Oscillator 0: stop, 1: operation */
-       udelay(100);
+       usleep_range(100, 150);

        /* y-setting */
        write_reg(par, 0x0024, 0x007B); /* amplitude setting */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0025, 0x003B); /* amplitude setting */
        write_reg(par, 0x0026, 0x0034); /* amplitude setting */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0027, 0x0004); /* amplitude setting */
        write_reg(par, 0x0052, 0x0025); /* circuit setting 1 */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0053, 0x0033); /* circuit setting 2 */
        write_reg(par, 0x0061, 0x001C); /* adjustment V10 positive polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0062, 0x002C); /* adjustment V9 negative polarity */
        write_reg(par, 0x0063, 0x0022); /* adjustment V34 positive polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0064, 0x0027); /* adjustment V31 negative polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0065, 0x0014); /* adjustment V61 negative polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0066, 0x0010); /* adjustment V61 negative polarity */

        /* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)

        /* Power supply setting */
        write_reg(par, 0x0019, 0x0000); /* DC/DC output setting */
-       udelay(200);
+       usleep_range(200, 250);
        write_reg(par, 0x001A, 0x1000); /* DC/DC frequency setting */
        write_reg(par, 0x001B, 0x0023); /* DC/DC rising setting */
        write_reg(par, 0x001C, 0x0C01); /* Regulator voltage setting */
-- 
2.34.1
