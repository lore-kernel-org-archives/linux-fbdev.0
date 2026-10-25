Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792925646;
	b=qmxD062vb0Oj0pbaxVv65VmwKmPMlByBaXJFewPMz6TQeDtzHZxjfxoEW+xhdy3+PxLm
	 NTvl2hYbJ8NPyKtHLZuWCjczSE0KVeZKjTDcSbTurVmEZJ+CxzbHuAhDWILnI9lAPGUK0
	 sF8hWwyABBFQVXXNMSMPMSusveQcHgCsOCfTN5x3WRXQNrHK0Gvbc5MbJ74z1HjF2okRx
	 KZ9dG+n4CZR9hamYdIoDtZiINH0Hk/hUWnt/MD6aMxpwnki5L4Jg7sNT7r/psOk2139En
	 lGTecACd58mUSJsjvuBuMMJ59/6FUDfjlhkSxgcizaVhliXIhfdMhXBiIVVJoQe0lmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=MtahZLniFEJWP8SrmHT3ICGVYOg1SiAxfLPOaOBltmM=;
	b=eA6kbc02rxhcYsi0aVd7M9w89fwvUgikR0pAleBPA+RuWHLMP8lpw1KmGsNvGFKivLOB
	 Nvc9ivlLo0KD1JmURoYWFLdFL1xxFvStrz4Lcq9j8NuM/YebYn71odYTw4HTbF2kUrlrt
	 vHA9cjLMSeppWg9N1FHDp3A7Ky432XFadW0wxccTgnKvArCiwSKWuHev0lUNKjaZ2/TLJ
	 G2hhs0vdXayxT76LxkNRGR1K9+esD8Sn16DSVMZnkDmr+rqIv8viidonTYGAXJ97tbMc8
	 Eju4IsBwBXRVjSfYMtognYaBdx9/eFQk9I2WPFzeQiMtNUV/1Ubbi5+vANTkjcAuskA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DV8n/LCl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC609606A31E
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 10:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC609606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DV8n/LCl
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso313934966b.2
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 03:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792925644; cv=none;
        d=google.com; s=arc-20260327;
        b=ZREFAmA03EFHl9fp6Nz4J/Men0gXouUmU/sLlU2BLNmoH24/7x+lHjcRDAgAdLzNCW
         flUmoovtCfjtf45D8gX6Zo4XMSsHQ+VyZ+2P7xcBuFgEJMOZU9CfIGq0idgo+ew5+5Zr
         uEyRvzt4tTtJu3dNNuSnmySYUXGUDLj709KY7l0F5iMkMBEoZNtY+yH1gzivqT/hujwb
         Jjvb74doAq1Ssw6GsWaQs1hhLG8qh5jkxNwxrWTvgzyuDpR/pNPTLZYsu3yD0g0N8XAv
         KAbS9Y91JfQsa8ScRjgKnmvw0zq+uppFVgNEbH0J+bvVWZ+hw6+FRfBRGmPZa1/vH7Ks
         xkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MtahZLniFEJWP8SrmHT3ICGVYOg1SiAxfLPOaOBltmM=;
        fh=FEhlthIm5V4CHSupcIXFuetCAQ0CJkMKiLSzigwyVwI=;
        b=EgKf+cVXOSrannc01xNPWCNYoPAE1LjMdBuYtGJezgL1/VsWznG5nX5RbAg2v2aTys
         80zVsNEtrCVNv/XNVdNIlWgMe/8GcdvRzsaSkcfUsijsvWIVexNzhBrCl5imkjdxYOra
         N/TwOOZ0lIwptxaVIYDsskOblPNULsgCwvgkvhZJnyWOAZpE5ZOrnj63Te9yLHuAinkE
         2bqKW+gVz6zK2BQSEfNIIh23hotUBAeGluGD4Ig9InkgetlYWZV2mv2tOWPZazuz9iSV
         hUZp5yWWtpMFzDfmj+CGuev6EHo1AoX/onCVQMVf4lIlQ+MEEC68PdS9Si1pXwqmULnA
         OTfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792925644; x=1793530444; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtahZLniFEJWP8SrmHT3ICGVYOg1SiAxfLPOaOBltmM=;
        b=DV8n/LClRQkvosXfhQ0fijXpBBiRX21CM1+IZat6DfI75dTcwsLeBQojsVBUfOeP81
         zvqDTzoRSZXb8btAR3wX6x67PyEkaRPcWi1N4xvxKb5mQGny3do1SMBosemHyK8jbQwE
         5GPkMz9voLcdVGw61GQfC+kYyJ/ypICn+XDq1hu1vSeKN9gnfAFro6jN/pedfVPAWA7Y
         WDhuzUfYrbf9qVIPIqPz868rGk52OsRLBViKCdZWqmhnnKy1uv+3HKnBJ1MzOru0WHIT
         //uh0UGCll4z0ouMqkQj2ntts15HaXe4D7v+F2lXy0rVRX219NP0hFqVgybIJxYjerGJ
         h9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792925644; x=1793530444;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MtahZLniFEJWP8SrmHT3ICGVYOg1SiAxfLPOaOBltmM=;
        b=nE1kcJ+ZqRa+UzLV2sPGaQaIsF1DrFKCPXjhGq7y/NN1I7ykaXIBpEIBVKVfMkqqQM
         GQ7h0AVljxuPbiWmQIwXuSZA6RHSdll7mtfYGbyri1qbCV/AAp04/+FoebQFJptxlp/Z
         YHzgT66PyS+MexaUruhHdjjI9N04pKqYi5GKaO2og5uffD0Wp/hZIIPYiytmepWtXvoi
         oZfnK7nmnBkT0pon7XePtSPnMsvWdEJVgoKNE09ZqqXkRwDQK5+RGZUOkvAyo0aSOgg1
         tGYqJHym1humjf7J1kfI64G/v3Xi5F7oN1Nc3DkxFVuzsIIu5PXXPb/unCoYMZO0/WdK
         1Fbw==
X-Forwarded-Encrypted: i=1; AKwUvBynfjUcyna72k12yJf13Q5vnFMaDN4N1szJ3xpxtCm+hcQMhJsoyRd08QC86nzt1c1xVywrIEm4ubg8TA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL4kC8Ts6DKgBnGGYghwDu0DdsAUOxqH06pGtSXtq6Gh6ZRfFdt
	q+L63++95elVbQ0zowKC7x70a5fCzZxOG8c1RWmbzACMA8S1QittwStWNFAuM6gRARnJc48O8SI
	Ko2ut0vB7yKzZFhHftOxqxRkx1g1ys9g=
X-Gm-Gg: AYBFou2BLtZKSMnhPKrmee8BUsOy2VCluHRTCNDBaN7DhXcJO6rFgr30jvWYfowyc/0
	OqxCtJ/vrC5WbUJFiSTxkTOMjS/kEHV52R27z+47ySf37l4gKQYsEynXTJl2Uh9YQehvnPKdzqm
	8kmVqbgaRjqnTG80vx3pxXHdcj32msZm7GP0fdPuyGhNOl+1F38Z9L14DTU4rJ7rc5BADRaRlnr
	nGU0C4a0sOplMTMCi8QsgviDdoOf6RAQoaTFXKObXFZy4mQr+pqkeUDe49wxQQqHu2ndtrNg+WL
	y3XYipSLdEyryeV4SBJMo721WXMIbCbdlI5YYYhESG1P0reqvPpLqnbETmBf5QqUT5vvsmm2RHF
	R6AFsZox0/Osvrn90tBQufHLOea2d6WwZtOUs5YEnYx/TWhJZSeoQHhIxPrPqADkxmtLo
X-Received: by 2002:a17:906:dc8b:b0:c29:659e:2fd6 with SMTP id
 a640c23a62f3a-c46bddb549fmr450364866b.10.1792925643928; Sun, 25 Oct 2026
 03:54:03 -0700 (PDT)
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
Date: Sun, 25 Oct 2026 11:53:49 +0100
X-Gm-Features: AclHuK9TY3j97je9JyLB2E5dU6k-0NiwAm7rcWLnTy2tP6DroPMgj8seRuA_E5c
Message-ID: <CAHxSwT8zGKHDLjAbkR=EZL7QVwzS_47TPB283YTHKEQsE0mvFA@mail.gmail.com>
Subject: [PATCH] staging: fbtft: fb_ra8875: Replace mdelay() and udelay() with
 sleep alternatives
To: andy@kernel.org, gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"

From 474546adc013fab098dfda25e6503413fddb9929 Mon Sep 17 00:00:00 2001
From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
Date: Sun, 25 Oct 2026 11:38:17 +0100
Subject: [PATCH] staging: fbtft: fb_ra8875: Replace mdelay() and udelay() with
 sleep alternatives

Signed-off-by: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c
b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..ded953636 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -47,12 +47,12 @@ static int init_display(struct fbtft_par *par)
                /* PLL clock frequency */
                write_reg(par, 0x88, 0x0A);
                write_reg(par, 0x89, 0x02);
-               mdelay(10);
+               usleep_range(10000, 11000);
                /* color deep / MCU Interface */
                write_reg(par, 0x10, 0x0C);
                /* pixel clock period  */
                write_reg(par, 0x04, 0x03);
-               mdelay(1);
+               usleep_range(1000, 2000);
                /* horizontal settings */
                write_reg(par, 0x14, 0x27);
                write_reg(par, 0x15, 0x00);
@@ -72,12 +72,12 @@ static int init_display(struct fbtft_par *par)
                /* PLL clock frequency  */
                write_reg(par, 0x88, 0x0A);
                write_reg(par, 0x89, 0x02);
-               mdelay(10);
+               usleep_range(10000, 11000);
                /* color deep / MCU Interface */
                write_reg(par, 0x10, 0x0C);
                /* pixel clock period  */
                write_reg(par, 0x04, 0x82);
-               mdelay(1);
+               usleep_range(1000, 2000);
                /* horizontal settings */
                write_reg(par, 0x14, 0x3B);
                write_reg(par, 0x15, 0x00);
@@ -97,12 +97,12 @@ static int init_display(struct fbtft_par *par)
                /* PLL clock frequency */
                write_reg(par, 0x88, 0x0B);
                write_reg(par, 0x89, 0x02);
-               mdelay(10);
+               usleep_range(10000, 11000);
                /* color deep / MCU Interface */
                write_reg(par, 0x10, 0x0C);
                /* pixel clock period */
                write_reg(par, 0x04, 0x01);
-               mdelay(1);
+               usleep_range(1000, 2000);
                /* horizontal settings */
                write_reg(par, 0x14, 0x4F);
                write_reg(par, 0x15, 0x05);
@@ -122,12 +122,12 @@ static int init_display(struct fbtft_par *par)
                /* PLL clock frequency */
                write_reg(par, 0x88, 0x0B);
                write_reg(par, 0x89, 0x02);
-               mdelay(10);
+               usleep_range(10000, 11000);
                /* color deep / MCU Interface */
                write_reg(par, 0x10, 0x0C);
                /* pixel clock period */
                write_reg(par, 0x04, 0x81);
-               mdelay(1);
+               usleep_range(1000, 2000);
                /* horizontal settings */
                write_reg(par, 0x14, 0x63);
                write_reg(par, 0x15, 0x03);
@@ -150,11 +150,11 @@ static int init_display(struct fbtft_par *par)
        /* PWM clock */
        write_reg(par, 0x8a, 0x81);
        write_reg(par, 0x8b, 0xFF);
-       mdelay(10);
+       usleep_range(10000, 11000);

        /* Display ON */
        write_reg(par, 0x01, 0x80);
-       mdelay(10);
+       usleep_range(10000, 11000);

        return 0;
 }
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par,
int len, ...)
        }
        len--;

-       udelay(100);
+       usleep_range(100, 150);

        if (len) {
                buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par,
int len, ...)

        /* restore user spi-speed */
        par->fbtftops.write = fbtft_write_spi;
-       udelay(100);
+       usleep_range(100, 150);
 }

 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.34.1
