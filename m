Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D01C8626;
	Mon, 25 Aug 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089044; cv=none; b=siy3d+urwY+TuP/UhETIVrZy6VtNJ5FHNEC7htTJVxvT8Wug5GMEAZUkcjnYCzqMKwX/zKK947BqBk+YWAqlD97GRNC8t7B/33NGAzFVL1IpK5ANRH7NzAiRJ3Cxc/jIba/t7PKA1yuaJeT36idBYLjkfI1B5tpR0M/GeGtcCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089044; c=relaxed/simple;
	bh=gK1bji433iA2jl/n7FvFfwhw8vDqh7Q2h32KSjblVwA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liuocTlFlN8URlJlcqWwJjnPQyV3OJhPCjF9E8cVJco+FLsKcNw3AA/56m1H937WHOuHfLWow4JkDdxIsSdi3f+KayvWjlsYpqixS9/Z5Wh6uK0faP35c8GlzvsQAHfy589BMHYELfybDbH/beszHJVfiwVoVXcn29fBYEkCvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBEifjA5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBEifjA5"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49e0686139so594932a12.2;
        Sun, 24 Aug 2025 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089042; x=1756693842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFHAHU/+z+yhl9VER8s4Wp+oPk3FiOJt9Cdy6eMoyvc=;
        b=LBEifjA5kgkD++w99+07meLC8qMpVeKMElvKw+RLaoIw+zKqBqNChLmzIEXhxeqFY3
         AzPb+3vs6lx45/ApuHo7tKrHaO5dJupR+Bdq4jjS0IYfy61LlLPE1c93WdRyyspLkqtm
         FUb8ilAS5iXpqjAYH3n6k/Fl7KFt/mMGP225C+6f4wBg7moar3mBkj8DMWIubGXv6Usm
         uYsIK2QIhNIN5moHzX2QTolMVlP2kQyJUcKTK308K19cdqmW4F3kXBIIpxkCkbXvkhbL
         dB3c14zfHoTtzlf3McY/zn+4H+H/Z9HjTStfd3AT4gk2mt7EH6v5Ao8+IlVW7/VvrAby
         ihew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089042; x=1756693842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFHAHU/+z+yhl9VER8s4Wp+oPk3FiOJt9Cdy6eMoyvc=;
        b=bbXXnGOKFiofmLYAqTzOVIW9AqWxaxBHQ9rY/6n8Ufr/6iOGtf/plZB/NznJ8PPJzw
         NFQSdZtETh0vaMm+2Hp2fjt9CwU+CmJWQP9IX2K+zxau5DPRIra8dOLkxH2MlbrX8x6D
         ldR9Rz4n1zCysNh0SL2WeLecfEdlmqps6PcAhrYrkxrHNXG2ESHrPEaNRKVWqvrhSJmf
         XmLLRzNx20dGAwcMeLOzUn789G2iWsk2H3q93JcuIr+DXdNTom0lbQARBUJCEhQAjHqj
         z9v0zHOh/tqEbKqu5nD3WyACE4trAURyQZnUqNAsZPD3xS1+P6729hu3kC2dWhJsZfYx
         qAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2CeDk3W9Al4fEeCjgPqtAwpPwfy65iCEmSOUoDRfM0nFU85+1GtITs5am7dZviKizc+woKL+N5zVXhg==@vger.kernel.org, AJvYcCUn7Qvxjbrs62mbQjpLCMT8HkHuoS7FqXMlDo9hcx9pAgo3y+BzzzpILL6wgD9I0Ar9xjeNiCZQOKH3uz1w4eJB@vger.kernel.org, AJvYcCWOdJpGkrL/qq5kYHCSteAh17mQBPUsMp24WKFBYjfKm1H4B8sDV1Nv5uFTGIu9+JmkiQs/TtEb9uXOYvFo@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbhAj0nDs97QXsfUNWoL6MyEpEwEAbsq+Z1sXY/kp/LdXFO3z
	iRM5OuTxpX60PzSAoT5M5KJ9G8zqFahY38Hx7J9D6n5l2AI23UO3gXtA
X-Gm-Gg: ASbGnctCm0N0wZIw5rdlK5fHEaJnqvlSnKog1hC8rFY1JVKbJSUMq4F1Pjmn9Ou7lBZ
	SrbENK1zjfgItjFbZbXRy/PTA8AlZEej080mpWprrZtpwJdN1c6BLZ4yz64B/0c/cSeRAPCfcm7
	3paEhDzIEPXpbV6uk/HCxWiEUTYlcK6LIp+jSK/LxThFWhF2cgc/PVgx/U2MLjmdWbnFu7kay/A
	irNorpl2e6mxfRoMNp11vwefA8V2qWlc+sfmgLPPGvUGbjsdmFKoWd/N3Xmk8tPobmwRizHI2gP
	ocmFGGYDosQhp7pqw/vcivTz5uspE2OKFPQRI4IQUeuA9Ce49Wt257Vkqp/3WZi6nIf8cWHUvTx
	lwtZ1XRvjHOEfQFhpT6qsBJLGX2muGcvXTbYivld6ySfna/JsmJ2RG9VPQ0TkrLU/jxBf3IvnGq
	k=
X-Google-Smtp-Source: AGHT+IHERO/1eHRkEF6AC+dBVfTjpOtqq/Unp7jmksVhNk83icoLby3erE1Gst+iT6A6gassubAXtA==
X-Received: by 2002:a17:903:41cc:b0:246:b58b:8b86 with SMTP id d9443c01a7336-246b58b8f44mr31066895ad.32.1756089042108;
        Sun, 24 Aug 2025 19:30:42 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:41 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] fbdev: Use panic_in_progress() helper
Date: Mon, 25 Aug 2025 10:29:30 +0800
Message-ID: <20250825022947.1596226-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the fbcon_skip_panic() function to use the
panic_in_progress() helper.

The previous direct access to panic_cpu is less readable and is being
replaced by a dedicated function that more clearly expresses the intent.

This change is part of a series to refactor the kernel's panic handling
logic for better clarity and robustness.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Acked-by Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/video/fbdev/core/fbcon.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 55f5731e94c3..b062b05f4128 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -279,14 +279,7 @@ static int fbcon_get_rotate(struct fb_info *info)
 
 static bool fbcon_skip_panic(struct fb_info *info)
 {
-/* panic_cpu is not exported, and can't be used if built as module. Use
- * oops_in_progress instead, but non-fatal oops won't be printed.
- */
-#if defined(MODULE)
-	return (info->skip_panic && unlikely(oops_in_progress));
-#else
-	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
-#endif
+	return (info->skip_panic && unlikely(panic_in_progress()));
 }
 
 static inline bool fbcon_is_active(struct vc_data *vc, struct fb_info *info)
-- 
2.43.0

