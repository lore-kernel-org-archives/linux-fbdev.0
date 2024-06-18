Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB816DC3F
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719359; cv=none; b=Vhl998lFxLdyrqQcW4HROdFWYTjkVWZdSd1yOsGO7hGMPwWMqal+7rKvb5R9vdetAE3ya7REPH7atmSodbRgrM/6iGjN6DkiEsGOGlIb4pQZz+Qkkg3NAjE39Xlnoihgx+ROytutAoT/QRw2Jd5YnzCD2zfll73QT1Wpred6C64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719359; c=relaxed/simple;
	bh=fMDqf1KM7W/RA77rezMz3nE602KNHtmJiEMO09XyypI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mutdELBoTBpmmvvjX7TYuhuRVJye9muGUs8q3Birl1dLHkPb6XV18rs7a8ykG5L7ZRgQheI7hiBHDDQId0wgwMHvd6+3Ky9Ao8FIsHmd7u/h+5ruUEW7FDJVvjG/EeVCtA3zLIAxLEWcrVuTy4pWDo5jzkiMigZxzMBDTwtQJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g8K4zTrc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g8K4zTrc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f1dc4ab9aso4506277f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719356; x=1719324156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=g8K4zTrcB5EEc2FjvPAPTibOgigNssdsV0Nav1MvTRwvBEVeKKcNyCf350+kHi1RAH
         vaDci42ni4P+wOPxWdToieOVNFY4ssEsd8GmFNH6B0p6BFfsYUOZ6li14l2kfbJZI7+u
         5aF9XLQQVHY7zqc71qz5/tbc4wnAFU7u0xv8EA89jwNXgOdc99zzCEnqohzanEDLsYzn
         d4FjMocb0KXlkvti6BbNhsXCAr/dG5cR4M9tEDbvp0lwSZ4QmmZ59/IMivxMe+204EBr
         SaGcZzGpz+KUk98e8pFOc63fkqgOYh7RZZHCom7GJmd9ovd9v2stUaSwGHx/9G42oyuw
         meOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719356; x=1719324156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PSO/1gMPYozHX3dfKEvclJiI5tF+MksrCbjn3VycYQ=;
        b=OX4vf145gL6NLWPsu1hSE2IsZBZHCLPKaKZC8gEs9jYerz84bqYxTZ54AxRSP2wVqm
         leFSforUYmgrdsEtgK9XTJzlnNTFsUee00w5xsV01U6i7UiDJLFjU+c0HeMsMjTncT01
         +pwBQXQ68X7UiQi83HB41mUwPwQVQUvOCV+/NBtSpY/MhBd3BWoGer4/aopWDK5SLAaH
         C8XmjMivco0lUc5nEMcihKhdRpT4n1x2itaP01W1tTrsnfK3ierPg9n27+9QBmm62ZsF
         lT26elx0P3wrwAR6zfXQw0mtKbOTJ3qpkFFfGmGWsirTKRUSZtvFqYZ3Bz9TIahgCQfH
         o1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCX9njwuH2Zd38LWhPy8j6yTSFFbQ791tbTytJ/+WOTej6kNidddtaTSu0e0VON8UhECLBBv6jHjaZxDNBBb351Ru8RvH6LHKP/logQ=
X-Gm-Message-State: AOJu0Yy4PclLuB6XqVLFIhMIBjf9VKIJw3WzIZbbwmV+l0T1XLE3/dCt
	zXGFCigtagHcaqYeVOvqsI4qMk+1O2QHxvFCXXyn/Kt+pmsm+8g/Ybl82C3EVF0=
X-Google-Smtp-Source: AGHT+IFhaLPzqepPaG30Gpc5wKJD8gFH+IxtsauFUs+mCd/Kver+eAIQm2Ywl7oZ1ItrgT/c7vP4Wg==
X-Received: by 2002:a5d:6192:0:b0:362:6e61:a342 with SMTP id ffacd0b85a97d-3626e61a39bmr1041071f8f.36.1718719355495;
        Tue, 18 Jun 2024 07:02:35 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:35 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:34 +0000
Subject: [PATCH 2/9] dt-bindings: iio: adc: adi,ad7606: comment and sort
 the compatible names
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-2-f1854d5c779d@baylibre.com>
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

AD7606-8 is referred to as AD7606 by Analog Devices. This comment aims
to avoid confusion. Also the compatible names were not sorted by
alphabetical order.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index d55c58400df5..00fdaed11cbd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -20,9 +20,9 @@ properties:
   compatible:
     enum:
       - adi,ad7605-4
-      - adi,ad7606-8
-      - adi,ad7606-6
       - adi,ad7606-4
+      - adi,ad7606-6
+      - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
       - adi,ad7606b
       - adi,ad7616
 

-- 
2.34.1

