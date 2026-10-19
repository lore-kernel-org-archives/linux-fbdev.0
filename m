Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982114A7CB8
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400554; cv=none; b=QhjiT72k7PBZ7C54kXSMaLsrCsZAxKLZ2pelO1mSxKZQRA+CsDeMAJe3ifwnzJKUhP+KYJ/pROqqC26UuGaXJzoONI5cbGyXSlcckhnjfeFsdgy4OAwfpVRXwIVtI7SsvSWv41N5Cw9JkEYoyEDVmGEqP62IwDv34MWRADfQdSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400554; c=relaxed/simple;
	bh=eF9ybIO73BvXJx/tfM15TxxY0Adrd/pDfCRrQG6zpJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/iIurod+qR5dqRphYzXlGjCDAmQNNdecVjIRAuGi2hEsZSu9mOS9vViQWSYcTxLUyZqewBqHnBepTjEftsh3zhfMNpztNzVWxoWnAWH2o5O7Umj//s8TSDAN7HXaeDUvdIjEMOZtpJAZRKqt2aonKw6uJnnGT7qpo2ocWN/8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK/ENO2r; arc=none smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK/ENO2r"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-139b659a45eso508016c88.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792400549; x=1793005349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=ZK/ENO2rN2TZeuiApTi0/qB8qiJrAAE80GgDWCvwwP8dL2ZTy5i9Pz70z+UeUgJHby
         3S82CcH+cC2/NhwZMF+7sjc5KClPEX4F62m3AiHAklTrePFYeYBOXfZWdvi+3FIfPFuW
         M9ncQRUKVqiwm+ka4lz3IPyb5po/cjid+qotIGvWmO+QqfGS2VI3s05NC+e4tQzBzaf7
         s0BSHTbM5+L7ObnGu29xgI7kNK97H+PbSL2Dhk3GjrYkISoyYPkJezBUMfKZKNT9H0ol
         BjDWF60CSZX/owIN7DtTj9UJsHBHWXu8ZQpsV615J01bKdv4skcv+IbR6dTiedNIp5Qk
         J7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400549; x=1793005349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SS9kJ1jH1xG6CLAUi3XRMYbxFYxyeHVEus5/yx1itww=;
        b=D3UEbTTTczuBYiu46iUpx0Q2GMsMsQDB+9QDbY8eWN1hKc2xOkXVQ4SweG7815vFPc
         gEuVVNxn+Ol/eh7jLNmD6PwAy2Ykb92JVK3pibO0cwqxTg+t2XCGEHE2Axl5bLeo3KHa
         4FU7Vl33AEF7dAl/3LpzuOU3nm5Py8GsmeOVPtVGctjEq1bwuNjt7tl2DdnXoehT8lOr
         Ba3Mr5uXevepc3GvKIPEsCzwUulzBX4TmhzHKXV1vusMnZdlOvAGjnUsqag8bkpkhM19
         g52WNb5pduDiE0WF9LhupKRNaxYERLyHuxzHfiT7oSt2fMRrx82Ap8/h6FTzuazsuqnj
         HDMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVkvy8Mjm9kUkfLxguBsurpXDBg1AjyabaA4lG9ChgUZ99Cf008x7ZU1hnaLZ+4xqwNkjwvoSHefRoQw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLtcCFCYuqnWhnvd23ipAR8jjDV2p7ZVF6t9L/2M6XitDNiABiz
	XdCa/BiFa3uf2JlqOY/us5b9NCfWPCO9eNjQi2GWnqsE0Bgc+BlttC3L
X-Gm-Gg: AYBFou2Gt6p0Fu8kaSQYW6VWAaVpHDVSy7RvPS0rLokAjGX8VCa0ODm3KmQY6e/1ksO
	NG2s4B1N8qsDM2JVUpNPb74SKLgaCJE4qPPItcWooYLeziNT9yzm1i1t2N7Pn4vTNrWgFZ6jT8W
	QiyFMmAMC370MlSzNA2c//IM6fC+XwhzdKltHw83xhtADXdLwcxLpEqpyCgZPaEEGIuIbHEV0Bb
	0sla9t+teT/hMIgXbBilW9Dmn6lS2wRXjnRKtHYg4yqtD335nLHpjbWWU5Ib4s9rF7I15FKnuOW
	DKcFEOzUxNHXaQcwpMWXg3ZS5KMrbAOXocUQiDbBfUfzRtDJBDGLLI0e8ufHcQ0TSyeK9umRbFF
	jEniRAtSFgz9Fi2F7V2rrM7XqlyhPUTpmivk5hF1X5DsCrozo18X+5PEBblKPW8I3dFg7gbsR2D
	cdPjoxI2IJ4r0Bj1s3skU71ErSr8qMODg6U8cI6+gw6JTTn0WoJV2Gt2NEkdxCtM3FtEYzqZcwY
	igCsjW1oYEIgqJgsXmPQzA1N78p6/upcbs=
X-Received: by 2002:a05:7022:eb44:10b0:14e:d0ba:7569 with SMTP id a92af1059eb24-1850c502379mr10698378c88.6.1792400549264;
        Mon, 19 Oct 2026 02:02:29 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm27085064c88.17.2026.10.19.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:02:28 -0700 (PDT)
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
Subject: [PATCH v4 3/3] fbcon: Retry rotated font allocation after failure
Date: Mon, 19 Oct 2026 17:02:06 +0800
Message-ID: <20261019090206.1094958-4-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090206.1094958-1-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
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

