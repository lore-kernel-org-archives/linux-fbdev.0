Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784926;
	b=PTVaQamvb6u3hxyX5fdXXQ7BBD1pcp1C3OURGySagzQcx2pYhYPML3SrybP/efkboEf8
	 sX9CECGZlTUfetdVc6p9qL9kV2/e5FhMJrV0Deb/ht/xyzRXZ9csO2S7NvCBBaD9g3F5+
	 63Qg4KNSS89uoOq3TNwaQr01vgIjcTdHJA5Yg2tIwpzxepu0hxX+cFIu25daV+0fLk57o
	 uzp93wU624osGhBGcr1ZST5mZPLCMjkKjapWGi7Q6cSYkO1ChuEuCiYo/W/bl+wxKjV7w
	 i0pfIyuxDprbpAA7oGn1BLSo3rybGs5q4RulvJlbLI02GwTwAR4LtPd5K4pfjvvwxuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2M6HoHkTeVcJIWfMAzqJ94aeV/R3TSw3Z3JZl8kxSXI=;
	b=sA/ltfGHfgWzbIMzGKNhctJoaBpTM7iiJ9Wdz6XQBDzDbFfSulpo9ypWsptzcXVNuvg1
	 pa48o1QMy0GHRGIfRNSNIE/pQYz4M7JSbV6QBntxLTY5BOivtAwKKu9dLjy/tPKY2f7vc
	 kZSyPMtF8GlxLVYZ6tBCH2GHFv4bKt4oOpGnBHGrDSYu+QbcZ6sN++9vwqJ3OtSTkAfby
	 uYZmKpeRDFHF7YSGtzni66NG1NuPZMTZBECSLpaxQXNP6C34eOzsvp/ZmjuVoIYg0o6jv
	 TU0XdKzX17CAkrqC8AVuPXj4TGkIOo1guLudvDZWKtAfgaLmq71jqtF2+kCecSv2JoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASbX8W3B;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16091606A88C
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 23:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16091606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASbX8W3B
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso30651855e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794784924; x=1795389724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2M6HoHkTeVcJIWfMAzqJ94aeV/R3TSw3Z3JZl8kxSXI=;
        b=ASbX8W3ByAyt5NTODXjPhDEF/llLXL3T+KSc4VFkXSFgOapFIsx89vR4EdHZKzpZ0d
         9OM0B6CkzCWrddXddFfz01PXzxCoLgXIaBSau/cqNSaG/CksiioPlexZ00OVV9do2ufn
         16+eH+ODzHnZBHfhjCxkG7ZJOv2pbKYZ1BXXuP2CqJh+nz+aI2HpkBudQNFKQX1ILj0g
         S78ThpG5NCzY5IsLhI7Mlr+GrpbtjobJHvFRpPTSwjND4M78iyD+2cqOZBLJGEhz23sr
         oZwZWmS23kYNaRtQX44IMSquUhVG6e15QCQOy4AfKBDm+rsn0onfwkmRoyd26KDKjpwt
         a2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794784924; x=1795389724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2M6HoHkTeVcJIWfMAzqJ94aeV/R3TSw3Z3JZl8kxSXI=;
        b=k+XQI3/k7YW/2gbRwGB2xkLQ9TTOGxMsuUzq3LyY+nHyPJE/ZBWaj5kCnY+qfkfDjB
         4DCk6NXJkdcfoqmv+GM/Xs/ZMo4neGvd/keAss/O8/ubqHC9H11GHSvQJyM9J8st2XsK
         b2AA/uWGFViZGZlQKsC1/u6lGNGiCg8iCb1CvmRB7FlBfYgS8jtYm7JC4Dp/2NxuW3r/
         pAxAFVva/uBWlDfymYc9x/lzEj8OGpJvQfvUB8gtCah2Nb4gjJ5rBnUO90Ia6eojqMfc
         wr06pOFDjEbOFLVgP53mW0DQAbpT/ipQZAuSGVM0OY5ODBhjSPWchyRjM0W/808DOS67
         pCmw==
X-Forwarded-Encrypted: i=1; AL+hErFsQAHYaWcfYMX1EJBWZhPv1C2k1NzBXy5ANiwc7+76+lex3J/PoR+dBtuW1Pl2HEgkf2ZFr5UkvRNqvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xUIFI4eK8SamCCwSzqPzaLSvvCXnJg1AHbV0hDSdE6Dq1rTmQ
	strCxNJ/JoPM5PEVNg9uhLuoVykFhqr3nVYAiv4pZYiRMj++9X1nck7b
X-Gm-Gg: AYBFou2h/jETeo8yFIfXVbBX39tHc7GtXdeEKktHzIm/LRvazaaSKbVBZW5jBXAjrZt
	nvulogSy+FevQOYiNJJz6HbC1qzyNtLZiibd3K7SB8FK4zwGdEsraojKYA3V0ei7U6noS+LD08Y
	aFCUa1+Dyi52wKpV9/zHgmps7TTuNrHKcPrmeKPM37VsTrshMKLrqyMj/41NQag556tiVEXu7Hj
	vwmmcybDNpTaL+44cXJm7qx22ttKvIygRrMrkbMgVVHlS5EI++DKaLj3BduwrkHsccDW2XI0DL9
	+Lw6LknS5+zORjxdJqsc4jErsn9v2km39A7HIyPePZrz0zPZYE73EfgtLWCrixyLLF3DcJIbmk7
	G1AEIfTi9DzvIHxKLm0AAGqSmhLFSOVdt/atfPTC/fdv+2TSFIevyrrZN9eKToEOX6VQtSqvY3S
	56y4qG4tSE9NlSzpCnSHVmPvbb4qvk2R3vK6h5rTh3NS9+IJg19Ovp3AZIB4rU6lQDMg292ucGC
	F+DU9JedUOnVJL2IG7QWfZq2m4JSy9QIer3fY8YvWJsW7sG9jhxDM7BB6384l15Dof1bgbG6otx
	y+N06PlWUTXN68l3hZw3nih04cm7Vx1YAYRz7WulgX9aoZA1gMeaxus=
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb55a59c9dmr137490185e9.22.1794784924398;
        Sun, 15 Nov 2026 15:22:04 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 15:22:04 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/6] drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with tabs
Date: Mon, 16 Nov 2026 01:21:51 +0100
Message-Id: <20261116002156.1027726-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
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

