Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360553043CB;
	Tue,  9 Sep 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399884; cv=none; b=ACdlODD9knyuWcPGP3CfylFBrUU1heK41yA19LO5v3F9xIQusB3CTFhMD3y8opKshc8AlkpF0WLaoYFK46ds8TyzWipZCuAXDYITjE7m6jWMECdLuUD3Tf9902IyWEldqrqBdY6QhUggmUDJhgj9vkicQ9wLLvO7sH6JD7znFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399884; c=relaxed/simple;
	bh=1YacTfXCdJtgWi2zW6TivDngANaEgZA7E1AouXXqbn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MebZdXW9Vk9ryRPBNCvSZ/SnZvLalFtcx5uydZyxJCFo1UTwEW1n1mSqarJMQO03EBIHvT9QcWuO8ypBjr/yTaiIRU81uau366gROwI18rQrggjqhB8LUPcDVCqJdJyrBOGwFuDh90bcOpEPM42jY1zRQX0UBH1ozWal05hBmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Itx/MCAZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Itx/MCAZ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c863e852aso46997335ad.1;
        Mon, 08 Sep 2025 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757399881; x=1758004681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25UWmpQf5SbKYiEprNQF1Lau5aR6d2EunzG6nL5zuBo=;
        b=Itx/MCAZh7EWEwHrzHU6eICT1qhGcjmSQ7Ca1huQ5Tqc+0PmyHMQfuTKGIKGRH7C/6
         8yQxW1bQC1SaU4CnwWnnwFJ4XR0Z9cevl8CAYZCRUHHf4CnnFGuiEueF5MA3Hpy/JwPH
         xChBoHkgoctg1BX1GYhUsDsBP1iWh6Dr563LeCavUoVqV0AmlOvg2sSYmbU8mZkt9Q0n
         aADXU7gWMyUfdvgsgtdL2lTR+5A3WRJZA3ko0e3W3XUDrd78ypXoP4OciqNysAjNijCZ
         nNR1F9oGyPyaBduyLpJ23D4eagtA7yaPxSD4neokchwUHuQn4JhhJsUVpB5giEZijYyf
         XdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757399881; x=1758004681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25UWmpQf5SbKYiEprNQF1Lau5aR6d2EunzG6nL5zuBo=;
        b=Q64TYk4bEn8I0YSgBhQ9iflnlLt6taiijzuVlyvQfHDwXNZKrBU1sFsatYDaoYfoft
         1MxOVgreEE9YmcRGOFhD/AK98LVA6cQynzni236mtq5bX38u/BHnqAWSSclfujIdMt3c
         EjA1nZK8LbeZfgnzsqsqzt2QyUla5SIYLiLlz92fBYhTJrzTymgHd9reFB34qxwQ/fUd
         cq3yPGyL3mVsZeA0C5YyepEfdXTY9q7MPkOd8KsrLgh0ErZvpd1PcAxjlg+izCM8Bl3e
         O0nk8c/5e4bKJdz9LsdjZ0XkYEbErKxfu+gIWXloeepcsVkReglKJirjc/8KgazLIj4u
         qeTw==
X-Forwarded-Encrypted: i=1; AJvYcCW4PjXWHyL/auXfgKNV+14TigU5xG2jyiOhZFyTF9J647ye0qFhcokPcbPML65oHi7PZ1Ulqc1lmShH5YU=@vger.kernel.org, AJvYcCXOUG50g7T6gdpw1H3a/qI0UivT6+fCRg9K/ylLYbpb/z1GDZi7/y6TSfG0/R3czbtQhk5/yFOCbdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4CoemPtHhxbCzUWxt2ydS0VrclQ+zush78YeKjbhimOzC1Gi
	mrkHHPcqhugaOb6dt5D8HFfpieoHi1RfyUkirLCMnRDoW4A/i6pUyJvr
X-Gm-Gg: ASbGncvNypamVWcR5bPtB4vjLIBU9hZM0Y4Wq/MM397GPocLUtpUykP5/J6aB0t9C1s
	NkMspNJPmKQtASphgnjTNqM7B9bDgGzmfhQQtGhbgIlWTLiyv7+3u/6akis0eT0M2HuyVubIqXH
	8UMxGhKxGuiMG5WtaRRVv6R25JYsY6VB0FIKM6zZ9UzgwxRFGXnmhIpYwc/Myjxnkpx684j1/hW
	6jU0lkUky7XzZXfLhiuupV1DBr4TSQB8uLOvhG3V/Wl0ATWsNM8rpiLSBpm4k6UTQEcAz466G1O
	4ClJRsF+ALaUbJ+1UFBP0B2leQc+Rqi1qNz/aEGG+ggtjuashWnDXr0S3u7uLfzLaGXyZCdcyTd
	tHXxYHSztwq9FP5PToBaDgdpQY5f3ARb1tKsw
X-Google-Smtp-Source: AGHT+IFFSNt/TerbKOH/mJyFNdTgR/Ln9+8EsB6tolM8c81vOQhFBupjVWJyh52QWZXF3IA6RTkAgg==
X-Received: by 2002:a17:902:f78f:b0:24c:ea17:e322 with SMTP id d9443c01a7336-2516d817c2dmr141370545ad.3.1757399881492;
        Mon, 08 Sep 2025 23:38:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b8ba6e145sm15157694a91.22.2025.09.08.23.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:37:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 534E041FA3A5; Tue, 09 Sep 2025 13:37:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/3] Documentation: fbcon: Reindent 8th step of attach/detach/unload
Date: Tue,  9 Sep 2025 13:37:42 +0700
Message-ID: <20250909063744.30053-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909063744.30053-1-bagasdotme@gmail.com>
References: <20250909063744.30053-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=bagasdotme@gmail.com; h=from:subject; bh=1YacTfXCdJtgWi2zW6TivDngANaEgZA7E1AouXXqbn4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn7Tx28Gh9mctv9ptsR4dle9jxzmIqdrgjfesJ3UVz8d H5kRWdMRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZiVsbw342j+u7xNOaQJtNm 53B1v0mH+uXcjnmJv8iQTj4rNPvqW4b/8Za5n7JXP9Lb9qNY/+VV1sqmSY233onwc51MDmRYHPW IBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Properly indent 8th step text (as enumerated list item) to be inline
with other steps.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/fbcon.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index b9ddc145aa9f6a..3ed98b3ce64713 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -251,11 +251,11 @@ restored properly. The following is one of the several methods that you can do:
        echo 1 > /sys/class/vtconsole/vtcon1/bind
 
 8. Once fbcon is unbound, all drivers registered to the system will also
-become unbound.  This means that fbcon and individual framebuffer drivers
-can be unloaded or reloaded at will. Reloading the drivers or fbcon will
-automatically bind the console, fbcon and the drivers together. Unloading
-all the drivers without unloading fbcon will make it impossible for the
-console to bind fbcon.
+   become unbound.  This means that fbcon and individual framebuffer drivers
+   can be unloaded or reloaded at will. Reloading the drivers or fbcon will
+   automatically bind the console, fbcon and the drivers together. Unloading
+   all the drivers without unloading fbcon will make it impossible for the
+   console to bind fbcon.
 
 Notes for vesafb users:
 =======================
-- 
An old man doll... just what I always wanted! - Clara

