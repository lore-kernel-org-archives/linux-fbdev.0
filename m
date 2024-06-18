Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA416DC2D
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719359; cv=none; b=nfUCS1Ox0QWESiqTuaxMByJLs8Fq1RmiommcNn534wV1Gjh+tJlCJ8QHTyAwEiNxclcbW4ykcrAzdwe9e+sy4Oq+JW5C04vwXlhxhGU6+hKEoCtlVjBuw7zpNfWEI9XR3Ld/FpnBsLWP/OUYFLCP9m4HRd7O67oSA5PzButnkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719359; c=relaxed/simple;
	bh=PLtj7bSe++tHU1muE0ellbCUBsOVwaNLui/U8TXTses=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrLv0HIR1+xb731nZV0MmTH0hRwOxZ2osDkuOwN5PSmrXyRu2KfE3qM5ymANFmy1O3m6T8DwN1GY7Znd6KkDK3vGJBabmGG4571uiv40prHw1g8z/kG2ZJB6+CFHHV/QgrjuZxhwGPz71/M3EF/D95/DDc8CtrqLw0W9439A6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vypcjnui; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vypcjnui"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f14af40c2so4574739f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719355; x=1719324155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJg4U+PW9Snx8tG5VLs4l5kg/oNVaqq+3EVHHkcbQfc=;
        b=vypcjnuiJke07aPcLopSP2JneN2mnNHmsXw7xgLzXa8jq9pBV2NnxEs9W+AMySMcgx
         FPkt95Cny9Mdqq2ai6lF+rlm1p1WW9eVGUSCXhQT3AM3GENw2atiJQXAW2GK+o4WOtZZ
         Q7oJWFTF6MilkHHPKrpD90AS2Dvl/4qG9RHqvCkun8W36XnGuCK2WEz0fL7QFdPUXWp0
         rkKohkFRmS5HFQbKZsS7dFJI7iM5uv5J9+Nw5F/qasNfFHJS/vDk5zMpZE6cO0FT1m58
         Z27OzAdR0/8QGEE+zIwpmy8iGhrz982wj7bLXgayPypcH9dCwNfb+z42JC1jhOQwIYFw
         IM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719355; x=1719324155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJg4U+PW9Snx8tG5VLs4l5kg/oNVaqq+3EVHHkcbQfc=;
        b=agx7gAvmcOqD9tKlZjzTfGv5uzfD3ZoDuRlXf2JgUI3oDN9kI7ka9a+0nbGUClHcuj
         scsfdejS++kMwiP8QZHWLLRhwyGANHbCi/DbGi5+HdeSgED8YFtszPA6lfMioin/OflT
         yIwVapC5fXdpO3DdwLRW/WGMGR5Yv86f9NAzu1sLMjvLMD5AmwC6Ge3W+pttmH5paHiL
         eZW6IxS7N7m1rpu0fYsx/eV1GvwjVWneYHHiXdFsdeZLfbonF7kZ9Oi8tpEuCjZ22cu1
         sVonx1/6o2v3QZhmhrdrGHZSEQmG3Fxt+G8HvxOBkSY7xN1SDaN3lj78SzUAfC7BbLHq
         UeCA==
X-Forwarded-Encrypted: i=1; AJvYcCVn7oZKu6ZHjzl3pVQpwuksEMzL76DVx0/oXx+Wwfvw12hufXYuN6SuEdibzCk28ozIR+uP6r3QFVR462Uix5m4K8kJGLfgREB+HQc=
X-Gm-Message-State: AOJu0YxDeG0e4IGcuPeQ29tcgAzYdL9i+b7KSY4HBWmSbypiQvHOBkTo
	pEW/04KckX7e0IaV5SIs1Qye/ypcNeQ9Ry/nwD/jhZd3H5WNeF5yA7sV3KDMujo=
X-Google-Smtp-Source: AGHT+IEpUUcK2t2NT0uyE9LsIkX7F9ePlZPM6Wgs49S7h0PwgLnOw5XdUvtGqV7G0aa932wJUiWaZg==
X-Received: by 2002:a5d:5607:0:b0:362:ea80:db0d with SMTP id ffacd0b85a97d-362ea80dc64mr155775f8f.11.1718719354954;
        Tue, 18 Jun 2024 07:02:34 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:34 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:33 +0000
Subject: [PATCH 1/9] dt-bindings: iio: adc: adi,ad7606: add missing
 datasheet link
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-1-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
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

