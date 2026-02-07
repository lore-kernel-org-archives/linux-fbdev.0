Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D234FF67
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501926; cv=none; b=o8P2haveKXdpJQvDbsQl94fsDacMfjb14OXTKU42Rii8d4p3RoOrp9Tq3lJgCjquz0QNYSY52C430Kw5YCUKEnwt+wR5LTh9X7AFrG7HGC+tN3P58LGNldqUHBech/jecf1+o9MJLyILX4Cw6SbKC+Drb+z6cdPyhvgzqheL+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501926; c=relaxed/simple;
	bh=8H2Ql6oifHkT4CjsqLdLoTTkCv7GeOjtLl6+VhEXK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+PnzyZ6s4fmz5cQnPRfpgSZ+znfIq8Fom4oQ3MjyMLMy9AMV5x2S2i2zFBcNU56ODmxmcBMLvwwCMPLuwM5Dkr0W4E/DUWXZCPjnRkfdOOErl8/JjvMKIMRn9kh+RXPb4qtxWatp9AssTR+hTg5XkOtNvzG5DB4gQFALVgvkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHtJgOvu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHtJgOvu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so503971766b.2
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770501924; x=1771106724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkQTUcevqbbom2GaQZHgQn6sBJw6oM5+vBUm2+nyG+U=;
        b=eHtJgOvuy2oElYjR859Wij2npV9D7oaW8AnAaZJ51eDDHJ2RNjZblcLjF66hw4RXDp
         YLZbCDlP9h5XT3jdZplj0glejiLcS9AoZG0JGHWzugQuY6HKZVz1/9+ZzLMxNGTrMMBF
         0aGrZ60+799fLffwcoOFHu7XkvY45tmt4ZsjUigpKZHO/O2RLk1bId/rD3yZ4Ds7rfvs
         eGuuFHAJuPkPX19adN3Mbr8OoBS/ZiXWV65RVuGzq6/kMlNvAVrCYnh9WeHyvWk5oBGl
         tE0Uw5ePiUoxzQhq1Z3NMTjeRRg0jz1fydlR36y/dMTJK/gRTiXTXIki1fT0Rq2DdQH7
         1riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770501924; x=1771106724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkQTUcevqbbom2GaQZHgQn6sBJw6oM5+vBUm2+nyG+U=;
        b=S3M4/msR3iAlty7rqJKpqlHqK/rhjF/FW+xx4MuZuLMN6ydCBGLKQlvmiZNhoI32rN
         VHR7AjANuES71D7nQo07JZUZx0GAE+OiiVUPwAoFV/TU8NkwIwe/zVp/K9sn8jQpkHPE
         EEcCPoz4TweM0sVUcRT1S+KONhomlyD6987yY/YetVsXWh1VmTfEH7EukEUQXrOfebmu
         VRdOo1QnTNw5KAIrhQPjWIRCSnEETFvyTdx0BfhaoWVrqO5V/MDWABFtRXy77k8Y1NgF
         wsiaJZTh8pvOEpy8bTmRLjOriVvdb86mg7V4vkZdAiaxo58+fttFKuUYEglQITd1ZLag
         HYcw==
X-Forwarded-Encrypted: i=1; AJvYcCVyWuXPyA/KHrLViT+iBa8a4n8PN+zHM6afsv5Aoo6PtcMB7RvT6FBMOe/0el0vMU+LucXtanWz+dfw7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlzbXkzx37L0XEXJ0WHHv2PZkC3aHtvupdSsMHIsseglu4PJL
	MgoWdagv2XLTMIMNGll0MQ+qFerW5rW/jyXg9/XqByg/VRkp2hgDoaqY
X-Gm-Gg: AZuq6aJ/em5G5ySFgz6S+IsC2OZ2UjvrmR/u0pQRtRX4XHJaoUDxpJ9ntgUtTBYkomm
	I8Wf3lDUODmB7s3TCyC64Bg5VqkcrQFNCTxpMEvQSyq/OJzwgWz3R5Ikp6lanfOcPXApo2EpTb7
	6hGAASz0a6di+nv/M3HayJjs5Now3NilDGGEaa/yI8Luq1+1Tu0xBi6k6icQgZfY43LsjAJIdP5
	G0OLzBY+hYR0Bmda54NHk9+GE6O+0LHddZUgCE6OCGZiVI/tkIif/XjU8DVVQbo5zBw03VDTWSE
	rn+hCR90DqYKAwFy5q2aEgJOA+n65d9qwuV5M7ukw+dj8uvDEKpLn24t7vwrXzlBLHB8ZF39hEH
	3f5HuVrrVupjG8I4rffLKfUgQ5NcmCyOKpwzktiRDLoWipn4It0kafCYaCL3X3JBCzRUQvWgEle
	VpzkUsKziRwQpKwyUz9tLOpYx8wwgxM4e4LHBetodNVyXFr6jEHBfeprD5JYrY3cUARHixUPprE
	ooQhOJJ/IsBOqceHdKNYwx/5WJXJfz04Bw76IKibk5mCp7vOksQwPS4
X-Received: by 2002:a17:907:802:b0:b87:1590:d528 with SMTP id a640c23a62f3a-b8edf2fe560mr403194166b.40.1770501924363;
        Sat, 07 Feb 2026 14:05:24 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (99.86.90.34.bc.googleusercontent.com. [34.90.86.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a46ffsm222487666b.17.2026.02.07.14.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 14:05:23 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH] staging: fbtft: fix unchecked write return value in fb_agm1264k-fl
Date: Sat,  7 Feb 2026 22:05:23 +0000
Message-ID: <20260207220523.3816-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second call to par->fbtftops.write() does not capture the return
value, so the subsequent error check tests a stale value from the
first write call. Add the missing assignment so the error check
applies to the correct write operation.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index 207d57854..b4883c365 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -375,7 +375,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 
 			/* write bitmap */
 			gpiod_set_value(par->RS, 1); /* RS->1 (data mode) */
-			par->fbtftops.write(par, buf, len);
+			ret = par->fbtftops.write(par, buf, len);
 			if (ret < 0)
 				dev_err(par->info->device,
 					"write failed and returned: %d\n",
-- 
2.43.0

