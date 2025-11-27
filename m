Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CD328264;
	Thu, 27 Nov 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256920; cv=none; b=EBlMrU5NfyzxXBY0GaWOND9icvUuvptUtTQMTN2jZz2hG1k9+ACkb1/KhAtRSR+/tzqRJ9U4rLY/LsSchppxkeDXPUXJGj2pEUQ/MRViaFM7otdos0q4h1wo/H6RuWNbYi7cQpIngOmNnHjT/OT+K3qSoqGjRBUncDqrV04vRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256920; c=relaxed/simple;
	bh=0DYPf8nCWVRUOaNVG3Sdtd4XAtoEggEvVG8k3t7HN0Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dpLI2hXLHRIm5HIuYlFkGvI8jT1665daZfjKwg5OKUDlOcTytoBwDIfkIBVE6H8M6VwgvR1TjbFqTmuKHrAqKyyoyYSQXni0IVm/emur8K6xgYEc/bPA2eMMefIXGo19rFGJHGBPfVYTtQefvkFj55X+ILj+eQCyYwg/n/+cHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMnmiUTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMnmiUTR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71515C4CEF8;
	Thu, 27 Nov 2025 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764256920;
	bh=0DYPf8nCWVRUOaNVG3Sdtd4XAtoEggEvVG8k3t7HN0Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DMnmiUTRERyX55lKxSZ6OgwZt5jBGbiVtEvHWa7TizcF7T7YpjfKdfjPbVSmjWWXn
	 aaY9glhwZUSb8NUFjq1fSqx1BrmSYxofcDmUJhvXpNe+3DReklfPrxCxm0GiucZYQ8
	 rzRdcPHqEzkX2pqYFJ000Ggl3D0JgjvtCQwUM9D0KnvvOvrt2J7bovofEF6LCVOZnF
	 yuMWRWuUJSon60ootwr3fU9i6m3yyWZwdU5TxUZFVtXcl4jz12LrfxTuXxMJ4Iadx2
	 lP3q2XMPrFp06gPYjw+3d7fIMmAi460OIzg8PReC3WTGIMznQ56xp3z5m1U8RoxMhw
	 xuh2YwQ8ifafw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B7AD111A8;
	Thu, 27 Nov 2025 15:22:00 +0000 (UTC)
From: Petri Karhula via B4 Relay <devnull+petri.karhula.novatron.fi@kernel.org>
Subject: [PATCH v4 0/2] Backlight driver to control backlight behind
 Congatec Board Controller.
Date: Thu, 27 Nov 2025 15:21:58 +0000
Message-Id: <20251127-cgbc-backlight-v4-0-626523b7173d@novatron.fi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZsKGkC/3XMQQ6CMBCF4auYrq3ptAXBlfcwLsq0wERDTUsaD
 eHuFlYY4vJ/yfsmFl0gF9nlMLHgEkXyQw59PDDszdA5TjY3k0IWAFBx7BrkjcHHk7p+5KpAAFH
 bRjQVy6dXcC29V/B2z91THH34rH6CZf1LJeDAEUuDhRIglL4OPpkx+OHUEluwJLdAvQMkF1xb7
 aw9oylLuQfUBpDFDlAZgMo4Lcuq1gC/wDzPX9QhonEwAQAA
X-Change-ID: 20251118-cgbc-backlight-35c1109db0b8
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, Petri Karhula <petri.karhula@novatron.fi>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764256919; l=1467;
 i=petri.karhula@novatron.fi; s=20251118; h=from:subject:message-id;
 bh=0DYPf8nCWVRUOaNVG3Sdtd4XAtoEggEvVG8k3t7HN0Y=;
 b=5BGt3s3TPKHC72VXiw9Ebb2AuFW0gTrHlmAvfcGWm27oYv6CcuWocLtVK0HdOk7BExRn3cZTg
 2d2ZeqFlGV7AbpkRpdQ4i5v4b98tUwXDtDOQSLIyxGVlMClbbp/PPbq
X-Developer-Key: i=petri.karhula@novatron.fi; a=ed25519;
 pk=LRYJ99jPPsHJwdJEPkqlmzAMqo6oyw7I421aHEfDp7o=
X-Endpoint-Received: by B4 Relay for petri.karhula@novatron.fi/20251118
 with auth_id=567
X-Original-From: Petri Karhula <petri.karhula@novatron.fi>
Reply-To: petri.karhula@novatron.fi

This driver provides backlight brightness control through the Linux
backlight subsystem. It communicates with the board controller to
adjust LCD backlight using PWM signals. Communication is done
through Congatec Board Controller core driver.
    

Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>
---
Changes in v4:
- Factor out brightness read into a helper
- Set backlight_properties.scale to BACKLIGHT_SCALE_LINEAR
- Link to v3: https://lore.kernel.org/r/20251125-cgbc-backlight-v3-0-18ae42689411@novatron.fi

Changes in v3:
- Fixed review comments and simplified the structure of the driver
- Link to v2: https://lore.kernel.org/r/20251119-cgbc-backlight-v2-0-4d4edd7ca662@novatron.fi

Changes in v2:
- Separated Board Controller core driver change into its own patch
- Link to v1: https://lore.kernel.org/r/20251118-cgbc-backlight-v1-1-cc6ac5301034@novatron.fi

---
Petri Karhula (2):
      backlight: Add Congatec Board Controller (CGBC) backlight support
      mfd: cgbc: Add support for backlight

 drivers/mfd/cgbc-core.c           |   1 +
 drivers/video/backlight/Kconfig   |  11 +++
 drivers/video/backlight/Makefile  |   1 +
 drivers/video/backlight/cgbc_bl.c | 179 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251118-cgbc-backlight-35c1109db0b8

Best regards,
-- 
Petri Karhula <petri.karhula@novatron.fi>


