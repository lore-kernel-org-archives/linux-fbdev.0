Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E932721B;
	Wed, 19 Nov 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540780; cv=none; b=fz3LKR7K60Oxp3Efp9p1/3j3PKl576XaWAq8TbJyE/gqTQl1YtFsZXIH2v2C+ITI7rbZxYIbHO7KH4NNBpxxZshtySTa5PXsjlNzK4Cp9LEq+uPjTJWorZmAgreA0309nnFLw1vxjK4PcfZ9boFwbX4e8Tdl6MZsbdCgI6GMyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540780; c=relaxed/simple;
	bh=jcPepnZLZgpDua5txvocFEmcFpPGA3RIdeogtsflON8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQY/U1kLH70y4QtYr0cUam3a9QFG4K+iwgam9E4tppnKD6clNywIvUAirVYDeMS5rPTi7WH3dtH9sjnrNo1wDnj+yMRGDg4HyORkFCU3y6wq7jxjLsu/q+EHk0IPh+sIjFeKN4roKJqv89a6zznRrJSwPEfo2+j+4T0tFF78n/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncQv555x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncQv555x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D67BBC116B1;
	Wed, 19 Nov 2025 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763540780;
	bh=jcPepnZLZgpDua5txvocFEmcFpPGA3RIdeogtsflON8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ncQv555xAkzsNq2E8THOD/w5ae5i9Vr778lCVxm6zsdvcDRuydmic8J35CTOIQbDQ
	 Cjz0+BieySvLVT9Qa1oDXyYYSM1ZNxwVxHBZI7OV6FpTwiAa98TYgDtMLqyQiH9DkW
	 r+Xgkg8YjVirW7S+sOHqoLWEd7Pu+LVQgq9ApRnHTudpvOhzKNGNCEI6jIi0R9b9iL
	 DFH8QwU7zjfhpSD6KZ9fnuik1d4iKzHInsTHwOWWm0cGgBgPRtJ1YM1/JDcvFSTgUz
	 P3dk94qSyZ4f48+rM1YNPOSugSnB9zLNGGxwC08y7DpP512ah1Ou2nmZwFGSlkQV8M
	 Rv8pVr4ixh3Hw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A8FCF259E;
	Wed, 19 Nov 2025 08:26:19 +0000 (UTC)
From: Petri Karhula via B4 Relay <devnull+petri.karhula.novatron.fi@kernel.org>
Date: Wed, 19 Nov 2025 08:25:47 +0000
Subject: [PATCH v2 2/2] mfd: cgbc: Add support for backlight
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-cgbc-backlight-v2-2-4d4edd7ca662@novatron.fi>
References: <20251119-cgbc-backlight-v2-0-4d4edd7ca662@novatron.fi>
In-Reply-To: <20251119-cgbc-backlight-v2-0-4d4edd7ca662@novatron.fi>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, Petri Karhula <petri.karhula@novatron.fi>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763540778; l=730;
 i=petri.karhula@novatron.fi; s=20251118; h=from:subject:message-id;
 bh=KPNSZCbWidPbzGQwgMCbuFj/C6Dnnhi7zAXThQ+Pso8=;
 b=A7+u4KN5Q5OzUvkb74yRsfjSwPDVsYz3jVlv1sGdlQe1+mLVQgad1xROxS1PTS1iZ1WxiMgXK
 3nCRWzu6gzTCiIKkZwybI23Dy0+poEOu0GLUs3La79VILxRSokKxgXM
X-Developer-Key: i=petri.karhula@novatron.fi; a=ed25519;
 pk=LRYJ99jPPsHJwdJEPkqlmzAMqo6oyw7I421aHEfDp7o=
X-Endpoint-Received: by B4 Relay for petri.karhula@novatron.fi/20251118
 with auth_id=567
X-Original-From: Petri Karhula <petri.karhula@novatron.fi>
Reply-To: petri.karhula@novatron.fi

From: Petri Karhula <petri.karhula@novatron.fi>

The Board Controller has control for display backlight.
Add backlight cell for the cgbc-backlight driver which
adds support for backlight brightness control.

Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>
---
 drivers/mfd/cgbc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 4782ff1114a9..10bb4b414c34 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -237,6 +237,7 @@ static struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-i2c", .id = 1 },
 	{ .name = "cgbc-i2c", .id = 2 },
 	{ .name = "cgbc-hwmon"	},
+	{ .name = "cgbc-backlight" },
 };
 
 static int cgbc_map(struct cgbc_device_data *cgbc)

-- 
2.34.1


