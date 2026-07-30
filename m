Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75493453A31
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436031; cv=none; b=O24twBX53v2bCerg8YLmF9yMvyPtIC/rL2KjA0eeo72IsXUdR3kv5vBPBUVKd+znZTm+On0aNSXaWIR3gjWLi8TvjO9aURLBw2uDp2shtDP7qRe4to3BKjvpx6EPpTCaPhGu96Zv7M4b8w3Bm+IMQQvuYSbUv4/e3j6r3cDdNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436031; c=relaxed/simple;
	bh=hnYtda8JlxtGVwcwnTy5tbE+3Fv+maoisubV7hqJGGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn5EyVgrewbuVoTezp+zx7cMcH/0vbCQrxjtX6l6g4T16JEiqZ58suA2Y3M5m2zJ/LmooJnzsIs5mU1KiSvQguv1Fpv/Oemeh3geTSyBe+j2hLGwtmYO8IfZnjct2cxkyq8GZE/dJo/SS4+5ceEmUzM2g0OXEjgjbKdRCbupJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=ruo54feF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="ruo54feF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848d21bbaffso273693b3a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785436030; x=1786040830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhElDLQZHukV2QsaThv4BOaHBxc1XzjF+Kx9MuUiQB0=;
        b=ruo54feFvtb91TCQljMGR45jQUYzvkxf3+6ubwE/dYS9dXuMDoNkqQFO1dDnPslI80
         TK0Ngw+FO+GYfTlMCNu7sFKoch4UW1qbmVcyvcmd0SVb9/YZHIsAjnUANbqD/vfXxSnU
         9gSgIZliDdYMx6Ihbgc5YSBnISlmhJUJUOk6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436030; x=1786040830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhElDLQZHukV2QsaThv4BOaHBxc1XzjF+Kx9MuUiQB0=;
        b=tGEoOtsGWy9QMJSst4OD2CZmleb92dmm2V474o4XGd/GnSLfQq5vQEmTGvOPBmk6Bj
         NiYkfjTb7MBW9y1PKM3tuVdK0BgZy5lXrY+W5Br7Bs86QAiGq/OsEAvLB1TALsLU3fzz
         Y1Kj07xJl9fK20J81KHqZs4xz9XeIQ/Aycq4AoHgLGLZxKEQUep44NtUmr0l2gQCI7vd
         RrlpEaa01AoO9yz35Pr0R/QSof+e6/tCLx+Zj66VGXF8yZLyJXhtpGwLmSWvZMcOCOUL
         r67ctfRnCaKrdpU7rZbkFxFkzjmpadrBYNzDb/Aqy5qAwrR+ZQXU23B96AH8kbmjgsHf
         zQAA==
X-Gm-Message-State: AOJu0YzhyS9OKFZrF4ahKfThgv0cPkJKXQio0yBJAPn6i2SjAySKAb/p
	DfOmkkNOr2nz8nVnSJYv+Bg2JXFr1oirskTSw7vXOyrYMEDQiv2cmyZPG5uh9g+wyFo=
X-Gm-Gg: AR+sD12ar8TJ+Oq2q/PW2RHXzqTtXHfL0sk+6qyKS+V1okRDoc4Fpf5t87wp0kwqS9I
	JJAc19s5IbUhGVNXnPGIV6sERegjS9R8/0lyXqRpKY+uQYHVbS1bXHJRZCTHm/LhhYe3MPJwCCZ
	oUmC8M96M6wkZXoiWL/uNKydbvKzXe/OJK3jghwdSyrN3D3yRE5pwEICm0Fu1Gd+BEpnCVDh2C7
	KMeL/sCl8qGMqhzp3DuagpeEF4HRVY5FM3fLWru7fa2s/2rxzeaYjiagqxI6dWKphTSBkN7huGV
	GM95nRK8aj42AHXgsTkuyS31wuan9ja4pLASaKYH5AWCPoyaF+DMFx15ae/nlAu+Hp+3eDcLdKa
	GfUJDemskl0MMEUhgIIydrkzcyfv++qZq2EkFT4RIqNRO14a3O4qbVWJVIsXIM1FGnO+JLU9TCC
	40l1p0qA4ZDnGVJ6nY36ilJtyJ3ndg6e+Ds7a/aVICc4/l7ZWUk2M=
X-Received: by 2002:a05:6a00:a16:b0:847:968c:a0f1 with SMTP id d2e1a72fcca58-84ebc3d0aa4mr3376460b3a.43.1785436029678;
        Thu, 30 Jul 2026 11:27:09 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:27:08 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/5] fbdev: tdfxfb: Wake the VGA core before programming the CRTC
Date: Fri, 31 Jul 2026 03:26:39 +0900
Message-ID: <20260730182640.2808572-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
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
index 4c1d847c89c9..9d55efd2c934 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -482,6 +482,10 @@ static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 
 	tdfx_outl(par, MISCINIT1, tdfx_inl(par, MISCINIT1) | 0x01);
 
+	/* Wake the VGA core if it hasn't already been woken up */
+	tdfx_outl(par, VGAINIT0, reg->vgainit0);
+	vga_outb(par, 0x3c3, 0x01);
+
 	crt_outb(par, 0x11, crt_inb(par, 0x11) & 0x7f); /* CRT unprotect */
 
 	banshee_make_room(par, 3);
-- 
2.53.0

