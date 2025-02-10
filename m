Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBA2566C9
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203981; cv=none; b=pLKFRuF/piV9zzeSDlKyoYKASW4mG5AAag3E17b2vs4ENg6VRmTwMPHSupmF4sgARYZjU367illIyYy+QdUIWuYTng6yLo/7NZXjT/WiK2+qGPtgal7Ykzqkn1wbvdHlEQ9tYx0gBsEsfii6B8Bc5XX989EEe3LH5RE4kcdcblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203981; c=relaxed/simple;
	bh=EYN2jmjQpt0Relr6D6FUdK13M4l5zeXDuBWC3e77YUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq+tArS2qgZUJfMdDuTuOq/13f0Imk+aGKhDxAiRrgflL346E9CG4cdEsQte+DjBsrM0OVc/Pg6PnzDQumB/xc7k1KJ7wRMlnTom9+0atMoAkkDGe2W97l8fh8QqHmHDyHahh462YRczOseiVtHiNmWbiuGhNsX/s5zIM5mahmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FPHLrmhX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FPHLrmhX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dc6d9b292so1819132f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203977; x=1739808777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIjPfuFGXuMmM5B5bh3vlcOXqvUxOsdFQdpkLRhWYHE=;
        b=FPHLrmhX4ts/LCgk7/x3bYH2HAsnyNptf+3hs4tl/l0O/vXV98N6bdaJEht7+q2MHd
         3wv3vg7xXFzhXXQHV7y/pMariaIkHuHrQAlYbBXr9/uFmnIJlTyBw7hOLguJNEp555MS
         cq8woka8YhtXvjRiC+n2PPo3OhHyKy3EuFB2UnSZTkrZfmaIUKnQS8cX3Xe3P5JGVFju
         3l6xIk6/c34RuOSrdbu1N51TKCxYrhSLz+elkzbExhfvWjax/zRQPt+Vs7pFXaixf0wD
         JG5KmNcKQyhAVDSbRGnkzNrA3+2b69hwxcDFdAusbkM67pmSjar7GnH8oqb/0oc/mvN0
         NDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203977; x=1739808777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIjPfuFGXuMmM5B5bh3vlcOXqvUxOsdFQdpkLRhWYHE=;
        b=vP4A6DRgI22ZsLuUJTvtfUHWapgYa308Bbd14UBf3oO2/HIr0DfyisxOj4lv8WB79I
         q64q4vmjNuWLeZmURaR91imB3EGrSuriojchnXrVdK6mgzbQNEdlFkryDgQsmFbj7ufR
         8fTPQKps/dXBrnordDFm98bOyVsndXIV7ego1DpgGSvwHZn4SN4cr1XQb3pD0Qs0ppZW
         0EOLh0lEAgHL123pSJqx/Crzj0EW9SMzwEAXeV2T6PQz9Ipcctb9+dZpE2LC1CpslD8V
         8ezY6ACdJOHUJPAsYfelgTCaGEkFZyDHTWtYjHOs8X9nzql6ANCfJxmOZize8crsbt6m
         vRXA==
X-Forwarded-Encrypted: i=1; AJvYcCWgnRZTTpV/gyTNTjpHkgS1LAjtcFItt6vJkur/zc6MCBwQRSVJVM0jFVL70YRYShYyiXFaOpL66TY2/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwudjCvR2wRsRtd4Hm8D0l8pz1hUN2u95I8NU8SGAHGa0q+CMLZ
	CbiKs6ZWIQKhgIxc+9eDBgYTGwbWqJ5fX73qXQxaEORJ+vExNLgFC8qiEO7mvx8=
X-Gm-Gg: ASbGncsGrkaElubhwTIXxLfPQ8VjCn061eHPNuBB1Ndyd43XUDzIoN9/MMPw4STJT2b
	Qx/hmTZ0LFI3rh8oL2YRaf4QhW55FCepc86k7T5e+0eWRZn1m1rcrqK0ReXndI/cGqi1R8QkURK
	N4/qNQUZSwOnqNyGDcnooLTYiFw7MJ6BXYjJPvmjkGyoJX0GAHyRUHBRVDdq8ijnlx7EMu5Gjgh
	zHEODVcr0gO5Z4iwuboI4GcNnWym4r2DzErC3iHOPTFEyXsc0wTNy9DchTbFIhw6PmdduXHuDQt
	V1+nCDX/Rk5nsOhc9KtV7lY/iAFO+Co/ECFYdPvY2kl+3UxFnU2qiMWXHHHEhiM=
X-Google-Smtp-Source: AGHT+IF8U4g+gzBJ/cIqcckdV7LgaRgLDwbSHf1t/ZRLRiATW6wIMx/g/+6UZw2NAefFPk2iWnxLJw==
X-Received: by 2002:a05:6000:1787:b0:38d:ae82:e5ed with SMTP id ffacd0b85a97d-38de41c3d17mr166768f8f.51.1739203976810;
        Mon, 10 Feb 2025 08:12:56 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:56 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Feb 2025 17:10:57 +0100
Subject: [PATCH v4 7/9] iio: adc: ad7606: protect register access
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-7-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
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

Protect register (and bus) access from concurrent
read / write. Needed in the backend operating mode.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7985570ed152..07656fdd602e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -862,7 +862,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		}
 		val = (val * MICRO) + val2;
 		i = find_closest(val, scale_avail_uv, cs->num_scales);
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		cs->range = i;
@@ -873,7 +878,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		ret = st->write_os(indio_dev, i);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		st->oversampling = st->oversampling_avail[i];

-- 
2.47.0

