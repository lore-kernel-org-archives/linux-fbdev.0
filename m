Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794779696;
	b=EIm87II1Bdm1JWt6ugPcC2uoMtvnrZ4z8qXu+DapXbTWNvdOavu5zMm+VbIOPjx30RcZ
	 aLeutsBOelvGMNBLZQqpnWeqeEbRjNy58FWRcG9/Gjv4m4TWT13VdxY1z9LLTI6raAnCd
	 Uwx++t4tMsJKs6/K+TYiPPnW2+ADksQE6nSFIdDQbk33EOW7Ih2fIaV2E7LBquWHewiw3
	 sIQoq1KASDUQy9E8Crk8HPdV1qTeP+PaMQIe385QSmNmq4uI9BG9kwYpCIwyAoUxYWEE1
	 BhQnUc8nw/QDdI4h/oAliJ/yxFaDTNMlU2wsHtpyQIlQmVc5RbVcV8cGlU4eHQ+D0xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ll+dYl6IjHGgVeB0nKnh3CO9OrbX/VIAlSchVwuRn28=;
	b=us+8FhSDzNQ6vy3f0hsU1Y1Vt2rJB6q6SuLKdcRokzHDAG7QxL0tliPXWKXJL9VTw0q6
	 eXO9gGHyukEX3/JlN2ZBvf7Ic7DtXz+0PT+YC9Zhz5HCAIo42n5/LQI/A+2lkMKQSCN34
	 xcilIkvKllu2MOXHB6rywKBSjNRWp9B8g5ftVP5Gml7cxQKzXTWInw8v+ofE9L1k5eSoA
	 +yoYEUVr5mTbz1PDFJCWm2ngzRioK2oyJF2Am8bZjS49jcA+Pg0m7OtuOvLGgwks1ISvz
	 ZqV2AZrosKshfNyDmshT0wqatG8vUv+T4/0W1KDJodJpajP5QrRjSZFHhMUa5KyHV/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLp8UpIh;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA276606A330
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 21:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA276606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLp8UpIh
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4918c2d727fso1466376f8f.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 13:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794779694; x=1795384494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ll+dYl6IjHGgVeB0nKnh3CO9OrbX/VIAlSchVwuRn28=;
        b=lLp8UpIhczoGU99bKCQ/deeLU4T5+QOEljlbDSClUD4xBGymN7xpLVok+gvT6WgU8C
         S8Fw4KQGzqMKgthHIsCpKE26cWMhffe39FAnlPT33fg3S39lY7CqSNnyl8ycwYOGHGKS
         3NS4AIbQH1EgHzck90Rhy0TU+CEFMgteHQJd+0Pf6dLpAVXClgJZttXPb4DpunMGTki/
         szqDnwDynTAg5IBAm+x3HWSYO4nEZCDDgWSwwg/M8DYlaW4CCKJiWh+MoKUPkJpROG2y
         wcApysLZuT0rDb9oTgoeto1IuaGXMOyiUidNFhnx3AHAkc8a0SVsbiyUMpfDAkHuSxg4
         Fdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779694; x=1795384494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ll+dYl6IjHGgVeB0nKnh3CO9OrbX/VIAlSchVwuRn28=;
        b=PVCkFjDO0ooyeZcnf2j0zEOg+yztUE6bw3L13IU/LgL2S6cI93/K8qyqyWClItXoJF
         3137ZqcnSsUiBV7I0WRdqtgjW6HRJptjUwQU0wsmRzAfjtZHZBrbat4ni/ckVdyedgei
         m0zIxywtIc0bqcEgKigrle24prlhtXowQ5Sm8RoxvglWFdkptt4Hm7+evo1+w8v2n6aX
         JjNL4WzFoVty7pjGLl8iK1/OJdCCUPyWifBzCGoersMTCT1FT7Ts3yGaGtyJbfyEDAzT
         BzDrKKLfxK50XHh+wnEmKoiaYzU19mgxpqzMFUUVJeKozbrzydszg01l65Q+3b+xnXxc
         gUtg==
X-Forwarded-Encrypted: i=1; AL+hErFdlBvhQ0R1Osk4VqAMciJkr+rby8icweg9DfAULJkga1l7qgdw63LZSKTadiUpKwIGKQEazsmWjxMoCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8KFA+cASRel+d0eT+gj69dJZj2fWdO2WefWIjI9vlSvYH7P7Up
	5HV8AhtP4XkO0AypfJSR+UeMOtTWvT31S9WSyxVYFHQ3UxXEWSnXPHlP
X-Gm-Gg: AYBFou1oZxvwQ56JWt+j27Bs5N+pMrS3el1zhIwe3mb7xZErwOJofOME3V7NgZnbZxn
	e+5KaayNh9SmGM81AfRIVo564goLR8jYgZEBLw1BFLrwSsd0lEYAtWGkZC/EPwQeQEcNlWaSTwf
	i0BM6OZSG46RzuwWsH/pV39pFMvMVPdDY4/XQqxet/KWwcEQV0Hq3HYVdzW4G/pzgUt/TY0/CYM
	cKYUrq5xHeE0UKgwl0m7KrHfFAEkqLCCiIKpUix91faWXxKZzUqonZvemi/a8VZFs3SGM6S/V95
	sMRYNQrigNWngotaf7HHhqYsG7RxBJtVDcqt0A3Gy7vQ97RxD6s9PpT9RxvfJQVzEk9HFInRJYm
	yObXoz5hKLAZeUvC1kcffmz3Q+aIjhH0klBakVcVivPNHFhM5ewgl+928zNhFktuSmkm7JCpDOV
	msXXlBDoZ8V9VgxAhf2XBeTx/BCmICUJBWqjb8cdalmoVNEtAOBqaRx7W5I9LqGQm+G40llP50w
	EgZH5/iDZc8zdnPFmfvsl/tQGi40NwN6Cnzy7feOhQLUJ3DS8rrq7BLZjTr5q3bLzleEAXwVK93
	rcSxSIDGRJYlCfduYHj70Or4AcPTm0PlDT/f5jVj6Zx90Hig6UD8y6qEQbINYtnXLFC+4XP3GfF
	d8boXwp8xQsKji3yoUwJ/BDVAkQEFbECYZ3CO9fmjpJ23m3ZHst8eLSu8ft/znPnl/5kd7kGBOC
	95
X-Received: by 2002:a05:600c:5617:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb55a71035mr134809435e9.29.1794779694189;
        Sun, 15 Nov 2026 13:54:54 -0800 (PST)
Received: from leon-mainpc.tail82c8c6.ts.net (77.119.194.237.wireless.dyn.drei.com. [77.119.194.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d673ce75fsm12553145f8f.55.2026.11.15.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:54:53 -0800 (PST)
From: Leon Pelzmann <brunonick1801@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Leon Pelzmann <brunonick1801@gmail.com>
Subject: [PATCH] staging: sm750fb: remove ineffective sw_i2c_wait() busy loop
Date: Sun, 15 Nov 2026 22:54:27 +0100
Message-ID: <20261115215427.112315-1-brunonick1801@gmail.com>
X-Mailer: git-send-email 2.56.1
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

sw_i2c_wait() is meant to insert a delay between the bit-banged I2C
operations, but it only consists of a loop that computes a value into
a local variable which is never read. The loop has no side effects, so
the compiler removes it entirely and the function compiles to nothing.
With W=1 this also triggers:

  ddk750_swi2c.c:95:16: error: variable 'tmp' set but not used
  [-Werror=unused-but-set-variable=]

Remove the function and all of its call sites. The I2C timing is not
changed by this: the object code of ddk750_swi2c.o (x86_64, gcc,
allmodconfig) is identical before and after this change.

The W=1 warning was found by building the driver, and the change was
prepared with the help of an AI coding assistant (Claude); it was
verified by comparing the objdump output before and after the change.

Signed-off-by: Leon Pelzmann <brunonick1801@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 34 --------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index e63f3b00ec..e298bf3128 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -75,31 +75,6 @@ static unsigned long sw_i2c_data_gpio_mux_reg = GPIO_MUX;
 static unsigned long sw_i2c_data_gpio_data_reg = GPIO_DATA;
 static unsigned long sw_i2c_data_gpio_data_dir_reg = GPIO_DATA_DIRECTION;
 
-/*
- *  This function puts a delay between command
- */
-static void sw_i2c_wait(void)
-{
-	/* find a bug:
-	 * peekIO method works well before suspend/resume
-	 * but after suspend, peekIO(0x3ce,0x61) & 0x10
-	 * always be non-zero,which makes the while loop
-	 * never finish.
-	 * use non-ultimate for loop below is safe
-	 */
-
-    /* Change wait algorithm to use PCI bus clock,
-     * it's more reliable than counter loop ..
-     * write 0x61 to 0x3ce and read from 0x3cf
-     */
-	int i, tmp;
-
-	for (i = 0; i < 600; i++) {
-		tmp = i;
-		tmp += i;
-	}
-}
-
 /*
  *  This function set/reset the SCL GPIO pin
  *
@@ -257,11 +232,8 @@ static long sw_i2c_write_byte(unsigned char data)
 		else
 			sw_i2c_sda(0);
 
-		sw_i2c_wait();
-
 		/* Toggle clk line to one */
 		sw_i2c_scl(1);
-		sw_i2c_wait();
 
 		/* Shift byte to be sent */
 		value = value << 1;
@@ -272,9 +244,7 @@ static long sw_i2c_write_byte(unsigned char data)
 	sw_i2c_sda(1);
 
 	/* Set the SCL High for ack */
-	sw_i2c_wait();
 	sw_i2c_scl(1);
-	sw_i2c_wait();
 
 	/* Read SDA, until SDA==0 */
 	for (i = 0; i < 0xff; i++) {
@@ -282,9 +252,7 @@ static long sw_i2c_write_byte(unsigned char data)
 			break;
 
 		sw_i2c_scl(0);
-		sw_i2c_wait();
 		sw_i2c_scl(1);
-		sw_i2c_wait();
 	}
 
 	/* Set the SCL Low and SDA High */
@@ -316,11 +284,9 @@ static unsigned char sw_i2c_read_byte(unsigned char ack)
 		/* Set the SCL to Low and SDA to High (Input) */
 		sw_i2c_scl(0);
 		sw_i2c_sda(1);
-		sw_i2c_wait();
 
 		/* Set the SCL High */
 		sw_i2c_scl(1);
-		sw_i2c_wait();
 
 		/* Read data bits from SDA */
 		data |= (sw_i2c_read_sda() << i);
-- 
2.56.0

