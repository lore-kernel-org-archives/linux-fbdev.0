Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871921E5213
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Sep 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242226; cv=none; b=o3R+dUFFlRsfV3fEd/YuKfTLGXzMW6rEEnecayPBgA+HlsqP3GU2SpvlKbm/DqcKFCz6Sz4UI9A4/zzHo/wMltLt4RiRaLXuued+b5XHTZ1qggzI8yJ1NXnDGF5xybNVaHDhlYXYbdC1yEuaHYQf6fqXTUk8zLxOdDWb1qlnXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242226; c=relaxed/simple;
	bh=k2dBfrdNtLGAZ64PrS3NFKJy0ruuW50Pp0bwQuFiRAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT2mwzgx9A8vN4jUUMwD8/53RQloJFULqAfIqToyoi8p4bBL3qp54KhUgxwGFrwRoLSBdPhIK85+1hY6UnLSe3UaIlAEAUSSw64RFSW3WUuEp84FyIaQ/011uRD3r5kPUbuWyffNVTT//Lv99ALifdKa+f84ixDPfkNqpQ4poeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1yBAU0F; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1yBAU0F"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5241e51764so1159568a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Sep 2025 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758242224; x=1758847024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWbzRPCjSF9zkkrc1WhzONXArq9qHtgULo12Vo1t/Ms=;
        b=l1yBAU0F9OyIDzCYGvQ1xfpg8acZEoqH10xMtJaObl2+EZbCf4fXuWB2TZV5h10V1P
         Du7h8bmQyBrAWGs9mXNN5av5Pm7dVG2NfbsIPyC4AbSSpvvM8oZCFucIdSMpYXJ/6pO7
         H+Hu8kfOcyDoIO/CHJ+pRiyCLm6GFGgILkphr19ZIqbxkT44aaqXcJIqrFfs7iiP3Mm2
         BQILtMgRbZPh728zLo5SQz1MVLdlFRM7crf5XAm1UxIydmEV39NQjMv/qB8MPxC20Vh2
         bASArHIOvxiIq2yxbvkl0Y1hkPM4q8+1SmUzRA+/37aYPiTMvuhKfsRB2UL/zAHUukG2
         NmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242224; x=1758847024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWbzRPCjSF9zkkrc1WhzONXArq9qHtgULo12Vo1t/Ms=;
        b=nY8IEM1avLnKnHG7QgaGNSGYMbca7mHGmU3WNN/v/RpzbZxkT2C1u8/xbY6m9m5gkK
         U1nFTscKRydmxIZcTxsKO2me/bnGji7yGPqldtwlTbAVGd00TRbE5cTewVQKTX0Ab6LM
         nGDEndxBxr8hdcEUH+5sjn4biUCSEor0RDuriy5iFqvOorbF3pBRBEUE2AW3/mJYbqKz
         fepC/v6gIOqJCjCDdNQB4JeNQPuQLpYmiWj5gftC1/OQZ5EAbjsp+seUOhe+4gVPBUyM
         gW9Xun2wyGuIiKo9xLWhyXxuUrMMjpW6q8xZ3hXIggPnnQzR6yUFXtwYjBSglXzIX9hr
         Mrnw==
X-Forwarded-Encrypted: i=1; AJvYcCUMsB7OBtTxCunGQ4yxVL2akM0udreTW8A4lRIpdTvlH60SPvg7hR2WWAi9845QHjOOX11zqzyfWgtmVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHzto/SyIBblabEYi0WIS1/sRh2aiNZ0DkxKV9FHORPtYottf
	+9TzamHKhhxRDxonT6UGWJ8HZgHweQ02TsDE20NkTmZ9BFqUy9E8uQwz
X-Gm-Gg: ASbGncu8O7TWj1COU/veDr27j0RuLMNBYAs1E+p/IoPYosCfWbwVrmgjvZGHh15nQsI
	PNrPFB8nV797PqCBF5OgrEQwTmOzEumDuWcJJiujGTEb6OkBLsDP4slLw2QwT6E25HxU5lYg1hE
	6PwDR1YfBHfqrJPVPIqzZvdHolsdeABNQKDctCBQOxKH7yx9DvHmIZ87h2Y9ndJLahEO3fBglZ9
	xndE2StwF3iynhd3IcSiwiBbCT5x5TlXc4dvdp9vz77Cx9whCqglvvLkCis1gPEgL/nyCZc8vjV
	lwYpK+W/ZWgfAlME6cqoBab36RyRafP5zoay6iFRXiJDRLq9WeJ9LY/z7ofKK0A8Se8GVT6ppc+
	I6rYJUXMpRKm/+i7HOygnuuCKmcyJ3nyP2A77O+AY
X-Google-Smtp-Source: AGHT+IF04noo2z6nfhj/WjW4j01+xVKhsQR6t2wKDzK6qpg/OEXcEUFT4SqFii2oCqgKJ7SG0yCTqw==
X-Received: by 2002:a05:6a20:7348:b0:243:d1bd:fbbb with SMTP id adf61e73a8af0-29274fb7736mr2077670637.59.1758242223625;
        Thu, 18 Sep 2025 17:37:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff445dd7sm3349864a12.51.2025.09.18.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:37:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3E9BB4227234; Fri, 19 Sep 2025 07:36:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 1/3] Documentation: fb: ep93xx: Demote section headings
Date: Fri, 19 Sep 2025 07:36:38 +0700
Message-ID: <20250919003640.14867-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919003640.14867-1-bagasdotme@gmail.com>
References: <20250919003640.14867-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=bagasdotme@gmail.com; h=from:subject; bh=k2dBfrdNtLGAZ64PrS3NFKJy0ruuW50Pp0bwQuFiRAw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlnlrS7CYsEXRY8VzLlwce97sGs77MD52g9PZglITvF2 tHuyhHhjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExE4R0jw7Fzb+umPpMMTd19 ISEk4PLmfTIrrl+Uj/V6U3ad46ODfhsjw4eweXXK7uvdzLu5XZkaBaaXbdrsO/exk8VUf/bH/u0 yjAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section headings are formatted the same as title heading, thus
increasing number of entries in framebuffer toctree. Demote them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/ep93xx-fb.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/fb/ep93xx-fb.rst b/Documentation/fb/ep93xx-fb.rst
index 1dd67f4688c751..93b3494f530979 100644
--- a/Documentation/fb/ep93xx-fb.rst
+++ b/Documentation/fb/ep93xx-fb.rst
@@ -41,7 +41,6 @@ your board initialisation function::
 
 	ep93xx_register_fb(&some_board_fb_info);
 
-=====================
 Video Attribute Flags
 =====================
 
@@ -79,7 +78,6 @@ EP93XXFB_USE_SDCSN2		Use SDCSn[2] for the framebuffer.
 EP93XXFB_USE_SDCSN3		Use SDCSn[3] for the framebuffer.
 =============================== ======================================
 
-==================
 Platform callbacks
 ==================
 
@@ -101,7 +99,6 @@ obtained as follows::
 		/* Board specific framebuffer setup */
 	}
 
-======================
 Setting the video mode
 ======================
 
@@ -119,7 +116,6 @@ set when the module is installed::
 
 	modprobe ep93xx-fb video=320x240
 
-==============
 Screenpage bug
 ==============
 
-- 
An old man doll... just what I always wanted! - Clara

