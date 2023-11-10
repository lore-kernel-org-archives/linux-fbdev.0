Return-Path: <linux-fbdev+bounces-2-linux-fbdev=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0EAC4167D
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:46:52 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7372813EE
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Nov 2023 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791D38DD5;
	Fri, 10 Nov 2023 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cce5gxPR"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DA31A9E
	for <linux-fbdev@vger.kernel.org>; Fri, 10 Nov 2023 17:46:29 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C13119F;
	Fri, 10 Nov 2023 03:44:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso3125875a12.2;
        Fri, 10 Nov 2023 03:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699616649; x=1700221449; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls+i1gmtLBTSrDfIDCKkUwn7wVHegofzcMpwXT7w+4A=;
        b=Cce5gxPRibYbOcM20d+4cd2ZoeaRJuAq8WgCtnwg8EdN9Pgk3o8wW3rVVv/sJevWfO
         X+sjQZbsUckL/3EYaSIQtH0C2jBqbkhu/9fxU4LkVeKlabCGIeq+py02X140ptga8ghd
         qyWIrbdIU4/+QYOZ8kndIgdTONT0+QtHLe9CyOF8HaaqTuh3FsdZqeHmeeMxAF6nPgz/
         +v5JDYByB6mzMVTeN9ezeNvNkoJlqWCyREhfDvD1ONUt1+Qk6DXdxEhtMHjo+LGr/Kq+
         ADsEK7I+WqO3IDiArCHmbFcjx174LiJAaZY/jiMJU4scMfp+z5TqPAzLgJVRfmnhJQaz
         Kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699616649; x=1700221449;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls+i1gmtLBTSrDfIDCKkUwn7wVHegofzcMpwXT7w+4A=;
        b=LQpUykiHadaZTpOAR26RTAhWW19oDnwbhyTbDgMlMrsN88acMU6I4hl2+2tk02/SRq
         JioO3xjBysKCen07WDqlutF/EER1J+wcgA9ypeO0CBUpeSAfkd9KK54Oivr/WsF2cSiE
         14kPDEJ4SEKbpPz/q7oQb2ere7bacCz+iOEubeClepi4aaZXYdhZpIp0mjQ+7gNFvJjm
         0lpIHwZR+JP7ZLvyN9aIjVNI4jPcPTBJFq54KUKp7pp4qWxKu/CvFYAHs4AclStbZlyp
         DNi79rKaVCwO25l03HTE4SGjiWnJExzgXluktLssYByg8PPDom2aPt8tslaq1kDCvKRX
         6Hrg==
X-Gm-Message-State: AOJu0YwevJutcQHcDgmrF7uYy6hxilrKOhp/I9H+ABXFCG4zd94qtern
	ikPgpKuFfUwCACGPBlBSjNA=
X-Google-Smtp-Source: AGHT+IEDZNf7fK3SBH4Gvbr9dwhXqJGG5/7RAug27JiRlcTC2LXd/5Y7qKKS4jMCJMa8w2p8UhXYcg==
X-Received: by 2002:a50:d554:0:b0:543:5886:71c3 with SMTP id f20-20020a50d554000000b00543588671c3mr6540595edj.25.1699616649333;
        Fri, 10 Nov 2023 03:44:09 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:cd7:bb15:91b6:862d])
        by smtp.gmail.com with ESMTPSA id cm7-20020a0564020c8700b005400dc94f43sm1018916edb.45.2023.11.10.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 03:44:08 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] vgacon: drop IA64 reference in VGA_CONSOLE dependency list
Date: Fri, 10 Nov 2023 12:44:00 +0100
Message-Id: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

Commit e9e3300b6e77 ("vgacon: rework Kconfig dependencies") turns the
dependencies into a positive list of supported architectures, which
includes the IA64 architecture, but in the meantime, this architecture is
removed in commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture").

Drop the reference to IA64 architecture in the dependency list of the
VGA_CONSOLE config definition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 83c2d7329ca5..bc31db6ef7d2 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,7 +7,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on ALPHA || IA64 || X86 || \
+	depends on ALPHA || X86 || \
 		(ARM && ARCH_FOOTBRIDGE) || \
 		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
 	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
-- 
2.17.1


