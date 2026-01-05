Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A72BEFE4
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603092; cv=none; b=TQ33hoJtrjB/Aap3l3TKupgpmnES8RrrvXeExsSaz+ho3ilkwiouOQEtel53LjMz2+VkTr7Pd/Efocq08wqtG44/MqmQditmFFzoMTc6NS4ZGZpUKc6xsZYeheYKZKCKbhV7XTG9LPr8f/x/P+6Kb9t/5sQdkBGteKAssYr+8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603092; c=relaxed/simple;
	bh=itcUwean7UbvHQ+5/h9YYVCyXLTIelI0ikVV2LFiJKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bmb1tw0uk3q9FjSApUlX3ZWKFzJulfR0BGFzuy/+jvYEe9w7ACc4mCIcjLMeYhl3UKtSmWtCuwpy0TxOjlgQZFcsCiMQVy+zCWp0JZ/BPmgrs5lnBuGgznspycll803TqzrQ7iODk54648wE4jaEwfxYkrjsEd7Ao8Tb9tGhYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpOFaPPq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpOFaPPq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso15575944a91.2
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767603088; x=1768207888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl3uiFs67UDa8ZibSp3TCnzqWfwUKgTkl0JL8TbUXMo=;
        b=MpOFaPPqKVIhWdfLkv4vdHBUR3WuxizQBiP5B0Z00bxZwyoNaTdCxq3WmFg6dD7XHV
         jDhpQlg/t579Q+hdNtp47fq2M9mOPAUlrrCqYib0wSbSRV+y3ercv1qlovGCzWJqmVzr
         RsE1BF6K8+6MzGNCPEYSse9infsWRNhS4BSKW/R4xCuKnmTIcLL7OqQJLQxIadsTUPhy
         2RNecOFzuiTgVZQOVGmgRy+DEKlATpMCFy+7Qns2MUfua0a1J1TxRsoPIghnCRsx84qT
         9SD1R1rVdVg8Ij3acN8RvOA8kbEuTiXWY9Vw3lj64Jx3pMO1+mJFVIpXT/igN2C9i2p4
         RVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603088; x=1768207888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl3uiFs67UDa8ZibSp3TCnzqWfwUKgTkl0JL8TbUXMo=;
        b=eFP3E3+VtmXxM7HlTdK0wLYb3+780DIyv1ZB9OYYpZgPpWJhKSSrBO5mirMijtMih0
         xAp0+luIi5VXNI3RBCbdut53FaVWK7uEbUip0Uf6jEujMrP+NNAubsJP2ycYWcjguaLT
         +/j/7GQMIU1kwrAHFZE9vMj9tYqD73HZPmwfpTcN4ODmNVZXYgN8GsHg9lEQSVsQuQas
         ULXx/zDHGlt7YsaSPS2dKzfUKM3b3AEgLJ1m9q8H47oeuincg46YVpk9tbMkyxZScw7M
         7Mue6msaOzSrk1nHMrs9xTsJVptP7qV3CYV3vlXs7iRlAw16qFQo3uxb2LfdHN9nftp/
         r18g==
X-Forwarded-Encrypted: i=1; AJvYcCW7z2U21kGZ1OXXMJ27ib4WccgJ9XCxv06RAeWRhonjVbfq+7V0mKGulRIKB5RkP9NVv0gbD5CGieXovw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/bWTErfUHPUHUHDOY2iGLQ1Ks7LOx9FlAuSyDWtyuWowWXBL
	0X/AmExinjlF8/SWbuybbCzzfZS8KuXPcuZ7ZWMaqtnKkYu2/ZnvC0Jr
X-Gm-Gg: AY/fxX5/RuRYk7KAyIfVIE0jrVplMG70XOWCJnKis/JvtxDyjeKOMuxoCgRNrzfVZBN
	SxNCOkZzRzzRzk32S4jmpd2XeUVv8IaEWt9FC9leY5Uwa6vxnnXhmGNpqlsfVR/ep99CnsNzEKl
	uxy9irpdRP3lI0F+S8GWszDv3XvnoO5K7HDWC5hFO+aYr54ak8QByokmcKRi0f13OjgmsXnfEUF
	4x9ajqxMx900eAIHbHZ16RXX4VJx7FeI9eiBMacs6TuhAjM6xPst8IiMAJGgnPhZI8U5NPDuj2w
	ZjarcEmH6QgWmHQ+rb4kGGgH0gJnJp94l7a+ZV6dUGsgsYi7pv57P/TuK4i+X5fKdqKGty38Qzn
	giROBS/EGKCJ/0JsnO/Mtbk3BUhIsUP99j6mMGIRNlXRcXbIOt3YdEFgKE4KSmln80ggV9t1hcD
	ONDCgKVqBBOWx+/q4zwVptSGR3LsuxpKxQaXOE
X-Google-Smtp-Source: AGHT+IFv5GpgGolY+Hm971OnXPqumtM8dOJ/xZWxT5pLM3JhzOyMQkgCUWKBDEgNNeae53lKPk0A8A==
X-Received: by 2002:a17:90b:2f05:b0:343:a631:28b1 with SMTP id 98e67ed59e1d1-34e9214e781mr48976231a91.16.1767603088314;
        Mon, 05 Jan 2026 00:51:28 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fab12sm5631951a91.5.2026.01.05.00.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:51:27 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: deller@gmx.de,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v1 0/2] backlight: gpio-backlight: Add support for multiple GPIOs
Date: Mon,  5 Jan 2026 14:21:18 +0530
Message-Id: <20260105085120.230862-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch extends the gpio-backlight driver and its Device Tree 
bindings to support multiple GPIOs for controlling a single
backlight device.

Some panels require more than one GPIO to enable or disable the
backlight, and previously the driver only supported a single GPIO. 
With this change:
 - The driver now handles an array of GPIOs and updates all of them 
   based on brightness state.
 - The Device Tree binding has been updated to allow specifying 1 or 2 
   GPIOs for a backlight node.

This approach avoids describing multiple backlight devices in DT for a 
single panel. 

Thanks,
Anusha

Sudarshan Shetty (2):
  dt-bindings: backlight: gpio-backlight: allow multiple GPIOs
  backlight: gpio: add support for multiple GPIOs for backlight control

 .../leds/backlight/gpio-backlight.yaml        | 12 +++-
 drivers/video/backlight/gpio_backlight.c      | 61 ++++++++++++++-----
 2 files changed, 56 insertions(+), 17 deletions(-)

-- 
2.34.1

