Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794339541;
	b=QDbFNxljwlUdiWwe+lcEEtVJJQfZd+ikMkB+B/8dgCogoCy1zSa/fabo7pwUoVSdsF99
	 cg5R5k75rX7zzxO73Bg5c+QvADfOj8+Rlb23EtvCTyqXAPYRzler/3NWZvdmDMiJCDYyM
	 eqX3QF61GyB6piM+Vog9Dole2Xz5+epanfoZ0LbjE4uPSs7diwkr4IlJuImppXMu/jhcN
	 Iz5Bv7iTKApiO7ILt81NWapD1YYIy7ZrtDTwIdyJFElN5DXOxpR/SPaKXXm2njMZIRg8b
	 V9KzVqPh8nQze3yZZ3WBux+xCmZEHPQZ2PPpHpoCmujhtgNOi7rqiop0jqciJAcOr7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339541;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2Knh+MG6yRQDB1koTSCHAMZw8rCeE37kS7kHXPBxgkI=;
	b=2jmN//D48PZxfpAAoIXd/Zg4UEJv9ZW4MRkbnh3ZqjprAPK32da6sv7UHUvs8AOe6B3Q
	 mInfcUXWCD+3EIz0OW7B5B8ow93l1ZBXXROOaFSxVvY+vICyhuoPa9T42PMifOtz+ro/l
	 o+Rq41wDdSo87H1BvqQG3buHpooPGmCT4y8YlmTuUG3p584N4QMIWxENZ976Q5mX7nSn7
	 2UsP4RTkzBU8vfUt/o53U66khVf5u9OX9z7o2gndMLJCapqIrij0EoKZODfAscxvHZja9
	 hnZCTNIT5iJJkfYW2b7Vax+KEPZtrKz6Pa+2p4mTPZz5O7eabyGcwaCFp1oXm4bdPoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxLypjf2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB96606A320;
	Tue, 10 Nov 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxLypjf2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794339540;
	b=EcRvM0t4+BF9I77Tj7gkq963ynSwIq/NDnpvRO1GMGSUu6gsM3OpBNAr+FC4hqq45pHN
	 8tcXtc6UZ97kPb8chrEVbKcg2/Wh9AQ1UcHOCmS9v7mVnRI7ecDUdR6GEHdlrrnBHD2sj
	 szzeKomUKeeQyXvyNCWz95k/aEatrOHgi/bhiqWFAEUpZykGl3ufjHsbU9QgUNGZyH/jv
	 zkoJEf97NHiT7i+2XwM2IauSm4J42FaUaIFImQF2e3Iw5VN7t/nZAfEAnwFaBLM4zp7m4
	 6Qc0A28hJul3R5VKHCgA4PFgAO3glDLRWq7Qm6rD54DH7ATIjKwksuBySDxseKC+geA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794339540;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2Knh+MG6yRQDB1koTSCHAMZw8rCeE37kS7kHXPBxgkI=;
	b=SDk4dPbU419kSHA3muNB4mgk9Hycr77wT2Nw33Is6gFw5ZMfLhun74Vzl0wizCYVlEgv
	 4VBiRo3q5o8CzIi4rAuEj4rjO/teCG2kVvkk/YF4LPCkZf7/aMVOw2HloOyLs89L21nQn
	 BcYhz5u3DB8hFhXBxesJJE767gDnknjP5XlMgqdQOpdKfFgqTNhk6GhyWtXhbwFAZfIr4
	 BOWdTPrPNGfZZKRGTsAoG56k91GuLq96yDRwhMH+g0JE9rpAdc4AwX7LlK6IXUWLr0IMV
	 lczJe97J5wiZrmmyOIM1T5i5tH9ppG1eBlnM5igpDKjcKnJhY4vfHTsVctOBVG0Hctw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2CBDE1F0089F;
	Tue, 10 Nov 2026 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339540;
	bh=2Knh+MG6yRQDB1koTSCHAMZw8rCeE37kS7kHXPBxgkI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZxLypjf2Ob1fkL/bhKsSaiGn+6+GULU99JHVofeLNAFhO6nN62KJ/Fic28hVp1Yjk
	 idPEgx1itgcWHSIhryZW0xGIj1M07kU3JpV9zDrq6u8kg1gnEz9UEbCFpCNjoqb2qd
	 0zfvJnLnYMhgMviX1ZSpG+2atI49nBWW2FPFY/t9yUK56fsgLtX7+eXmeRN2LZWxzJ
	 s/bTSE4oT+oX5h1VpQpcESHt3oSPa7xbW8s2aMmWZ7r1AuFK+QQvtG8WZJ9Jbir0h3
	 gBZbOepZIDiJ+iABfwagpkJbP8eIpCN4xt2Co81IO7XUKwN2FSoAbJ9hkiOKri/0aT
	 Sqs2onmVR72zA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7B72A48C6E;
	Tue, 10 Nov 2026 19:38:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v2 0/2] backlight: add ktd3137 support
Date: Tue, 10 Nov 2026 21:38:50 +0200
Message-Id: <20261110-6768-ktd3137-v2-0-9496c51efea4@protonmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2pq2QHms/A/DgpZBRqUlbSUaw
 r8LuHZ5knPPXSCgJwxQJwt4nCmQsxvIUwJmaO0NGXUbg+RSCcElU4Uq2SN2qUgLlqGpcq7KXqs
 Wtsnksaf3kbs2Pw4vfUcT98ZuDBSi85/jbxa79yc9C8aZznXWVzw1ucLL5F10dmzpeTZuhGZd1
 y9qvTASvwAAAA==
X-Change-ID: 20261102-6768-ktd3137-4ec95068fb6a
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794339538; l=1622;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=nVPDdJ3JnMVhs+SAbohUAkjVRUMXwv9zoHcS2AawkNI=;
 b=bt3HNbSrpPuheTayuYlq2Bjl/f+0v/HSyi6bV881yJEQ55J9Qa9EJ5lTTnU/OmIrmANGS0Ek/
 FmVRC16rKV6Ca6NaUYkguZj44iskIzDsrFCT4jHZx5m4HLzVYZBhpAM
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This patch series adds support for Kinetic KTD3137 backlight IC. It
supports linear brightness range from 0 to 2047.

While the chip supports PWM and MSB modes, they weren't included, since
MSB mode supports only 8-bit brightness range, and PWM is not enabled on
this board. I have checked other Xiaomi vendor kernels, and their
configuration appear to be the same as on my board. I'm not aware if any
device uses PWM mode with this chip.

This series was developed and tested on the Xiaomi Redmi Note 9 board.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Changes in v2:
- dt-bindings: drop vin-supply from required list (Daniel)
- Driver:
    - Drop val variable in ktd3137_init() (Daniel)
    - Replace KTD3137_DEFAULT_BRIGHTNESS with KTD3137_MAX_BRIGHTNESS (Daniel)
    - Drop gpiod_set_value_cansleep() in ktd3137_remove() (Daniel)
- Link to v1: https://patch.msgid.link/20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com

---
Roman Vivchar (2):
      dt-bindings: leds: backlight: add Kinetic KTD3137
      backlight: add ktd3137 support

 .../bindings/leds/backlight/kinetic,ktd3137.yaml   |  63 +++++
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |  11 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd3137.c                  | 258 +++++++++++++++++++++
 5 files changed, 339 insertions(+)
---
base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
change-id: 20261102-6768-ktd3137-4ec95068fb6a

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


