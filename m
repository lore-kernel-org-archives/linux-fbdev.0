Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109240;
	b=cePbJYu9eIcziry+Nx4Pz+LSAHX6+91llMECFI4JNO+5WEt3pVs3YcorZkEYrTVDWVpS
	 ovR7Yw+ee651d3Ahii968lJps8AqGCCgcH2RducDOwKQiS9fEDROKzSJiNXnvT8ij1rF5
	 CixmHHCGl+iwogLv9WmMzI1QERxl7Pq3YFPxkqY8FnD9z8BVxg7eT3VG73S1yvV2K50uG
	 3jEvVPaRiIqWZqpSL6sOEKtv1WWRGo5VwVx4L0DhWpBHPowYDd3vDZa/JhJO76UR/mNim
	 Qpyl+9gBh2ybE/PzpCRZLshwckyURwzv9yaTw/ItvMhW6xRjf5uhACLOy3MrfjW9DZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
	b=VnDlwtyxUTnHYfDR6x6N3xWYueFChIrUya0p8z7buTDn64F0jBTWZ8wzO9WANfQDrAwm
	 5j3++VfPb6kMbFwma79JAV0wStRnT08ggOv9ukr1x0u3+7oYld3FYSod5eXL1vpo2aFEG
	 MbIqZPgnMVvaKi7Py8/afjbAhaAEE6vDoCPIVRmAw4g0Tp7coDIOffezy8FJUe1D7xXgn
	 oXcTkk9dMM0+WzsOTMTrBuEMaXRC3TnrVZLPU9iWqXrJxfeARt3qeBAgbT/wDpXu54tnV
	 D6gC3pz54UHHk7OXPDr5i6PnRieeRDy5iRFmg3PHNFSFkETeknSi1uyxKhbwUDQ/YfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBF0TdNK;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D60A2603
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E3D60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EBF0TdNK
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso32746205e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793109238; x=1793714038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
        b=EBF0TdNKiZev92JTXZUKMNM+bikjTpnl6F+xtg1lO25YQMK6ahE6FtSlVFxjBHIfIJ
         2tDrWqG50yvBgr1XKRETOm6kWMHgVeuJM7lBibOyLXXDYgMKX1OPJwSjhZhLALr5KYEc
         Q1SCgLNw6BDYwmvXk5af0SJUgK8tAcDbAMVyUsW6eeK4lI9ZJ/zeaLnLSL3QXyaOHP9c
         3LAIk0jo9oQzD/MXMTG9cVzn0VCwjdkQ/RQrhNaRSRhrf7RTxJJ4NNApmMPopv82MM0Q
         ZP99MlLYSNoqXjI22Xh68F20Jf0avL8oolZjogdrqlkKurBxko1tjvuPerYh9ooefJAS
         w38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109238; x=1793714038;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
        b=0clg/CY537NHD4Wn8ZMB0pW5vA5SsaQnuuKpD0cDIieqbOioxkM0SQAwtuaaQfagqt
         Qp4uys9fOgL5iuxQH08UMV7s3WX/1kPrBY8tSUzUlaifoSU15om5AvRL1SYLZxxGucZa
         Wpws6TKeAok2/bw1GtB3FGvMS3hNvHaNEzJjdL9G0deMobBBmvUlmGGZ+saILCkZUDZh
         bPQ+ApUNQ6x/qloT7MYztjGFg//dw1qRTu5KUgu3HOrENYTlaqB+VcBdJCH+8bmlRgCA
         hxscDr85XdC/XapZiInnvmE/wpfPeopfmZHmvFJIwMlZYjZAzW9CxPadF2SFK09WXze8
         zcfA==
X-Forwarded-Encrypted: i=1; AKwUvBwtXTbkyL1IZdwB/utY0zTy8ca9FAN6hYR1ZOTzXsC5IAKQKLEZuzMTjw9VtahtYVhsYFak3XS1b+Qk+w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJBraLPfyOKcq7ZOF4HfODvUTvofLLivH3T/PYjSTy+HeTPcUWf
	X3r+ZR/dkhgWhbg+SKBrX+BeWwrC2TFL4lx+be/2jA4VpiiTdk8ltyC+
X-Gm-Gg: AYBFou2UhILmfExfqZTU2iBZ2Rz9DwIcE+YISjSi/oLMntnjtDgE2p8Tw5M0L0RKUgm
	OH4katHIpIzElfdkJ0MKRamPrkwdZ+Aa28fawkHWKmeeJINepkTB1Vh+oXI6JdrT5p0VV/smyxZ
	XulM+G5hGEGKwQr4+qb5OnUIWUWE7X6BNZALVA88bAeiozQzg1s0Elcylj0xe0UtXg786LnphQ3
	ZP8CGVeDJMNgj4RunkuG95yA3lPqkLErUKfdkPw36OcZC+6NX9qok5rESMlhZLtIwt6MEtYwWSd
	coKsFLGNAzGmKu8+tVNW5L1iR6Fm0gPEFFduEEHwox2o1pnOLa1lOFFB09HmowHCLUtVuC/zOT6
	2b6Q5kn/wEX67OyvTwfldoqZ4EL1s/LmhSLGVOzooo+SQa4yxaIbguwTwXfT15pYCvNMzBnbVmR
	Naa8norrAkQszKd5ckTh7tprMzNI7gYXSviKDBevLbBv0azhpMeuyiYyan0rwmLtFFU29pKrlMe
	RfKgTPUpFvqKo1iB5XeHcu81cj8aIxtrDJrhFcRJkI1kL6OSLZyXPBPwqFLlGuuRPFeIid3L++D
	tTBjX4s=
X-Received: by 2002:a05:600c:524c:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4a35ac8bdc6mr188823805e9.8.1793109237982;
        Tue, 27 Oct 2026 06:53:57 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:57 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Helge Deller <deller@gmx.de>,
	Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/15] MAINTAINERS: add entry for DRM splash client
Date: Tue, 27 Oct 2026 14:53:32 +0100
Message-Id: <20261027135342.2003632-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
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

From: Francesco Valla <francesco@valla.it>

Add myself as maintainer for the DRM splash client.

Signed-off-by: Francesco Valla <francesco@valla.it>
[Màxim: add myself as co-maintainer]
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6e67..321ecb9f5b5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9168,6 +9168,14 @@ F:	Documentation/gpu/drm-ras.rst
 F:	drivers/gpu/drm/drm_ras*
 F:	include/drm/drm_ras*
 
+DRM SPLASH
+M:	Francesco Valla <francesco@valla.it>
+M:	Màxim Pedraza Padilla <maximpedraza@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/clients/drm_splash.c
+
 DRM TTM SUBSYSTEM
 M:	Natalie Vock <nat@pixelcluster.dev>
 M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
-- 
2.39.5

