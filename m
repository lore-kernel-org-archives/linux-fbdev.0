Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137147;
	b=QjbbIRYQpivKj1DhFrKIbu6v6j+jhaLPaauzDR9ye1o3VBivZd9g28o3lcyQW1WKMWxS
	 tlKM5HfwBmNyBCFLDU14ECI/y2BjqWWSpXljnIamOZLQpOyOvj5g/1WbMW5RZrKI83Bfs
	 mNy0HisyLtOTQ0aUfq04MVrecIanJia2qKUEVjMUpewkSjvEv9zZtNGWhOaPVMPgmZj5F
	 W+u9oSJuc1smCt14TvaUP1NAuncMXMPxvom7YDpV133XtxifWJyt3fJcBnw/j7QbjkUQi
	 xfUPaI2dFqds2/4vdSiR33pRhVedAKWf9evxginN8V6TAQ5mDHBGEfE+Y8CPApcKmmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
	b=OSMLvBzahMx9Bhra0jguhytzQtE7H5Awlo+G3IpyTcbRemLlIaODVxKUQFMG8rQBZ0XR
	 y/9RdI6qS79uxpY6atvDCghJnXYhYeQbqo2KGM4Rgx6Ccdyvm/TKmNQaEGuRRZMfxR+w2
	 a5PjXTVHJJh/0WiSFbmA5yDqCOlT/+V8z6WogRshFjuwDaPtViZG7Yu4YpWnf8BuHT0X1
	 j3j9BTlBWVGDMejlLPGYXMr/Wm1PC6vO4hwB6S4awtNmX4lT97nhtFKmQTHwUIDwdCSPC
	 xIcioxC0SanwoAdHtgMzuzLC1CD3WaR2xYn3yZqWhef9ZbxvXoCLChrAaZNkb4wr88g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vX6Ne/6b";
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB318606A33D
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Nov 2026 01:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB318606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vX6Ne/6b
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b196fefa1fso191310a91.1
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2026 17:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137145; x=1795741945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
        b=vX6Ne/6bQ/4UZ8sumxqYuz35G1OsJVZY8r6kEm96WGyPZSYmlUYcIc+eAQvfyKgirI
         mqalQRpE0Y0mQuFiAxiIyr+TY91KeyHfpdhPFxbZvurra6CH5R2YAwScJap5KnLDt+Oj
         dLNw3RJQx4AQ6SnbVdc8EnT+A3oY09bzx4UvyF76QRjWWt0DN48I6p9vYIwwJ7K5mLrt
         0KS3UjI7IGldSuPP3nXAqmMs8KePOZES75jHhNIKbT52kSy5tLUTyfLwTkK1UoSq+vNM
         TSqFcELV17FzYq0FwMERFqr5Ln4dDWJbpyH7Bn8rg80HyYDec7kPtBESGsPnGbuIyILl
         jAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137145; x=1795741945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjzNoj806C+rvUXpCLkwOoZeurc6cZlqNpY4AXcwYQo=;
        b=dbAFhFMteamNKq/9egFoYfR/B5KbWr7iFtybwpP9rLN1p46cJAKI/JxRm5nH8Ro3kR
         fbDmkZVjypjJSGqeW+MpI/0x5uITl5w/bXx3nr/zgNcyAuQwRz+up4nfoSr9FCNoHU/q
         iW8sXuAcuGNXysZeGHCTZUzaqMGA+y7Xg74fWkMFxTUU+R6uD5FejK+AbIDvHqELHNJM
         zmV0NuBiHCC87xyjOotT8ZL2ZQbtq6iAPusPy8tMOJC5TIpUeXa6DXvzfQVE7mA7BFi5
         wypPV0MMbcVI/LQo4NGcZoPAI36kNhbv0Tbz2xn+8KRymqJZUXrCTIMxb+SamYRTgQHT
         dnUQ==
X-Gm-Message-State: APuU4Z8cBhThwR1yCHAUOscgI1IV3XFhZEenFDERqCxHhUqIPfcuSANt
	Ja/Ni815n/aJ4EFIwptBYBGLe/scvVgIqEuKMI2imfffV7aMgtrjBUmvfinjBX3KO9M8Mg==
X-Gm-Gg: AZFdTZewhnk4OrsBT3nyFxPdru2E9tUdSX1glvR0abCPD3gAuYRNwMCy39CgKPVl3Et
	358+GG9JHrWHfSeEmsgk3uyWB9QCMDU5Vmqc89PZE9lfZHCgw2Et2bbOrEOgfLNt9hux8rRdcGF
	EEjqbwEixLFnaiWDAgA9l608ywUounN7Bxa6tBb5wN+n0gHJS+XiSEFokQXSPpIiB72784KA2AT
	ID/PUUm1K38hpOAzUn1g3Vs3fK+GU1I3DrF1lDijU0tb3+U+UvgKUYWAksUkTu8YWxqZhdc8p9k
	R5Ipqkxk5hOf7d26+PXgR3+Fq3Nc5RBTDZghkkgtHsVPztJYwOydEMa224bGG+hQgq9KeLGRIrV
	T6tgblh5d+DTmcf3tQdNNBBNNqagc8BAJ01UgGH8cj/yQqOJOp1CZSAn9BP0u+iAv3wGcPdPxmZ
	nBaKtXTKok/TV4mzQVFDHYBdEku5Cprshh3lSEATLWkpHoRG4AVoDT4z/ukxbnPy6GmWILTdIf7
	uqlCPiGrsROAmCjVUzJ+ExP70SLyGPTUTo/8x0uH6xsvoeqNEDbFhsB4vBO2Bjh+V5RxJ5RbASi
	L408jri44vtKQI5c2aNb1nvnFg5E8jNHT5bmF9CMD4Jw6UCpuVIJnykhE0OoJONku2tD08nAMve
	dy/y7bCcdcc9m
X-Received: by 2002:a17:90b:268f:b0:3b0:d0c5:c110 with SMTP id 98e67ed59e1d1-3b41c95ce7fmr1046872a91.56.1795137145051;
        Thu, 19 Nov 2026 17:12:25 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:24 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Fri, 20 Nov 2026 12:05:48 +1100
Subject: [PATCH RESEND v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-2-d7531fa8061b@gmail.com>
References: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
In-Reply-To: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0

Closing the last framebuffer descriptor can deadlock against PicoLCD's
deferred update worker. fb_release() holds info->lock while waiting for
deferred work, and picolcd_fb_update() takes the same lock. Lockdep
reports the cycle through deferred-work completion and fbdefio_state->lock.
Repeated framebuffer open/write/close with concurrent device destruction
reproduces the hang in a PREEMPT_RT QEMU guest.

Use a private update mutex in the deferred worker instead of info->lock.
Take it in picolcd_set_par() as well to preserve serialization of pixel
format conversion and framebuffer updates. Initialize it before exposing
the framebuffer.

The test with the preceding output-request fix hung in the first round
and reported a circular locking dependency. With this change, all five
rounds completed, including 29 successful framebuffer write cycles and
concurrent LCD, backlight, two LED and UHID destroy operations, without
BUG/WARNING. The original syzkaller reproducer and persistent-open
framebuffer tests also passed again. These are bounded virtual-device
tests; physical hardware and suspend/resume remain untested.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferred=
 I/O devices")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h    |  2 ++
 drivers/hid/hid-picolcd_fb.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 846a8ceb95..33e6654ca0 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -115,6 +115,8 @@ struct picolcd_data {
 struct picolcd_fb_data {
 	/* Framebuffer stuff */
 	spinlock_t lock;
+	/* Deferred I/O runs while fbdefio_state->lock is held. */
+	struct mutex update_lock;
 	struct picolcd_data *picolcd;
 	u8 update_rate;
 	u8 bpp;
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index c17104fd60..258c7c4fa2 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -231,7 +231,8 @@ static void picolcd_fb_update(struct fb_info *info)
 	struct picolcd_fb_data *fbdata =3D info->par;
 	struct picolcd_data *data;
=20
-	mutex_lock(&info->lock);
+	/* fb_release() flushes this work while holding info->lock. */
+	mutex_lock(&fbdata->update_lock);
=20
 	spin_lock_irqsave(&fbdata->lock, flags);
 	data =3D !fbdata->ready ? fbdata->picolcd : NULL;
@@ -258,11 +259,11 @@ static void picolcd_fb_update(struct fb_info *info)
 				spin_lock_irqsave(&fbdata->lock, flags);
 				data =3D fbdata->picolcd;
 				spin_unlock_irqrestore(&fbdata->lock, flags);
-				mutex_unlock(&info->lock);
+				mutex_unlock(&fbdata->update_lock);
 				if (!data)
 					return;
 				hid_hw_wait(data->hdev);
-				mutex_lock(&info->lock);
+				mutex_lock(&fbdata->update_lock);
 				n =3D 0;
 			}
 			spin_lock_irqsave(&fbdata->lock, flags);
@@ -277,13 +278,13 @@ static void picolcd_fb_update(struct fb_info *info)
 		spin_lock_irqsave(&fbdata->lock, flags);
 		data =3D fbdata->picolcd;
 		spin_unlock_irqrestore(&fbdata->lock, flags);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&fbdata->update_lock);
 		if (data)
 			hid_hw_wait(data->hdev);
 		return;
 	}
 out:
-	mutex_unlock(&info->lock);
+	mutex_unlock(&fbdata->update_lock);
 }
=20
 static int picolcd_fb_blank(int blank, struct fb_info *info)
@@ -332,17 +333,24 @@ static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_fb_data *fbdata =3D info->par;
 	u8 *tmp_fb, *o_fb;
+	int ret =3D 0;
+
+	mutex_lock(&fbdata->update_lock);
 	if (info->var.bits_per_pixel =3D=3D fbdata->bpp)
-		return 0;
+		goto out;
 	/* switch between 1/8 bit depths */
-	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8)
-		return -EINVAL;
+	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	o_fb   =3D fbdata->bitmap;
 	tmp_fb =3D kmalloc_array(PICOLCDFB_SIZE, info->var.bits_per_pixel,
 			       GFP_KERNEL);
-	if (!tmp_fb)
-		return -ENOMEM;
+	if (!tmp_fb) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
=20
 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel =3D=3D 1) {
@@ -369,7 +377,9 @@ static int picolcd_set_par(struct fb_info *info)
=20
 	kfree(tmp_fb);
 	fbdata->bpp =3D info->var.bits_per_pixel;
-	return 0;
+out:
+	mutex_unlock(&fbdata->update_lock);
+	return ret;
 }
=20
 static void picolcdfb_ops_damage_range(struct fb_info *info, off_t off, si=
ze_t len)
@@ -506,6 +516,7 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
=20
 	fbdata =3D info->par;
 	spin_lock_init(&fbdata->lock);
+	mutex_init(&fbdata->update_lock);
 	fbdata->picolcd =3D data;
 	fbdata->update_rate =3D PICOLCDFB_UPDATE_RATE_DEFAULT;
 	fbdata->bpp     =3D picolcdfb_var.bits_per_pixel;

--=20
2.56.1

