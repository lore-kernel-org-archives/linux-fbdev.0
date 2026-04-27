Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1726D4F7
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268876; cv=none; b=WVq0ilbWh5bTVuEZgbDRiR8MvWlP1B93ifIiBPkQW6SdlqIB6vh3Hx54xPGf0X7+eIrcRLkZDVQ5liFK6cUWfoqdp3h+F65iRJjWnbhLaOOjAMdeDGT6ZsYMlELRCXQvL8H2sjm9tFW3p7/Om3xczRw0HM57xKaICdxqHcDdOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268876; c=relaxed/simple;
	bh=J1mJvlaAW3wKVSXFEWKooMpwWLDuELTBMHdHUjl1OKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anx1nvYxZMo4WVoZHEH7+SI2S4zSlOl8N0nv5u5OiYOeCQJ9RvBZ0ODkEvEdpjpmQyQqNKXznTBsZKkiFSbYwM+sd2udR489GhuseMP07IOhszbCZ8RYIeVMY2t1+A888ITvClb/pUuQ1uHuxgZo1XhZl5IhmI/w42wluGHIjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjJxOa0U; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjJxOa0U"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso7953021eec.0
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Apr 2026 22:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777268874; x=1777873674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPdLQCge1s6wCjpbb66L80RoiUF4bz6kOAIF+KX2Fo0=;
        b=RjJxOa0UKGxpYSQFtXmV3pPzYNxVbnYVlyyF0FjBHKGSU4LtSt4RWfWJi1OyVhO7o3
         gCkl/s+A23CIfxt83UeVHRdUhMTWrl474v7dq4QgIidjUQSG+z6uRBqcfXbkN3RCNEtZ
         HE/fWTiQoLDGbJHQguOnaJQ59CilsI7eI3Sx/yDw5KmmHm/J3YLjZTgoULpFf2sQyDtS
         N4XnlId0yIVuahglXxNrTSZs26+fWMz0uibWwV1vwTjUFCAkuXlOzcplmhFLD4ma47Ih
         UB1vJf+sk5k+Y316YnaxviFa3RNyG246jBzEYqqrhWW6vvoh3uusb4hab3HpO2IoOJcQ
         MzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777268874; x=1777873674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPdLQCge1s6wCjpbb66L80RoiUF4bz6kOAIF+KX2Fo0=;
        b=slZw3fTeg2nEUvAvnFf2F3gC6u6nczhlwukoCugFnCq6J1wmvFaeQClboIJvUUY5NA
         5thSpDrpWqCBpOVC/A55XOFWTE+EkbRcsgMHYrmtjrN+VUOiM4FzB1C7lFRfqlAod4Cw
         UEqI3xdXv7q1YK0CaxbX/lKAGzqL5i7jZOIouKOjZAC+PLnheSBCbDufmWosJmQbH30T
         ZA5xk/ViJL2fApmBSvucN6JmjJIv6amruHkgNVlf5XlB1XwU09e4ady9uJoeRTVXktjS
         B9w9xOvUfsrROtTtYaWRz4LieHXVTkP2HAjEWXkm/szy5Lcq6knzKaIJ5eyEmdxtdKOk
         Z/EA==
X-Gm-Message-State: AOJu0YwT4wJHhLYRJr061krat5tV7lUuSw+lnv+0iV5Z5hA4tvjD8fyn
	7jpvO4XE3JPSGdnygXxclEmJFJO+kfi9uyQggkVmHaDUwf14UYfr2WqV
X-Gm-Gg: AeBDietHxQcdY3jovF5Kt6RwLUOi9Qdytn59zracRIc5DvX5QVtoDjOCJ0jjGgXNYX5
	hlsUMlbCcCNPFIXxrPbh1QfxbO1JrOcvCj8FjufHlJlKzKPZCO+z80cXKL52Zx5OLX4gLMlxDHs
	Sxc2jvi1w8J+HgPZDhntWet9aPsb/IlXxRxHSYDesRysWOFAZkVwbrG5qNwZ1QN3OKBRg6IjkJg
	kHumyrUx6bn4hK3k41K/gLl33hZWMljJ7gcezZSL3kd/Zrtdqybg3/JzOTyf/y+ky6CeVzXOpYF
	bi1FgxflLmyn2NAVf0UJh8g1jYmdwzSlK+q6ZJrYNXQoeug4YvxiASHUO5j8ZyNL7PSadQHz0Z9
	Yut8pOMkFHjej0rZulAKp2A9n2Fc4sjycWicghB7YdpvFxFs1P7S5HGRSTVN6LpxCfNLDNWKJGJ
	4KFr2RPtOs9teoXmJ2uK6qex2T634egEvFnCK35G0NGwglt1BGubZgcQBdDRiExE1yxaz8tbHEU
	hgL
X-Received: by 2002:a05:7300:e685:b0:2dc:5d20:c163 with SMTP id 5a478bee46e88-2e42c848e2amr17751531eec.6.1777268873707;
        Sun, 26 Apr 2026 22:47:53 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm42350209eec.21.2026.04.26.22.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:47:53 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3 1/2] staging: sm750fb: return -ETIMEDOUT on timeout in de_wait functions
Date: Mon, 27 Apr 2026 05:46:56 +0000
Message-Id: <20260427054657.758-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427054657.758-1-dennylin0707@gmail.com>
References: <20260427054657.758-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hw_sm750le_de_wait() and hw_sm750_de_wait() functions return -1
when a timeout occurs. Replace these with -ETIMEDOUT to use a proper
errno value and better describe the error condition.

All callers check the return value as non-zero, so this change does
not alter existing behavior.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a2798d428663..ab3d4a2bf1a6 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -501,8 +501,8 @@ int hw_sm750le_de_wait(void)
 		    (DE_STATE2_DE_FIFO_EMPTY | DE_STATE2_DE_MEM_FIFO_EMPTY))
 			return 0;
 	}
-	/* timeout error */
-	return -1;
+
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_de_wait(void)
@@ -519,8 +519,8 @@ int hw_sm750_de_wait(void)
 		    (SYSTEM_CTRL_DE_FIFO_EMPTY | SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
 			return 0;
 	}
-	/* timeout error */
-	return -1;
+
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-- 
2.34.1

