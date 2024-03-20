Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CE86128
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710976925; cv=none; b=Bz5sKphDLaHl5Zb6T9ITn9Uj5BDpkukC1Fpj+mZwgGSoTPIcXMJcAwKPs3VB/zhwRVYlxR2mv8HNMo3MmmoX8BEqh8/F6lQrxOOx9N5nqt1seTxz6GZc98Yi4a6hGFZsSJP/CYCgvzD3VflrvcNbwNo8otv2UCf1yM4hOGYemnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710976925; c=relaxed/simple;
	bh=LstULD3SZgSv3OfqQEREHb9PlnHVDFzksy2daTuKq/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uIekWKvXw4E1EwmYrDZYe6aO6hyS+hHt/vQS+2RQ52geAOkN9wXlhatNQs2G7rC+yjUOyE36cOg+9ITi9rLiUYN9a2T5TDn1OxCx3BEs4EvJcpDMQ9qUwhMg9ucMfeGo5Vp/Q1K0qu/Ow3eEeIrgpS7QHqwHMXrQ43HtyuHZMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uopcagLU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uopcagLU"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ab69a9e6fso19661797b3.0
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710976922; x=1711581722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31u9h4pRsIoYT5xL2+2Sx/Q3BDCy9WQzGQxSt0T02WU=;
        b=uopcagLUe9FUu5r+Uju/IIdjmlZvPd8g8tPAHZeY1L74ucLYao2lqvpJWWEkGKRz78
         xrkjAjMclpsRi8qc1hy5NIbfcaioJnTkBNbugXLKVpGzvzo5IHVDHbIBJjgeT5HQkXzB
         iqcD1xaTHex0kL7fWJ7049ZAhs8Nbx+Bvg/GU1Q/XA1+racvK/Df+zYoY48PRta1V1lK
         5tyflTyWUhpq+pC+ZE6YyXwvLY3wZcSYObhcLy7nukRavgR2B/U4VJeLX08y+trMRrQl
         8kcqT9YdLMjujjOp/aQQFG/vMjfNIHJrIJcmQ1LdRl8mKopXzHwjDQO9LLFSL+Ap3Jt7
         k0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710976922; x=1711581722;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31u9h4pRsIoYT5xL2+2Sx/Q3BDCy9WQzGQxSt0T02WU=;
        b=ibzxZi5FZPB7GXiIpZX9NmTQHa6zf2y3YtNlqc0Q1JwPypIEKfUwdrMG1LQL6ZYCMi
         O7F9tCYLT1zCJRDfppnbmHQhs99tcZg06Kn1hRFHVkVTfVywu6kSa0SggDAFA2xxv71R
         uhzivfNlgzb6yoZ+/YnwZcwiIcwvUEOmnlkNsFaOOLOSWt/VZbuJDWiIkq7Q8iQOKlAB
         91IL7u8ZchJzwqIu//aHht+QGnRBRUldEmTkCzNHZgwJGyAzzPukD2Tqwc2WWlcLMeXv
         X9Faf6CxWK08tTPjkaO1of/+8puB34e1qVRHFGnmZmCIEp/QAFZXf6hL9sG/KAn3C0Zl
         k1vQ==
X-Gm-Message-State: AOJu0YwhV6NJjrjxBNtAHFb/OFSXFzAZkiHgJzBhZCJXdJ/r3BFPisgh
	x7JWi81tjCAz4Jejmi+pqf0VJQVf0hphW9ZjnUz3BPuMsptn5Wrf4IY+kT9dYgdpt0ysQflz+Er
	cDtPQpUl7iGmB4vB5jQHRnA==
X-Google-Smtp-Source: AGHT+IEbxaoDxR39hoPNgni/Vs4CVRqb2djIgFXCSM9OsEXWBDwH4FweLj7pnfzYDXD3ipk1F2Hy16EUjCN+ESro/Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4b84:0:b0:dcc:2267:796e with SMTP
 id y126-20020a254b84000000b00dcc2267796emr201630yba.2.1710976922546; Wed, 20
 Mar 2024 16:22:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:22:02 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJlv+2UC/x3MwQqDMAwA0F+RnBdoqzL1V8YOs4maw6okUjbEf
 7d4fJd3gLEKGwzVAcpZTNZU4B8VxOWTZkahYgguNK4ODm3XFLc/kkpmNcxCvOJCX8GIY/QdtV3 bP/0EpdiUJ/nd/et9nhdMvlXFbgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710976921; l=1895;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=LstULD3SZgSv3OfqQEREHb9PlnHVDFzksy2daTuKq/I=; b=asHNy0GS4ziNs7+teZK7JmBwmWLU7eI7UJYX/Jv9UFQa5idrd1r/icfuQF/NfP0K1Tp7LHyZY
 MGpRYh9EuvuDYbE8MrciB/WCTNc+XdNdU97Xs+IFqzbG81WPC/L/6PW
X-Mailer: b4 0.12.3
Message-ID: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>
Subject: [PATCH] video/hdmi: prefer length specifier in format over string copying
From: Justin Stitt <justinstitt@google.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

It looks like the main use of strncpy() here is to limit the amount of
bytes printed from hdmi_log() by using a tmp buffer and limiting the
number of bytes copied. Really, we should use the %.<len>s format
qualifier to achieve this.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/video/hdmi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 03c7f27dde49..ba301f3f4951 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1310,17 +1310,11 @@ static void hdmi_spd_infoframe_log(const char *level,
 				   struct device *dev,
 				   const struct hdmi_spd_infoframe *frame)
 {
-	u8 buf[17];
-
 	hdmi_infoframe_log_header(level, dev,
 				  (const struct hdmi_any_infoframe *)frame);
 
-	memset(buf, 0, sizeof(buf));
-
-	strncpy(buf, frame->vendor, 8);
-	hdmi_log("    vendor: %s\n", buf);
-	strncpy(buf, frame->product, 16);
-	hdmi_log("    product: %s\n", buf);
+	hdmi_log("    vendor: %.8s\n", frame->vendor);
+	hdmi_log("    product: %.16s\n", frame->product);
 	hdmi_log("    source device information: %s (0x%x)\n",
 		hdmi_spd_sdi_get_name(frame->sdi), frame->sdi);
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-drivers-video-hdmi-c-bc18d585971f

Best regards,
--
Justin Stitt <justinstitt@google.com>

