Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109229;
	b=OMI36u4xzxUUWvGNvef8KOnvqo1THv9NjvfmeVfiHhX295lsjS+p0GHF8elkxbwzFus5
	 Yn/Dmqps7Z6qEuYqwOclIIcTJvRCXLa3aneBkSPuPktsyJ6xexmLmMWGGCAMUqX0y3paT
	 D2Q4BPhLN9CE6Rc0JNGFIV7g3A55zlGO1WNcIxu0wh1MB7GlIn//86m5uRw+VCGfqUFe9
	 x++Rj2har8g+tuQHnfAzUbBXKv2CJxRDV9RiIUxu1b2XdTMSkjuqnhC9htSt1/fvR/Vsx
	 TFmFcmzcDsAVJWexOXhbNKey1rla7hiXPg7sa9Wf1ubWJaxqLZBSv1MAvqZsddh1oFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/ggIeAF8ymqQPticOc6wmD/qoAjkwXyVLKkCNBrapmc=;
	b=AXwQ6FOsufIsYJPOIP4IL/YP2vOBE0StekIel/HX4pJdExqG5mb8s8293MAepDZMLll+
	 X6LDoQ+eBLH7If9rPBLC88KsoQLJt33yjS5NQ0TOIcGa0D177mRf9KUDpN0Z0rx24SdD1
	 LbPzCI/bmVTxpLOqyn7IvJfT85owNnjsVlwe/NItgpKEpYu2FR6/qAiK658MXeDPa2/eu
	 nzQ52/rF4porcFiy7MuNxw7Gey8da6TwJwT7ewD9n06j9RDE2L4lJptCokyYQU7EC8ZWU
	 sGaen9NaOLYMxGpQMxy4YH3X1QgeOTRHPZh+Pfc1chJxi8MmCWDYiSg1psi5kIyAlnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J9EdSbtg;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CB606A32D
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02CB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J9EdSbtg
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e00eee27dso2712369f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109227; x=1793714027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ggIeAF8ymqQPticOc6wmD/qoAjkwXyVLKkCNBrapmc=;
        b=J9EdSbtgiLFlXq27G6BCfiLyCUmgTmamz/0X4sPuWGR7PI4baQHTwUqiGYuOjNv+Zw
         1+lFWIFT+YbazTtQ73hJYOUYzJ3Z4g1NZE2eOsEyEZytb/i4LPOqbzR0IbSPSNEytzDz
         1hHhw/E32QerKbf6y9ivfV/PqizTxvtDena7LjediVrmbjhB5EjOWBkPv/tNqmWrG319
         Ql3I/u4j6qJosxpMmd/ho6YxJ26kxYdNzdxIqPRZcfKDqva/aEjEcEyumDsrF2yfWlTf
         74MjiDyd35Jl7TGIWolX3bWIaH1dYsBJ625xdzWOV1luCLOkhS12QU6RQOgcVXRjuHtC
         2PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109227; x=1793714027;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ggIeAF8ymqQPticOc6wmD/qoAjkwXyVLKkCNBrapmc=;
        b=aOreBXd63OGGbQUV4rFIa2G+JLkpQ1+XVeUUpNtZhdozczU4i+e6gqu8nnWTHGwS04
         E1u69W609n7ug33mFGIb1oqFubk0yW6rppaq8KGyh11htr4Itwz3DOQ10YzCYfjY/onv
         ckC+F2cHM0Wl5vOf/q+oLfKLffo6ALXK3ISW29LEKF4V3WcCBIs2SQ2Rhd5rHhHzJrLy
         TTzaNmFD6/JHMb+D43ZrfQ3X7lPf5vJxlwtCAUm6LbUU2EUGLmkbt9EXpBGHP0itW5au
         z8CMFd6neRV4naX9Ir5HZGkSq/6C/TLdI11GJr/U0uToI8q9GibjaU8XrFWB/4+s0B7i
         wWPg==
X-Forwarded-Encrypted: i=1; AKwUvBz3/l0QJRDdXxkKRjSffolbkSnTivu6I3lI2/rowk4arsfQnmdVnk/Z7tMfuRAnwtRV1sJAsMMMh2hkVg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCjwKQkrwElliKI000qJtO904rUACjFvOxHLEgMkdnDdSErZow
	b7tMoDOz9lewYxBIcQeKJJ2vSHjHpfHI+zIvbI1Zj9wUErq/8U06AKZf
X-Gm-Gg: AYBFou25ucE2E3xoVaks0XkWOYexa0x+R7ZYncRbyg0xOeRJnd9Pyp89yZRfGobzAa/
	K8V1OAMiy2Wg7mEvgKxRcYLzXt7K0PYMwAxXuUf2b/8zCNrNFDHfofkyIdiiGoJnAvbL/1uae2C
	gVvwhKTaPeyWrJXdls+vjeEvCB3VLw5Lv348qiB3XRMlEmyaIcEIOodIfwjty1du0ANbI1K7vd8
	hjq2Qhf/eaRmZOeE6KXVSXxEb3CcxNdPOWtsQNAGE1dMV2r0h5tlK/Q6vqPtpWAkU0yBxbJ2kZ/
	WQvmKnSwaVzAK2mFBYFL2tMzBiW9h5jHW90DYgumYEVeQXXygcUxEUq9o6YqQpV7A9vXPVbz0x2
	J7qUl/nPfqGdJmodvXCxC4Id1Q3UxkWidhndcaIpWAZBxdnPc8S4U28QFyZLkNaO4Rmh0iu8l1O
	lnX5yuVvSgLt7r1+mAloVjHAQs0SghvRb8uv8K/dQRkRB6MpJjtEOPlcSFrrEoiNtByKIkUqiFg
	UcKJaeFWtMlv+sebMwyigvLMuKPQVHX4jLF3xdSnmLm1qX0U8W5EgFZ4zMedfUwl3ZlXEtoakxx
	hL9UM2wh7LpFGVpwMmPTEomW1UnK
X-Received: by 2002:a05:6000:43d4:10b0:48c:77e3:6c8e with SMTP id ffacd0b85a97d-48e3eba1660mr15009254f8f.49.1793109227175;
        Tue, 27 Oct 2026 06:53:47 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:46 -0700 (PDT)
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
Subject: [PATCH v6 01/15] drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with tabs
Date: Tue, 27 Oct 2026 14:53:28 +0100
Message-Id: <20261027135342.2003632-2-maximpedraza@gmail.com>
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

The body of DRM_CLIENT_DEFAULT is indented with spaces, unlike every
other entry in the file. Use tabs, so that the next client added to the
list does not have to pick one or the other.

No functional change.

Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 6096c623d9d5..8d8bc37ec9f2 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -114,10 +114,10 @@ config DRM_CLIENT_DEFAULT_LOG
 endchoice
 
 config DRM_CLIENT_DEFAULT
-       string
-       depends on DRM_CLIENT
-       default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
-       default "log" if DRM_CLIENT_DEFAULT_LOG
-       default ""
+	string
+	depends on DRM_CLIENT
+	default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
+	default "log" if DRM_CLIENT_DEFAULT_LOG
+	default ""
 
 endmenu
-- 
2.39.5

