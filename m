Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348C190053;
	Tue, 30 Jul 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323703; cv=none; b=mV3ozEFwgqQwYhpTcUYtvXxOpZtlkb3ZlAKZWrP9WJ3KRRjMzLgRQqmZbbuameQ2CVbOiQhvMVG6Obl6tCL4gZZFwfMsAYH81e5BbGUtwxPaJ4FNIt/2P1m5a7W4i3o+nXq6bwgVOjXV3kCC/OL/LbKFNmnrrXgzSDW6tcP0RVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323703; c=relaxed/simple;
	bh=IthfG0EQvLVT4Dl0Cp66KroYdXLTIhdye4Z7i1IZar0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czE8A01PjoyibKOOm2luauslV9wuHVwfth5qZvHwTP/JK+LXlZpQw6TVEtlH8F0lPePV6OqeDhPVNnX1e/HbxgRewJUXyDNM93qO2/DsF/FOfp0Oo1cvrb2mAWRiij5c6NXAXfWMYSACAbFFWQTbaAZlC4ED+i0T2Iskefwol8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCrHJ74e; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCrHJ74e"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd90c2fc68so29362125ad.1;
        Tue, 30 Jul 2024 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722323701; x=1722928501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGBS2rpr+A3aPueh3D6OD2pyezLrXyWzp0rS6hZNrGo=;
        b=fCrHJ74encQ/bhUjLJBY+U1eI2o1JW8wB+ntgi2VQacaz4nGRiwol0Qj5DgPg1RqAJ
         BJ6QU21+lazRzIZlSAoDF3GhZR6XBJ3+jg5D059+DcvRodO/p/UnYqldRaMJ2pCngoRX
         MR4aHxQZu0cLDjMxSfT4c5CaFt2b2caYOUQcGncedoggRE1zq2QGOZBlCUR5abu30h76
         gGziAeZo4EpWVE0m+GGR5EILlmPcmrxVpMNnLCnMAdD6rE0gxWfNbsRg6ChQ6lAVgwAs
         xjwjIr2lMdIY1BhpaduoP/3vxXgW36hP/FTZ+Xsh6WHihbKsqspcTLfx779P8Dw4AiyL
         uFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323701; x=1722928501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGBS2rpr+A3aPueh3D6OD2pyezLrXyWzp0rS6hZNrGo=;
        b=F2ugCtAqyoujmCqwebHvXmc9tvsMkYW5quMCVjpLA0g9cQc7LGRtm/yZEd/uPOZ5jO
         +Z/l6w7BkJsULD8509RwtKILJsc/XJk6KhTP8aPOD/5nEoFT2dS/Sw6Z7qSzFwzKS/VA
         n1xl9cSU760RW/yFllxdD8hClryz3mXu2uXa34MHo1gsG8TvVWqTdNIBVBLAnZpiy2PI
         /w6wU8dysMmHx6b8hBy9nfW1BWUIBVzRjo9r0+HbeAj/rR9uQld46ZIKhA3223/EbfUt
         KlWcPhoKt0IsYnMcRp0K1MbkPBOVbFD7aRxyxSSYeSwlsGjBovyJssuCfHQYpkmGdiYQ
         7ZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCwWk78tmisOX6uyixmzHywl32CgpWIU3xIFUn7ZRbSSmrImOJF7S2N00k/NhM88+oF+jbV68gQf8BQHLWip8wMckw08WiSeQd4cPiudhPiZWltb7RJ7DVWZQEpLo7FXqQJ2HKuCbz0EM=
X-Gm-Message-State: AOJu0YxPZ+UnXtR4HY+RazypYQI6Ft4Z2+NrKgzV5Wybz74PF8It7pUx
	l5VQacvutOuY1xbxMS92LvEjzEzdSoGK+Y+NYcLdY4+VNFwipaoI
X-Google-Smtp-Source: AGHT+IEqaChifI36y9GRjZ1BIZXEH3NXZ4BPZ7FAGlh5To/g48a+6rZQW8YI1/pp2Aw1QDfWYAHgCQ==
X-Received: by 2002:a17:902:fb08:b0:1fd:a72a:f44 with SMTP id d9443c01a7336-1ff0482b8acmr64992035ad.17.1722323700747;
        Tue, 30 Jul 2024 00:15:00 -0700 (PDT)
Received: from c4897d9ba637.debconf24.debconf.org ([116.89.172.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa18sm94810815ad.190.2024.07.30.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:14:59 -0700 (PDT)
From: Sakirnth Nagarasa <sakirnth@gmail.com>
To: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH] staging: fbtft: Remove trailing semicolon in macro.
Date: Tue, 30 Jul 2024 07:14:55 +0000
Message-Id: <20240730071455.37494-1-sakirnth@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <sakirnth@gmail.com>
References: <sakirnth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpath warning: "WARNING: macros should not use a trailing semicolon
in fbtft.h:356.

Signed-off-by: Sakirnth Nagarasa <sakirnth@gmail.com>

---

Hello, this is my first patch to the kernel.
---
 drivers/staging/fbtft/fbtft.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index f86ed9d47..45dfc92b8 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -365,7 +365,7 @@ MODULE_DEVICE_TABLE(spi, spi_ids);						\
 										\
 FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)		\
 										\
-module_spi_driver(fbtft_driver_spi_driver);
+module_spi_driver(fbtft_driver_spi_driver)
 
 /* Debug macros */
 
-- 
2.20.1

