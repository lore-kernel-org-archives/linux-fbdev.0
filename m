Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169F4AA59E
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403041; cv=none; b=G7g6aMfNDo+SRqZT3NPAJY7JqsRCxa+q4RInBmIj81H0z8bfYcGhkMbxhul/3H3Xt0Jq+3mDto/KA8TfTTeIEXHe8PY6i5GDrE60arp42kCPbGMVdPsN9MRGPOoY9mxjDm3pszjjghNXNi2K4qHuPEHkvLTILwpI2BjxX9dYVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403041; c=relaxed/simple;
	bh=eF9ybIO73BvXJx/tfM15TxxY0Adrd/pDfCRrQG6zpJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrYMZEJNzGPU0BZykg9j8swT3Qr3lRN3A1ruk8pZdTTht2gBm0rGm41YCNMalwhPmD29hnKzgxkVfOW1o+OJEem9ZMPRGGYoidm04m46X+7GJTMX9xO1fNnbHC8wZf9PB98cs9L87ZEcH1MGyfl8CVHUsw8bnVRNX4lPI9u6y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZLHAr+5; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZLHAr+5"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35fad13ca97so84623eec.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403039; x=1793007839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=CZLHAr+5SX+9O1+UKYUHozqaxF2RfMchhttSCgzxcKinJil1RdzUOe07aDVb89Dfsi
         ONyShNKWZhj4smiq1Cm8hyyN5E2sRgdpHp0mln5BucMZtPhbmILte6x1yK9sLQQvIIe7
         Q8IRR+fb+Gqe2GB9lwtoYS4DpAbIDF5dlOH6iUKoNfS0JWxeqYlCTCjE06kH8lcAZl8O
         r1BOSBW5oqmyA67DDa/5yX5gkDGmdj4sqAKc4CmCNycam4OvLSudgfllbg3LiEnjhWIS
         XqIJOI3m2k6YEPrQYQ2mZVbp7tuchL7XHn1XavSIEX7Qq5mUgic/Dz19Mq1OtiyHvFTM
         9Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403039; x=1793007839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=qF8lDIJZh0S0cwfFTNOiBt9pZuOk04T+p/kZKplzLIDRjnRAoMc4vVTekMbFX46Dub
         OYYS1wMRQ20XyqnizG3+5b9qXrwTDapTuTpaeWkJJeX+fr107OQMhmUr1NNtlLxbtd4E
         3o++QvA8m8K0AQdZY9O0IKU0xeM1zkRXv3C8u9YXVhAGMlPbVAq/qmNzQ7migGhzo1/6
         7Exxe8oJJdhTMQ+mqi6Q4Qj5dpArDQoeJ4QsadOMduVXsMQJu3gcXYG25sC4ekrZktoY
         3lUpH/Q6oZ4wAwByTvUyQae9DPVb7Zb0POK2dTe3b64+Lgw4YkhfoGjL331TBRknxfPe
         sz9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxgSgSuCpDgZKbJPJf0A79QS5rpSJCrlxvjd4P6FCWtWEoKWnlN8AaqLr8W0oACBeskpJ8esXq2RBgLZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKoeAITcIfY2jIqE3YrG04bv+l5qx+ouvZ7UKl/WYiIiLqcuzj5
	HZe8pbHKQ213gFjOf7jVZomxkMj5uNejSy5Qeyhnn/NkJvVU8pimxzKN
X-Gm-Gg: AYBFou2w2zNGT0DJ44cZPd/FX9kPQJ+Ri8KdHl0AQXOCnfrKcY00rzySxgz+9SXZEuv
	OzZXYMs8Px4M1NPwR4G+6JYEaWJzmgeAWKMcuAG026y/YErJEfb4oOiS2Kv8J1KOT9JOsZkn6SA
	sro4G+U+2m0N/b8Z54JgF6eQhYWFF0dIjF/0LpodKpIazTzEh2BFB8E6w0JYbXbw07TipAIJabp
	PrWZ7Znleo+iSI5uRWOaKRb3hP41zdBAjyHFGZW55veA9DAg3vd/dGJEe+D9r+0dtjt7Y4DLBoA
	yFBlwze8Bzg0/+3n9YgHCImBRHvtkFRnursrr7Sz86lBTMgdK4mTZTjDPhAeti0PLGK05MezfwW
	i7qV7zDvXQUdObKLOrnvBf3h/5UGGdNu6sSCCLj7YtcFisf9xoTxXyZeJbycfaqokBLL1YY3oHx
	o6p5cI0Bpkx1HiwcYfTWwHJk007NetLKR5GfXqCYEA43239+Dl8l74zf0C61MvgY/44vQKdJZbJ
	7oysG9a4OEE82RyqRub9Q/N+0bHmz4KbxY=
X-Received: by 2002:a05:7301:6404:b0:360:f13a:ff0e with SMTP id 5a478bee46e88-361a1b539f1mr10748987eec.23.1792403039178;
        Mon, 19 Oct 2026 02:43:59 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:43:58 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/3] fbcon: Retry rotated font allocation after failure
Date: Mon, 19 Oct 2026 17:43:31 +0800
Message-ID: <20261019094331.1128871-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
References: <20261019094331.1128871-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81bae..7afd63dcee7b 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.56.0

