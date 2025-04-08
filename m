Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36876218ABD
	for <linux-fbdev@vger.kernel.org>; Tue,  8 Apr 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098184; cv=none; b=ojDbOHiX1OoYe545FJBHZ93JG3cPyBdrWG4l+SBUodXgEAIkGc87JPXCJOoossjcOCzPvG0nr+twrCLxd6z8KGFs6F/QLkcLCi9kqtbF8IXFCY1vjGUzmaoceIw/tKnbgO4/Be+BkD86yjTs7ISE8lRdwHJKw2JKHWHMiuXpMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098184; c=relaxed/simple;
	bh=8ISTBGtoBPV0o3S1L6GulmKX5sCgfZzNnVhJxDI6sJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pnMDMv5GmQr8M3wtRVraTMPyM9lIRWnQawVCvcUWuAdBZJqBKQPsBShT2b+m9vlTtQW1VgHpkU8Ffh7NJjNfqxdBfezNiULI0vjdK/7sNMRQRvMbyl3MGmfixMUn/tzibxG1FOHs9l6FXN1HPLiPFVecEZmmTkrVSTcjPlochKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b84RM+S3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b84RM+S3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39ac56756f6so4441651f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Apr 2025 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744098180; x=1744702980; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnGRyek4b0Q9O6DVrKIv8GSHSuD+kexCPo4NSS6OhDg=;
        b=b84RM+S30tK3PRN7vqlMSF9N4dYkTb+IvbCda5lKsfyprs18zU5ma5Z5unY1kTmna2
         Xz7i+/4rotDdNK/8JU22XKsbXHBPpzC7Ucgcf+p3bmQFnLhgdF680aZKgNH3QY6dYjzH
         dUjCGLxWPZ6laJNL9aZ1V9sX6/BQ804h4y3KR5bjy6bUy2U7Xv1tAt313BMK+rUhg8UU
         3IacvlU9JwuA2xpLHVZ750/zdEqXQmodKiD3JdkYDwTYvlX/VovlCDAHG9k4z07khazK
         VH+iLHAgxPBCeF3jmgDTs4xNQxXjd/YVYINs/8BZs64O9KtbyzI3zdMVdew+mu7GHoG8
         SsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098180; x=1744702980;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnGRyek4b0Q9O6DVrKIv8GSHSuD+kexCPo4NSS6OhDg=;
        b=QxrT5O7krfLvMNQ2moUA/hVUVmxEr1Z1wG0qlP6nJdqgalH1cRIjH3/pApEE0Yrs1n
         wbqfz5sPSfRuo1+Qp3VSX6b5ScuCHbOMoUvKqPPkZvDYkH5saFGFQ4pf4N2XKUuwk+4S
         9Kn02/vJcYr0TPXllJoQgxEW888ccbo0J+ycaUr3bRpdD+68LQCt7MPn1i/ME3syhOl+
         0vM6LXWYuXirS8XxlZWu9Vkrn39zqlbrgxb5w/sEUm3jUneBPTjREiJaBIRQg4oOgxKf
         D31KX/YF/CdZXGB3hwq4V6kmLpzoyGaddJstLrsmTLrnbAORL9dkipFLGdF5KfKszNrc
         BPNQ==
X-Gm-Message-State: AOJu0YxCrlSBjGqP9Nl+2aYmV7wVbtOc/nnhBgDnPlTTv8WCJcZzMIgN
	iGsZXWbFx8ZE6XwPzCrhyMK4rG6fan9ByVB9OP0SDAZ3SJJ3Oa0XDSfkfYrAaLZ+bu6SEk+9KDf
	wCT0=
X-Gm-Gg: ASbGncv4PLYNmLii3pOyYHEsKhC0uX/3h/I/Tzuma0KqpSC2AaersLyoyZdL6XR86Uh
	PA0MZoAjfWYXP0DNy0wNiAnws/ChP27MF2EOfvXs6UIK6SZiDOBIH/vJa5flad2i4TxWjUe3ktl
	FcD0Jx4idkytplHgTC5b7a/u96Q0odQDk54OxRWExU0DztdR6dVGEtWfdIE1Aev9osA8fw70Wsl
	wG1KuFJVycc6jnVHK7GsPOKD8zzrENzlZxaFxX1GI1/CCQsHehLFKZnweCoRAkAfKwTmY5mMwI1
	/H8hCkUW+SGX7HHUsq1htxNWZFLS0+XEnMVnqQ==
X-Google-Smtp-Source: AGHT+IGL45iV9q8qlh/Y51nlH28fz/uo5n75LAnwAcUwjWWcmy/4Xz7sdy2C72SYXaCiAiCukmgEsw==
X-Received: by 2002:a05:6000:2285:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39cadc85ab6mr13296226f8f.0.1744098179869;
        Tue, 08 Apr 2025 00:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2adf:eaae:f6ea:1a73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm157870225e9.0.2025.04.08.00.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:42:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 08 Apr 2025 09:42:56 +0200
Subject: [PATCH] fbdev: via: use new GPIO line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gpiochip-set-rv-video-v1-1-200ea4d24a29@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH/T9GcC/x3MQQqAIBBA0avErBvQrIyuEi2sppqNioYE4t2Tl
 m/xf4ZIgSnC3GQIlDiysxWybWC/jb0I+aiGTnSDUEri5dntN3uM9GBImPggh+N2ymHqjdFaQG1
 9oJPf/7uspXwfzH8VZwAAAA==
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Helge Deller <deller@gmx.de>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=yngfshF14pwSvzrYSNhyzUkMWDnjaEIdy0M4XDuzgqM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9NOAFPzoYiBfJTd1dvJSY7THpbhM5Nui3ZcaB
 ywwwKbK9XSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/TTgAAKCRARpy6gFHHX
 crk+D/9Xizg8WvZa9J61rbqYpcpvD1ujH1jEBpC2/Og+c4KsE/FYxmYpTFDxBBH9IkCNU0wZ+MW
 sXsQwo8xypAlB0Qkmn8E4YG+7VqjDpbbq00hsJNax69W+Ces/apbqznairccWCqnWraBxWjxlMA
 qmLoYtdidVEQBbYSFHmDQWFjfBYnBbxhbSSrvwpbGsJLsmTo3mtZnSTRlkOzwRxvoRcx6gAlo/l
 05ShLFNEo4ofMRbiQBiB6Q+5PNS4fCG5VqIxmFykmT9fuhZ+gGNfIdE41tX2Cu/7rdoTutaFa1c
 GlsasQIGu33rxNBj3nQRS4hmPW/uUvSe8p2/xGqZ6heD4oFMxImiaMckAdvl8ogEqULDzknduvk
 L6eeHIWdzXOqYm6uBpMmO6w9XJhcCGJf3D5O5LSSZDBWBPDR58x0xDYecnSrhoMLxcV5y8QJphB
 S/1FBPnALDBJSWI2zsF3KfzpkJFOEXE6iA6ph7u+bz+Kulgqd8oZta3LL/VVJN3kOkbQg5LhI1r
 Fs5mXSUi9X2tNacDZ/4CXZS6xYO48VRwKEQyKQntkXb9yYOi6XsQH1szvlipwTizNW88c6w5vJ5
 2qD7Pp1PSJC+CHjId8JeHhL9CGNIa4HMH+CJZEsDJsbzUX7WkEL92Z3gs3HolgyKBdH6NDFgp9G
 BtCYYpvPO2gxKfw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
values") added new line setter callbacks to struct gpio_chip. They allow
to indicate failures to callers. We're in the process of converting all
GPIO controllers to using them before removing the old ones.
---
 drivers/video/fbdev/via/via-gpio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/via/via-gpio.c b/drivers/video/fbdev/via/via-gpio.c
index 9577c2cd52c7..27226a8f3f42 100644
--- a/drivers/video/fbdev/via/via-gpio.c
+++ b/drivers/video/fbdev/via/via-gpio.c
@@ -81,8 +81,7 @@ struct viafb_gpio_cfg {
 /*
  * GPIO access functions
  */
-static void via_gpio_set(struct gpio_chip *chip, unsigned int nr,
-			 int value)
+static int via_gpio_set(struct gpio_chip *chip, unsigned int nr, int value)
 {
 	struct viafb_gpio_cfg *cfg = gpiochip_get_data(chip);
 	u8 reg;
@@ -99,13 +98,14 @@ static void via_gpio_set(struct gpio_chip *chip, unsigned int nr,
 		reg &= ~(0x10 << gpio->vg_mask_shift);
 	via_write_reg(VIASR, gpio->vg_port_index, reg);
 	spin_unlock_irqrestore(&cfg->vdev->reg_lock, flags);
+
+	return 0;
 }
 
 static int via_gpio_dir_out(struct gpio_chip *chip, unsigned int nr,
 			    int value)
 {
-	via_gpio_set(chip, nr, value);
-	return 0;
+	return via_gpio_set(chip, nr, value);
 }
 
 /*
@@ -146,7 +146,7 @@ static struct viafb_gpio_cfg viafb_gpio_config = {
 		.label = "VIAFB onboard GPIO",
 		.owner = THIS_MODULE,
 		.direction_output = via_gpio_dir_out,
-		.set = via_gpio_set,
+		.set_rv = via_gpio_set,
 		.direction_input = via_gpio_dir_input,
 		.get = via_gpio_get,
 		.base = -1,

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250331-gpiochip-set-rv-video-6bf1584aa770

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

