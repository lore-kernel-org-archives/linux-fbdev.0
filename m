Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD12749FE
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478627; cv=none; b=SwU70izctmqNU7r4UonPtF/DkNnCUzZzPl1D8yW7/JHGJYMo52KHUaVlLoPLND5pMO11+eZgkjrPmBb3N6+9mRaqbWWVoU0TbEI0KBNVED5xa+wmO4jWAL7j76bEZi+3FE4i7U7LkaxnqxRYN7Zu2fPKT3Oa6+w8ybGtLtVoJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478627; c=relaxed/simple;
	bh=WkAb2pNhz6Dgl69G7CNYQ64QUWJ4cKW8u01AHwLjZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVkGE2J0AkuOTujpAxGj2onPk3cbkY5gz+CpZIf7e8u4B4GWFa+dsqg+1hO/0fFjHZclb5m1+pkMEPWTfp17t3zh7Av3lfnb0+l40RADVpSP6UfKHDXN66oNxYV05blt4nMz+rJxNYikiQ57/B7G8/K5B9mjh6RRIc5U4oi6KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2jD9LbV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2jD9LbV"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8e526081ceso149786166b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770478625; x=1771083425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyfO6Wt4gjdc/BNcrwfaeBvSt1Wq2H1phlZ0J+Zduew=;
        b=b2jD9LbVdr5XRaKmwHK3yOUQml4pAV2yrKX/Emt3/RiuzRXm5eDx4ApEZFGY61O/4I
         dm35SRm5EMNXjGA8xeMxtq/3B9N4PQu1/ImO2I+AgJdhvhZKFYFmKs4s3JKZEF2PN66b
         zjVmADTqxS9H3aQ7zKQ+S0m40tZMgw0C8AvJiE8vjeXsDoG8hWtpUx/x1CC0wz/e0dLN
         VUE+pB9UIuNI0BKBeDjIZkpaH0d7VUHFcq0gqoegbLgv8S52VebsUCt+l8OVxTQGn50/
         mQghv4bcqPPUfkBBLscasUP94rK+wv6KFecNY3yk0xrKUVEIxPTzoJ4RHQeHKT3HZ90u
         XxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770478625; x=1771083425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyfO6Wt4gjdc/BNcrwfaeBvSt1Wq2H1phlZ0J+Zduew=;
        b=NrlvywZHfQ6zsZwbsJHZLSJcVWA25rixKr1r2GrsPtpNCcQt0BeJEYRY2zg9ESsx9G
         nK4GRHWfbJ2dJaONuIDqPEcLIkTc+dNE5BRrHiNq2h7GwQRSG8D08l1gD3pjKpyNtLJF
         NBGH5x500E0RcrgpCfB9+VJ2BzgS1FWRqlADqmR2bMRqr79Wxb3hsNcCZQ8/Z0pG/b1l
         dU1omJsIqPvTjll402GRCbPHe+OawI2peFt09mcUhuSknliIBcPukuza6lrWkNyzntFl
         RIUCjOL5d6xFWHNwgGYYKR+sHhaYQUNWLf+U0x0/u7I/OebCpzevhosmLN8N3TtRM6Lm
         M2Kg==
X-Gm-Message-State: AOJu0YwVGKHZwwBgIZ0qP7ZjXnUMT0bkiMNLmIgRuEzE5iD/7sTvNTot
	GDDL2/Ixvb7NnSNMfaErV71D6ShiNvSgYsRXS2gJIfRo+LboNEsDqXJH
X-Gm-Gg: AZuq6aIHUyRXz9429bAhcj6i6ME8ZK3vPTGDIv/zUCz69ojeZ7jMHoFd2u54xBaFaGZ
	DNgQTVOEjTsOyvhwfusCFGjk6ThWHjvjr0ctL9pn2hlthoUasxhV8ueBu2g3v+3STlNrVl9WWsi
	+3hWhmd2TqVSvtIALdCJuBhXamnhKbr99F4hQTVanbibHTfS+XnAYvtMloaHWfBsh8Q60402zHB
	u4z10mvcBfRzMQwKaOzn+Y9BaC5zoLh55r2YucT9wywRSu1Qp+q48zxKFZX8MFxxSI/s889CIm/
	n0hSk2A1FsZDX28ZQ8ujNJsj0N6gVJzVBCot5SC7bFpC+XTwf0txINp4KztY6sh3qugGwauhFyb
	Nc7Oa3ej2MdkgZYJMxDX7Y7XHLh8OEHAGqAZQxucPXbDdxcFgMlcaqhmzOHguPL+/zgw1Iz9eyQ
	c7RgJpYrPbo8f9HwcvRVTlxLqYx+21eV4UwAmp4gr8gBrpgut5LoT+EImTUfZIw6rQ6V/Q4xHu4
	j4luCk0JZ40WgvtqEepwuewuKFwTkcQ9bswHU1qBiJgx1lbTXzJnU0ZBjZf7YYM
X-Received: by 2002:a17:907:960a:b0:b72:5629:1789 with SMTP id a640c23a62f3a-b8eba132f50mr614997066b.13.1770478624847;
        Sat, 07 Feb 2026 07:37:04 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (170.249.141.34.bc.googleusercontent.com. [34.141.249.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda748aa6sm181308666b.1.2026.02.07.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 07:37:04 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v4 0/3] staging: sm750fb: clean up logging
Date: Sat,  7 Feb 2026 15:37:00 +0000
Message-ID: <20260207153703.2049-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the logging in the sm750fb driver.

Changes since v3:
  - Dropped the strcat and strncmp patches as requested by Greg KH
  - Consistently removed all pr_info/pr_debug/pr_warn diagnostic prints
    in one patch (previously some fb_find_mode prints were kept)
  - Split dev_err conversions into two patches: one for sm750.c
    and one for sm750_hw.c

Patch 1 removes all pr_info/pr_debug/pr_warn diagnostic prints
from both sm750.c and sm750_hw.c. These include address dumps,
debug variable prints, fb_find_mode result logging, and CH7301
DVI chip status messages.

Patches 2-3 convert the remaining pr_err() calls to dev_err()
for proper device context.

Artem Lytkin (3):
  staging: sm750fb: remove debug and diagnostic prints
  staging: sm750fb: convert logging to device-based in sm750.c
  staging: sm750fb: convert logging to device-based in sm750_hw.c

 drivers/staging/sm750fb/sm750.c    | 88 +++---------------------------
 drivers/staging/sm750fb/sm750_hw.c | 26 ++-------
 2 files changed, 14 insertions(+), 100 deletions(-)

-- 
2.43.0

