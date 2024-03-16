Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B9414290
	for <linux-fbdev@vger.kernel.org>; Sat, 16 Mar 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710582335; cv=none; b=Qdo6om9UaF/DLl7Kt8zstMzlI+X9GOMIZY77oPNGKLvujU39/JOLs3qjwnoeG8KSp0ml+Hv7R0V/96EObkTHq55sAhlzyWLpjNXqbSTlJZzt8ubVvT9IgtUIMUJDO6N0IMl3aoWFZ5hk3K4blcVpZMwMXsBgU/r5AXjv4VMJapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710582335; c=relaxed/simple;
	bh=hbczFDATHkIyK0WzorFo1BmIzgN2WzvtB9k8WKOd2N4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HSCBdmvQJE92XhVt42nSKodRHTjhX7nfS3HmdwbMsrqqhK7BA8gbyhdNV8V1p/CBllgL2V6SJv/eCu6VEA9x6+3HiToFCOUffTMrEgdUZVXhbtn0G6/wTSXpAx9eb7w56X95Q9rU6G8eRZ82OgXCeaKoC4cMRDYo5RNEvU6yamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URsKJsqH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URsKJsqH"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so708729f8f.0
        for <linux-fbdev@vger.kernel.org>; Sat, 16 Mar 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710582331; x=1711187131; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmf+EhkCbPD4zN6pmu9jbRwb1AOtk+4/VyFIevrMxPI=;
        b=URsKJsqHFHevktRcEID69N0aFN6S4C4yStmpHwkKdUdTs5Z0c9FCrBWnLvtWlYVscr
         c3013fwa/nGjaeF2le1XKVEJ+XSGw+4BoZ3Hr3/NS0E5HeuA+8tr+oLa46GRQpquZhXz
         EP61wBYAR+MHyxg2lZXAVJghLXRWajf//W1vjp6vO8uTV87iZmwZ183PLAdLR7UwsWu5
         1RhaJ60ZOz4DpYI+A+XMNDuUXHd75eYtUGCr7zJOOih+/B52OBVb9QRmbBEnLsYghux3
         tMYNY+uw6ZCKgZ9nWUsJNLC2gCQUgpuxH7LJ1uN0khAJM6LzZrzd30FmJ4YVo/RW1X7i
         S1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710582331; x=1711187131;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmf+EhkCbPD4zN6pmu9jbRwb1AOtk+4/VyFIevrMxPI=;
        b=Sjnq0sVfgqHMyElKgsY+TiZ+Kp4HrUtMaEkrYmJI+tP/IkgkiHgKSklEiXVqlcwiHw
         4nCT+Tt02ga/rrHNKoVgGaC4m4/BO4JDO0FF4MFgeuZil31HuYscAUDzFn5Jo/+BgMJH
         FvwW1Dm1B1D5rQD6I+SnA3yUoD0wjALO7yoB2cDq/2YqIAZ89lxVuo6UhPfxP4qyjIcR
         AviBzkWXxLocvrx1sGxqC0HNBBEgQ4TGj/WNds5gy18VUruj16skdd4+n3J4Ng0HkuR5
         Ho4vJNygfN1sxQcx1Y2vxDYBi64wn8ZITT7xZzdRL3AcAWxPsh9SWKRMWpmubz2StpeB
         QWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhWYff+fmnXPpkm+KLiSRzSSFVkTGt7kuO10vS6dlPVbzHHxfv0ZdvDs7CxxfWnzt2dDW7AbHbbz9Nx1S3n9BRm5O3xHm33aoXChY=
X-Gm-Message-State: AOJu0YxhnfOxMqEoAEnv3d/FTVVgdZGukl5WXhrTnuTodU2eb2g46OSo
	yc/7vLSY4mhJyRXl1s5rikI7jDJZDpuuvLNh89xv7i0UJkTXf/EUSmis3ZTds90=
X-Google-Smtp-Source: AGHT+IHauOfu90GrAhcslu1pR8/IgIcfemYw9G775rZSF8H7HGHaPyO9in3oux43aPDC6swiuJd29w==
X-Received: by 2002:a5d:6a89:0:b0:33e:c236:ccb1 with SMTP id s9-20020a5d6a89000000b0033ec236ccb1mr7746624wru.15.1710582330925;
        Sat, 16 Mar 2024 02:45:30 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bs8-20020a056000070800b0033e3a24f17esm5221863wrb.76.2024.03.16.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 02:45:30 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:45:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] backlight: mp3309c: fix signedness bug in
 mp3309c_parse_fwnode()
Message-ID: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "num_levels" variable is used to store error codes from
device_property_count_u32() so it needs to be signed.  This doesn't
cause an issue at runtime because devm_kcalloc() won't allocate negative
sizes.  However, it's still worth fixing.

Fixes: b54c828bdba9 ("backlight: mp3309c: Make use of device properties")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/video/backlight/mp3309c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index c80a1481e742..4e98e60417d2 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -205,8 +205,9 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 				struct mp3309c_platform_data *pdata)
 {
 	int ret, i;
-	unsigned int num_levels, tmp_value;
+	unsigned int tmp_value;
 	struct device *dev = chip->dev;
+	int num_levels;
 
 	if (!dev_fwnode(dev))
 		return dev_err_probe(dev, -ENODEV, "failed to get firmware node\n");
-- 
2.43.0

