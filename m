Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A13E7BA8
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180229; cv=none; b=aVa6jKs9lWXhPnq1gKyDmYEyRaCUGCsBNprMMrVaOGHldGF6WQXcbFGE0ZTplSa39DQm6E4dS1MJ19eBXxkWuDFLYXMnz8Snlf1E7RAG0bWVIAqrGsOGmi+6XEZAfKhURWhjOGGivuvf/6R3lFu9wmmvx10YGpuLD1I5pzHDl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180229; c=relaxed/simple;
	bh=SBsRx6COMWb8PWEHsPOkez+jZUIfIF/PVkJNqhE4ISI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T3nBgU57RvZHdr2aFcVCpEClOc8VU5W0eeqRruP876n8M+EWxq/MWXE7LXQzXkpCeuO0HhC9xHiv5VeNRnHu57qFPBZ4/gW4JDy7OinR7DkkR1wFSRDE83Rhfet1FGyEKAEtqO0Br6EbbY9ljoKP/zesiTp2TFLOIzzJJMuKAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSi+SAFM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSi+SAFM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a5174670eso1803389f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779180223; x=1779785023; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmS0AK5bqXeh0xlGi+onoeqz5lotlB7Tla6Mg7VB7/0=;
        b=mSi+SAFMgqDpfu2NifGgD9RXIyBIPLxHraaKGpHN6XuXY8C/s8tVOJ3brFKkdVtDnk
         /bUVGTcmN97MYNB8cIQDuBxENtfB8j88yNkJ+fJenv/2Fyk1MItPcBNCzobQf/Wf5AD4
         2AoRUwhmkdTJpeIgdxBRKdLO6XSAz+XvvK+p8Vp336JVlya0zjCgDeqdJmQQaXM0fS2Q
         9GSnKFyDmJkKB+eHRG8Ftem3GPp47ef162VQ2/7FrS7tA5Bv6Z0ZQeyJXJ7Q3lP9hyqL
         dr7P5K/1mn7sWVos2/fa6bJWurg5qTugydic+8SF0IqTTspkIwY/BdC+uf52sV+csMEV
         JKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180223; x=1779785023;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmS0AK5bqXeh0xlGi+onoeqz5lotlB7Tla6Mg7VB7/0=;
        b=i7JPiUUJw/cYR3T9PJvhvgI/y5r92iDu11/xKcRp3+RB0zlfxEROK8sCSv+w2NJzrB
         pZfoGM3LimLm8j3E5Qi4UDcHuKs7tBa68UnOaWz3AbDoMMJL/723mlxJU2Z1FWrk8MM4
         7W+UWfcFkJaKG7OUd9p5yaTpEDaOXh9D8JFPhtzQsQws7ubGqXF7HZJ3vdznKIhLdpCw
         BsMxoVYmlvgsNra1An5y2RY9Cu0QsgIKhc+dzYTFokUaT4vKwENwpDVYVz2U8bCnY1FQ
         KIYGCfcLVlS1gEW8c0WRc03Vvsl/48NgPTqcjBUqpR9xxzd6CMxC0m5PN2JsvpS4XS2J
         OaNA==
X-Forwarded-Encrypted: i=1; AFNElJ8UzidSO08N80wuCKi8UIdIQeLB2BCCkATEM2zgAPpsK2BoTkHF2NlBXBmyeAKGjZceCXu0PLsZBOtLYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww94I3qxgZdUUQGOEvEyOLOrWQ/ibd1fLfYmjdyZrZuv2qtGW+
	ohPGADX0+BbXJfOiX6Uy+/B5QuWv4i9wNqTZhUMQr3dtLtBLEZ1ngoj/45mbbJhgs7k=
X-Gm-Gg: Acq92OHphlpKwJX8EbdlfvhDBXGG0FZTvZfGREwk2ujSJWkUPQqQIZfOTUIuSpszeAt
	vIIe+EHtTF/AwGd2YK3VDTr62QTjX/IY/QeK0hxBYKgjevPoSKol98viOo9mok5YPEiqPyug2mF
	tsnZxMHQavUxlkEg1zdHsuC9bzbo7YcBcTRz6/YjI8qbXBn8PGZ2wc2A/BIbCYyhJ+hOX9nt6N+
	NwIGEaWBjchQ3kgZf4De52FmaapPTy0QcGuiC2AIB63+4Am45Hh+MsySZXwIWJplblcBK77B2/H
	rJHlrGpPzvYMMQ6aoWMbiBpB8gWxZrEgtnEm7svoXHDVxQe760lgCWz0VwedaX8jONjjWy0GcG8
	NwT7lCGIepXmeDrF6WBbHXoEMotEUwsx9d7EpZoNzWiePFBxDedbbP6qoGkRZ8ppBFiyz/Jl8zU
	4jF18UL2JTWL9LiEzONkxC03hHCbdGiAIyu2h3JlWC6E6x
X-Received: by 2002:a05:6000:4210:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-45e5c5dd47amr28790430f8f.33.1779180223003;
        Tue, 19 May 2026 01:43:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm47709855f8f.31.2026.05.19.01.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:43:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Tue, 19 May 2026 10:43:37 +0200
Message-Id: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkiDGoC/5WPzQ6CMBAGX8X07JqlpYCefA/joZQF6g8lLRIJ4
 d1t8aI3PU7yZWZ3Zp6cIc8Om5k5Go03tgsgthumW9U1BKYKzDjyDFNewGB7o8Hfi0wiqEl1ZKG
 3+koDeA5+ynNZgMAiIcrrhLhkQdU7qs1zzZzOb/aP8kJ6iO64aI0frJvWO8Yk7v5MjgkgoFaqI
 llXpeDHm+mUszvrGhabI/+wCvzRyoM1fpNilmJF+y/rsiwvRIsjIEEBAAA=
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SBsRx6COMWb8PWEHsPOkez+jZUIfIF/PVkJNqhE4ISI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDCK8S/slQPHXNXiiLc2aYeHWz7TKawBWv30dZUIO
 Bdzq9q6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagwivAAKCRB33NvayMhJ0XWrD/
 9ZkZGEDmabhlVXZ5CFJPKdgl4HPnSgbIpAlrs4w9RkP9cT0IDxI2J9pjhr5x4YRFpvOs6QzMB+d4Lw
 g9FlRycyhX93EgznWHgvhpvjWItJewGSwLOJ/bx+lHK4eBr4faFs/mOJsNXNtH9b5jcmO90q49sreq
 mRHdEngfAO3DMOcZkMEMQr0/+Do3r1fQd+5dfD0qs7kOXC9ZG1jCBvipyUVwWisgKMdHDILdv7sZXv
 zTE15MoylurfnE4m8EkDvTOSEx85N3Ibq4SRRz1psqLOIbhmfJ+gsej1aMQWoh6MZMlINgDXfojFo8
 CLZlIjVDuIh6+lHeW4XOC1NBh/2Xvug09+3nAUFh4MuMPFij9RTS+p1d/tJiLA+6+SCmiZn5pWgcvy
 ZIVmofvjUjEIk6B5RPmqiMvR7RbqnHC5N4FSKHRmpqgGlovDaUa7gelUvkqsLAuR+vECNP+njNU1Zn
 4pPBYMisf+g+t5tt/Uo9l0dOyCsvwmzR/kzwI91BQ2vJzSQDpfPGtEn+dneZLjjLwDl30Yk8MLnej1
 4SrZHx/dvwSYJTs5FW6yXSLRZNeL0gOZ78YnlrFXfP+t+gmUkCCwcaQPajPQ3XbMeAjxrwuw6yvd7m
 LH3MGkaGlvfSUFgi2pwuB5ty4Kn0fUnYEaGfaG1zdOl5XNv1CjonJOJS2byg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Dropped unused macros
- Added second autho entry to match header and commit message
- Move my signof at the end
- Switched to flseep()
- Link to v2: https://patch.msgid.link/20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org

Changes in v2:
- Fixed bindings subject and removed "|"
- Added review tag
- Added higher delay before reading ID from HW (100us was too short)
- Removed probe defer if i2c read fails
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org

---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 +++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 259 +++++++++++++++++++++
 4 files changed, 321 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

