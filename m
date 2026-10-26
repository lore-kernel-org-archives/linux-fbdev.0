Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792989962;
	b=uYtd2VEltJMQPjCm5tFcKDDgelZLtt2CQdAif4eThL5pYWTLadKFI4fU5aFHoI87brQZ
	 2+4X49g1sbgf4W5tIQxfJ2QLhanUj1q9jwzEteU8HOHOiuhgBY4zeoSk36Jpxx1xcNyNz
	 HZq0JU0YWFGJ5BLzKrqa2kPu5pNp+5YnSSud3K9twqfxZpFF/HTBK03uPNr8HuWWhnhWZ
	 vhcXRb6/d8FPkySMpS1Y2HABjR75F9uf65tj/dkLf3qkTDIe9LNqj6aok5/8PF6V6M0G7
	 UWG8Rn1jshQY/yjWR9FCv2dNpwjDwGJv+DJ8TlJiyFjWXw7ew7Zy/mtncobwgacDotw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792989962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J3DoOx+7KwqVIr6jxYa/DyB1bbCV4XdJJBW9Yy/mfpI=;
	b=WKLPVd01cBG57Ob4HBWUaysiwU+AyZAq++LlEP0J4DHBVKUQ2SFSzI1KjbamZYyPv0Gk
	 n9hxmCzXKHiC5H6NllE6dQolejMZsNxZVKzTbdHfKkqMwevt3EZ9KCbSW5rw/QyPsDDYl
	 UTYvppPkoy+TJ2BjUECSfj4UOz4nVm+NfyvDc2qDuXTwoFT7+X/sEjrcrSdVK8xUEIpYy
	 DNqWm3qA+qorcuyza0kva8EMTtOrPs63BsuA6ejvtOYZ3IoO//3fkbSanBNvWLi1Qk8Pc
	 g0xZRpkLCRLUhpjyDA3/KI+7hrizw2wzeuih0e/CbCFFlr7M3IxhJ06EchhQgcfov7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gqZTLOFK;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB89606A31B
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 04:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB89606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gqZTLOFK
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f036b17easo7056678eec.1
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792989961; x=1793594761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3DoOx+7KwqVIr6jxYa/DyB1bbCV4XdJJBW9Yy/mfpI=;
        b=gqZTLOFKVYQJF7VBfihMP4KTKK9ROJu8RFfm1rzK1k/Yw096E9V3HfleN2a4Ve4fdr
         1jQUuDCzqJ1GVEiDkakRHAx+i/qb8VZWxwwvf9qFlZ0HLWIF3SxG9EOns6wkYNW++jyv
         3EEC8xzBozrUv7xI6z+wTRhZELPOwNGrGICEfkH1bCy/hKUWxMKKIaYP7ImYXTMAXxJm
         b4hEXT7BHxbLphZ/ewKRcHKJFfJE2Sc+eu8+nTmwOIUTaS8Jf8jens/4eCnq2gV+pxmt
         CigppTaWgJ1NWyjjVSua9WNtl0u41kVaAmqJY9tvnEmPOfwgxKRuVzIs3vI7vWxPvb9x
         loWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792989961; x=1793594761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3DoOx+7KwqVIr6jxYa/DyB1bbCV4XdJJBW9Yy/mfpI=;
        b=cTFCNmJpstL7WrZ3sszkn/eGoO63K5qt+6SICoCCZbqvGqPTCcY/1iUG8bFzsOU0B1
         Wt0iVq5rkjiPXf68nJ1o50IM16p2eXF4uzuZo2/8zMYgDjkkBHN1QEJEHttkXYiH8JmY
         k7MuY7MB+srhKrGTSb5ANAiAarZkQ1+W0z/C4gzf57TXk2IgzXqZT7+OnLchWyfj9PiO
         4dgoTkzlFxl7y+BLP6PznQDjd1AWkM2i15RdQg/WjiEGd3k18UV3I+d7Zz3bpXt4Dxxi
         KIMsFnEKSU6xkoabqDmXwPqFkidqliE9lwTV0PwwXILZp4o+UWlAIeb+qr+w+zjxreqb
         8/QA==
X-Forwarded-Encrypted: i=1; AKwUvBzHXywJ7RiGnkQmUrFYvb4ItchScU1cIFUPCIGlQLIIwh4Fgrtnsktih8LSz/LUG3CSPabYlXGnUMjEBg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfQhtowSd0ViMBNZnaG2UuMIAK9KbmnU1mDZy/FVtIPRee5oJJ
	yDUays45JHuvIi8xqJVHnlOVETpbbq/MzxweD9T2IpP6Tn3KUxftc65j
X-Gm-Gg: AYBFou3f82aCxaRhPWMRW2tuXfk4ntzxEI7uU2KtJe2dFYbdO3K0kZ/DhNFRDQwECz3
	f07ybFMb1DUHNA4NxUHhzQVQnEVzkf6cSinYWfDEN2Ddo8VzLw36QdQqmvxjyO5PhskxWF4Gmy2
	Vv5n4iyG5aU77x7n7JvdmNu6UXNuOLS5hFyO4/6BpvCtQ0IRAsbuJcPpeuJGIox7uv4ZnPiAWw3
	pWD9KZpOVdBCM35SxuKUDCSfqpmDUzYKrIfVpwPureCbf6bwjbnwgvuVwJltRp5/Mh1k/zFAVpE
	tA2PrXpp9HTkD6eTHXnYZuh9R/ZYb+hyDW6qIFG8u5GW8gzXsJJe/sU1gdT+KpcHssMBGVksZt0
	E3CZyCYBQNilHHNpWUlfEAs6SWWYxlg8IjaOoYsM65hroD1DbVoqdgR1ZOUFFWQ5bbSyZYDOZEV
	soEC2OsztpgP6qSAyKNo55WkRN/Y0apif/we8n5dBMRNjUcA5vB7prnu7gyc0P081leQKWo5p4N
	COmb3+RhgFVee/GeYtQOpCly/iWOzrnecYfgoRDJPCwRoP/JJ3xBHce5PyxjJGv6iAEGjSIK9cA
X-Received: by 2002:a05:693c:4195:10b0:360:905a:7c27 with SMTP id 5a478bee46e88-369e84e701dmr9620677eec.26.1792989960862;
        Sun, 25 Oct 2026 21:46:00 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a005c0188sm7281133eec.9.2026.10.25.21.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 21:46:00 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v2] staging: fbtft: Fix line length warning
Date: Mon, 26 Oct 2026 10:15:23 +0530
Message-ID: <20261026044523.18516-1-himanshu.bakshi478@gmail.com>
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

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

Split the line in fbtft_init_dbg macro to keep it within the limit of 100
columns and address the checkpatch warning. Also aligned backslashes (\)
for the macro. Added a temproray variable for platform data.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index fd7f8fc2afba..ceaa9a3906ef 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -421,12 +421,11 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
-	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
+#define fbtft_init_dbg(dev, format, arg...)						\
+do {											\
+	struct fbtft_platform_data *pdata = dev_get_platdata((dev));			\
+	if (unlikely(pdata && (pdata->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS)))	\
+		dev_info(dev, format, ##arg);						\
 } while (0)
 
 #define fbtft_par_dbg(level, par, format, arg...)            \
-- 
2.56.0

