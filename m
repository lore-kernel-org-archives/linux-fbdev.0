Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37A16DC13
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719358; cv=none; b=hdrzr+KvPyJYFKs48tL8X+z4AntDwJXkdtNvD+sWAh959cjEPZKX4ujsZ5DbPQjS3fcnqcIs3XXetKXHivkM/H2COO4EGmN2uiQPyJa0sXjupiCi/jCmPzuL6lN2/sQ6EEAtANAW85pO2VEG9D3JczgHXCwN5gAcT4yupcEONFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719358; c=relaxed/simple;
	bh=dQxXp9Op1zTGeFN8lKe401hgz5qSQTwXXD+bvc/TFcM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XQSZ3fNpn7fJFXFOEvezYx+Cb7ccqkxD3NK31vr27sZCFVUqQOvCB9WW8+nBvR4aaf5iruWIE3H6sQ02oAaFEKIpE9oEH4IhbgTeQqgxMq0hEqgK6kHtnN78PC/DSmnq4Vp4bccswZPC3Sw7t+GFLF32BmhLumydZo22FsgL/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YquMQCKL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YquMQCKL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so43097065e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719354; x=1719324154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fySTWzP7+2Q4hnnSyXij3ZpjveKlFndsAqH5BZexb8w=;
        b=YquMQCKLSr+dQ5OqmcKk61B3NmSeoZK7G3VtifXDN/Yu5tfTV83njaPyt2wMIqyCo/
         gup6dqaL5rAGYWZjk5FoX5vyVaMtWh6cr9hNB5UjNj8qJerWZ+ln4Q0oIir5fMP4QQzi
         9IUu0KLtTPpBEr3ndc7PIRdLvtVuaDmqwrgrKi/NBo8RvSUYgD1M4rk/leAsM3T1ec3I
         cbjsTwsbuMYKfjUjc1svresGfHs1ovu0hxfU5+NjEMtOBTMUgOxqsxKSoCFq84xMo0v8
         zopspJRFb4ponLJ7xPfnypO39WxvcP4WJkbuIxrrMqDH8FoWjns19Kk04VHtbDRQJs4V
         QBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719354; x=1719324154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fySTWzP7+2Q4hnnSyXij3ZpjveKlFndsAqH5BZexb8w=;
        b=WBRPid0leV8siBKRYPvjcdnkNv2TMT34LZQhVfDpDl2zfidp6D/AF3c7hgXsorAtjf
         QKhjsKiVZaaDvSSKLL2sY+m7WhYPsfyBYruf/8JkzH+LBYAR34WUZClRIRivLfCfrzF6
         j+6Z0LBUO46HrhEZkdtd02mQOwdUYawfmcy/bR06Db1tOgDN9W/DBYLZbe3qGo+DobID
         jVLuXtjfE9/3brRnJB7UrY10nxS4uDZYTkPaAE1EHXCIf4AwrJMtcKp41FyUh5TDUd/W
         sWAA/WMRvwIAj4srX7M8/5FHuntkKTxp0xG0Npaqs0ah8jgg+EW+7Uzzleyf+OvsMyyZ
         JU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXaEIXXOpS+2MCBig/zztVm83kkY/ymvxtr4FyzFMl4OVFMb/jUj/eUFCs0KyyyCTYfErtvxYFSMy4Tb5QChVBbcAsmvIvcIQInOo=
X-Gm-Message-State: AOJu0YzsBYEJsRIG7xEaWQbm28VuyaWQ/UKtZxKAm9d8USaSQ+2B3hgW
	kGVBeA96rPcqp2mCG03e1TolhKWTRMs69iDeMzvVBcDQj8dfAffLbbVKhi6ESTA=
X-Google-Smtp-Source: AGHT+IFjv5B5zrwnrKG07bNRwmngFblZ30ls8fBQs0cX2uPWV+t6prLL9CNFqYpst13GA6h8bFeT5A==
X-Received: by 2002:a5d:550f:0:b0:362:fa8b:224b with SMTP id ffacd0b85a97d-362fa8b22c8mr15107f8f.47.1718719354290;
        Tue, 18 Jun 2024 07:02:34 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:33 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH 0/9] iio: adc: ad7606: Improvements
Date: Tue, 18 Jun 2024 14:02:32 +0000
Message-Id: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiTcWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Mz3eSc1MS80gLdxBRzMwMzXUMzw1Sj1BRLC0OLJCWgpoKi1LTMCrC
 B0bG1tQDo3breYAAAAA==
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

This series adds the following improvements over the current AD7606's
driver implementation:

- Fix wrong usage of gpio array
- Fix standby that was documented as ACTIVE_LOW but handled in the
  driver as if it was ACTIVE_HIGH
- Improve dt-bindings documentation
- Switch mutex lock to scoped guard

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Guillaume Stols (9):
      dt-bindings: iio: adc: adi,ad7606: add missing datasheet link
      dt-bindings: iio: adc: adi,ad7606: comment and sort the compatible names
      dt-bindings: iio: adc: adi,ad7606: improve descriptions
      dt-bindings: iio: adc: adi,ad7606: add supply properties
      dt-bindings: iio: adc: adi,ad7606: add conditions
      dt-bindings: iio: adc: adi,ad7606: fix example
      iio: adc: ad7606: switch mutexes to scoped_guard
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 126 +++++++++++++++------
 drivers/iio/adc/ad7606.c                           |  79 ++++++-------
 drivers/iio/adc/ad7606_spi.c                       |   5 +-
 3 files changed, 134 insertions(+), 76 deletions(-)
---
base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
change-id: 20240416-cleanup-ad7606-161e2ed9818b

Best regards,
-- 
Guillaume Stols <gstols@baylibre.com>

