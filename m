Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970684189DD
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500375; cv=none; b=EMEaH94VSY3wNQfQNyOwnW2VRnD8MD0RYSAoT15RGxAi/stgJm74FCvvdJFyipfZSbB5Ur4nXGOe46whEgnDfpPYK20Gu4h+tyKT40BSlihl9R5FnVTOvNyX+JxZwL6UwvIIsHlZGvuZ42EpYaOsmwmxGvTvKT6iUEybMP3PdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500375; c=relaxed/simple;
	bh=UWUqxiHy7gFxk+c6H2K9YnLPMNAZarkqKR1p4gyNXJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KK/y6cxXlwz+mp9hShRdfYxaEhVT9sk3vpTZhl/iSdW2fh/t8447JmRNDfgtfbHLN8xCMWp3l0LA/3vL4QhsVXr2j/ggrcfeY9SRejBGq0CjNe2gCBkyRxqX+A4yM8mk0u7nJ6C0vsww8h+DcXSRIEd8nZM+7cAV6oQr2WDCJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HX2gDhMm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HX2gDhMm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d0407aedd6so8777585ad.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785500372; x=1786105172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2f94xloHl4xvf0KqfbafdGgU1JTOpluCmeN1ZaakJsw=;
        b=HX2gDhMmrCcYippymw695bl3E7SesdM+QJZY1vRT1ZERsm+UvRJiYZ/BUKEZxSWVzy
         0lIsY3x8ZH7S/VHglL00rGjGz86Dbl1OY1gY3TOir/W2zYTt0ZvlMh6nd1VdnbrQT6KX
         sbJ0+p6C3ydTAnwxKMUK7Iv52bNWW5GS0+J/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500372; x=1786105172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2f94xloHl4xvf0KqfbafdGgU1JTOpluCmeN1ZaakJsw=;
        b=o2qj/1+jT5Q5tSFihxcGOP/byFX6kdU0nWGUy3xxh09542GzjhUxFoWd8VxJJuwbPL
         nQTdbHZeyZLs16/1HKckfNGtr9O5vfybrNDCjT2nWax8njUmlAQL193fC/jsyM9jiOp9
         P0Bul7yR3SylZKQlE0P3EAlEg6fY5OrqGdNUplVUAgf0fUDdaXesOK+Furty90kfxCdG
         vd1zdKkepr9vfhjDmUcBc06x6Gf1NVFOif4U6H/5YbVwHEMzsiJKHydrElo9TWoFVH7G
         3ieaG5RwF2PlvS5yJwhvXiu9mSfy/SXHaNne6ZxNUi+OTKurxEK1kExlfL5ecJXZR6Vw
         vOKg==
X-Gm-Message-State: AOJu0Yy4WNgE+h3Ek3+fFwq7jrS13ADSynKwJFKVbDhscEy2tkIzDa8c
	zHJfJZAlPEKodNWnZrl7mTFGkm5dAVhdCzzJY5gXz9572CN3RgkYxRSsEdldwJNaQvE=
X-Gm-Gg: AR+sD11ybOhtIzbrE4TIrkgKt0PWUG8f7SjItfgL7pFQDBc5TafAbul3MqfLeaGCZKV
	0suKo5FrmvNCYqL53yAqD11XlBD9FD25f+8IZHbtdIoqbwV73f1xE9ZIBt94P8Pwn/8XeOEVNXJ
	muJF4UKKqdCkM2NNQPhRtNCabqWnPq254P2tVUxqIwdCCTLS7avndkHtbfgQmJvDNCGR3pubv3z
	ppXT5tyW0HkD5PxwQffEoeSqe0XLT/9zN9GIKwGrv4UP33SCqGRw0vEIIX5bQxxitC/trpN3Q0H
	uJ+VSpm/ZDFSTqZ+1f4nkh2dTgQ27nY5S1AWZ07cb5ima2aXUc1qALX56ESkvlRcrKSMiTjl18C
	LHtolnuGva9EhWgEivk6Zcly1Tq7uDckFZ4u87AvD9NWBRKAZKhkX6vp+xBA6QFoQmIuFuD3dUv
	X4jnQTLbIUblsIxMJVBZy8aazvq01wak78ZfHvgNp9zlnE79CqTpV9UOP0owGrR0c=
X-Received: by 2002:a17:90b:57c7:b0:384:5dbc:cba5 with SMTP id 98e67ed59e1d1-38fb1378a80mr1615857a91.26.1785500371570;
        Fri, 31 Jul 2026 05:19:31 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:19:31 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 4/5] fbdev: tdfxfb: Wake the VGA core before programming the CRTC
Date: Fri, 31 Jul 2026 21:19:13 +0900
Message-ID: <20260731121915.3362232-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the card was unbooted the VGA core needs to be woken up before
poking at it.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 4d92ab5b5430..f2b658a47135 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -485,6 +485,10 @@ static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 
 	tdfx_outl(par, MISCINIT1, tdfx_inl(par, MISCINIT1) | 0x01);
 
+	/* Wake the VGA core if it hasn't already been woken up */
+	tdfx_outl(par, VGAINIT0, reg->vgainit0);
+	vga_outb(par, 0x3c3, 0x01);
+
 	crt_outb(par, 0x11, crt_inb(par, 0x11) & 0x7f); /* CRT unprotect */
 
 	banshee_make_room(par, 3);
-- 
2.53.0

