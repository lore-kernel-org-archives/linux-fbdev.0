Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF5308F36;
	Fri,  5 Dec 2025 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937191; cv=none; b=GIcYHdGRWOtV0ZXvZfkx0+4L37UYeOSFHoiPNBFJsrc3RA5z/cKSK9qp3CTdb8MsksPc5aXZ3/QfjKRfqonGEWSP1LTebpBCHujeiFo/a9atwRfTrR7Wi3t0dXsMCkVe3xGRDeyiDnUO+E2uEHhg/RF4X5pjI2DnDiHdS7CVyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937191; c=relaxed/simple;
	bh=jcPepnZLZgpDua5txvocFEmcFpPGA3RIdeogtsflON8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/hs0gdQqx+OLu8QJhYmpiuF8o+5eYKKi1ZhqBeSIjPtk5p24NDHucsPLb46nUlkd+yFNAqE4P7+wntCgEtowD0+CEWLPx1wo+pj6E9YccgvAGr+s7j84RG/JYN5eI01nKj/CoybBcvbG/doHkBKTrnxUqXJ+9slKvpo9egJBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6jgj9fC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6jgj9fC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B16BAC16AAE;
	Fri,  5 Dec 2025 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764937190;
	bh=jcPepnZLZgpDua5txvocFEmcFpPGA3RIdeogtsflON8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t6jgj9fCeMa0/Csw4Ha3dekc3fKmiEtasNWdlFzNiHYPCIxVzkt/FmQdTpGuzIdSz
	 K5zPoINTZH3y0rjNs2KFiAKUP/p2ah7dwy514WvRbF2NgdJB7Ulz3kAHSoROoM9Skl
	 /LZ/LPcVZ8h5X24rB3W1n8+Fg0t/1/96r81t14SbUeXukV8uf0lHFgKPqoLByFbs1k
	 tXeVkd/MJo64GP/0MVXbubS7W2WeGU9uCKjYKO6wgShwelzfXq1hkVk+lLUlypuDH7
	 mKmFnXKCYK2NZHrXX+9kr4x3aNK4l7zfJEdXXz1e2k+ud1lPLDzgtkB0e00UF9Z9qK
	 K47ZR+7EL2saA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D6DD2F7EB;
	Fri,  5 Dec 2025 12:19:50 +0000 (UTC)
From: Petri Karhula via B4 Relay <devnull+petri.karhula.novatron.fi@kernel.org>
Date: Fri, 05 Dec 2025 12:19:48 +0000
Subject: [PATCH v6 2/2] mfd: cgbc: Add support for backlight
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-cgbc-backlight-v6-2-e4175b0bf406@novatron.fi>
References: <20251205-cgbc-backlight-v6-0-e4175b0bf406@novatron.fi>
In-Reply-To: <20251205-cgbc-backlight-v6-0-e4175b0bf406@novatron.fi>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, Petri Karhula <petri.karhula@novatron.fi>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764937189; l=730;
 i=petri.karhula@novatron.fi; s=20251118; h=from:subject:message-id;
 bh=KPNSZCbWidPbzGQwgMCbuFj/C6Dnnhi7zAXThQ+Pso8=;
 b=Yi7moofqQcbmddXD6FGj979QkC2EfgDx8hONE6czwuiqUrrRllPRru9oRtY18aIZspfHZ70Nr
 2o3sudaAVSeAgIkLNRcBLg+jFQ0MS8lnNRgQ3VNhJQB94+aKlYq01Hp
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


