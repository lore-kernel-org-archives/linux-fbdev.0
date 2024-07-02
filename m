Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77371C0061
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jul 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941653; cv=none; b=ti6+NvZwzZrz0uAqITdiOit6g6LMm9guoQXdVco7fMfiDF8/gkupD5Bzg7u/EqYT65CWzXPP9Zl5qw9oYBHf76vgZlnfszuyAPOqNHhTnQrFW2wkoIC3qBV/Loel+CBifyKfYvCQHETV7O+hOc37kuhrnUheu5psJQzYTwkflAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941653; c=relaxed/simple;
	bh=nGzK2S78m0bky0xL6X4TlkILzMXZbw7Q567KAtyItso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFEbRVa//Z3TMFcYe/0BR0oi4TfX5wwBxKm2ywuJA/PcfDqHAZFxFVkopWDL0p8VJTbGPBNk7t0rLfoZXY7hC8ikxRxyoQ9jUFtLAzgAvwmHI0j5UefL0BF6va4IArc8XPNuEbViZX+Q8aXNLQtiCaqpHHEZwIThZW6dw3E3H20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X9OwpT/G; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X9OwpT/G"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e93d1432fso351286e87.0
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jul 2024 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719941649; x=1720546449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqVxrCmaqTdd1OivUsUaCiiNGBxmmQjkW28fKPO8hWM=;
        b=X9OwpT/GOyRvGYNRAocpe5BorQ35LZ8cPEWEfpTR6VVmG/PAiBclZWeABUcaqBY7qh
         LDPrH3wmj2M9egaLNVE0QXywMfeRljb3nFTSSHVEA2Fq6BttdiEj5Wg1LvIhwsPo3FQN
         YSjl8QJTLn5CachTFU1FE9zAyxIYewQNASAbijE5rrbCTLor6iymiVQlZGI3yH81+hre
         hmhcxSoPQ6mjcnmwbRKMq9gwBFiRFv6XD3dcXiah3zLKRFZiNea74dhik8S2mz6Ho3lL
         t4WG2pmXB7JXCj9SJxI9Vc/mfFhv7GyeVtS+zPSNqggUVVSPskvwEtL0EMutxK6dI13F
         TPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941649; x=1720546449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqVxrCmaqTdd1OivUsUaCiiNGBxmmQjkW28fKPO8hWM=;
        b=W9tRvgQMmLmKj2pgDZqJ6+oQFYCPDYIndJzoxg4OpD3X1OEALUOr/tni3uXYxNkn9S
         7GlviKKrFt/4BRDuBJ3HiHmsIU5iSQys8Lc79IeVFUVUGAXyJdj87JtUawi7p0hdBsBA
         p29Zu3zaYFsQZaDUWgX9UV9SQ2Npwinlaldxc+Io/PeS1G0rmc8Zvz2H7BQLakACbcht
         SFVcHXjduteCnmnpP5v5z5t38whTpBGQWObkP+662JVtasnQsjhh9YgzYV9uk9gaGfJr
         KpLcqY4Puh9XykCAVQGQGUb4YLY+qF4lDRfy8Lx6aOKR78P6lIU1SeFybfqWq8wg0RdM
         /l3w==
X-Forwarded-Encrypted: i=1; AJvYcCUM38CGjCuMNu4sEPjlVESD2/pW9ZtQNrH9TRoA41EjT2VkX1NgNIpok5qQvyEYW0aRP5RxvdML4myaDtKQDQxg2VNpDXzWAcBOr0c=
X-Gm-Message-State: AOJu0Yy3Lfg+KSO9pJ0PY+zYf+FACWU8ZCccoz2NrmuA16lSW9U0UWuA
	ZlhUVwe665JFrFRp76gD+6JD31M59gS/A3ysA70Rh4mBrt6E+2FEoaFQQkbzoxk=
X-Google-Smtp-Source: AGHT+IENS/hi3LdGvHKX10bpeZAX/pN6vBzZfnzLA+VvEBpaHsDKR8zQxnIVkfkUxagS9XQHEEGRZQ==
X-Received: by 2002:a05:6512:3d1b:b0:52c:b008:3db8 with SMTP id 2adb3069b0e04-52e826898e6mr5673752e87.38.1719941648842;
        Tue, 02 Jul 2024 10:34:08 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm207594485e9.11.2024.07.02.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:34:08 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 17:34:08 +0000
Subject: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-cleanup-ad7606-v3-4-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0

Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
available for it. So remove this property from example.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index bb716182db63..499b6ad5525a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -152,7 +152,6 @@ examples:
                                            <&gpio 23 GPIO_ACTIVE_HIGH>,
                                            <&gpio 26 GPIO_ACTIVE_HIGH>;
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-            adi,sw-mode;
         };
     };
 ...

-- 
2.34.1

