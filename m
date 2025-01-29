Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39091B4121
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148700; cv=none; b=loHP02UX6wRbV7q+k9Zii7TmG1hudPi5iC+hBClwsk921Vv5c0crMN2PDxexeUS+KH3HGBY12LFWsE3K4GoZ71gJehATCuNvWVUGGtdqiaCkZdLYQRU/C9fQX7k1JNFHN40hQOjONtvpa/RF9VxFaFbJ7MPg8DKcjm1B4dxQCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148700; c=relaxed/simple;
	bh=qTP9VZUeKRuaZ9Hqi5LnAy3vZJvi795fRxc+xbuF8Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBp+FyDUkODv2p35mN2R1WBtia71SPu0Y2BO7FGm5r+HSpCBrIZ1yMnM5VL6btlKrQEdtqTtOmBH9pJMYnveLIrYayfMfqA/585QMC55EoT3Wtpj8KZkNamKskKtrUsi4goESHtDCJrRxeaoRiBQZiTUdyaaqGkE1u8B22p727o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yq/gACss; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yq/gACss"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so3694563f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148697; x=1738753497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjQqajOlG7CxEKLfZvVkKt1P2pyBeTRvUu/sCOgs0mw=;
        b=yq/gACssKX8rQhDMds6SLHK7d7qPBSLXuWCSIA+BltrjAMGOjRDPkIwLX+nm4tK7dt
         nNifzCSqvgDSHrFzAP7WqsR8VN4j/2nwUvbMZW9+4IPEgHiTyzIJPyH9HBufzxxi7q+h
         te0tHiakS2DZ7nSmIq+RMpur8kqNIQWvSyDSct6L7TSC3qypEU1EVyqnqjRiRYcyCmTk
         EuC1yzHKY352syOFjAZDV8gqwSiB34gYZlj8b/TR6XHqO/cylVpUzWQnsStSDjvtIuvg
         pik3RlgR9FmPDxKNoRHWT4JeYwaSnX7mXQS877HhHMkR5Ows7j8yE/YrjCzCN5PWFDl8
         vrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148697; x=1738753497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjQqajOlG7CxEKLfZvVkKt1P2pyBeTRvUu/sCOgs0mw=;
        b=gIo6YuEI8uYWH5CVvsdmAVKpbwFPZjySXXgg70Q/7HEasLGudlAwG+rY+dRWfmR84q
         k25EcS3amEsTOmH98BoleM/ZYBalaJVJZ5/bV484aeE0YuVg+oc4ZYN99hhzWCZQfCtO
         Hz+cPUYlkZKFwLFyLbNgQRxuQDTvkuJ6PXrtvbnJnohX2S9LZalN+54ehX/nok/mxIJN
         LIQamhSRelPSyXwjZcAEVrhNuAES6DnRAg0Kr+vgGKphTgNSUqPt9i0xEl38cLp4I9GA
         4MrMAwVhr0izPYIgtquEaHMnjcxgRLCj0ZIjqydBpkMRraXqm+nuYfDJZAeVPQS4+rFR
         C8cg==
X-Forwarded-Encrypted: i=1; AJvYcCUpqpYL+yAr40OW97KMx3xYUiD0rdoep5wM6wMbzOENXHrU0dJ8oU1NYytkiWKx6xQu6IlqvEA7y2ZBEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kBBtddQXDo0MefjMH6BQGnznJOyYsahPg86jcnklEXuox+SN
	MU0ozu83Ny61KNO5rUM4e9tuKjDeIrWRhISKT4Ti3MitXDmUNgDanDPYInnbymw=
X-Gm-Gg: ASbGncsM1nNZybX3C6KnyjfVO87IFW5wtepFrYiz5KzzcM5p5m6m5A8uu9VXd4lBo6Y
	gOjBA6Jrj3DqoZU8/IqOisF3+vygWHEk9gTzoovjHicJL+NNrb3zYg2l1iclSC7zcQS4/b421Sh
	t9Hx8MgtRDqUNSHMaCUzhrohVvbaNIcPUM/P0dClbo5AA8O1T8HrY4KDVmsMSJW1cwbxLSlZnuR
	J6I+vw5kDpgW77HWy3/392yMPUioiva4PV8IUlh4feljWTlClJmdQghX2DXwsTISJxhV/ZObL9B
	azc5JsSMUfZQXudRbueRom5YD/ri8Oj04oSG+NFOi0zAfv78kWTiE1YxSZ/PHbyQOeXdbnw=
X-Google-Smtp-Source: AGHT+IGuZV55gZIAdwXj62dAal2XvKkGucrO0OnzpAfK3Sa3kD6jA1qfS4afbucGb1xx4G4rVbpYwA==
X-Received: by 2002:a5d:6489:0:b0:38c:246f:b0b3 with SMTP id ffacd0b85a97d-38c52097871mr2095096f8f.51.1738148697140;
        Wed, 29 Jan 2025 03:04:57 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:04:56 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:02 +0100
Subject: [PATCH v3 01/10] dt-bindings: iio: dac: adi-axi-adc: fix ad7606
 pwm-names
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-1-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix make dt_binding_check warning:

DTC [C] Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb
.../adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
    from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

Add "minItems" to pwm-names, it allows to use one single pwm when
connected to both adc conversion inputs.

Fixes: 7c2357b10490 ("dt-bindings: iio: adc: ad7606: Add iio backend bindings")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index ab5881d0d017..52d3f1ce3367 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -146,6 +146,7 @@ properties:
     maxItems: 2
 
   pwm-names:
+    minItems: 1
     items:
       - const: convst1
       - const: convst2

-- 
2.47.0

