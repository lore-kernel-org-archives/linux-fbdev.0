Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB13F54CB
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497820; cv=none; b=NfColkkdR046ExUWP7cJbNBpUT7M4TM5uv3Dqp70ABS7yqDYonw+RlE6JWVgEjifVqiTghdLu+uZuF+8IyV/YfGjjyZjHPstzP4oJn2FtAHWXQoGDtSIUEGdA0b8RzVm5VTtWwT8cEvTt0cv8EFw83tntj3FOn3OAeNDUX7tOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497820; c=relaxed/simple;
	bh=g/XAR49fFVzuq467Ik799+2FdWOn/LGc0r4Y6IP8+yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYcrXk10yTVl+LkmIvT0SYT9vqwBWzF/Uy+LpjhuY4VW3Ezcnn3EP/YLOrni+kKfQpVenMdtvaaxD/6Ro6zMKcF/MWG8C8n5m9DxncVpdROC/cJgZDXwnQe3tXV/S12bgzufoeiAQfHUoVTXg9E7shGsLT7e9cRL8il15PKWfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKpOp00x; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKpOp00x"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f707e5d75so650747f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497816; x=1786102616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwovEeXaCAdfULQBEy/htRRSiSsUVEDD/fWA6pMEZ8M=;
        b=JKpOp00xbHR7rgB47Jl7J41iv5z2u2EC8zhFUCf8B+w9o1MW9puL5S/tT9EXAf6So1
         e6Rr3dwT0r/PFnYbUUsnIIm/48oqLM1K3MU2aoqU89ilDZuMGpLOVE6l0dJzHnxZnxU7
         GNvNbqFOzhFmH5HCRZhBU+MOd3qEMNogXeJKwHbVlV5ntE4PQRX2RFRYqQkr8rnsD+Qd
         VogE+ByHBBTTNIZaHzUabxnwFeTt6tQYCiDKHoyc7hz3LpfipXVCr6ArMdka5BfDcHfE
         sHeiIbYAnbA3mUJ4bH1qA9RS2awOtMI+wGl1jD4ziHvjlBFmXz52VIJ4oZPDlOg3a9Fa
         Wfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497816; x=1786102616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwovEeXaCAdfULQBEy/htRRSiSsUVEDD/fWA6pMEZ8M=;
        b=W3k0/2L5oxHUyX1eBWv1agna3DuNwErViYokoTr6CWynnFktni3wbyBS1ZUQYRola0
         DDe6FJ61viyt8Th0eWbZbgAUIL7lIwu231pJ3kRVpenjoieH0AN8ikVOnhTrAjT7anw7
         ateAND9hpM5V/TIgGx2CF0o2P8fhyvhOO5HJi6APqLH0n2jL802o/ZFP3zYjAxSOTaIX
         GPE6BuST4lxDIqX5/1neUZJpUrlrcY4ULU356bgm77ZGH9Dfny8DFyOaS8N5mpjnelF1
         PFI3ipHc9mPJIl30+S4Rldc6Ffb2LEkqETeUIXS0vkmJ35z3xM5/rMvrettoxMySCWif
         BQxA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Up1y+fxzBFaxR5f337DO7GFzhbhmwOD5f8vQBBZyQA9aRyxVJ9Vxcygm26n0T5+ibkyoeft6oYKZLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4sIQA/x2khKLuxQwwvJWyfGJ1iRVVNxppwUd8UFvZCVm7FsX
	4cZ7roraGThWd5p75VpobgUQGUqe8Kn2YXFUKe/u38fCibt3c9/RV3te
X-Gm-Gg: AR+sD11P2Go6hl+ExqczOq0Q1ESE+mBlTGLUkB+fqbXrx5/sTY4PYqTB0tByDTiAYSI
	ppo+NzHY9fdVKoqe8qWjpSuB5huIgnFGTzR0lkbuwq5S1EuplKjIwUVUSpNRBB0WqWM9Z+5NwwX
	As5evYIF16ZZYLjJ5DvDFNdEPW5EbGdaV8JAus+FZFY766yYM063bijms6u2U+vD07+nx+FBE08
	15oIGIJa1foMGWgQK9naMs+Ze/utVPbVwX+8F7TpH6NlZwNNIBps8IDY8UO1mOfAgR5WzKUw4pl
	Vq1mIV/hSD2yO0HI3qckP3EPPZi4KHIGybSzvFUTRI9qy/Zj0P56wKkkI91+I9bA2Dhe/LDnIlN
	vk1SxXVrO1gfGofwryHkyV90Vx+h4HK7maG+keHojc2acYGTO9AM/KVzXEapDbGpO6O92GPlJqn
	xlk8HhNvK24nAWjPahENc+vwQdruVS+sT8C6c9RUbE/zSOcLnrXkiMyAQoU/62GtDcMHkRAyVdI
	QBneT1dcA==
X-Received: by 2002:a05:6000:41c9:b0:47f:86af:8fdd with SMTP id ffacd0b85a97d-47fd2abad19mr3920947f8f.3.1785497815591;
        Fri, 31 Jul 2026 04:36:55 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:36:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 03/14] mfd: lm3533: Remove extern from shared functions in the header
Date: Fri, 31 Jul 2026 14:36:21 +0300
Message-ID: <20260731113632.158440-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 'extern' is not required, drop them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/mfd/lm3533.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3463b164d0c17..c4c38876c09bb 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,13 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

