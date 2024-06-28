Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D671C0053
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586121; cv=none; b=RoReDYADVAwhM8VEGVJD+Pv66dXq611oXS99JX/PR7hJidsHYacZc4DjLQDyzy8ek8YeGv2d+hvb5fc4SOWGsrYmmXvn+AUy9pd+3BYtVZCPMh858hYK0FloknEvVUDOSgNMPTlxX89RoaCg3UHnyajUA22n/vxkmNhztGN1r+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586121; c=relaxed/simple;
	bh=PLtj7bSe++tHU1muE0ellbCUBsOVwaNLui/U8TXTses=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CwVDP9ueA/cM9YBWQwQuWR6NlSdbFKDzyF/MpqDfTuBAXryFqaqWLOngijYlPq0ruUaeNlAvsL1U6nnyk+7S5s29J4nDxdOEEX8xdmsazszBm1NEO0iItmoWwg5MzZNVufKJvTHIXgJ8IRxJm4NJX2M4PUYNpsreQeVWAvq81to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v6jOUtlZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v6jOUtlZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42566fb8302so5394075e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586118; x=1720190918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJg4U+PW9Snx8tG5VLs4l5kg/oNVaqq+3EVHHkcbQfc=;
        b=v6jOUtlZtIeACeLCCkYRk2O8ycfb6qRg/MEUNbSK0nsQ6wujLPYBGgHiKPJWTqjbz2
         m7LspueVlAWnBhfoV7BBOAEwO5uORdW3RjH+qNHIwj99m5nExCisGlkPvOlFpMMbapcG
         e5tG5LIFzE+E8q0Ytn5RUsN2OYGGWehui86FNrSpP6IGbUtHZj8p9THStSUL8q+7F4N5
         9mWHNSqrwVLxp73SAHWWRWUTHQSAUFBc/Wpa8pYkoKhYmP3uA0TIqnF3yqviKFg+bU/q
         k0CjSbL58MiJYm0KC7vGvuahzbvOPL6NSTur+KkqYu1fidzSe4jieagZWOmIFi7dhUFy
         ufKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586118; x=1720190918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJg4U+PW9Snx8tG5VLs4l5kg/oNVaqq+3EVHHkcbQfc=;
        b=UldajAJJTD9FUMnat7cPrIuHSY5HEJjJUNSe7GZS2jYWRGDl2SDolnYlC3mqNhfx0Q
         6oT36b4m1xA1UGt0LHaZwZpLyCToeGguyVTOW8ZZP+IGFxA4XaxRMiB/ZSWc/DEWphUG
         RK2D1kxgAYEpEDglGO7OHuZWqJ+hBpq91zRt8vjuHOavw6bC7stwrZ2fUJG9mWh27rJO
         4nnyaGReAQQ2PcirXQj5DR1ZanehtJC760F8eVuJjxkpMComIcEVFCvNkuydMi/PV+Lz
         YUIsyAVDQRt9He3kCllLa+CVrd9X8BdfCj1Y0rA9HPEza3/yLnptUkzHwbW4Dk08xpDs
         TZxA==
X-Forwarded-Encrypted: i=1; AJvYcCVO10zUqhc5MUL6gQdCmUqo0jkqut+B9CKKHl82O0niAjRFWZOtUioXaaMuIMa8oVVOkvROYG7F6FvtATa3X6lbo3wHaXCbzM2R6yM=
X-Gm-Message-State: AOJu0YzR5JPqHWTW06MTv70nDBuwE4T8IUp8TQTYYr9MhnXEXlKWhr+6
	sHkCCouYjhRPGlRmNTa5smtkIGhjOwE4dgBTKsr2fizvnlPKL+knjO9ZRpPVc5k=
X-Google-Smtp-Source: AGHT+IFZJvZcGme5tYJIDm7Fn4HGpd/PyLd+v7/pwoRVXETsHGa6eBvd/qNPMGWqDBbSv0goSqbC5g==
X-Received: by 2002:a05:600c:54cc:b0:425:624e:d80a with SMTP id 5b1f17b1804b1-425624ed961mr46300535e9.24.1719586118172;
        Fri, 28 Jun 2024 07:48:38 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:37 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:19 +0000
Subject: [PATCH v2 01/10] dt-bindings: iio: adc: adi,ad7606: add missing
 datasheet link
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-1-96e02f90256d@baylibre.com>
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

Add AD7606-5 datasheet link.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 7fa46df1f4fb..d55c58400df5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 description: |
   Analog Devices AD7606 Simultaneous Sampling ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7605-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf

-- 
2.34.1

