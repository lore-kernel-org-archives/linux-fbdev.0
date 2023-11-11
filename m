Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF212B60
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MbbU5Gvv"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C582C3ABA
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso459482466b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Nov 2023 02:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1699699356; x=1700304156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ge0gNi9DVXfC2vKDgGEclw0Ori58fekABd1HKK5RJHA=;
        b=MbbU5Gvv4vY/L2xQb9BPBSBuz7AttYNt7KrblUKUMWD8MIAYUh9aCcMfrTOimHshHe
         ZdJ1nkCamch7LQLY+9ZFu4f5qy8z9FWYu3edY4qBE1d1obd3AUdUq27wvlVyXK5QOY8I
         BKUC1ICenXwIPVnHF+58SG/z7whQKmQvw2NgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699699356; x=1700304156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ge0gNi9DVXfC2vKDgGEclw0Ori58fekABd1HKK5RJHA=;
        b=iyvnr2FoOviKiG2rGJeJ256X7+mHR3hkshq6sy9n0dE6M4z9PnAXkYe+eMCylly8ep
         cvVvMevzsl/ktyhPOdwuqwX9OzgZGvFxtX/wiTkO9h+kEMoIPxKODVCLATt5lPNLfERo
         47SO9N3tbUOmOtJnxtNqMFQgWja+CbDMCz5C+9VNvUcLxo3+r/yi1dQ413z4esIEHtvR
         bcoTP1Q/TTv5dB/FX6eu3J6HNxQsaR2RL7IOFYGL5FlYlfiMZxzsrP4PZcLkxxdoYYD8
         HyxBbeER3vr3JGM7AOyU8RUHHCk5CZ26gwh0fp2DR3I4Kx0jDdYZ50d6y+LotS/kfrZv
         /gEw==
X-Gm-Message-State: AOJu0YxwkKQPRMpQfqCeL6mqNDk+gASnLUBxdtXYwqB2DxJCiPtwda+U
	XuLUtIcJwMgVA33Xk9pEnny9yA==
X-Google-Smtp-Source: AGHT+IHi7umdHJSN/J3vKG6LIaXqc2IzKyZTj5K72HPZNOWFZKca+Sq8nOJ2Izx28leKgWLIeRgloQ==
X-Received: by 2002:a17:906:4c84:b0:9cb:5a8a:b19d with SMTP id q4-20020a1709064c8400b009cb5a8ab19dmr929295eju.5.1699699355850;
        Sat, 11 Nov 2023 02:42:35 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
        by smtp.gmail.com with ESMTPSA id ga33-20020a1709070c2100b0099e12a49c8fsm872183ejc.173.2023.11.11.02.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 02:42:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Martin Kaiser <martin@kaiser.cx>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 00/10] Fix left margin setup and code cleanup
Date: Sat, 11 Nov 2023 11:41:49 +0100
Message-ID: <20231111104225.136512-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series was created with the intention of fixing the left margin
setting. At the same time, I made some changes with the aim of making
the code more readable, as well as removing the errors/warnings
reported by checkpatch.


Dario Binacchi (10):
  fbdev: imxfb: fix left margin setting
  fbdev: imxfb: move PCR bitfields near their offset
  fbdev: imxfb: use BIT, FIELD_{GET,PREP} and GENMASK macros
  fbdev: imxfb: replace some magic numbers with constants
  fbdev: imxfb: add missing SPDX tag
  fbdev: imxfb: drop ftrace-like logging
  fbdev: imxfb: add missing spaces after ','
  fbdev: imxfb: Fix style warnings relating to printk()
  fbdev: imxfb: use __func__ for function name
  fbdev: imxfb: add '*/' on a separate line in block comment

 drivers/video/fbdev/imxfb.c | 179 ++++++++++++++++++++----------------
 1 file changed, 102 insertions(+), 77 deletions(-)

-- 
2.42.0

