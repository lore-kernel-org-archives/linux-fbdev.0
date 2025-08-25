Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B4234963;
	Mon, 25 Aug 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089092; cv=none; b=QSv1eSv57uOYWQLHoAu/cqpqC3+e7PsFOzp0FOtWDRe+DWM1krBJpO4wKtq/sVLtDhDiA22EsiepxC6L3n6pBlMpco7k1sM7ro+0XJo9f7ecvtaQwNZ3fjeizfg6AMu+/S8Ouo6zznL5nc6vsj8ty5e/DuvBkvT2ob7icspbozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089092; c=relaxed/simple;
	bh=KT9SUhjt4AKUdsfAMRDowDVzPk3fq4BEd8+MHQn5wjI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVaJ5D0jlh6fxKHYN254vTp5cqXwpaS54s/wUlCJacwA0M1SjDZ9FcLvaMy7HVq3ZQGI3lGGad0TEmMmiyIkQvj+01VVYWyPFvP4QqpLfq/wVpW8eRvWXiWWyIHLj9jGIiOXJ9mHMvT1faK6aYyBF06Lz5/d5sbPcK6FxhwlQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1s/pu/1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1s/pu/1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e67c95so4256544a91.3;
        Sun, 24 Aug 2025 19:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089090; x=1756693890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVC8azoXPoxosuCvm1eCBz9SCYhPLAwxnPZ8goaQCGw=;
        b=d1s/pu/10YXd/RekzjE/SzgHro1ydF+nhCUIJcKNureBewoaci2wm59OPy6e7vjgP9
         UIrFa+YI9w9DHNf3qLAbr3spiK6DUBuBX5x89CNLWGl6Y2MyKavxLUqwkdY5csyxaQHu
         wrIYAoKgbdB1OQufObZCAGFV7oHv+GuJCr5DmwxX9ydmqnItGpqI10/2IPvqVeXBpTNl
         HYNdp1VmvLUsmNNGoiQRL0KdcKsicwyp5CXDFX9N1vRNpCgqfCV7I4IgFsO5cm09HkZC
         6bWl9UlU+f+wK7bep8D2XQfMV9t2mLLz1JDy+L5tt2EENrDIkFesx7dNur1BUUJ4TyDH
         xcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089090; x=1756693890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVC8azoXPoxosuCvm1eCBz9SCYhPLAwxnPZ8goaQCGw=;
        b=C7ayGiX/DSTfHoCPZjjgaKu0WYZwCLMlOIHo+F3JDXJQqDP30J5riydlJQrOMaYQYS
         42rpxEDQKdlWKY2Ls2F7RAxsNkjVV12I/XnlglzQg40pjGwrJyT/F/2rPBkmJ0/dEizg
         ZOybUJvFyD5ba0c7cGA6BnCtYyqbAbUvYahWmwvCvqizKA1rgyjldXtCpMeIaYc8XuLI
         Jt2qEEOsdquOZOTWFopLqSpIGGsg5hQFnUUHBV9Q7CK8737UIVGOKYeMhDEjpwnFSzV4
         01hpoEVBJfvmiYrgRY3cv8gJsrfhKIfzHO6Ri6Oyoasbzb+G9rwJSpFkBVGupO1uGyNR
         Ljig==
X-Forwarded-Encrypted: i=1; AJvYcCVafHzzdubKVZcXMf+Xep0faxBxHovbdTPlGN9HnXBDCAMQnRA4hly3ND9v82xsESkjypVenhpqfSEyFfotdcij@vger.kernel.org, AJvYcCWWtY4Bt8R+obNWNd3fFt7caIV4USI8V0jy1wZn4Jou+gMkB0//RIYfCVhGe21cvzfU+28/WXnbWxM8yw==@vger.kernel.org, AJvYcCXL8FXlwzxVe2vpRYb/ntFsDm8ig8LgY168Lxwy18fzNk1BDL9f+XAQra+enKld186YTs/b8dCha1LwNYWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtGyqluWw9pHD/zcLm1SGPTmsNXleUro8eYEDqBbtUhJWyCAM
	GD+O3CHuF77MBaTUIckbLrYiwkv/DL/XupUWri2ZoSHHZKTrxqgaLi4T
X-Gm-Gg: ASbGncs3/BVHtbXDniEPl18HPgnIDG396ZKjINu7HuQBh4Ydi4xeFo9eJsRjrX8fD3h
	zkaNZRLvXKn05DG1KuTcRlWdDA6ctgB0HwgAo05dB6NAHN8r0D40LGItY/gkQENzS1QQFRWzGoh
	deyV4bYmycb83lDoi8nTx/eh2439OHOtsJXUAIGvYzvnGXgBAUYBMV6AgUi+oLAUS7Voay7QPVU
	BrjXKV7L+L9DwJJP1rdoEZlwJ7HJYjM9B7d6BHXDbhzoEZmZR06rwMDoNZx47yyUQYlSDRJP4Pp
	9ulXJHtx0LnFiVHamfWUbh5j8ZiPr9Bo7YKUTC/JjDyrplNNvVDgLBZyKDrhirB23gh4QZ3mpOE
	GmC2T+SljiMGdZ670vbB45mHwpmoZNGlA/iA9amEBPXOODRqmrt8S7T9Clcynbc5/q5pcwbjbd7
	I=
X-Google-Smtp-Source: AGHT+IEJ/RxmV9vk0nXMb491fT4XTeycZujwgAzjS69NOeWahllc9+DZTfyHZl2PP7ynSHAO+OZuag==
X-Received: by 2002:a17:903:1ae4:b0:240:a889:554d with SMTP id d9443c01a7336-2462ef8e723mr143141775ad.45.1756089090224;
        Sun, 24 Aug 2025 19:31:30 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:29 -0700 (PDT)
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
Subject: [PATCH v2 6/9] printk/nbcon: use panic_on_this_cpu() helper
Date: Mon, 25 Aug 2025 10:29:34 +0800
Message-ID: <20250825022947.1596226-7-wangjinchao600@gmail.com>
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

nbcon_context_try_acquire() compared panic_cpu directly with
smp_processor_id().  This open-coded check is now provided by
panic_on_this_cpu().

Switch to panic_on_this_cpu() to simplify the code and improve readability.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/printk/nbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415..7490865e2f44 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
+#include "linux/panic.h"
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/console.h>
@@ -589,7 +590,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  */
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacquire)
 {
-	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
 	struct nbcon_state cur;
 	int err;
@@ -614,7 +614,7 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacqu
 	/* Acquire succeeded. */
 
 	/* Assign the appropriate buffer for this context. */
-	if (atomic_read(&panic_cpu) == cpu)
+	if (panic_on_this_cpu())
 		ctxt->pbufs = &panic_nbcon_pbufs;
 	else
 		ctxt->pbufs = con->pbufs;
-- 
2.43.0

