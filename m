Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289123DBD49
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745714; cv=none; b=Zin69NrToksueTiJv/PtqdV1F0uWgj/AJ6wuuevR3lf4Fn6q61Bby8Y8bQi/83jMuzBNKCS6XhZmhsp50QbucNwSha7Wis0U2u49ATOP0nduRPZO5A9VV2YODyDYn9zXWcySR+cngpLA2pVRjrs+alqa5jkquJPlFqDVjB5hcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745714; c=relaxed/simple;
	bh=6p4QF9QphcGSUD4l+uqrzYbIS6kc3jd9F/UtB26ySvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EPu6xNsIFtiJul8zNWRIuAMVA0jBYUrPUGvTLtN3cLrxl4aqZroQlSOxiMiWBmLQyOgJqgkOqJ/KD+yRtdCtZ8TaQEyS/RgtZpC/aPyMcdT2aoli27+n6Keh2kpmpoY6WPm13nNYyLjYMHoHxolU4qDWvh7bWjmHtqoo9ik0psM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex9dsFRT; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex9dsFRT"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12713e56abdso590173c88.1
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Apr 2026 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745712; x=1776350512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHoVRK6G7QNLQuMnHul4V6G7GtbprndlSqKrNeZpyuo=;
        b=Ex9dsFRTI+7sbSul48pc5XlK/Di6OvkNvZtl3RhNf3qMZr/ZSLZQH+vthbdqDkglyj
         AFD+zOQIWp3Vbnfhm1OArRfmn1z1vOWBYILrTNh3tgCZAQLEFcLK52tBHfA8Tj1bMGp+
         OYvOXWrvtpq98bzqnRpinV2HqT8OCqG1t2wj5GQY48E4C45lMJdK3cwoa/T31LWmYjIj
         YSNETlqxfr2QROxYWHwWk8iWsW8pIgWGuItOa3pwFFGkleAYo7gFFCw+InleurffILtJ
         CvwIf/kQw5x5jJj9Ggs7xWR05Lb4LD2rJ8tlgb7NZ4xXQCYb/BPNPgbbAdNaKP3q+TS2
         GJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745712; x=1776350512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHoVRK6G7QNLQuMnHul4V6G7GtbprndlSqKrNeZpyuo=;
        b=V+/DApapCNL5umw80jZuvEZxVg8ft+DmrMMYZxunC3VIKovu+4vOwFziRX2/ExlUju
         mwO8ICph3nAxeQViTZLE8mw1NlvbH3qj/j52cmyU+1GDm20owVAGGvn4tIAUDj7Gxj8R
         U4MOsin3AATC3EACyYfs5Wd+YNrjsxvCfErH1jxwUbZsY0V1RQnKMNvFYcAxS4PISQV7
         iwv4+AgaeGftJhRBlIqnfHwiXXf0aPkvswI7LGyNELVnnl8x1vkh6Vry9Ll/N8pPduFF
         BA9OeJgeeEFsZRi4wIezyvhwoAghBBOMadQFSrm6dRogvIeQ41Rt4WYyZQ0XFkb0dkby
         HoHQ==
X-Gm-Message-State: AOJu0YwNMlD7TP9fGD9rEMCue0Qeg0uKTKrgnpaAKgpl04wZhXH5epUI
	hrnWQKO3syKqAPk+o2KTwBsNwJqt79lGxhPnlE8jNg0cT8ZisRd4hX7g
X-Gm-Gg: AeBDievRqjZtsc4WPyfotAyTlkHbJ8E23QkC6CjTz/bKEHmGlZBhdaGi3qcRJqzy9cm
	oM98El993sn7UcBWH0sGAKdwc86V8UPl4gbAI38UFES7eEgKeBTM6coj0mQRnA2L9qZczUkLnoj
	N4TFug3/sRGdwSiGXjfj+3EPXi1QrgBvloYhWOVw65XeoF4GIDKFK0Gl27kQ8oD3VwHqnhAOJqa
	GO66JPns4LjgfOVSj9zqEWqV/jaOLEXBc2KwewZ/Tz10tDhIngfifu6WMYnpy306F/RI57Z8ERN
	QotR3U1c4xBPjH6w/8DgqoTO8ycnsQtyW4Gqe7w/zpXGy5C9FmYU+uP40tvr4OPdHIpd7fHDp1X
	v5IWXQW7HYvmh3IArF6mumiVoaKImOJKjVbnvygD83XYkAznPItB93DwBZSV9uqkxASzWV7ECOQ
	yiXL1uo+VrUe41GzLWS8qfFxsKSPW/HbQo/vLoBLCXiFQ6XD4j8U43igg=
X-Received: by 2002:a05:7022:118:b0:119:e569:f874 with SMTP id a92af1059eb24-12c28c2f6cbmr1557835c88.17.1775745712202;
        Thu, 09 Apr 2026 07:41:52 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c07a8703esm20363284c88.8.2026.04.09.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 07:41:51 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH 0/2] staging: sm750fb: improve error handling in de_wait path
Date: Thu,  9 Apr 2026 14:41:17 +0000
Message-Id: <20260409144119.21500-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves error handling in the sm750fb driver.

The de_wait() helpers currently return -1 on timeout and callers
discard error codes by always returning -1. This series replaces
-1 with -ETIMEDOUT and propagates the error code to improve
error reporting.

Patch 1 replaces -1 with -ETIMEDOUT in de_wait() helpers.
Patch 2 propagates error codes in callers instead of returning -1.

Hungyu Lin (2):
  staging: sm750fb: return -ETIMEDOUT on timeout in de_wait functions
  staging: sm750fb: propagate error codes from de_wait()

 drivers/staging/sm750fb/sm750_accel.c | 22 ++++++++++++----------
 drivers/staging/sm750fb/sm750_hw.c    |  4 ++--
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.34.1

