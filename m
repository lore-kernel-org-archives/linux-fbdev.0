Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793429247;
	b=j06oZCnjG9kAbkUkrqWuBuQQmk1jv8FtnXRqV4CWs5KnrByof+znxEqxjzUtEXvA0LED
	 F6UX0LLqYRc3T2Nt/KqXV8kEx/VaKObNC5qjaHMW4Ax6pWwf8PNuCNPtVLd+Vf8WVklQh
	 Ch5XO/C2l52rdWIcxY5fGpWAQaI8mE3U9X2NR7tCjX7i+AfHRbjZV3NYDuSSZuW6XWJL2
	 wqLMuLYsQKjcu/gAQRWnvMwQxgmvqOH1Rb4ngz2Vl550h2yPU7qAArxYENk799qmP3kyd
	 V13vB9p5zG7gyhzHIzdkGaQCC+9J0n3SveC0wY8146s9ZuNlDBVfcWgA621HOti7dPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793429247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9U3dWfP9wuIKNIASQMC6j7LlTeXrOraHdMR5EURM28M=;
	b=JbuWWqdFr6pt4WyQST2zy50THkytr+3WKgpCYKGu3RE/ih0YEDrUntq7r9iawNYth9eO
	 fDIeuH4On4lqgOL/VpEmG5BPDqC6B1te/9McquUJYc+BX94+2KDgWCdJq3y1JApaquU7A
	 JvrP+fUZfjx5f0UQKLEwrBBfRVwuuaqLWZvEtV2ej9rCLpwBfl7Vr+P6CWGz2RJE4QCTE
	 +0T/SyOumkPhMMsPB+UoOaMVFULZbk74x75zFbMy9SwYq61lSsaIIn8wNk7L3YTzTvXn0
	 P44xFU7lhMpZ24i1PuvtRlVuBWXICd4SrGJCU3thRGWK2jsCNKZTEgHlOifQBlz9aPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZhqlFdHG;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D39606A31A
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2026 06:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZhqlFdHG
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c414e5d282eso174318866b.1
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Oct 2026 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793429246; x=1794034046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9U3dWfP9wuIKNIASQMC6j7LlTeXrOraHdMR5EURM28M=;
        b=ZhqlFdHG/4Fe4Aj0hNIJOjbgEETH12U5661PKpmYqz1xR8tHK/kqg4aY6pEODGD5H0
         LlOA+5112rYq+/P4t+2I+DKweLBORfOZ75XQycazt8sBq0xn+iwE3TTpIbU33BfMg3Ty
         m0yV92yb+vQaSs76F0kmqQYBl73CgLoLiBDsfc/fBrwhUQ9E9be8W/+cvMhaR2lLwS5a
         Eh0DM/216SaxM7gRZaGGGLDfabR79qb/trJB+ARbEBzdZJkwBxvz+D0JPzaZF3CKFdjc
         gDwAyAD0L9nBy7m1HQBt0/lq3J3rlC+Gay+rVticzvl+glaYdTybSuDJGtij8aeEv0Ys
         Pgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793429246; x=1794034046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9U3dWfP9wuIKNIASQMC6j7LlTeXrOraHdMR5EURM28M=;
        b=GIpX/VKi330BuLsTujvgoxisaaHd3WZc9BBu604O9m4shK13rN6jhQ/27q0440L+ms
         YUFNsMOrNf1+t/qr153XN+EeLF+rlc/ZrHSRT8Xa0FBgRqWbBJLUIPXT/AWHODSj7G3z
         cSbcSEMD2Y8h6d2C9LDi0KzinZuUBkdu31caJkvCOc+F3yPCpF8FGhkGwQUXHY1xvvxd
         6ZO2KUZY4qDN7PFylpcCo5UBXHMupKWmWVRG8pjMSEiyQ9PeshFHzOrfJDLHITqCgP1r
         wT5N5jXbZjMFzbPVYZnm49OI+2mZW4FYPSs5pzAj1w179md1cvWIRPkXe41mc/hZ4Hc+
         mtBA==
X-Forwarded-Encrypted: i=1; AKwUvBwVF2pyOmiYmO4B789zKiWgg6DSaMtBJvSNqJVwutB5jnIs6RVWZEeX3pZPbIVspq1t+XSXsOYwcTnwtQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtmPHnNtryF35KdtXA1pkX6klNQ7FjY7qOjs13IJQinUM7zJ8y
	GyXFlg9b218d6/5MQFqXSwIduJRKDJrjB3EC89eCrLvHjOPVAo0qJY+x
X-Gm-Gg: AYBFou02PKI/ZPjLHJaZenb6T7BXepBnDvPknZeyVAuDdQPWKdEl3Vye/eZy3tafAPu
	Hgm+J6KWefTv5iPoLPs6UONdE/0kAP8b3Gi6QQvVsS4+dxzW24GoDcUjGb99JgK1l0Iox29TIAV
	54z2Pbuet2+ng+G6eYYCqvevdzAT1ESAAxGRC+qwZNwiJ7saBmqkNJoJSqAayfVP+rSd9gLeurA
	wSZeiAcKdyHLUIIe8HpzuXxkHpjBM4oSdR4+MjufPNxswtLypY3NxRy/tMAC7CtvFi7IMCWF1mF
	VznjGvHNHB0e5vKghrMPphYoPzbFghVR3fx+5ZkcUU7FLRk2AivZ/pD2EuAsD9ixb1LhTMTJmIY
	xTjAsu5VwMnNFz2OqULuLVgOjTbvimx7e/9Fypg2vIi2cEZU5ojiVp/ojlYU/7InFe+WwShSKBA
	yJZVvAVJ4aBuE9GjYF7yP5Bxr0e69UVm+HAKXTwnRWAKZ5FyriC2qOFtdZqYi3T2nQKHcF4atGG
	Ql0UWNl2izIlFZIqFrA9goXc1iyL57J/v848hS4yK8Wk0tljQBUz2JOksBRH3+bQUdm0aQZY8jz
	WvfUxWRXMiVy3vZYVfLVVkY66+PZk/jqTuEIzCWngYeH+nPMFUUN1Vh6/p4KPVt+JOUulQD9xD5
	CblHTo4X6z4GteHAX7svFR3RBG1ZID4GEYmNSbnpJJ50zH2OuC5XFYp1uYcoZyQOv2H0=
X-Received: by 2002:a17:907:9346:b0:c49:b9b6:4b5e with SMTP id a640c23a62f3a-c4ca7b1f727mr373328966b.20.1793429245709;
        Fri, 30 Oct 2026 23:47:25 -0700 (PDT)
Received: from maria-VMware-Virtual-Platform ([182.186.37.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabf43b19sm145030266b.87.2026.10.30.23.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 23:47:24 -0700 (PDT)
From: Maria Sheikh <mariasheikh812@gmail.com>
To: outreachy@lists.linux.dev,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Maria Sheikh <mariasheikh812@gmail.com>
Subject: [PATCH] staging: fbtft: fb_tinylcd: align argument with open parenthesis
Date: Sat, 31 Oct 2026 11:46:59 +0500
Message-ID: <20261031064705.9513-1-mariasheikh812@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Align the continuation line of the write_reg() call with the open
parenthesis to fix the checkpatch.pl check "Alignment should match open
parenthesis".

Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c740c5..d58b1247262b 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.53.0

