Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692D12B7D
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GrCfM2er"
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7A4228
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:44 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-9be02fcf268so441630066b.3
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699363; x=1700304163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfR080tdra7BLhUIWSvcaEDMSQNVyZv5MjwAaJaquw0=;
        b=GrCfM2erwPgk4/3+nyPnjZ2JFTv3Wwvd+P8cfyzcebe4TdbGQuwMOCiL2NeTI/cPZn
         HntLgdH0GyHiyjjlgnFbRK1YPaxn8YeRBiiYwIOCJgXuYnCl12mTsX2sEWy1vCWl5g5B
         dSN2gymXCMVjLelNQ55s8bWQTTUCeLODdZvkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699363; x=1700304163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfR080tdra7BLhUIWSvcaEDMSQNVyZv5MjwAaJaquw0=;
        b=pkFgOSbiip3vsAiPEXS5C4CTLd3QrD22M2aCmQfosaDNz7lcNtATV1zJHmRW8oh5sw
         cNcNpnLT7c7G4Go1zldqjOHXfRJBpREWh2gQ7ds5A65JT3pz6ZiwRTLo4X4KKVSF2nuH
         XomDpx3/MQ4YFLI4zF6Vb5Qcjm/lj24uirq00sTxCm1TODMkPqwuH6WsXu/LnZPMd1bk
         af8BRuyJax1F4wGyIgLuYEvbZVHARV8K6fcqqwQiTn/YnsD7qabZ0lzam6HWaCplykZT
         WNIgFfnmbn4JL3svyMBaEqjgN6OlwqB/uPP62aMY39rL/tkFlTEVeniC34Kt9aZnQiEX
         P3HA==
X-Gm-Message-State: AOJu0Yx684Vhxfc4ALtdFNGWuho8mRZ1Y0OXCXSEiPmp66dFLt4DwMBX
	b2TBNajivaL2dvhFu1BRg8YxIg==
X-Google-Smtp-Source: AGHT+IERVItiW0QNcc7Itc1tQ63vCmzWRiYW8aKUXkxzrDZclJWRXQE4ZuhMCcTgFOSgvNri9tEQNA==
X-Received: by 2002:a17:906:32d9:b0:9cc:97b:5a15 with SMTP id k25-20020a17090632d900b009cc097b5a15mr963727ejk.64.1699699362713;
        Sat, 11 Nov 2023 02:42:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:42 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Helge Deller <deller@gmx.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 05/10] fbdev: imxfb: add missing SPDX tag
Date: Sat, 11 Nov 2023 11:41:54 +0100
Message-ID: <20231111104225.136512-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
References: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve the following warning reported by checkpatch.pl:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

The patch also removes some license info made redundant by the addition
of the SPDX tag.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/imxfb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 485e57fa9389..de1434069530 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *  Freescale i.MX Frame Buffer device driver
  *
  *  Copyright (C) 2004 Sascha Hauer, Pengutronix
  *   Based on acornfb.c Copyright (C) Russell King.
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive for
- * more details.
- *
  * Please direct your questions and comments on this driver to the following
  * email address:
  *
-- 
2.42.0

