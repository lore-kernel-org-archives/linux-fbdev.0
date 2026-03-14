Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5131E82D
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Mar 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475798; cv=none; b=K6NmQlyLpIgJ2d9hw1P7HPHqkOBHxpnFLwikmlmpdJMpr3KXdfhVM16j4+DP/5wn5Bx0j4l2zOqBvtC3jRPcuSTNLV0YnX2ugFn5RHumUxWcIWXk2z07hytW//oNxzXI9WBQ2OREaO6UCkqcwd8vL6McLPMWSRZQzlE7qmfEUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475798; c=relaxed/simple;
	bh=Ej6quQFb3gfPTuE+COdLvKyXP7sId4xnK2ZAaE//f5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw1Mt4c8qXI8ERCcGnH0RVoDlAaBRFTXkxf9DL6EEzZNIaYyW7Milj5wjrmxt/OBF0xvIKTU07GiUwlD9SpN7KNfrAEUsYmIYS2TFwM5BWEdghf75VJoSW73OHog+mQ+m0IatVmwk35RwI2bHoSXY8Xiuk9SjKOfA0FcpLFelkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acVcqzPw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acVcqzPw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaed195901so14304645ad.0
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Mar 2026 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773475797; x=1774080597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bij56Q8/mZC/30hBYzuyhlpvFrw3G2CfXcV+RBR4NDs=;
        b=acVcqzPwbTJfSmggP3FWguGIkbX9KJYPnk7r0XWX8RHnWE2bBESpQNHkzN0DOodSrj
         ZMUqlK6MgGtF57giWnHbO3lV7RRLJSuc3pmxm4ik/quUqIGxmFFIKt30Tb+WnsaqXtNd
         4u9u5+EY/KmZYFD+6DnD1svVbbzbM/rOE7p79qW5884rYWRYEtgKi93wIQCPjxFNPpjO
         4jGqlE292wkQkLw975NSGPPRt/7OLhToVGMBmzI9psowr8+3BBisE/3qk4pcMBbW8hUT
         CGKwLGdApAzk3491XySUb+HRCdAyIhIRzM9Hk1xJw7tTD7NsZ6cg4B/S+ROlLcRf6nv6
         7P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773475797; x=1774080597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bij56Q8/mZC/30hBYzuyhlpvFrw3G2CfXcV+RBR4NDs=;
        b=mcTqyA1e8TCDTTQ2OognBKoeRzSbw/gq3vwfB5wVI7VkB9k1+07Uum+WZ8fWctReR5
         a8m1usHMDIc43GXw3L84RFkMYSU2b5KJQQfF6DfmE5LwqE5FV7kZWlcHnX1iuCk0oGjy
         39LxwzruqJ9XsldjgixN369npPhl0NldOKAHJYPSCWsK97NAOVONTRi+lp7ToX9YXDb3
         9fukhRI1W1NT8tXtrDqTv5iL9uYVYkE9ZfWtUS/35KDvp+gbfBj1rmgoPp5UeyXdrsrl
         j7jKa8y1LIfEZIUG5l5GNTBz5foUb7WlYidGeO4/H6P51oLanO93/JqfyE/oQSvYqrD6
         9Dhg==
X-Forwarded-Encrypted: i=1; AJvYcCWpT0AYN6ORfMES8MMGT8fcmNX+NZhHL3qAvcovhbgNjizxsLM/kPzKZuyRLPY1jLwpanX/qmP7TSWmYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiFVLvEOBGsFvO9n6BDs3Ni4dRXVMHZMWb/veZxhYZLZgjEUn
	poiC4A/+SzPgevFhL1vzEZEqHCDfioilcwjU8dszcWSobCU2ZgZZ3YC1
X-Gm-Gg: ATEYQzzpQjuWaphjZAEQIH+fpbRqzEGMw63Kz0bjnFYUMnRzUaEP3JDODHM1ffoYRoB
	i0/pCvvPWJwGIHNuoRGT/rZVRyMxmpzbfRe8jrJ/+B2hS0yJgunrTLM683pzkLJ2oZFnUCLU5hf
	Tq88RWWxWPQsQ/b12OrYJTHGqwyJ1Ts9TfaLXVOtYZVbwY2IK9oZd45KeoQI+KkdE5sPWs5A525
	+r8KtH37Ka7Y3j8ofgSwA3iE0s2/h6joHbwV44LEisyC2tT6J7Ed327kFWpxFKagwF6W2iLdldb
	NiHBbR7JFVsCfMLJgYRp9az+Xqp7Nh8DF0aAczpoHy1E86/I6cTwSadMMMDEyy2q2bvXMp96W43
	1ucgBJjFk+4Df3WpXtpnlq8adoCiPNC1SBm3Epl37Ya5G6vqE2k7KpooqIEkZNST/VIUMlb8agC
	AYUvRSaQqnKcHPU2knI5mkBvWhtgalrRrF
X-Received: by 2002:a17:903:2b04:b0:2b0:4579:ae6 with SMTP id d9443c01a7336-2b04579119cmr9368075ad.38.1773475796882;
        Sat, 14 Mar 2026 01:09:56 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:d0d2:2da5:541:7e3c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966d9sm3665378a12.11.2026.03.14.01.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 01:09:56 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH 2/3] staging: sm750fb: Rename struct init_status members to snake_case
Date: Sat, 14 Mar 2026 13:39:31 +0530
Message-ID: <20260314080934.135457-2-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>
References: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename CamelCase members powerMode, setAllEngOff, and resetMemory to follow the Linux kernel coding style.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 729c34372a1e..c30ffab8a5f3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -921,9 +921,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.chip_clk = 0;
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
-	sm750_dev->init_parm.powerMode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
-	sm750_dev->init_parm.resetMemory = 1;
+	sm750_dev->init_parm.power_mode = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
+	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 49a79d0a8a2e..b683a82af349 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -39,13 +39,13 @@ enum sm750_path {
 };
 
 struct init_status {
-	ushort powerMode;
+	ushort power_mode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
-	ushort resetMemory;
+	ushort set_all_eng_off;
+	ushort reset_memory;
 };
 
 struct lynx_accel {
-- 
2.53.0

