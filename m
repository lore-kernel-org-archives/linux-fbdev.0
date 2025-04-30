Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C644145FE0;
	Wed, 30 Apr 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992612; cv=none; b=clskvJQqyKHfgZ7WDyV3LO68rCa4GWO614thcm1LPaLhcxDfG3qa7b3FHEos6Ox04uA/Zq6fFYjmqkdSluYghzBshE9eZO2A48tSj7oHHr36QlJ8uZqc+912jCyo5uS7ZHTyzkGbTFzZ4V1FisGd/PnubBNTMES7ipitBHW8Hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992612; c=relaxed/simple;
	bh=13Qo05XeSWOf88djYrgymw4RZtXdKHMD66EO9HyNJig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/BFzF5pGj8sp1Rqt+a2XSsWJFh9PkFxo+Q+Qzzf+TO3a0vRN74fq4hQNZW4hVNhFO9IUY7RzHgTDOgJ6rJWnZrZLjYKJ22N4henI5wVoRQOZoChbZWdbZNThAjECvu8XBlsf7C0RtKOp99dTsU/oD1rK6ozpeSKlJfV9Ir5rSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+c79xl3; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+c79xl3"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22403c99457so15364395ad.3;
        Tue, 29 Apr 2025 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992611; x=1746597411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PhUqqxVP/BLi7jqvWQjnBB9ROUrGfrNMOfm/brn9Rmo=;
        b=Q+c79xl3FqzgkJyOXF5jOVdgftwTq8slH45DQykNP9NguCPBQP3BtCMuhFhfuOBzkC
         i/vkajebVtNSgPtjla2ef2MyDUZx7ejgUavrpw1L1l6bHixod+JYQMB7gsYKj3kwc24k
         t7dQ/u2TOhMdkQSp6WbTV5RFsb8pVUiUFB8m0hGo6O8B8CTyPlcGSlNR0Qmc/qCzmO65
         fPRjFBaadHzTx9v7TFT2BbrYX1425tJEXLpjOo9oVt4PtCRVCz4zlE2Zh0CQ3WyWiJwh
         qDCGbwKxCTog5TZ3NelNikUK1zcw+jWzV6Gd8ac2stahqGDrMmzcPp+znttP0WaNQpY5
         7nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992611; x=1746597411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhUqqxVP/BLi7jqvWQjnBB9ROUrGfrNMOfm/brn9Rmo=;
        b=ipHj2t6Nu9LxB+vDp8kKBelsaQOYtQNB86hgStABcSqv5EDSU0CACR+6LWJpTmxj+0
         fEEJx5T+F5sb/XHuvkCH9P2fMzbnKYD5JO3rIfF9FZDbR3LiQqggHQmF3uXY+9RC402W
         cgmxsTvq7dK6/BMTua1ggoCgjzC07wV2SddWs/RLRdmaXy6GPWmBXFRDaq7mBW1SkQNY
         4iqYbb+tVL6CJ+r27Xe8cg2VCHDL8DUXaA7X5s70Nu6vhFTnrzvnFg3UPrdeGEmAKUdg
         TfcV1y+yJwUQlLo9QdNp9oNeg3r3emcEzZbKK7V1JEooimzWrd7XlfObna4SmJVCEn1h
         wFow==
X-Forwarded-Encrypted: i=1; AJvYcCWj5fLjWdUNJL9BP17TnKzuY1kSmtWg4SdCVCthbLx7agjUZkVAR+XV5gowbbVQchBGoCG8V3a5K785DQ==@vger.kernel.org, AJvYcCXUAcqsPbffNPnb9A7lA5XmmboAOcn1oGpNjmniSBOvVssjEfY9s4YxlcMUlV9v73jOxDJUIQ/zVXtRC+XI@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIG6BMiAzQucPqjwGyvH+79/KrlezfnHaHfddYYOdfKrdQnOr
	MY/wJ/AK3zmUDlYfthl8Nn5daYGQSfWgSHC/s/jmR5mfnXJkt98f
X-Gm-Gg: ASbGncvcVNHAekLcsUbmvvAaD5VL9GWM4njBjTbKMkVBnRL6g98+K/mb2GDwgDVuPC2
	vOZRZ3UoDdAKXtNdLnsE8wwSC+yJ8gfQimOxSLxBopy1A+7+Y8zKeLPVCqlTKgua9xwBq9g54Q7
	NYGD1fli9C+m+HWh+DjQa/OvnsdJqjCG5eJ542ALyPXhPtQcXo3jdnvEzNli1I79tfy2JEt7dvf
	RSRr0imMnfU18jba4HdDjdMNBFPjGIaQeR+HbBCdJFPHKHkfb0qEkK3Ff2+ds9aA7gAkTyNhZfO
	T2vv5hA05ri4xzAv4eBoZM/vCiPrjTudS0udI1iSEEy+gQb3oIJdhVJuV2GYeDhVO2QNB9oE6aW
	I0YNfsMWltibv2VeuKekAJcntzIJyJaT/rFRkYhFNgMg+7aBpWJuUCek=
X-Google-Smtp-Source: AGHT+IFQlsChKdvo8yeBzYHD3oG+sKW4TgLubiXBAn+sb5J1uDe59Z7thhcPMrDzNK+/LL2lhWM0iA==
X-Received: by 2002:a17:903:2cf:b0:224:8bf:6d83 with SMTP id d9443c01a7336-22df57b3ae9mr7881815ad.8.1745992610609;
        Tue, 29 Apr 2025 22:56:50 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221a82sm113383895ad.257.2025.04.29.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:56:50 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH 0/5] staging: sm750fb: Style cleanup for sm750fb 
Date: Tue, 29 Apr 2025 22:55:34 -0700
Message-Id: <cover.1745982772.git.ericflorin.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches addresses a number of cleanups attributed to
`drivers/staging/sm750fb/sm750_cursor.h`.

Patch 1: Rename sm750_hw_cursor_setSize to sm750_hw_cursor_set_size
Patch 2: Rename sm750_hw_cursor_setPos to sm750_hw_cursor_set_pos
Patch 3: Rename sm750_hw_cursor_setColor to sm750_hw_cursor_set_color
Patch 4: Rename sm750_hw_cursor_setData to sm750_hw_cursor_set_data
Patch 5: Rename sm750_hw_cursor_setData2 to sm750_hw_cursor_set_data2

Eric Florin (5):
  staging: sm750fb: rename sm750_hw_cursor_setSize
  staging: sm750fb: rename sm750_hw_cursor_setPos
  staging: sm750fb: rename sm750_hw_cursor_setColor
  staging: sm750fb: rename sm750_hw_cursor_setData
  staging: sm750fb: rename sm750_hw_cursor_setData2

 drivers/staging/sm750fb/sm750.c        | 12 +++++-------
 drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
 3 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.39.5

