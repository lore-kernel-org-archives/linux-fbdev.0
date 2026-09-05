Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A804A13A6
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612286; cv=none; b=VdO63oxiOJ/lRj1NEa5j4A3jAQKKWpSiTf9ShXJUvUoD2bOOtWfvlJ8SGlzOaQpkMA8YQ1U8uYjVNPgQa3vEC+/vBtiDj8D0qwPW0S0pI4jle5f22UHkJ67NW1Ef/d09FHZCXJHVm7eer7R+K8gQkmwjMLUfNzFYzqUoZMnK9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612286; c=relaxed/simple;
	bh=fqRQGN2NtOQEQ6U4DtETKEyMZbTPYavOTcCPLbSO1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYzSmqw7H6ClE/ejV0jCFs6gLUMRUNaMCQm7NfUkeIfN53gexoDtwKKtSgjgbW7u8y1HmmGszMQZWiH4oDv2hzC+uiLX/kRjAr3wmD0l1u6bAosmFcthDu9hD9tjEdAYJnNNuree3MHgeU7CgseH4QIYvyPSSBClDrd52QKQ5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxA+t2+o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxA+t2+o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1353635b3a.1
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788612284; x=1789217084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=kxA+t2+oXL2x7EMXQO7yKd8Q2TsrzpN5J8KcJOxJtzo8UCq3Pq/eQ6OvRiTbgGBKxU
         FG+jB4lrUw+ogJbMGc97bJp0QdX+qQ3BK2GPWguDm7swABoeHQMsqmGcQmA97C9Fwg87
         4yx1Ama1LFuuEwDwqpCNuCA44gll0EabgP7oCJwFKGpQ5NOlDYja3XbJ0+PkaGDAt5RZ
         +xf/jqCwbhA94ngMM55TRADZAAVSgHx55/KmIatYzZFnJbkstYvE7oH1T76VfioL9+T8
         Fv2sShwtLS4PLZy6xiVs5TQmfgI+fDgrCi1pWTrl0JpdRy1g+SFUxkjJy4RjNKv418nJ
         7V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788612284; x=1789217084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxz4lmsMfRQxpCRJ9peAz4eypsaiH2KPm1iFXpwcLu0=;
        b=TWH6pPIYYxZ5tMnVbO+QAKm7NMMXHVtKsIjy+YdxlFlk/VAIkuMzb98m4PCdZ6yfTi
         QDajdU8g8AigXrMZAnNueK9SvFWfw+AHQRkTeYUDYUXBgFCo7W3cRGDmihh35PkucIKT
         RRcftkqoGMmoZfnK3qU1zptpXMTXuXspm0Qzop+Y7TkjVQxJJtEpWwKVmVCxLejz6nfO
         yEIbkkBjbUj/UQGWBPmkfFDyGdh8usuMQIwvV0lQnUdCYdYS4IEnKxSZ5gVKi1AdyHtH
         JD6s80erWGS7Rn9nE52LngLELboNMFs+bk1zlEqAL79jdMH2ukkq5BqoKeSoND4wuChF
         Hucg==
X-Forwarded-Encrypted: i=1; AKwUvBxNPBEX94ngUt4iVcfMyMSIbLwvFy3fHuVjawCtziBEgMcGkHkRAfsHOeFS2DSsf6m/+WBD87WyHR6tnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m64wF8Mjr4pDVEPgd7Adc6UYc2pfZAYqbQvP5AeKMoLBPU15Im
	eQa0isr1CtDoewRkclUTPTQb9J5r9UDF7XkwpJ5IUdyOxCrMIXWgUwfa
X-Gm-Gg: AYBFou01ziu7yoUOp9jXAepLqpgc1rUbpMVFbz6D4TVBF0I7hVMD9OcsrUE5TjL6Hx7
	W1ymWUZJTHpGObJoAuvwEmOTHDrhJdeDy8jcx4WlwSGATcRm8i+oNJw+CYPTtYcyaEQWcowbeyH
	NB18Mmtwnk9LzFMtLJj6/LMs8CJ74QjGvZU9oX5xxLh8uXcczjIV3eVelOPDszSwWkAhU7HUdLj
	HlnS+j9io3ZtzOl4u85TcxPLulW6XMd7TV8CWvUsowhN95Ye7h5H0qd8tdtTolyS9hrean5Ifxs
	fzpykY/QZ9M0wA2Q+cwaWDYKWoHBBNu3qngwJP6DXHeGAhtkBY7T4Wy9KrrTtaRmNpFa5vSRe0h
	8384fv+EtRh4yqcl+P2c36m0Eq2wuP7x3iMIgSxU5sYtPpalain7q9o2h/j9fsMq7nlWU3m2UJh
	LT76PiqJqMLygQNOCarcra3utykaEwVamqdywNEb2RlsE1F1aOUinGUZntWkWbpUZaoFHbPqr2o
	r1YE9CEQLDQnb6nxER3ZMsqcVX9WfTsJD0hP17e4bAa
X-Received: by 2002:a05:6a21:b97:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3da3a0cc429mr18182599637.23.1788612283674;
        Sat, 05 Sep 2026 05:44:43 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm11740417eec.3.2026.09.05.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:44:43 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v7 2/3] regulator: mtk-spmi: fix Makefile typo for mt6316
Date: Sat,  5 Sep 2026 09:44:33 -0300
Message-ID: <20260905124434.6163-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905124434.6163-1-breno3011alves@gmail.com>
References: <20260905124434.6163-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a Makefile typo that incorrectly placed the mt6316-regulator object
under the old CONFIG_REGULATOR_MT6315 configuration flag.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/regulator/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..f81d1f31a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

