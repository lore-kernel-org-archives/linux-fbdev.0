Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078F3D8120
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747190; cv=none; b=kagm+08swQNfsPHNwqwtSa8D21n6FYg4Baw2ibQQCSFca8I7M7QSq8/cjTr8EE55QY9nAziXwDa2UGubhBQaVDxyg8jbeBUNhCoGl3Hdi/a6TeFSkKaRJsCvb3Gyqk4j4Lha3quKz7m5TLosdH+4T6Lrbe+FAuCzcDjFDnnkNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747190; c=relaxed/simple;
	bh=zPOhLPdshjE8pq0yGg4SKIgXmW4mTNuSf+gp1KyIA98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6lIMtx19ioJdAzlgAQoajNfY62fxN2yHa2sRZAUppfpcc2/5m3gptgtKu4z3dBNE5Q+FnMRFG+H31R30re8YYnWddNaFPZmeOpjobMiTOEQYyzyZ+mKAEXFa+H9n5d9TlD4HR/Rr9FBQ9AlXozJDcoibsjO06vOwv98hMP7OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=h76T2dX6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="h76T2dX6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8173b2af32so5658664a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747187; x=1779351987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okp+cmZfIVDgj/1rQL2V5ef2DxZfT0YRw0dNkTRuA+Y=;
        b=h76T2dX6rzwGflgANlozqXzsxg4uiWSuBqieZVRcYKqyXWeEfu4JkBFZxfQV/+x4CA
         rIHcN4UoGHUtxBdD18N30WdNfC66AVGrFck+/6qGgMNYReuGT8DYIQw2eE6trGJw+IR1
         WxuRO4/ueeJIDYHZFPaHjlT8btsJMIl2Fjty1YyIL25KHKOW0qDJWyfRlehZCy7Qbc8p
         QxZnx/kYyLFbDygLhJoCF99KocQzjRZR3uNGPAGVLikMmNw6lJL2WAyaQ33hPTQbO1fL
         0ZoFaBkgji4g2oZrM6nflQIYUW6doM6KGgvVK903AMg3p1XCj98CPCU8AYRb28wfok5+
         tSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747187; x=1779351987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=okp+cmZfIVDgj/1rQL2V5ef2DxZfT0YRw0dNkTRuA+Y=;
        b=JL6gDmOLUDUGCARm6AJg/LGj2cFMq1iBuL4eMy5ha7lHFf8YSnwBzZrPjA2vIbSSpq
         4CXyAQ+gmK2aSf24rwxYCjEdvD10kmHglkSs9T3X8AzBQ27r/LV5HcPYKNKDjvqy6d8P
         bS3SjzUcFsitHw8QVN9w7hA7E14qtGqbCykYN7xQ3BCAdD6FsvIoehMtzeek8CgzbD2d
         IK9Qsz7k3XSNpyEPbt8cZoDNjihzzxiudg0ZlJ6Y3ZZic7qGpqRl0M/h1BLCNCZE7xhz
         CvjI+59O/sycTIQ1SDipmuBYhM2lKNcKzwVeoTP8Vl9Iy5l3yvzXFDa+7wG8vICnNWoj
         eqAA==
X-Gm-Message-State: AOJu0YzBtnSubE7KgZajI69M3d7d/Iq4t9nKaYX6OeA3IT1bG4+mOsaH
	L8h+J/LRDFA1RKYvJAuas1wvC4jvMI3BNBxbbGebUWL4vOm68AEfyZEjpOhzY+cYTVo=
X-Gm-Gg: Acq92OHCEJg/R/rsIXJO/eUGLODjO4HyCsGQReRPzTuxC4nz1XYXBnxfEZZUEQ/I8DG
	viwD172IC+UDHxy9uaRzzbVDChfVjiL0pIf3DFks4bqTTdtg9cjwX3iMAhfrMp0uyQi3+b+fgkd
	OGsxs+MK1fjpATHDz/gPF1iGGo+MnMwrinGCO+KAEpcGnq/IRjwHDIfzrd1ncP45mfQip5KwB9t
	UycKvdiRoBwfiuE4sDVDkLJionJWVhBOiHXbZzFI+baTvBZJY3NT6/+GPuNoJtsmiOS0oILqXVc
	/SXbfDHe0HQUpXo9NWxDlcbbdBRH6NcoY4KdXdGhsfv/sU1NxSrgg5LFHvnMbwx9fj6sN699+1S
	QnftuTbo9vKPojSCt17+U/Iubw3LrH03ZGIyy0dkZixmKMFrRcPi675vw8wsTHyc3u17kgBQD2E
	Fr5PFiXGdOMrxVB7VbUQ2pmIfhjEbER/uAUHF1d7b/k+jCba8ffvMFLdCFoTvpPLdyt78oG421/
	fv6N6I6jWpDZTUngwjp3sGSKrDJ8mj+zU7ZKXMrF96S
X-Received: by 2002:a05:6a20:12ce:b0:366:19e9:f43 with SMTP id adf61e73a8af0-3af80079e2bmr8359899637.6.1778747186893;
        Thu, 14 May 2026 01:26:26 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:26 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:42 +0530
Subject: [PATCH 13/14] fbdev: vesafb: fix memory leak in vesafb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-13-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller. But the string is not freed in
vesafb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/vesafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index f84f4db244bf..f1902056bd73 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -269,6 +269,7 @@ static int vesafb_probe(struct platform_device *dev)
 	/* ignore error return of fb_get_options */
 	fb_get_options("vesafb", &option);
 	vesafb_setup(option);
+	kfree(option);
 
 	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENODEV;

-- 
2.43.0

