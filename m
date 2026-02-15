Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9B2C2346
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163946; cv=none; b=qBdvyBnfWz2yXl1KvK3xO+4ko8MlroXM7LkLb33PHVfrLDvjTy6F8qUZXlwpJAeeMNpiVcd+SBPpCTtV3XfWtmsV8f0xRSLdB3QxVVJuFzL/VddfAf1rf+34w17KLM7v3E59ijBMB2yy3DJvil9a/y3mDbZ7MQhHcYCMe16D9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163946; c=relaxed/simple;
	bh=BalxdmGg7q8b/lJ2o70gT4nYTPOO6a2Q4by7wkC9Sh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PumnwWuVNS/88TvVZpyEjvm14YnToVMiRx6cQE/LMGnPtKpJ3FRjymi76v07O1TABNu7o1dv0SNN8LAOfzWvcnvQOm02Eo8YOu2D5rPbbDR0/O6Ag1Q/Ygkl9633Kk2CDBrEZTc/tMBRyW32ZBaxiAcsBkO4D8k3C8DljZkZQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+fAauJV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+fAauJV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso19607785e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771163944; x=1771768744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG6GmQsGBxr4ARNr9op9u1H7yyikgeK/hyPhatY3TU8=;
        b=c+fAauJV7BVpfH4WgXZPh3mW3bJOrfR80bmjDSPO4iBtTpUWbXAkokQ1L0VlO8YmN3
         tLMe9BGE4272mQYaHgfSZWL8IS3MCjQZWHWYMA/0zh26+0CmRAGITAbAuXTlnn5nLxiG
         3jAwnBexT8km9a7kM2/0OqWY5LAXsYq48vFFUsED+EqYZG3xzryIgCTwo8TdsA6Rq/DU
         WlmNK5vN4XSkoeKMBwAQgFp53MJ21HP6WO87mLwofacRGpwCl0BJh5O90SG1aVxd08Gf
         cF4b12yr78b94DzeYpUZJDyU12pkqj/Jv0y0EJjTYTik48GO3aoLnCpOo6jwERKlgHkK
         dxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163944; x=1771768744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG6GmQsGBxr4ARNr9op9u1H7yyikgeK/hyPhatY3TU8=;
        b=OFfLdqxyGGts98GlQvW8tigmQsf5mBBsETjNljpydxk1npDix6ABinWoKaInK/DFeq
         qkaQqhpZm6+Y3NQi6OsvQudLJP+JR8cZyRJCi9KWMixpDjYOwVAiA9OHnenv+7jt7iYv
         XzlXLJJ2OaVY3sBxLBn7hnNcjLYsexb4Jbnphmvdm11KlLLr6b0MCJYrPuMiZGS1Saou
         iRWkc2Tv+HB/EU/A4Nkt3JzU5FI56XaQRpWu0nxR2FM4QVkteghtuvOYH/oS1JY2GM8D
         56OnqenLO5Go3IqZkFjKGKLnWLCkUqsKNLum1TMEKnxdnY52CuFP6Hs+Wmh7yenw893l
         T1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVj95Li435oo6jtabJe2mFx1Q+YhNgSfLB761EHGs+C+Z+Dw4Hsx5XUy8lWY/J6BHp9BeS6Q5tdCjcuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ79BSULKlelB0vblhvva1iKnRELMvpdstWbchquvQn7Fp5PeA
	C+ylSa2/ID6SVOJ0v3jLA5ds54Ry4t2mV+LFJIGWeNIK3FyvRxmSc8UU2sh2yo0mKoE=
X-Gm-Gg: AZuq6aJgJUgENo0+QP0fxzR5nuf2bzXVWLehDz3lQttKQ3ktwGNIuId44dIe2DHCZVo
	zn4ziRbX8KfpiDfCkP37uT97ore6TfgLmy/aQTu4IJM2vVtekzzaOKQogv2cGLsFgTnD3A8n1bj
	9LIv4iytcfIauJ2ke1gaM/1Ut64fmPRHGeD60SLVEzPXON8vY0b2cM65GmoVXPTec+Gqv4vS08Q
	1TDtoAdT5Z87L+KjQaqmW14L/7sbYni1XOreyIdrek+tW3iE4YcTTGw+OEs41Ls14gCi38Kj9VQ
	3DFuZxHQU9u9R0m79yu7bX9SxRc6OEaxXa0zYNV2kdRYCTRHlIu6opgObxk+cEDJtBRx114ySVn
	ZS2Wn8jX4Xjw4RgLPr2wlh437QCETVZteWXdqfvojZ+ESMCxmp70szKbdCYpKGbqAZWBMbyI1Kp
	ixC7L63Of9N7HVN+lm/1kQYsXA08oIByHAmao2/OI=
X-Received: by 2002:a05:600c:8b2f:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-48379c1faccmr64682015e9.29.1771163943836;
        Sun, 15 Feb 2026 05:59:03 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48371998777sm219101795e9.1.2026.02.15.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:59:03 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v4 7/7] fbdev: au1100fb: Replace license boilerplate by SPDX header
Date: Sun, 15 Feb 2026 14:58:34 +0100
Message-ID:  <378a47fdfe6d90d1dd1420b4c162a2b545e194ad.1771163316.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
References: <cover.1771163316.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=BalxdmGg7q8b/lJ2o70gT4nYTPOO6a2Q4by7wkC9Sh0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpkdEUw3fDu0xEFBKtyGze12ytZuqIDgb0XVGgJ sWHLSzfkEGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZHRFAAKCRCPgPtYfRL+ Tj64B/4oqNE04TOxf6Tn9HSh2bENkqqkMjGreFYoQembZbUj2FsJH2QpQ39iBGVH608PveoAe2v 68AfdS4cAUfPFh/H/UHKc2UvWQ4DCWR5rJ9UaXDgXELZNpntSNzA8dAK1FmPz5s227TgJQ+CwcA Tt/hcOea5b1/MBboYi7L/IZCb/PnaIJP985CNQaHWzB8eKDoJTNOYrCtBiBNgfKEomrHuR2IhJK AOgLXNTCDlWdjDwr/6J5yiX7+e5NHn+SeF4PO3P22/0LsH/4DlbJAycUM/WA/TSGsqDA066kJgP zc2r5mSDI+n343ViZi4NGF5+aTSXGgI2V2lEXcDuoIaCs1Ga
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This also gets rid of an old address of the FSF.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 48637863a4f5..43d280026d0f 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * BRIEF MODULE DESCRIPTION
  *	Au1100 LCD Driver.
@@ -20,26 +21,6 @@
  * Based on:
  * linux/drivers/video/skeletonfb.c -- Skeleton for a frame buffer device
  *  Created 28 Dec 1997 by Geert Uytterhoeven
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define pr_fmt(fmt) "au1100fb:" fmt "\n"
-- 
2.47.3

