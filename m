Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854B49EC69
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611700; cv=none; b=u1EaZ0RBErGhh8bxjbrK7mk63eXq7JIf+dQieO9AHrJ0qzkDHSgi3VJNuqX1Ex+ArcZzlL50imqqE07G5jGDYjLe5EancMzlcXnG6fwMC3oP7UAEcCF1lzfZC1kEZ41G2H0qOpAYb2vWRZ2SOyFG8qtB5OB8cSt3R+D8kT3eOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611700; c=relaxed/simple;
	bh=6f5p//qeeEhJiLT6hla2lNz47zEGEWS2WmSvXXHcHig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWYUPkfPbVX2FYdJTnZigfJ/odzxODj0e7VAGLfCs8jPNjd1l801TAzC2kull/n7SK8By2MndeE5Jiddt61DZzKjD8S83ktxAMZjMb0Mi9mhjHayglupM81w2Q1PZT0WrB6vch31/Iicbx6Ot209yoy0ECxliF6q275EwcNjuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtbnSs8q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtbnSs8q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d94c868ea5so20245085ad.3
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611696; x=1789216496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=YtbnSs8qfPdzgH+oeRaodn+q8Vb2tox19c9H6lxT0EFKc+LY1/TEPedO12k3EV0weq
         ZubHW2aMvu5d9wRdvZ2JZKz7OYJGt9lSYnONx4iIPgTgklB3Zi9nQUeDscBHQNI2nipN
         8PAydIGehlYBeD+FYQjwg6pUJGFz8Zv+UkkQ3/NrLop+gj8ozrTjmwWo2IbPI+M0RoI2
         BN+5/uzNIMcpl8wO3T4RqLVBYURIS6zQbCgT+MIiipkpQV3o9deat8Ivesk3Ege7KHGV
         agTdBI1D8e/AHP9rHdTaJMom7wYS+xvDGlXRUX3Io89bY3cqjDkY4ewjOrVt3ANdSDC6
         BPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611696; x=1789216496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCkeW/rlDEZbQRwhNQlqYVSLXnulFlxF+aDVtk4kLrI=;
        b=JLichX+arN6TohIAgwePajjk6JZEzokBm6EYTUL8OhXH01aWpXG+Exm2LuAPYOnlBx
         Uup6J+2dEmbzI3ykmczkTgWDegtehkXFXReOrEorGo0tJQzNE/VrxOwHdB920XG63Mwr
         gJ4gXPJvtLwDYXW75fFICqODBVIAnJfnK/NMVv5D77bjgfNNVpTi2DnlVCa7NrtSdmUp
         9lGNy+lvypFj2pf/u2lHhdhlSKN2hO/R1/vhqO3eVy8ckpDdNdDJy8iYiT1SRvlXBzHV
         7fNb8l9U6qzqYJE5BNOxPZZEO93ps9RQXNpVXOybCxAHIZm9A91qhv6k6Gh6ixT5byHy
         9QCw==
X-Forwarded-Encrypted: i=1; AKwUvBxvB/SgJTwqEcpPYhzyD8feT6IOoPYjOo7On9jueWZSI76gr+0mSCaO0rZdpwYvSYK8a9nAO8j7Qz0Q2A==@vger.kernel.org
X-Gm-Message-State: AFuF++l+QkrBZHCjGL+FX2WTBhYSM0GNNYYpMD7ScgYvL68gz5up/fsk
	vi9UNZdwTrB4tZBYdYhZr3P8yQ0Rz18+BZPq54+r1lp7LB7G0ugseUkz
X-Gm-Gg: AYBFou09L0O1Ew4N8+/82Dez/YpdEiFLc6OdNjaFNb4lwbesafHPMKWJb5t9kIHoysv
	3TMezGOHnc1GS1Vyvb3y1BPrg/aEgaO3ZQcoc08q8NdIEW7nf4qTSCnlCg6sL8/49BlHe4JhTAv
	P+3LmKkJBrQH/FF7376UFignS4MNYYVjZgY5PI49cC/cTlLB4EvqwpvND9F29k35MxoKV/GsQLx
	Z0+oNuQjZPyFEGWdlurWNx7j4wOa0gCAyv2cQyeFZ2VcQ4dhHyBLTrUYUEX8cWAk+YGsEuT0XlG
	Mk022goLO65Kv9dbHMihmIp2GdUFAFkWXQTdpbRqENCFb7ZT6G15bD6ieVnb+DxwHtC+sm7oLkl
	z0N/LnTgZXd0qB8foTGrAvZpPUrfCnLDqyrgVbuphxUeFkYsRjJ+1CxTSEt/2KPtOrqqLJB9YZI
	pGmA70EVVNylKp8tzQtLqjeIXsy8FDWFTbpi4RHE10YpMJDTXCvoB/5jIfbc6dEWwuaoUQCIKtj
	5Xb2VRGepqnttcwIHwxykeIoROauC7X
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr17366120a91.18.1788611696373;
        Sat, 05 Sep 2026 05:34:56 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:34:55 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v6 1/4] interconnect: mediatek: fix Makefile typo for mt8196
Date: Sat,  5 Sep 2026 09:34:47 -0300
Message-ID: <20260905123450.5620-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a copy-paste typo in the MediaTek interconnect Makefile that
mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
-- 
2.43.0

