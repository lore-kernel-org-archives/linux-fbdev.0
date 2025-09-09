Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695672E2DD8;
	Tue,  9 Sep 2025 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399881; cv=none; b=bXi1RxDDNS6FQHKNJp6xtkATwjPfryn9MLWvNMa2335h/58DM3WamTBrIAjj2qz+h4+PxgZF/0MRORStvTWlO9hWUHq5Ve9wMUFIEjbaSRoGNUmVFfP7vGNExSumoztFmKaH6dEBmyZJh8dlUioDGOLs0Eg1iRNH5uN5fN3LBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399881; c=relaxed/simple;
	bh=pfVPxDxt9WcZWPqzB85AUj4avLsvCa8ghrZrU5R+vBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBkgKyi2B+Fbj2z67NFgzDSrQH8QYUJ6PsceiInoHhYQWLZ8X1M5/M9YT1LzaViTa7ycNTHdKzyJ/0cTNzsFOrqIIckVeXjjytpaXqxn8IkArDrNssexwX7KNV7YZWzcANNo61rQxHJqU1YvKkkJZdJEpcSFKDI9hGdLwgtPRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHbef1bh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHbef1bh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24eb713b2dfso32594575ad.0;
        Mon, 08 Sep 2025 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399880; x=1758004680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJiukvQMYchQJB9oFovtwsPeen/LDiO7bwNq5dPromA=;
        b=aHbef1bhuoeK0ZsMF2gIA9GU0FW1U7fb8D0AfXUS/uSC/2ZExWETk6zYTmVJjiCL+0
         iGkczpqF4O4vo/a8yENiLjChL2lhpxC3EU1eONL6B1co4PWdg7zjc6lld6xkG08saD/u
         ZZ+/BKWPDGbLy0eCMiv2VQnRrv2XBBq1MCLkT2D2/uiuzpjUJAYnRv/PSKfzZENAWe8v
         +GHZzQF+I/L8nMXRpQG3EMbHe7P7+JKu40rreh4HzYT+4UXkia20xD9Mnk0475A7NRzF
         1bavTQgjkgPC4U3aYn8uuMMF9RRLiaeYm/ttfUiHLv+BInCz49GtZzJ1EVkM0uoOIxu1
         OXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399880; x=1758004680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJiukvQMYchQJB9oFovtwsPeen/LDiO7bwNq5dPromA=;
        b=GXp1rxDEBjojUwJWR4wnHxxgmuMaWvHKUD1Zo1q3lhhuuewi48NaKdIJjXWXv+JJZD
         8qfO6YQ4sffscwiTJBvaK1ZzJFoXxYNPpT1q/rDGb8T3+HjVMvzqLZR0Tbeg+/wIInDh
         MO+k6M0Bs64tHDiXjQ05RV1sUc2R46STzsbQqz8RM2gCxio1hQx+KI4C5GmnkSJ1ZlLM
         TpUj3wSkP0WKp1U7FGved4Jdl9vVDli2Pfq/fyZ5z24YgIzWZkbSV4coqYbMlAdyLxDT
         iSwdIQiRr6ppA87c83IOs0qohsy1VOo43LzFjxROqRFqrsVHE2qT3HzS57SrNcbHbb5g
         Narw==
X-Forwarded-Encrypted: i=1; AJvYcCUqOMB77hfmz1tKxB+4PYmNXEmYR+po+0ME6izVgENJQQnPuBxfqaLY0/V+x0mCl20RYBOBNfOtAh8xSA8=@vger.kernel.org, AJvYcCX6OLqhL4tNnNrWgzzaRxDtzbbwUSQ5zLwaig80XI47lUomd68P1+9mG8U10FP12Ff/FhYGGztEWl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBJyKOpFweX16xXiDIujjsclWipbBuIWaARewT2WyQGu7/+X0
	YmSnNzC3EMJns9B+QTujQ7YEFYxgM0jCPyb7QQf2NTwk6aiKQ1m16e50+DRwHBt5
X-Gm-Gg: ASbGncvwqpelNa6xbosgrKFThcuNumMi8BZjJmy3kDYSRJN3PffAiTspxLDP6ZwbYSo
	hOD3fbjn6+aTAfzIcYL1WacAK/SgYBsXv/n5EXlGPi3YuH8y3a4zU+4ryETjoeF3G4WiUh9kdd+
	39RWhHLDrRrc2+ToZVQHQZJ0+3bWh8JWiTIWW2RD/1PjvIOg1XzA1qr/Jb0QyXsHuVCe7fqiLFH
	nEBTlhqhmDPMgnMgddhhnt4EnIDXBQWHtDZgZTJkOGGS276mogipBevnHmNrRLOkLxd7Me6COtq
	mbbc0U/mnXKzbUxBXrh+wxo71tkSbuSP/mebY4RywThw7i5Jpw4sxC6MaiHh362dC5udpWeM5hz
	F7xoU4HWvf+BE/QuWkKTk/OF1iCt01zK0itX7
X-Google-Smtp-Source: AGHT+IFotQUFwQ0lDMECPT4okq9EM0mj1zKB3mE36lhz+JWVRbzizXv+ZEreuSwiB9QKkN0vzAYNcw==
X-Received: by 2002:a17:902:ea09:b0:246:7a43:3f84 with SMTP id d9443c01a7336-2516d33d4ebmr152795015ad.5.1757399879430;
        Mon, 08 Sep 2025 23:37:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724b94sm299653805ad.35.2025.09.08.23.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:37:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1C2AD4206923; Tue, 09 Sep 2025 13:37:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] Documentation: fbcon: formatting cleanup and improvements
Date: Tue,  9 Sep 2025 13:37:40 +0700
Message-ID: <20250909063744.30053-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=659; i=bagasdotme@gmail.com; h=from:subject; bh=pfVPxDxt9WcZWPqzB85AUj4avLsvCa8ghrZrU5R+vBk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn7Tx20iWWJjb/lWBh8I1FUi3Guacrjs6uD9i9I019af tpCU0Wlo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABORyGb4n3z/yTEjjXcT+Vv+ Xljb/Dg67vzpPRs1ys24ltkvtzayq2X4K2ixfbfWP88tBZvtPlSHWTg/m3lcer2I9ko59VUiS6/ 2cQMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are reST formatting cleanup and improvements for fbcon documentation.
The shortlog below should be self-explanatory.

This series is based on docs-next tree.

Enjoy!

Bagas Sanjaya (3):
  Documentation: fbcon: Add boot options and attach/detach/unload
    section headings
  Documentation: fbcon: Reindent 8th step of attach/detach/unload
  Documentation: fbcon: Use admonition directives

 Documentation/fb/fbcon.rst | 42 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)


base-commit: 7e5a0fe4e8ae2eb341f8ebbee2b24231a58fc28b
-- 
An old man doll... just what I always wanted! - Clara

