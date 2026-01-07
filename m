Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231023254A8
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779271; cv=none; b=qqd84LSS4kt7Yx3UOFEw3VOA9e4BjQYsegSoLQEbmq0KVEAQ71p5MPjRWhKwZQlUpthfMQpTJ+SsE9kesnkWCDyEZSwORgVeg6gYVlciPa2HJ5mTVWon+nXWV9U4BK4MRjE19mLdbtektrm8t9+cPyoYKX3JOict2RBjtrTf6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779271; c=relaxed/simple;
	bh=18+QUqCvlJscTQnkn5gMK30nVEEEfSeMF7NdykjrvOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSNGMudlZca62G5DycSVTUb4JyfjM19QOhQ8Kb0upyUd7ncCtjwdsx4okdT383VUeONEZtjqeyIjIKcbUd2xvmXFnhpsurYiZvyAJkOm6/6pdOMuCS4NhtbWFqF5HiAez4YI+UOiJ4Z/IBqXeJhMP55Ss48Izys3+BUlPDbVc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljy5XmML; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljy5XmML"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so11111495e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767779268; x=1768384068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EIdnk85uRd+b7kAIsmpKRxoysfQFgjpX4iJZ9B6LB0=;
        b=ljy5XmMLqiqc+YKs6UVqUoi5dqpKGFICrlwt4LE2UfmRF/6zG5XaoPJegjAeonb6fX
         wqvJehXcQ8wZnfh0gedkBAgQc1HnvtIOYNm4cqa43f3D5G+N+57Lq2ZEZqec2/CxehvV
         fNUbTLySLrBrt9sR5IEecwRk3QepBG30QCmPgl7NlTbTBH56kz9fi2BEuGiYp0sTnTCS
         FXQ3myEVAH1dLQFUD8EVWIcg8EL2Z+13w1tIndUHS+z5AqyLXLe6gg0PdaYwXyJaXDoW
         PRgOwMWT9Q/Y9ccnrywJ+zzU/cDfSVX6z1v2LEN6RHnntrieK1XBmQ/vqCbigRRQ5AtC
         GJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779268; x=1768384068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EIdnk85uRd+b7kAIsmpKRxoysfQFgjpX4iJZ9B6LB0=;
        b=aoN7E2nbmQUV4O/ekbKEzogKZVPQZBJVLg4hDiof2VIK9wPM9vNpbTN1QDGs/QSHoj
         e0GTVCZZth2gieS3CESfATscRiDDOUsou6lZLPvrgOELhU4I9dMcQOnLAsf1HPbI2TbB
         cec6L/iP1VLa9OuYqtqiQBm8WoKXKrDiSXnhLm71X1IFuDg+pdlPk3VgoG924CBACyw5
         BXuaFIQVzoltywtkpcYZsEvemCSuv6DxNnUxjdXFDDlDcCaDxrKVnXaWPtiqYBeTAr/J
         LiuxteBzzisbrY+rFnlAjzTSG70UpZgDu0WCfrCA7g+BQ+oX4MqoZNCE4q/MtZe+CpN2
         F+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdrTNEObRZDYajOzIZeuVx0FlzegRKzjUoLD0/j3YlNmepAQVRIEPTM40mcnxGXf/P0jltW/BOaRAk8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGt78Rj0hpgUYn5DSrUKKROF1tR3ajpnYc//jZwcm4IUqUz88
	v5PBoOE7HijSY1O2p9nuJsSddSHcILGFI7rtOLdJ66Y9KWTly/x3qUfuWoJ4OApu
X-Gm-Gg: AY/fxX49jk2Tay5U+GyZOLMruuIJiqGxFnhavS6d0NdORCtaWolfTMxKK5nyib4OX+L
	yyqzlMWZN8sSqycWpWqYDB4N1KEepHSzj+eF4OBsXDwJfs2XY7KnxpNZDUE8EVdDH8jbBLx88xu
	5TYoELhkdA68z7nvM/7xhIyurV5PQMTS/8ZUDbnow23BA+nNHtG9zbf9nsggXeU6ZPcouRi6l7v
	3P1X+ctHoKesUrPxAA6lflKvqp2KWgE4flD0xRAmFD9IqIZ0WalozzbO09vGfqre0C/CFtBxH5H
	b90I0kg1bx2LNEiwirXMKR6U3d2dNAXPdkp6AiovyuucnKdGEL72iXsxFQ0W5We96wQnH8c6p3y
	EpzH3nBEgLuqezVwL8K0pvF99Jlbo0gG70f6BLoLfU+l+XThn7xwqUZp3Zu33m6EurIXyKlk4W0
	/ZEtygJoaxh6zYx6s8k4dTeSgb5BQyzG0ALT+fKF9/8lHqvcT+1P4y+WvNt+AD1w37BUWl19xpX
	9zY0KictFywn7ocoE0o4LPCCJA=
X-Google-Smtp-Source: AGHT+IGHPuibPlJxce/9LTU/PAqmI7i3ikEEBj6Fszu9bmdu6Z+KPfTEwz06ZCNEW9ZX7UwUV2l8bg==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr20755755e9.32.1767779268211;
        Wed, 07 Jan 2026 01:47:48 -0800 (PST)
Received: from fedora.homenet.telecomitalia.it (host-95-244-124-236.retail.telecomitalia.it. [95.244.124.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a10f7sm7423715e9.18.2026.01.07.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:47:47 -0800 (PST)
From: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove unnecessary parentheses and true comparisons
Date: Wed,  7 Jan 2026 10:47:14 +0100
Message-ID: <20260107094714.300380-4-lorenzosimonelli02@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107094714.300380-1-lorenzosimonelli02@gmail.com>
References: <20260107094714.300380-1-lorenzosimonelli02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up unnecessary double parentheses and explicit comparisons to
true in rtw_mlme.c. This improves readability and adheres to the
Linux kernel coding style

Signed-off-by: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ff4e668f1..d9e6778e1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -468,11 +468,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 		&pmlmepriv->cur_network.network,
 		&pmlmepriv->cur_network.network,
 		&pmlmepriv->cur_network.network);
-
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
+	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
+	    (is_same_network(&pmlmepriv->cur_network.network, pnetwork, 0))) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.ies) + sizeof(struct ndis_802_11_fix_ie),
-								pmlmepriv->cur_network.network.ie_length);
+				      pmlmepriv->cur_network.network.ie_length);
 	}
 }
 
@@ -710,7 +710,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
@@ -1386,8 +1386,8 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		if (adapter->stapriv.asoc_sta_count == 2) {
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, cur_network->network.mac_address);
-- 
2.52.0

