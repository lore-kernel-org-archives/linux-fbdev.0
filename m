Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A51C230D
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586125; cv=none; b=QZeUhZogUxiP79QU7jvEgMtqhlnxb/ctMbHmfPA0YTiq9cnLvBRKoU0KBW7LA1pk5wKmPP8yIBtJDNma/1fnvbWy65zZYExcLgn3oZk8jsWVzWTx9wUdHsbNSXA1McTrJ3xTdXtNsVKJeBpMti9aF8UfwMVlqdHRkia7zBrtyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586125; c=relaxed/simple;
	bh=KG+zFgPhZKlTNWnyTH8PVKe53m37TBYEzUhO1FprBcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vdn8/I7PGH3o1PefyyShimAiQS4cf5OeFNTIuKcBZq2kt58omtast9dEzvU4oBC1AvyY6xbDlhw0ahiHro+mIHzTQWNJSY4ZMWkDFKAh0itOQOgTHPnBQ1+7qifE3lsotCuZj9PgFfh2AKUt5/3f3xeQ+mOm4ZasVWNgsj61Tis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rxFGujD1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rxFGujD1"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42565697036so11352465e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586121; x=1720190921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXCtOPPk0mXR2hghTWte0gDiaQ2iQV0q2v+Lpx73cVI=;
        b=rxFGujD15SqFodEFf7DGkR11ptD6VzTmG28EzJm4fxXmLwU/zM4kxOADRkka3ms0Wz
         j31PbaZ8Qpq08F/njmc40JoF1tGOBCwntP02BlaNR42nO2FY4aGLIl8yRT6MMbKQTsbl
         1ThIQGZn+/MDrAFbvZijM+9tIw58puuySbTk/YJdn3KhgXQzIa74+fwN5ieqmSPNRG/o
         YYCYPYwmHnJ2ihQgrZqNOYs+qOOgMXmtSOkOcAuW1v2nc5blGGioOsM51jjV9IgyeW6D
         ZI5kb6InPQeBlLKAuhKiLtu4JYSYhVkpJO2V9+bcAlccsklyMrsYdiUMtl8vic7Xm5br
         3t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586121; x=1720190921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXCtOPPk0mXR2hghTWte0gDiaQ2iQV0q2v+Lpx73cVI=;
        b=diodGKgObGHNu7dySgkqCp7ahi5MAZx+8kfXp09COcdelj3Yk/Zmt7wAL8YqhCLVHL
         eKpged395QifwuCXWLAQRfRiFKt8OsJ4hPJ93zk14YebwIYKg/hRWPjgX0mhwACmXys3
         PZzIW1KA6IC5oZtOXhp5n2+KrXblcmcYF+6cLcRbq3Tf14/XFaYx7PlT2dh9LzpSt/iR
         /NdutNJlGEwJDNquMPQ0B6Tt8A9CcOV1xO8pK6DtQ+t7MVS7r5BhcLjMnAXf/8ulQZB1
         ZQ3PmdA7FGBD5OA27N6+dF1Hdbgbmiu2MMNZDk2ZFLcFPXylBvW5D1Lxs9mcT6NCTFFr
         XjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpqzCo/gpV+d/ZwuWT8UP6F7GzkQ/pMA0MsNlFJ8RwZRg5DiPhHMPDVGy5Bkr68xcOH7AMituZIaL/JE9LSOXt1Oo/fhoWQkbrZtc=
X-Gm-Message-State: AOJu0Yy1l2YkT9XDmCY8uSvZZmj4jzckYEQsXOiLTABFgzVDq1Qvcky1
	yjdzsAVcoKWQkW7B4aEFysOO00L7TBXat/eAWUIkYM0XSjHrAenN3x7bSEtB4SM=
X-Google-Smtp-Source: AGHT+IFUYH7Uc5K7rfzXLLQxOm6u8Fd/5RQ2WkQVjaTjQbpyYS7AwTX5otCgN3NSe8nB8PBMHiSj7Q==
X-Received: by 2002:a05:600c:2489:b0:424:aa73:83e3 with SMTP id 5b1f17b1804b1-4256d53df10mr18738915e9.18.1719586121172;
        Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:24 +0000
Subject: [PATCH v2 06/10] dt-bindings: iio: adc: adi,ad7606: fix example
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-6-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
available for it. So remove this property from example.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index a1c38a5812f7..626782ea00b3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -153,7 +153,6 @@ examples:
                                            <&gpio 23 GPIO_ACTIVE_HIGH>,
                                            <&gpio 26 GPIO_ACTIVE_HIGH>;
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-            adi,sw-mode;
         };
     };
 ...

-- 
2.34.1

