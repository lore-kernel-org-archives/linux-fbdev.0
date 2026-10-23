Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764716;
	b=DR1bFOY73kYcbojpRgts78JKH8OnFrGgUM4vcJLKM4zeVqFv9Q7r9JS5FkKSxMRa7SxM
	 XSPUebyexATi/E5dZ2hei1HznkIhF1aCl84fz3jLSu7wZ88LgQ8xRifgmUgI5k8IGdoqQ
	 Iq1n3RKOCqK+cNc0rLg99YIMAbDsqsFuSup/w1nyhRw0pPuS4M3z7Zap2POgCvqe/KrOb
	 PZXvVaN9r6JePtI5CT1xzg3DByAqusMw0rbMVWS68+Me0YV9fyXw5CwHkhRhrMgnI+8pj
	 q0oglJwzOgYKJTPOAUyLnHIDlmTTZ/IoRXH34+8RxJdTpAIFQgvl4KSuUnfVYmU1bWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764716;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GLgMio00KvgF13eWshGvS36uF/6/dz1Oxrnq8ImnAuo=;
	b=fgzaHfZIinFv6YhtACCJL6c2JYqjR72qQqEGfnPkgzbsfdMgGupOSbhkdQWsHABOGNpp
	 BHS5k52mSSaZ+NTTRdSm3A9tKh8Jfjj/jmd0TbVVoUqICvBtWWMNWgzVqwx7HB/waonk9
	 JNBl2PDnQb1TG3gCfg5Be1c1GK7PrSG0qzjV92idVmgWNuSnhE3fQu+iP/TtKYzd6UauU
	 THVPRk+P9eAThfWVD1IfuvLNh5mLKqPDlueznRYS0HfNhFzTAnIDxRyM7T1uSdYTCV6Gk
	 PwGbrQq4NN/rALH7Bu1px4IQGZciws7gSMwwypjkDnZy4H56Z2EPo5lBN/IcYbdwhIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OsLg9sXL;
	arc=none smtp.remote-ip=43.163.128.43
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDA606A31D;
	Fri, 23 Oct 2026 14:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EDA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OsLg9sXL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792764707; bh=GLgMio00KvgF13eWshGvS36uF/6/dz1Oxrnq8ImnAuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsLg9sXL7h2KWiz0TKsFJ9ldrw0q4E1gcu2+mCNfp2W9Z031Q6jxFM2NdRmJAMzMa
	 Ngf7YLWlrpW2GZFnpkDnWebw0j3CNnj3XM0HDa0tTVvLvIO2OffegNjoL7ecJ8Fbah
	 qO5hofEr0hNIMpPqE6XUsylMYfEw5C9xOKYU1pPc=
Received: from shuai-VMware-Virtual-Platform.localdomain ([223.88.55.50])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 2EB9A4DB; Fri, 23 Oct 2026 22:11:43 +0800
X-QQ-mid: xmsmtpt1792764705tfmdai096
Message-ID: <tencent_6CA7B248C9B3374DE2DA88094C98BB5F4B0A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn7ixNlKX0nX+QcOpWvfmtudXEjt+OvSpMkvM8FTDJ0FA1yDKVFj
	 t98BvqNiA382SUta9SehvI2c9CqWu0VAAAfqHHGeNd8xZS5lvK0Jixg/kpi70gdA80yr7Md/iiue
	 cQq6qZT0b7oCKsKMvFP6WSwNaeuoO1KecxWDr3rItyAB/10MfE5oafmr1QmzvPsa9S8VZQ/jGkcH
	 UWWMz+6R41OiKxUdvXkCZXSp0vNv/TStfC0PLPbw/2s5tc2DW8AMXa00HmhEj8c9enPFdorcv60P
	 DproLvGbRnXBoAjS2xROIicmgrjKG/3a1s5gEAFl6AsEYZ/e0S6nRUjCykKHne9MnWd69wn50Jzz
	 W3xJVuninSQDEJ3+ANSNqq03v36chzhYDfwC2jCQlf4EHV6c6ksqv/CMBohfLVLrbSIeKo1sVAHd
	 SvMwFkXup5jwtJ1KjtYsR9kwrOkbCFmLw48NKG5sz9voyXsjDXQWbMaU1r/EOe0cHGAWSklex+eD
	 hJHrrppob4CjYIV+y1yfbFlAZMFWWOufbAHNHbD1KPWeEqc4wq/xNz0amPCzegB6f+KJlMsTSI1k
	 pjRoKOg/e50+oGW9eJol5jLCcunM/XrNlqRW5H758KtQE+XvKM7S34XSFSP0HuIO/3fwXgcVPR98
	 nd57aXJ3IVNNu2N+1eXQwcWSs0ls3CGrmXLO/ewsSROwVLkIi6hCWEoHxkvRSz0nP9iDuW76FqMT
	 9uaQwPtEF2KDQjwtfyYtxR0VVpgX+cRDVMxSxHY6Q943A4OYKcOu9pj6PWvuCdBxovMbQpe4p4V3
	 ypU1AUtShQj+u3CVIHqqopK8FYuCdXIaGJFnh/1tKQPkY7PLpLU7+eszHdeflbVQFKAEfcroIUna
	 EBiborrkeIznNq+fGZDo2IQIeNiz6rXKcbuQx+//9W5etBcDQ4CP6zS/K+tWTzAi4SXy4in3jkd3
	 47yCjsaNjHfLXYTyso+x2kSt6QGk6rz5IaYmFaNVx8vcud+rT0wDQrzHtEvhDqQ47r4tRM3Y4xbp
	 YhlPCTqyBp8fReBNaPoRRssOYPtgfY9Uy9nouGv23gUliPQw22k0HNdLmvd+8X+z0Qm8cu48iQaM
	 6kuhMDFgwRiaRAJzm4YjNEo/ZeEUbqWmHl2mHcavfFa5QZnyuGWbmB530/IMvsfex1c5Ob
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: SudipMukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH 2/3] staging: sm750fb: remove unused macros in sm750_accel.h
Date: Fri, 23 Oct 2026 22:11:42 +0800
X-OQ-MSGID: <20261023141143.183061-2-847807867@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023141143.183061-1-847807867@qq.com>
References: <20261023141143.183061-1-847807867@qq.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These macros are not referenced anywhere in the tree. This is part of
the TODO item 'refine the code and remove unused code'.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 93 ---------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index efceefaaafb0..5a403f93e362 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -10,26 +10,20 @@
 /* for sm718/750/502 de_base is at mmreg_1mb */
 #define DE_BASE_ADDR_TYPE1 0x100000
 /* for sm712,de_base is at mmreg_32kb */
-#define DE_BASE_ADDR_TYPE2  0x8000
 /* for sm722,de_base is at mmreg_0 */
-#define DE_BASE_ADDR_TYPE3 0
 
 /* type1 data port address is at mmreg_0x110000 */
 #define DE_PORT_ADDR_TYPE1 0x110000
 /* for sm712,data port address is at mmreg_0 */
-#define DE_PORT_ADDR_TYPE2 0x100000
 /* for sm722,data port address is at mmreg_1mb */
-#define DE_PORT_ADDR_TYPE3 0x100000
 
 #define DE_SOURCE                                       0x0
-#define DE_SOURCE_WRAP                                  BIT(31)
 #define DE_SOURCE_X_K1_SHIFT                            16
 #define DE_SOURCE_X_K1_MASK                             (0x3fff << 16)
 #define DE_SOURCE_X_K1_MONO_MASK                        (0x1f << 16)
 #define DE_SOURCE_Y_K2_MASK                             0xffff
 
 #define DE_DESTINATION                                  0x4
-#define DE_DESTINATION_WRAP                             BIT(31)
 #define DE_DESTINATION_X_SHIFT                          16
 #define DE_DESTINATION_X_MASK                           (0x1fff << 16)
 #define DE_DESTINATION_Y_MASK                           0xffff
@@ -41,41 +35,13 @@
 
 #define DE_CONTROL                                      0xC
 #define DE_CONTROL_STATUS                               BIT(31)
-#define DE_CONTROL_PATTERN                              BIT(30)
-#define DE_CONTROL_UPDATE_DESTINATION_X                 BIT(29)
-#define DE_CONTROL_QUICK_START                          BIT(28)
 #define DE_CONTROL_DIRECTION                            BIT(27)
-#define DE_CONTROL_MAJOR                                BIT(26)
-#define DE_CONTROL_STEP_X                               BIT(25)
-#define DE_CONTROL_STEP_Y                               BIT(24)
-#define DE_CONTROL_STRETCH                              BIT(23)
 #define DE_CONTROL_HOST                                 BIT(22)
 #define DE_CONTROL_LAST_PIXEL                           BIT(21)
-#define DE_CONTROL_COMMAND_SHIFT                        16
-#define DE_CONTROL_COMMAND_MASK                         (0x1f << 16)
 #define DE_CONTROL_COMMAND_BITBLT                       (0x0 << 16)
 #define DE_CONTROL_COMMAND_RECTANGLE_FILL               (0x1 << 16)
-#define DE_CONTROL_COMMAND_DE_TILE                      (0x2 << 16)
-#define DE_CONTROL_COMMAND_TRAPEZOID_FILL               (0x3 << 16)
-#define DE_CONTROL_COMMAND_ALPHA_BLEND                  (0x4 << 16)
-#define DE_CONTROL_COMMAND_RLE_STRIP                    (0x5 << 16)
-#define DE_CONTROL_COMMAND_SHORT_STROKE                 (0x6 << 16)
-#define DE_CONTROL_COMMAND_LINE_DRAW                    (0x7 << 16)
 #define DE_CONTROL_COMMAND_HOST_WRITE                   (0x8 << 16)
-#define DE_CONTROL_COMMAND_HOST_READ                    (0x9 << 16)
-#define DE_CONTROL_COMMAND_HOST_WRITE_BOTTOM_UP         (0xa << 16)
-#define DE_CONTROL_COMMAND_ROTATE                       (0xb << 16)
-#define DE_CONTROL_COMMAND_FONT                         (0xc << 16)
-#define DE_CONTROL_COMMAND_TEXTURE_LOAD                 (0xe << 16)
 #define DE_CONTROL_ROP_SELECT                           BIT(15)
-#define DE_CONTROL_ROP2_SOURCE                          BIT(14)
-#define DE_CONTROL_MONO_DATA_SHIFT                      12
-#define DE_CONTROL_MONO_DATA_MASK                       (0x3 << 12)
-#define DE_CONTROL_MONO_DATA_NOT_PACKED                 (0x0 << 12)
-#define DE_CONTROL_MONO_DATA_8_PACKED                   (0x1 << 12)
-#define DE_CONTROL_MONO_DATA_16_PACKED                  (0x2 << 12)
-#define DE_CONTROL_MONO_DATA_32_PACKED                  (0x3 << 12)
-#define DE_CONTROL_REPEAT_ROTATE                        BIT(11)
 #define DE_CONTROL_TRANSPARENCY_MATCH                   BIT(10)
 #define DE_CONTROL_TRANSPARENCY_SELECT                  BIT(9)
 #define DE_CONTROL_TRANSPARENCY                         BIT(8)
@@ -83,75 +49,33 @@
 
 /* Pseudo fields. */
 
-#define DE_CONTROL_SHORT_STROKE_DIR_MASK                (0xf << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_225                 (0x0 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_135                 (0x1 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_315                 (0x2 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_45                  (0x3 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_270                 (0x4 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_90                  (0x5 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_180                 (0x8 << 24)
-#define DE_CONTROL_SHORT_STROKE_DIR_0                   (0xa << 24)
-#define DE_CONTROL_ROTATION_MASK                        (0x3 << 24)
-#define DE_CONTROL_ROTATION_0                           (0x0 << 24)
-#define DE_CONTROL_ROTATION_270                         (0x1 << 24)
-#define DE_CONTROL_ROTATION_90                          (0x2 << 24)
-#define DE_CONTROL_ROTATION_180                         (0x3 << 24)
-
 #define DE_PITCH                                        0x000010
 #define DE_PITCH_DESTINATION_SHIFT                      16
 #define DE_PITCH_DESTINATION_MASK                       (0x1fff << 16)
 #define DE_PITCH_SOURCE_MASK                            0x1fff
 
 #define DE_FOREGROUND                                   0x000014
-#define DE_FOREGROUND_COLOR_MASK                        0xffffffff
 
 #define DE_BACKGROUND                                   0x000018
-#define DE_BACKGROUND_COLOR_MASK                        0xffffffff
 
 #define DE_STRETCH_FORMAT                               0x00001C
 #define DE_STRETCH_FORMAT_PATTERN_XY                    BIT(30)
-#define DE_STRETCH_FORMAT_PATTERN_Y_SHIFT               27
 #define DE_STRETCH_FORMAT_PATTERN_Y_MASK                (0x7 << 27)
-#define DE_STRETCH_FORMAT_PATTERN_X_SHIFT               23
 #define DE_STRETCH_FORMAT_PATTERN_X_MASK                (0x7 << 23)
 #define DE_STRETCH_FORMAT_PIXEL_FORMAT_SHIFT            20
 #define DE_STRETCH_FORMAT_PIXEL_FORMAT_MASK             (0x3 << 20)
-#define DE_STRETCH_FORMAT_PIXEL_FORMAT_8                (0x0 << 20)
-#define DE_STRETCH_FORMAT_PIXEL_FORMAT_16               (0x1 << 20)
-#define DE_STRETCH_FORMAT_PIXEL_FORMAT_32               (0x2 << 20)
-#define DE_STRETCH_FORMAT_PIXEL_FORMAT_24               (0x3 << 20)
-#define DE_STRETCH_FORMAT_ADDRESSING_SHIFT              16
 #define DE_STRETCH_FORMAT_ADDRESSING_MASK               (0xf << 16)
-#define DE_STRETCH_FORMAT_ADDRESSING_XY                 (0x0 << 16)
-#define DE_STRETCH_FORMAT_ADDRESSING_LINEAR             (0xf << 16)
 #define DE_STRETCH_FORMAT_SOURCE_HEIGHT_MASK            0xfff
 
 #define DE_COLOR_COMPARE                                0x000020
-#define DE_COLOR_COMPARE_COLOR_MASK                     0xffffff
 
 #define DE_COLOR_COMPARE_MASK                           0x000024
-#define DE_COLOR_COMPARE_MASK_MASK                      0xffffff
 
 #define DE_MASKS                                        0x000028
-#define DE_MASKS_BYTE_MASK                              (0xffff << 16)
-#define DE_MASKS_BIT_MASK                               0xffff
 
 #define DE_CLIP_TL                                      0x00002C
-#define DE_CLIP_TL_TOP_MASK                             (0xffff << 16)
-#define DE_CLIP_TL_STATUS                               BIT(13)
-#define DE_CLIP_TL_INHIBIT                              BIT(12)
-#define DE_CLIP_TL_LEFT_MASK                            0xfff
 
 #define DE_CLIP_BR                                      0x000030
-#define DE_CLIP_BR_BOTTOM_MASK                          (0xffff << 16)
-#define DE_CLIP_BR_RIGHT_MASK                           0x1fff
-
-#define DE_MONO_PATTERN_LOW                             0x000034
-#define DE_MONO_PATTERN_LOW_PATTERN_MASK                0xffffffff
-
-#define DE_MONO_PATTERN_HIGH                            0x000038
-#define DE_MONO_PATTERN_HIGH_PATTERN_MASK               0xffffffff
 
 #define DE_WINDOW_WIDTH                                 0x00003C
 #define DE_WINDOW_WIDTH_DST_SHIFT                       16
@@ -159,25 +83,8 @@
 #define DE_WINDOW_WIDTH_SRC_MASK                        0x1fff
 
 #define DE_WINDOW_SOURCE_BASE                           0x000040
-#define DE_WINDOW_SOURCE_BASE_EXT                       BIT(27)
-#define DE_WINDOW_SOURCE_BASE_CS                        BIT(26)
-#define DE_WINDOW_SOURCE_BASE_ADDRESS_MASK              0x3ffffff
 
 #define DE_WINDOW_DESTINATION_BASE                      0x000044
-#define DE_WINDOW_DESTINATION_BASE_EXT                  BIT(27)
-#define DE_WINDOW_DESTINATION_BASE_CS                   BIT(26)
-#define DE_WINDOW_DESTINATION_BASE_ADDRESS_MASK         0x3ffffff
-
-#define DE_ALPHA                                        0x000048
-#define DE_ALPHA_VALUE_MASK                             0xff
-
-#define DE_WRAP                                         0x00004C
-#define DE_WRAP_X_MASK                                  (0xffff << 16)
-#define DE_WRAP_Y_MASK                                  0xffff
-
-#define DE_STATUS                                       0x000050
-#define DE_STATUS_CSC                                   BIT(1)
-#define DE_STATUS_2D                                    BIT(0)
 
 /* blt direction */
 #define TOP_TO_BOTTOM 0
-- 
2.53.0

