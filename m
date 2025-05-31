Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6B610D;
	Sat, 31 May 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726029; cv=none; b=ciblbJp8pKI2nmk6hlYcwtJvmdFw+Ok879GSOWpx56aAYG96h+zLdz/X02xhA/n8hOL7Z/O3ThQDUleAh79PXl+KCnnbOJi9biKyVKbddJMsAlIJLyAc+8T6sDcdN6lk/pFJ8GNQvqoV6EyEX9hWl6J/cNccrl39ssnhsXTVwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726029; c=relaxed/simple;
	bh=PRyboB1k7N2KcrjhZjcaIgm465CDqcL2+Yf2Cysk7ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tfk9XHG7x64TAtJ5jZCTN2ppK2s7bkMQywSxAgFCRncIyEyulXx12CEHmVAZTzzaIOn7Tqgk/rx1Kn8JMMGeunGg2LjOhU0SVSrjdk/vIl0144UBPvPZIMzOD4c7m8BPRc/I7ew3TXuz6FEw2/IHUqBpXw1SU2baDO7YiPOJ12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if7JRV3J; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if7JRV3J"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c9563fd9so2593021b3a.3;
        Sat, 31 May 2025 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726027; x=1749330827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPzi5xY/SLx3QtT6MiFRJHzuARJElgyvVmtym/koB58=;
        b=if7JRV3JhL0B9bRu92uaOaNyV/gIZ4E9kTlrbfEQHl/5v9ag6YfmLqF5BXOo/3rM7U
         wtBYJyl4JokGokdzn5UMRM0o5k2qma1KnTOsguB+3T8gCxRFTKi8C7EkF+gDu+uU3PtU
         4bvM0jcxrYk9OJSTxTFx+rFMN/3cRtgVpIi4N4SaY9JshCs5B5xlyrzsVTgMv91eSjqs
         CxKTqF4taopQbokMSohjJMKKi618MKqGfEg2IPAVFzevLxJJ3w2mPzoqAMyesMcNRxgX
         iMOrjyy/b98n/PbgZmVns8Leayizvq1xOYCT0QqVZ2S6rKNAPAeMrYUyR3iJtaTobua5
         mGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726027; x=1749330827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPzi5xY/SLx3QtT6MiFRJHzuARJElgyvVmtym/koB58=;
        b=OegFs4f/FSMyjkJrS4O3TjV4xxek18Lqtez/p6KtFZGVdqmojFHT/VNSfVlZaV8uEL
         6mvR25DoYz7GON+9cimFRJqQVp6TXoiY0WGaWaXbQqDI1yNVZSJ4ht/cmc/MjDXoK/ZL
         iCPYKhU7ejbQNRccHmYgST4tf99xx/vkiE1bV3wrSjRmhF/dLJNUI8SRQM7JFfnAN5sW
         Yt231VTyMOAbOlLyyVTeDe644ebubMuICnBHDqXpHEQQwJuPh9ZWHIfYGnc375ANYhh2
         MLlKsthH54qJzXz7qombJZNFiYuSvsHuKW61Mq09+tN4Qkf01RHbaV5xCIpCNdmmgJyn
         x+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjuLr/TEu1w61AI/WQSkWIe5EGVKdOg+ESdCS5qOeGRo+eJGRgpxO4Otwx9sUgux1DHSaLd9E3rORzZA==@vger.kernel.org, AJvYcCVfrS2xT2C1pVG4E0igrKIX4BwRz5fmg09kq/Op460G41Vcz5F8g1LqKDIDcJ25EBH6bH7jAyNg9Pr+GIaE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NlkhzkUnhRjoYrYlaV9PVROpPm2DVgvF7j1eU40tDXxOGPFw
	wYMUC1g3ZqXFHVj/L0tCZdCXSP8RsFlyhs+qD++5xVsU3mrUQdbzQIqI
X-Gm-Gg: ASbGncs21ByIfgwjyJByg+6okJBzGXZFMwZWU78RJ+Yt5G6aV7sv0qb5iTOn8EM2XHO
	/Z1aPzdCl2MbCnVv5gawr4VXEEJjVCtkYxiTupSUuUkR8AkUE5GSs4u3uKjd3B/bAcBnStgZbGB
	hATcSE81Lx9VjveFpo2G9XKadx/kJ4xNOJsq5tSExn4/1StPX1Uq9U5andpkEYd7qNFwmo2eIPt
	tq2WcqoLk4DCNpohGk5Q6ZFivxl4XypUJkUZbAU1GDb4lfuBVZRXHleM8r8nUvbzH5Cf/o5af+1
	d5dSSOjjgqMXuph0MKb1q7qYWBileMUmhEuVNE80m0kVZ/lyrQRT6XcUvTRLGHK2x1A/
X-Google-Smtp-Source: AGHT+IFNXrT07jQqOOjMisC/VlId5cQOFjn3jMV4LhgfHEDxAUPohcM7n20UJSliYShKjOPG5Nj/0A==
X-Received: by 2002:a05:6a21:3a48:b0:1f5:8221:d68c with SMTP id adf61e73a8af0-21adff48c77mr10543241637.3.1748726026726;
        Sat, 31 May 2025 14:13:46 -0700 (PDT)
Received: from khalid-HP-Notebook.. ([49.204.30.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affaf9dasm5161824b3a.109.2025.05.31.14.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 14:13:46 -0700 (PDT)
From: khalid.datamax@gmail.com
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Khalid Faisal <khalid.datamax@gmail.com>
Subject: [PATCH 0/1] staging: sm750fb: convert CamelCase function names to snake_case
Date: Sun,  1 Jun 2025 02:41:01 +0530
Message-ID: <20250531211319.55682-1-khalid.datamax@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch cleans up the staging driver sm750fb by converting function names
that are currently in CamelCase to the preferred snake_case style, following
Linux kernel coding guidelines.

Specifically, it renames the following functions for consistency and readability:
- sii164GetDeviceID		-> sii164_get_device_id
- sii164ResetChip		-> sii164_reset_chip
- sii164GetChipString		-> sii164_get_chip_string
- sii164SetPower		-> sii164_set_power
- sii164EnableHotPlugDetection	-> sii164_enable_hot_plug_detection
- sii164IsConnected		-> sii164_is_connected
- sii164CheckInterrupt		-> sii164_check_interrupt
- sii164ClearInterrupt		-> sii164_clear_interrupt

This helps maintain uniformity with the rest of the kernel codebase and
improves maintainability.

Signed-off-by: Khalid Faisal <khalid.datamax@gmail.com>


