Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905708;
	b=eLcrtWyNNWzRjS24T0O/Ww1tv1WBLdOMsSnofsUdjHED6zdO88SGHhIT+mB67zn8mSLr
	 J6/67uG6zhuZi+ejR/CRHU1ZOs/C6OQNMCLbdmEktP7f2d5aWt0KW/oN51PPg9guIGx84
	 IWQ7Zl+jagiikFRZWI/ckep2QQ/VvF4Kn69uK032tmtVr0YEd7sRvgR+6/xPuqlJsld77
	 vOtGCdWFx9G4tqYGmaikg6Cqyv388wE4H5ZjaAMmFl5DeDNo7ff9EJR0fLC1rMXWk/qVk
	 Iwg6/NxfXr5eNDB3sK2dScPnJOuDHyrETNsAuVJv0HJcI+s3iKYjRCfmde04of7U5TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VrsetohNIasoINtJjADb3Jjeqh2EUCIwdnh6PcRK+gk=;
	b=Uqmef6/gIN1fd/t3ZlTVwZcumAbwolF2YXLVMyni0uqXhn10wyoHfXphwBO+1tsTy3JP
	 PznqpFxAiMur+z8jeKE531FsXPsraWfXAzZFZfsCMXAax4PkH4IbusJ5FD+Ofir/MQAOl
	 iNKO82b1bRO/g9lgtzc5GpBO14fRmZcrUCfVkmuYlp6w/2oPGSjT7fMuAviKDp86tHMRQ
	 2LHC92WPMDPQhDOuB5S+I96oZZCSp91wdrtChwBPCMyfjaIGlM5iaAsu0qktOqaJgfK6g
	 gict3eCnsOsEzVKS14FybkRLwpiVv4pcugVD7s2i6IBbK/r6ybzmjKpaeCCuJiRKwVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RCNxwm5R;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C1606A31D
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 05:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 539C1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RCNxwm5R
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f036b17easo4981100eec.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 22:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905707; x=1793510507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrsetohNIasoINtJjADb3Jjeqh2EUCIwdnh6PcRK+gk=;
        b=RCNxwm5RMCOP2cRWckzM96GzxR6oDKWOmOhmBVseDOMPJuY2VsnmYrVDYPjIG4B/Yx
         jQ4XrLlhZK1/sd2OblIEltuinppiZoeW+XkW+0HidYSBKjBzJTuQqKRqlbBsGe+SlLUA
         ZWoPCX54Ba3SmmapqO+nBT3hJgBQ+DXlfwJ4PIPQ+t0EF59qIbc9QumxKbv+pAPA6SuB
         gWkkLZ2CBl9DYy/+ezeBm3/MOLffvS/EE+baaazUow/mOEHFL75owUDwWJy6OLZHiufs
         T/bBngAuA9UQbn8bzkkILHUWb1WImnXjEqkznbaTJcOZH5ZoTNDS+vrNq50Mvkvi/dDk
         afaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905707; x=1793510507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrsetohNIasoINtJjADb3Jjeqh2EUCIwdnh6PcRK+gk=;
        b=o3lvuOV38pRvAJdqxE/cRtFyPn6fJbxECSlhVc5Z+VEleE2XEmpp9F8jq3HBZPxH9P
         CunmVWT/eYy4ZiysJkRN0ndd4sMSA52p5idfFz8ACVt4xbuHa0eI6Yb/OK4FPJYLk0RT
         +ekaBj1soVB6UTOcS46rDOltCTVdatFJ1xHWF4fCke95jy7VdWvbNzfavsEZVZliDISW
         D82w+OGbMUpHzCAJTDzoS7j9zmQEwfX8cVS0O9Jtxme5DuKdRVhogYiZosDOgtB8B+zG
         jwBI3OVEhxfmgAvPc0nNBw0z8nRCzr+9P7A+T7w7tFBuZbShbjqpqY66saKkQIbpbenM
         e5ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpmxwlka0YtktJ9H13CmLctsgo14q11TpZOiuqWfSFsz/BPCR6lNYhikwhn2uFvOuWOzpXB2lPncIlCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL5DBXJCX7f7jS9IpvxK0/FYnDTjQuWYPaGOQKJf7dGchgzlY/M
	rKYIEg/1O1Yf+nACD23ems9Vdbq0hzWsqy3TjGUYfy1PltsOoSkmPjNp
X-Gm-Gg: AYBFou00GkJivtB4rqCkz03xF91WO8GHfU3mhEAMUMO7b5j7G8lqHTHOx6toSrZZvVY
	1F2/8TUb5Oqd88Ig9RQn32Poonsw5YVe0TtzlG6eRFBYjXidx9CtEzTIWmx4zbNWKrU+VhYfnvQ
	nqK4asUQOswotysflb1t0B1udH16cpdD41XspM9bdCp0o4Fo+tC35ZKT5WlpQTclNHxhOKiVOYl
	1fJrwiUmFFDP0V7Wqdca3UX8NqMcczLaSkHvVr7YTC2Q7bgxrRl/kfixnfV2tyHCA2vtRCn4PLR
	zBNLbBhoZkdCDJoJaIPusymGVbrhajcvQeBh1jQCh/VdZHTZCWII0PHsKOVDY0wL2DB5OMG8PoI
	kzZldentBJJJwxHXv+jasFRia8vmo3856lx6mSic4BI9M6LEgmUZn1ylfw5PqNbq7IBfo+d2gUG
	xx/F0KKoNwn1K456GeZEMNOdtRZsWE1XPPLRTny9fnI3FSGcxMNFZVdP3IIB7d/cTi1wa05n4p8
	csxDgDLlX8sO1dP2zIQTwhigGYIVfR/ObwmvW1h10qkpZpwAl4iKBKB
X-Received: by 2002:a05:7300:cc14:b0:358:1f59:48c9 with SMTP id 5a478bee46e88-369e84dcb4amr6835607eec.24.1792905707382;
        Sat, 24 Oct 2026 22:21:47 -0700 (PDT)
Received: from myarch ([49.36.79.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec864fsm15239138eec.24.2026.10.24.22.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 22:21:46 -0700 (PDT)
From: Aditya Nagar <dev.adityanagar@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Aditya Nagar <dev.adityanagar@gmail.com>
Subject: [PATCH] staging: fbtft: remove unused argument from FBTFT_SPI_DRIVER()
Date: Sun, 25 Oct 2026 10:51:36 +0530
Message-ID: <20261025052136.389541-1-dev.adityanagar@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The _compatible argument of FBTFT_SPI_DRIVER() is never used in the
macro body. The device tree match table is created separately by
FBTFT_DT_TABLE() in both callers, FBTFT_REGISTER_DRIVER() and
FBTFT_REGISTER_SPI_DRIVER().

Drop the argument and update both callers. No functional change.

The argument has been unused since the macro was introduced in commit
c222ea5d2f33 ("staging: fbtft: Deduplicate driver registration macros").

Found with checkpatch.pl (MACRO_ARG_UNUSED). The change was prepared
with the help of an AI coding assistant (Claude); I reviewed it and
build-tested all fbtft drivers with W=1.

Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df..62d5c39d7 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -279,7 +279,7 @@ static const struct of_device_id dt_ids[] = {					\
 };										\
 MODULE_DEVICE_TABLE(of, dt_ids);
 
-#define FBTFT_SPI_DRIVER(_name, _compatible, _display, _spi_ids)		\
+#define FBTFT_SPI_DRIVER(_name, _display, _spi_ids)				\
 										\
 static int fbtft_driver_probe_spi(struct spi_device *spi)			\
 {										\
@@ -319,7 +319,7 @@ static void fbtft_driver_remove_pdev(struct platform_device *pdev)	   \
 									   \
 FBTFT_DT_TABLE(_compatible)						   \
 									   \
-FBTFT_SPI_DRIVER(_name, _compatible, _display, NULL)			   \
+FBTFT_SPI_DRIVER(_name, _display, NULL)					   \
 									   \
 static struct platform_driver fbtft_driver_platform_driver = {             \
 	.driver = {                                                        \
@@ -363,7 +363,7 @@ static const struct spi_device_id spi_ids[] = {					\
 };										\
 MODULE_DEVICE_TABLE(spi, spi_ids);						\
 										\
-FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)		\
+FBTFT_SPI_DRIVER(_name, _display, spi_ids)					\
 										\
 module_spi_driver(fbtft_driver_spi_driver);
 

base-commit: 4a177d5e688e8e82113f7a32d6f75f0bab9658c4
-- 
2.56.0

