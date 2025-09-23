Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852F19C546
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647669; cv=none; b=n7JKg4pRpTDb4u5kBnEIjNoOPSV77kv9mozincElM+SbfP0igwXPRIr9mqabKBAFtfFAPx4sgfHOIzG/qMRYEJk5qXZRYwqkMvGc4y8jjnHF/KBNsPw6W0ORF4B1s68eXshH2l3SRhH9o13YT5iEQmpXzviXBcBphNlVtkzmKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647669; c=relaxed/simple;
	bh=Eq1AOZS62E3U426nVTK/WCGChMfD99wRr7zuaKWdzzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPAw0ac6yvwbCKbwb9v0uIXporrn+C195235f0HnoiUTRPreRxc8ndRveEN2QBxinI0jhh1lkqICRsTulq19+gQlNROZmwhGCf9aNNkdj343zk5+BYlpZZoBO7qTM/BkNTLKypRewKirQAaADmniK7WEZz0gwjZGRij7NfL1tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/d4uUN4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/d4uUN4"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3194020e86so82711366b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758647666; x=1759252466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXqXBnmiXImIakMVKpGGeYlSvR6C1NJ+HVUMvwnxdDk=;
        b=F/d4uUN4h2UHvet+h32/A9jiWw67ksJhqX7aMqi4CJkj0JrRvRXkU14ezj476DdTns
         0s1nyaLgt0X9YU/eHddqKCKlxpeecLs/lG2XCMrNvER1szzeks6UC9BmjEnh/t6i/Inj
         /5f2K/szSECXG62W2oiukiA1nKr+yOqeFALkuWd/G1Vg8kKFxfuRQqv2KKBibypozaSy
         sxM0/cpcozEXqPvrhGEFiHIGZZWg+NAvRhq1e1uj7w+WTB6nk8KAFm6BNFnZWkim/dDk
         pOWLqUwL6XaCAjYXsjj3SD6PnrhjowCr9V0o+2CVoLZdCzQBNBdr6K4VjQUlCMMtBHE0
         sBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758647666; x=1759252466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXqXBnmiXImIakMVKpGGeYlSvR6C1NJ+HVUMvwnxdDk=;
        b=h5vjc2vHd6wtRjM89n+ulqtRn7Imfc13IHR+P1UTFzdzYdLB8BTRfH7LOJEtwIo482
         y99xXwnT2aqNkkOsdZRiSVHBa2XMlMDW+cdrLD27qwsOyJuet1ndRdbrLgH9xT2yf4NA
         KEQG6NbiTIR8+Z1awjxU+e1pqK29P5PP+xdr9mkdhyzlaGGqJDCwOyOrAvqEIT2YRtHW
         6UxYipJy2UA6XSaAxUzsfYipAhbORnXVf6E3xpcY4NVEExz5B/wGxSBfqoQZy4VtUdY+
         1LAVmzOBFZWh62kqjBQD9/OF0mQbq7e/RC0xnz7mb5kHbtS/fqtZT5mUB96r2RBvK8pi
         TR1A==
X-Forwarded-Encrypted: i=1; AJvYcCX+SQRywmc22dZl9v4NrJQ9VHKJx7FHouKT+FyLzfMM47IfGCmhcB9rK9Iie3m/p/jDrcPPeACvieFnWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpWAXoM3HaAiORd2Es+AeG/qetG7O6UWna3uKOyXDFizjhOJ4W
	BGnKwXDKCf3GpeHY0+5ZhoXyVJtO04OFljTkR47G+c3v9DDUEgPcJaZ3
X-Gm-Gg: ASbGncvJFXW4xAgFVMkL6QDQnEAxnFXNcqSZqyml+4/ykcfLXE2nhFmN93BsW3J2kL0
	MzRUCtT1CO3F/DJN1auRwnACUrtWfgO7ABHnXgAB6OBv4WkSj0H2baupqRRtFHM9FibzbkrjFrE
	aacNnnIu8ZBy5jlu8/UVt3eXCF8tDOueOAPMcvVqZC77uOkBP0Z1Rcp/Y5oMMzguut++W0c43q8
	Rb1PDKeUcsTxtLlmMqX4WkdKujFJS20cn6ERWnucaE4LTAp+BKqhp/CcOnHZBe3yiREoG0ohjvB
	vLGHHOkg+2PY1Lyl0S4DeHc1Hekh4vnYfIyHVO+eqhKROWSt5atxSiR8qoRI32KCdVje0OB2A9h
	o04QzY91214W4n9I=
X-Google-Smtp-Source: AGHT+IGSyRbCpjt3M6fPL9Ny0dbed0xWG6GvMzBnFnctl3j3KrQXRZZdJVYOgLoC0uHRbRnhxPV+ww==
X-Received: by 2002:a17:906:ef04:b0:b2a:7f08:23cd with SMTP id a640c23a62f3a-b302b5190e7mr331780266b.50.1758647665932;
        Tue, 23 Sep 2025 10:14:25 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394d79sm1043812466b.38.2025.09.23.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:14:25 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH v2] fbdev/radeon: Remove stale product link in Kconfig/FB_RADEON
Date: Tue, 23 Sep 2025 19:14:04 +0200
Message-ID: <20250923171409.25927-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The product page referenced in the FB_RADEON is no longer valid.
Remove it to avoid pointing to an invalid link.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
Changes since v1:
- Dropped the link entirely as suggested
(See: https://lore.kernel.org/all/CADnq5_NHu5=esJZrgy_S80jF68ZapRRYX4_L70DwDDSN3VXitQ@mail.gmail.com/)

 drivers/video/fbdev/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15f0c..27639b2590d8 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -948,9 +948,6 @@ config FB_RADEON
 	  a framebuffer device.  There are both PCI and AGP versions.  You
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
-	  There is a product page at
-	  https://products.amd.com/en-us/GraphicCardResult.aspx
-
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
 	depends on FB_RADEON
-- 
2.43.0

