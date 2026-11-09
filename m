Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231463;
	b=hSNCVVASL8eLgDh/+qL6fB/M+4aZSoNl3wDnPx7bwVAaXQ+88dtxX0D5I79JeoDmewLy
	 H5D01sXi6M1QzaoFedB+s6zDQGBRcQAzkBv/2yMiHAzKZ1z/4E8m39swl+WP6+UTsc9jl
	 vzihfcqFob3B37lU1edSJD0x96cJvOKiB8dvw/1fZCLb73UNzHjzPI29psfqz/F7hm0T1
	 psDz2zySsPbkKGDHCpHd22ffaHOSpHdpHNbwrc0TDjUb/MuKvA+hiL9ZYP3bwx/oL1rty
	 Spw+nDN40rGeDBuY45RbIXAKpajia24X3AR+E/SMSccG4I4T6b5UMznUZVoIFPHKSow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QWyQhqJ9ucdQAcEnl95DfWPx+aoHDTMLg3gXeTbngSs=;
	b=SdAofFMbKFMSi4PR6e1Glwr9Cslcgo6wVd64lp5bFxHvhPj/hJOXSPQmAV274S6z+NOg
	 e83C7h/9xyKEG62QPjvsRE8nWD8uvsRXoPXM/gySS6jXmAdNTJ83lGuM20R3kXlYT2rz9
	 my9k2e3oWrIr6ZdY699rGtyX9itAL8klj8iU7Z1Jz/ZA85OzZ1k+xIXP94EaPlg0B2UvJ
	 LhL2tC5/2MwmB0/XyuhMqLAZkvRBWNxGsY6m3DI/ok67Msc7qHL86qzmmewv9JT8TCiL9
	 Ahk/J0uqoos+swvXaR2/f2Hm1K5FSVLoODtwcDMEgAXFv0GiVeiz3tg+yE5IbDcPDFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEzbnxCc;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8A606EE81
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Nov 2026 13:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8E8A606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pEzbnxCc
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso800716eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Nov 2026 05:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231462; x=1794836262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWyQhqJ9ucdQAcEnl95DfWPx+aoHDTMLg3gXeTbngSs=;
        b=pEzbnxCcQlvx2tn5lpveTfIoakyDzPtG7/g1mOwAG6x7gpmM70DDzzfF1jezM1uAH0
         jIkYyAKN9HSmeB12RFncRzoo+TkZ/bFCtpSdNhJOrbpOrT4FYfujfC8cpntxJTVsk19F
         M/KISmsWxJp4+s/pW6BFimu9wO6WhonXJEen+7Tm22TToeuJD08U97y+V/0LiPZskSpj
         6tRiWXNWlci/c441bviiQTo02omcJ/1rp39TGb2E9SBZVwwVlLZXu20FKoKtEvehmT5G
         j4UuXpaKInR0PrXLtHM2AOY7Mgs/u5FQvs6tI/0LkurFrmn7smh1kOGg+O5UkW64ZlcT
         EOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231462; x=1794836262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWyQhqJ9ucdQAcEnl95DfWPx+aoHDTMLg3gXeTbngSs=;
        b=K1NK563MYPuJNCwddULr43SwvRGQ88Ql8twNt7wa3rGvwds02dRi5ZgqBasEXnC1s3
         37KSdLb5QehCeoLzGEa7gHO9hspJsRVGr0QDmCKeFpdlNTOJVLtBLdDXU5XEOWVtehYM
         MLW6FRKt8T6gVueOL8co6WtBivGzpHzbLnu3Kht9ZWsjpL4y4QumxYP1APKtb4hITeYL
         LqEwvXJXt5equXvreF4c12u1AbPJS4e4pGAS8cB0JQetakjAGS3PulMZbcq9KeECZdi7
         cV+/y5FPhqPnPsdgJdFLttSVIYd3Z/QNCjojwBP36A4jaj2Kgrs4bD9Hum6IZuxVsaHG
         sDLg==
X-Forwarded-Encrypted: i=1; AL+hErEBlpFU3zuMfSJRK/GCCdsD2nj3ydilCa+p0YM1Z1zRfTUWTairdn80FxEOgu/dEaOCJNwg5dvahzJSxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8byygnq0TocIfuckB29MKNYDFv5eoe7qazwA7ZvSofs+pG9akP
	UPKeBkFweBrA0OHszbnkwyyV8jUq7pq4G6VihamfAWCnFtTNPT2Ed8Bs
X-Gm-Gg: AYBFou20brRtesi0GThu5aSiFuNLdaMuZskTmjqiO4SBmboRo5tOPyLuMpEIsYiIujZ
	ewe2IKcqujymXentx6JEtCnCOCvr4CVPliEPd3Ywr9Vuum2jRQ48LzSiHvSbkWEkumvrrNEWbvU
	58xlpW7frHpY87pgIQESJLCTQYSpG/CnYALZU3ZlpgPDEzueOHhKQ/ebg0Yu6I68ye1VRkZGgto
	mPpaBT1nHCPgV+amVwKZcK0Js8R3tfHlBjOQoVBCFbQHEqNrIE6eIdY8r3T/9FMIIemTwQUW5U5
	WNQI2k3lHpxM7CwFJHfeF5iugHYu2RP5011pEohDCwxag8mV2DK7fVog51UJhPvQaKHux8lMUrn
	7r6rbflthR0Tq2xu3Yk/iXThWwNV9M+tARElRC5BsR85zBEuOMrarfoDVyarOd5YjcsruurW7Mz
	UM/7Pk1xpVhGD2t3WtCCvNOGnRfwRWw1VhmYobj8qTis8Ht539dwtNoqd9Us/fpRgMMIEPPbRKJ
	bylEy6vEyPOwc3r1g/f+jtzZjLMMKNuQ1Ch7qtlBIQs6Cz6e4p7/4DTTcXThfnc7rf+r8/ZLIYw
	J5oqEHAj6KsrGlc8Lu1gS3mfoASo0ZiSL7dhranIUDccc4QbEIc6GTV3QhjDk9vXxblWX3TJjZl
	kbGZLBkrC5sb5QYNENrq/QsKxzNQIoW9zvOGDmNRDFH2V
X-Received: by 2002:a05:7301:6497:b0:369:efd5:9cad with SMTP id 5a478bee46e88-37255475628mr7236459eec.8.1794231461483;
        Mon, 09 Nov 2026 05:37:41 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372666d2fcbsm13225525eec.24.2026.11.09.05.37.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 05:37:40 -0800 (PST)
From: Shivani Patel <patelshivani2283@gmail.com>
To: outreachy@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Shivani Patel <patelshivani2283@gmail.com>
Subject: [PATCH] staging: fbtft: fix spelling mistake "writte" -> "written"
Date: Mon,  9 Nov 2026 19:07:31 +0530
Message-ID: <20261109133731.66016-1-patelshivani2283@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Correct spelling mistake in comment ("writte" -> "written").

Signed-off-by: Shivani Patel <patelshivani2283@gmail.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a15414..c4db681eb 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -221,7 +221,7 @@ static int init_display(struct fbtft_par *par)
  * write_vmem() - write data to display.
  * @par: FBTFT parameter object.
  * @offset: offset from screen_buffer.
- * @len: the length of data to be writte.
+ * @len: the length of data to be written.
  *
  * Return: 0 on success, or a negative error code otherwise.
  */
-- 
2.50.1 (Apple Git-155)

