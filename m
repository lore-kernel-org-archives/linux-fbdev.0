Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B613451AE
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580360; cv=none; b=ByECLwkKQMWO7IJ6Jm+8nDM0aB+bn1Q82i2RIwDjivDidQ/Vmrw54j15u1QjD8E1Oao2gl95Uky1D9U6O/aMUe8m5NHDP2RYuVTdvpizXJbUHd+Y3sh0smQwRMCbfDjtng6PqS3JaT9ic9eNDsPNrDD+CDicbpv2J8h0VX7kLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580360; c=relaxed/simple;
	bh=mcSHcsnGjbrTim3lHT2R6J/mI/34ikb6Ig44wWvwQSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS88MQaCpd9BGDD1wK3MLbaxq26oSoFRQlBZ3CAHn9CWb444t3ItVjgDHCDftl2Hcx1Mp6CNVNy+RsQc7PCncnn1zATdhHMWi2kq5ZLtZ4ngHW3TgJuq/CPUJL0mXNXaWlxeGXeKFcU1Zb8dADP/GahFV2pgKrZp7cCT3zjyDmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqyDuA6u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqyDuA6u"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so73332565e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580357; x=1773185157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlFdGAy1ipkgdmaAS81DA8NlLLwrLBcDJmRz4TQLYkA=;
        b=HqyDuA6umOowbnt5miuJDxllma5cy2jbYMREzIHgFiglFfZI+GCAlAvgMpTD8HdRhh
         KvyqQpwGBJKPkilYIvnjboiJD/1+ac672F9Z4bNsNm9kRIcvWvUYoh2jgB9CKksLcRSb
         Ql+pBZIOPLgEz+NvarM+n9rK7CuozFI4kyMKG+Ph28L/uEppYXr9N8EsSvDCz9WVzekG
         /JWj/O6dqra14Mn8IcJy5mu5koDMjzraQU9GC0IXNtBELLslk6oPFxdvAssjzJvERF+d
         8hLbd4dd8om2nV0IMENlICxNfParuu7xCvtf9dTSUkyIfwXYBQVODVDU9hN9Cpe975Ih
         easg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580357; x=1773185157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlFdGAy1ipkgdmaAS81DA8NlLLwrLBcDJmRz4TQLYkA=;
        b=XRfQWx0zgwDXbT2nqwZG5HmBu+++X3fTVm2DggNw2wcoYOBcswqm0BOVWKqOuFv7+e
         gcx5iaIu9dcBP2DQUuUvbS52uj9XMTxhvvKsVTU1+OEh0Mo/QupWLNsP74ibOKTf8KmC
         vgZA+mmeXPROMPVgSlmWFHKp04R4hvreNTTZKdzi11W186tzQloHNY1jax6gmjJ/+TVi
         N9kIlCKRgSw3/NPiMn+9jCuBcLyL55Wf5PiRbkdjzgEbna+AgSxplyXHV8TG4A2SzS3B
         SJd05ky+VIDzBP9fBCJCKrVKv0nFSK+M80eDRjrGkmbS0WVPKCsklfAssXblfS7OOhgW
         8YeA==
X-Forwarded-Encrypted: i=1; AJvYcCUSKOq3O20+utKzqITYradRp3cbKDgwZ+gzcE1SOuSTwZHMKcfpWs/8PnNwISGtYMv+xL8JvY8DMlShVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygfmL73CzSS+nR/6gtLeyQEYMDL91MzJjs6jalNrf1eahcVu71
	I7+dav9tKFGkbw7RJRn1v/qO4JXyjtYfPZD2PihENjAzoIpE2/LIfVQv
X-Gm-Gg: ATEYQzzAhd0BvURGlw6zHPoKH8wzeTITvd8NgjEvk5dzZZmq+uQ6x5QTERNJcRLWoJc
	5GtggRCIwaHhiCBiy2tw6bpVld9xHBExoqeMX/tHr9TFFRmTHMI0mbwVTXLO/eiswj11+nR06zP
	C7IUKBMv4VNA8w/Vha2WGOFPEQ0tA08Tifq7UbOzYFkNm29IqKLE+1LtAMUm9bfdtP0SX8QWGuH
	8RE0GKBZo0LUYQdVkcZzqQRuHIZRzPZgWG1vPJv49mUsJd3d92ZqX0Xv3uxZ9BiF3zbiAeCV+0H
	nwTxn0EEiSaJd2AcXZ2yNy43J7wUhFbvJlB3j08HYvz18jj9CsWNoQOA/CAcUytVUNHMYWIEV9l
	katO7q6n3AWLaTBidCwzzUsku6BH5lJWK4MsJq8A/qRURR58sBvpeywZDIJCj+6GYaetAR41gnw
	ARUJFyGSk0uxtfCgXJsApxBP9lpyuxelQjOvFKvzCG3Y7kD8F16Q==
X-Received: by 2002:a05:600c:8b53:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-485198992e3mr465065e9.29.1772580357142;
        Tue, 03 Mar 2026 15:25:57 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:25:56 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 4/8] staging: sm750fb: remove unused alpha and cursor register definitions
Date: Wed,  4 Mar 2026 00:24:25 +0100
Message-ID: <20260303232434.1850583-4-gawindlin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303232434.1850583-1-gawindlin@gmail.com>
References: <20260303232434.1850583-1-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VIDEO_ALPHA sub-register macros (FB_ADDRESS, FB_WIDTH, PLANE_TL,
PLANE_BR, SCALE, CHROMA_KEY, COLOR_LOOKUP_*), the PANEL_HWC hardware
cursor register macros, and the ALPHA sub-register macros defined in
ddk750_reg.h are not referenced anywhere in the driver. The register
addresses VIDEO_ALPHA_DISPLAY_CTRL and ALPHA_DISPLAY_CTRL are kept as
they are still in use. Remove the rest to reduce dead code as noted in
the TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 282 ---------------------------
 1 file changed, 282 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index efdafa993e86..24e826c31721 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -674,292 +674,10 @@
 /* Video Alpha Control */
 
 #define VIDEO_ALPHA_DISPLAY_CTRL                        0x080080
-#define VIDEO_ALPHA_DISPLAY_CTRL_SELECT                 BIT(28)
-#define VIDEO_ALPHA_DISPLAY_CTRL_ALPHA_MASK             (0xf << 24)
-#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_MASK              (0x3 << 16)
-#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_1                 (0x0 << 16)
-#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_3                 (0x1 << 16)
-#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_7                 (0x2 << 16)
-#define VIDEO_ALPHA_DISPLAY_CTRL_FIFO_11                (0x3 << 16)
-#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_SCALE             BIT(11)
-#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_SCALE             BIT(10)
-#define VIDEO_ALPHA_DISPLAY_CTRL_VERT_MODE              BIT(9)
-#define VIDEO_ALPHA_DISPLAY_CTRL_HORZ_MODE              BIT(8)
-#define VIDEO_ALPHA_DISPLAY_CTRL_PIXEL_MASK             (0xf << 4)
-#define VIDEO_ALPHA_DISPLAY_CTRL_CHROMA_KEY             BIT(3)
-#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_MASK            0x3
-#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_8               0x0
-#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_16              0x1
-#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4       0x2
-#define VIDEO_ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4_4_4   0x3
-
-#define VIDEO_ALPHA_FB_ADDRESS                        0x080084
-#define VIDEO_ALPHA_FB_ADDRESS_STATUS                 BIT(31)
-#define VIDEO_ALPHA_FB_ADDRESS_EXT                    BIT(27)
-#define VIDEO_ALPHA_FB_ADDRESS_ADDRESS_MASK           0x3ffffff
-
-#define VIDEO_ALPHA_FB_WIDTH                          0x080088
-#define VIDEO_ALPHA_FB_WIDTH_WIDTH_MASK               (0x3fff << 16)
-#define VIDEO_ALPHA_FB_WIDTH_OFFSET_MASK              0x3fff
-
-#define VIDEO_ALPHA_FB_LAST_ADDRESS                   0x08008C
-#define VIDEO_ALPHA_FB_LAST_ADDRESS_EXT               BIT(27)
-#define VIDEO_ALPHA_FB_LAST_ADDRESS_ADDRESS_MASK      0x3ffffff
-
-#define VIDEO_ALPHA_PLANE_TL                          0x080090
-#define VIDEO_ALPHA_PLANE_TL_TOP_MASK                 (0x7ff << 16)
-#define VIDEO_ALPHA_PLANE_TL_LEFT_MASK                0x7ff
-
-#define VIDEO_ALPHA_PLANE_BR                          0x080094
-#define VIDEO_ALPHA_PLANE_BR_BOTTOM_MASK              (0x7ff << 16)
-#define VIDEO_ALPHA_PLANE_BR_RIGHT_MASK               0x7ff
-
-#define VIDEO_ALPHA_SCALE                             0x080098
-#define VIDEO_ALPHA_SCALE_VERTICAL_MODE               BIT(31)
-#define VIDEO_ALPHA_SCALE_VERTICAL_SCALE_MASK         (0xfff << 16)
-#define VIDEO_ALPHA_SCALE_HORIZONTAL_MODE             BIT(15)
-#define VIDEO_ALPHA_SCALE_HORIZONTAL_SCALE_MASK       0xfff
-
-#define VIDEO_ALPHA_INITIAL_SCALE                     0x08009C
-#define VIDEO_ALPHA_INITIAL_SCALE_VERTICAL_MASK       (0xfff << 16)
-#define VIDEO_ALPHA_INITIAL_SCALE_HORIZONTAL_MASK     0xfff
-
-#define VIDEO_ALPHA_CHROMA_KEY                        0x0800A0
-#define VIDEO_ALPHA_CHROMA_KEY_MASK_MASK              (0xffff << 16)
-#define VIDEO_ALPHA_CHROMA_KEY_VALUE_MASK             0xffff
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_01                   0x0800A4
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_1_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_01_0_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_23                   0x0800A8
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_3_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_23_2_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_45                   0x0800AC
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_5_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_45_4_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_67                   0x0800B0
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_7_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_67_6_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_89                   0x0800B4
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_9_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_89_8_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB                   0x0800B8
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_B_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_AB_A_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD                   0x0800BC
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_D_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_CD_C_BLUE_MASK       0x1f
-
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF                   0x0800C0
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_MASK            (0xffff << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_RED_MASK        (0x1f << 27)
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_GREEN_MASK      (0x3f << 21)
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_F_BLUE_MASK       (0x1f << 16)
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_MASK            0xffff
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_RED_MASK        (0x1f << 11)
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_GREEN_MASK      (0x3f << 5)
-#define VIDEO_ALPHA_COLOR_LOOKUP_EF_E_BLUE_MASK       0x1f
-
-/* Panel Cursor Control */
-
-#define PANEL_HWC_ADDRESS                             0x0800F0
-#define PANEL_HWC_ADDRESS_ENABLE                      BIT(31)
-#define PANEL_HWC_ADDRESS_EXT                         BIT(27)
-#define PANEL_HWC_ADDRESS_ADDRESS_MASK                0x3ffffff
-
-#define PANEL_HWC_LOCATION                            0x0800F4
-#define PANEL_HWC_LOCATION_TOP                        BIT(27)
-#define PANEL_HWC_LOCATION_Y_MASK                     (0x7ff << 16)
-#define PANEL_HWC_LOCATION_LEFT                       BIT(11)
-#define PANEL_HWC_LOCATION_X_MASK                     0x7ff
-
-#define PANEL_HWC_COLOR_12                            0x0800F8
-#define PANEL_HWC_COLOR_12_2_RGB565_MASK              (0xffff << 16)
-#define PANEL_HWC_COLOR_12_1_RGB565_MASK              0xffff
-
-#define PANEL_HWC_COLOR_3                             0x0800FC
-#define PANEL_HWC_COLOR_3_RGB565_MASK                 0xffff
-
-/* Old Definitions +++ */
-#define PANEL_HWC_COLOR_01                            0x0800F8
-#define PANEL_HWC_COLOR_01_1_RED_MASK                 (0x1f << 27)
-#define PANEL_HWC_COLOR_01_1_GREEN_MASK               (0x3f << 21)
-#define PANEL_HWC_COLOR_01_1_BLUE_MASK                (0x1f << 16)
-#define PANEL_HWC_COLOR_01_0_RED_MASK                 (0x1f << 11)
-#define PANEL_HWC_COLOR_01_0_GREEN_MASK               (0x3f << 5)
-#define PANEL_HWC_COLOR_01_0_BLUE_MASK                0x1f
-
-#define PANEL_HWC_COLOR_2                             0x0800FC
-#define PANEL_HWC_COLOR_2_RED_MASK                    (0x1f << 11)
-#define PANEL_HWC_COLOR_2_GREEN_MASK                  (0x3f << 5)
-#define PANEL_HWC_COLOR_2_BLUE_MASK                   0x1f
-/* Old Definitions --- */
 
 /* Alpha Control */
 
 #define ALPHA_DISPLAY_CTRL                            0x080100
-#define ALPHA_DISPLAY_CTRL_SELECT                     BIT(28)
-#define ALPHA_DISPLAY_CTRL_ALPHA_MASK                 (0xf << 24)
-#define ALPHA_DISPLAY_CTRL_FIFO_MASK                  (0x3 << 16)
-#define ALPHA_DISPLAY_CTRL_FIFO_1                     (0x0 << 16)
-#define ALPHA_DISPLAY_CTRL_FIFO_3                     (0x1 << 16)
-#define ALPHA_DISPLAY_CTRL_FIFO_7                     (0x2 << 16)
-#define ALPHA_DISPLAY_CTRL_FIFO_11                    (0x3 << 16)
-#define ALPHA_DISPLAY_CTRL_PIXEL_MASK                 (0xf << 4)
-#define ALPHA_DISPLAY_CTRL_CHROMA_KEY                 BIT(3)
-#define ALPHA_DISPLAY_CTRL_FORMAT_MASK                0x3
-#define ALPHA_DISPLAY_CTRL_FORMAT_16                  0x1
-#define ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4           0x2
-#define ALPHA_DISPLAY_CTRL_FORMAT_ALPHA_4_4_4_4       0x3
-
-#define ALPHA_FB_ADDRESS                              0x080104
-#define ALPHA_FB_ADDRESS_STATUS                       BIT(31)
-#define ALPHA_FB_ADDRESS_EXT                          BIT(27)
-#define ALPHA_FB_ADDRESS_ADDRESS_MASK                 0x3ffffff
-
-#define ALPHA_FB_WIDTH                                0x080108
-#define ALPHA_FB_WIDTH_WIDTH_MASK                     (0x3fff << 16)
-#define ALPHA_FB_WIDTH_OFFSET_MASK                    0x3fff
-
-#define ALPHA_PLANE_TL                                0x08010C
-#define ALPHA_PLANE_TL_TOP_MASK                       (0x7ff << 16)
-#define ALPHA_PLANE_TL_LEFT_MASK                      0x7ff
-
-#define ALPHA_PLANE_BR                                0x080110
-#define ALPHA_PLANE_BR_BOTTOM_MASK                    (0x7ff << 16)
-#define ALPHA_PLANE_BR_RIGHT_MASK                     0x7ff
-
-#define ALPHA_CHROMA_KEY                              0x080114
-#define ALPHA_CHROMA_KEY_MASK_MASK                    (0xffff << 16)
-#define ALPHA_CHROMA_KEY_VALUE_MASK                   0xffff
-
-#define ALPHA_COLOR_LOOKUP_01                         0x080118
-#define ALPHA_COLOR_LOOKUP_01_1_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_01_1_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_01_1_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_01_1_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_01_0_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_01_0_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_01_0_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_01_0_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_23                         0x08011C
-#define ALPHA_COLOR_LOOKUP_23_3_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_23_3_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_23_3_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_23_3_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_23_2_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_23_2_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_23_2_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_23_2_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_45                         0x080120
-#define ALPHA_COLOR_LOOKUP_45_5_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_45_5_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_45_5_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_45_5_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_45_4_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_45_4_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_45_4_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_45_4_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_67                         0x080124
-#define ALPHA_COLOR_LOOKUP_67_7_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_67_7_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_67_7_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_67_7_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_67_6_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_67_6_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_67_6_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_67_6_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_89                         0x080128
-#define ALPHA_COLOR_LOOKUP_89_9_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_89_9_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_89_9_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_89_9_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_89_8_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_89_8_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_89_8_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_89_8_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_AB                         0x08012C
-#define ALPHA_COLOR_LOOKUP_AB_B_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_AB_B_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_AB_B_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_AB_B_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_AB_A_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_AB_A_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_AB_A_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_AB_A_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_CD                         0x080130
-#define ALPHA_COLOR_LOOKUP_CD_D_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_CD_D_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_CD_D_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_CD_D_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_CD_C_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_CD_C_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_CD_C_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_CD_C_BLUE_MASK             0x1f
-
-#define ALPHA_COLOR_LOOKUP_EF                         0x080134
-#define ALPHA_COLOR_LOOKUP_EF_F_MASK                  (0xffff << 16)
-#define ALPHA_COLOR_LOOKUP_EF_F_RED_MASK              (0x1f << 27)
-#define ALPHA_COLOR_LOOKUP_EF_F_GREEN_MASK            (0x3f << 21)
-#define ALPHA_COLOR_LOOKUP_EF_F_BLUE_MASK             (0x1f << 16)
-#define ALPHA_COLOR_LOOKUP_EF_E_MASK                  0xffff
-#define ALPHA_COLOR_LOOKUP_EF_E_RED_MASK              (0x1f << 11)
-#define ALPHA_COLOR_LOOKUP_EF_E_GREEN_MASK            (0x3f << 5)
-#define ALPHA_COLOR_LOOKUP_EF_E_BLUE_MASK             0x1f
 
 /* CRT Graphics Control */
 
-- 
2.53.0

