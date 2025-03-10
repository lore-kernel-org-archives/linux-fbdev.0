Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C181E;
	Mon, 10 Mar 2025 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582680; cv=none; b=d1akjnxwz6k9aZc+jrumCtPhCos3cGu/8q+jtApPXRAFIcL7qHRJHc50P1BlOA4cx8ep6wx1+OqB5xTShddMc4fhhTKcxoqkb/SQ/aNS5kD83BU+P0QJ5ECZaPvkuFTRE1li14Qfipv70dm9wz+UnLVDjTTDYuqjBLTHNv0KmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582680; c=relaxed/simple;
	bh=UXTg8HxhyDLnMUVUUzXdia6CGqTXBbweOT0vrR3/CQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+RuxgFB93IoWVoUFE1WPjaA5DNJpPpNFlid9y90LAp+K1RsXhzojFJP7RSvdP0LJWAPKE/I4WFr6uFV/ZX5iLwa16dDj2iEJheraLsmWSk+YNfb2zBz9ExKaRidoUZCD4azfzJsJNu/wXyJdHxkEYl6Ofd1KdU8ZFXAPJSHeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CohLkN3d; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CohLkN3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741582612;
	bh=1Ejw7dnHXGbcgwStfAw/3eaY/dgh+jPF9zfi0J6jwa8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CohLkN3d3I9fXk7WPJD62ofuUZDLzfGlHnjH7/DNaRO7XrKjwKXjAcPHDXbj2i3II
	 ZqANN22qs3nMOxhJvHSHfCg3r0GH05hqhB4YWEZ9LBjci9NvfJM44ytRR42IVVc/Ey
	 U+eTe+SQar5jFFA1nX1sERPjs2SUXwXUxPajcFWM=
X-QQ-mid: bizesmtpip3t1741582601tyaexxw
X-QQ-Originating-IP: S+iHdvzEOaySNSWMHE4rAW5Kl94eu9GLfHJ4prLBux8=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Mar 2025 12:56:39 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7054169263967918300
From: WangYuli <wangyuli@uniontech.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] backlight: tdo24m: Eliminate redundant whitespace
Date: Mon, 10 Mar 2025 12:56:36 +0800
Message-ID: <8FC39A4DC2529591+20250310045636.14329-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MsxCBMBvQQ1NtRdpMOwG3VxtA96L7hcYpK5OYkx2NK9U6euiViTVgh3z
	R28mKwLnY4VkvlJDnSmJZTqRXrUTm+pG9HikFvG7ED8S2Y9m1gaFgYJe8uTmXQBWOE2tDag
	J70/96jrAFHLe0iOkQa4Uzuc4jksy1om9KMv0eZCYlNfqua+iDfTxgCYJ4mYcJrLtEqNWD0
	TzbSM9XgoqFDI5y6ahzDF5uNTGnZ8LmrLfEyrHLYv0jklCLiNqMsOOHVzqpDBuBrIruGtYM
	EKUtJPDpUMAXVlU5YOPcEeYkxG9VgMjh6K8l7N98woxrcj97N6vWh0vrR0MXwpRFSu74PeR
	lFKeCchDwJ7Vk+BaznWFuYDxV9xdSt6VpB5cRnSt2V173gUMfoIUtHhVHzkbA3kwC24P8sB
	Bc5Z9Tg3k8A2OnfZ/Lc1DLRqNl+bbAgVIjpS5pe4ZWQjiWw1Ce/ZuUIeXUp3RVjQRPFGc0e
	nVLscg0IZ5WG2LA8ZMIRwVJYZuYctaWmwHesXzydkHzlypLZuQYRCxz9v7PAhxzDquUYD4A
	BaqHC5FcmZZJ939mWWxCQGpUdm7daib11ByC8Uk8DVhSC0rF1Ied3xg5bUbEGT2tdmgIpXX
	Z+d0Y/pa6OYV9TYIslSOGub3MrGSPvY7rFcUNsbJfp+5io7CGDl06SceonanpJhidULISwf
	7BdVoNyefsTgSAUTrw+wJM0rfYBPQgpGVU0MPFb+WW+YehD3KAicSFWZeOoMnLwmu7m9KN/
	HERvSVolEMsRI+6zDyZwJLQrzZNmS6u880dVl8Tkl5958hILnwY6Gumis2ItWebkp60GK9X
	ZASkCkFwM7/gbTh5n1RinPbJshNDd4NfVOmVPoNPhhu2Xq6KEbpzlvH3Jz56LzGONOgaqOd
	lS+G2Bjj1YgxuEOBCeYs3hUT20Pl2UKKMIGbE3HpJSVEHqOmkrTTe9SFDuQ4iltfiXdrw4O
	bVo20UzLLt6k18XDWFwQytbIVozfRKNZr5ImOlcWSZUlMRGsUXKqtdTHizedwNkuuusBPlE
	m0WyfFXfjdcMdIGSPj
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The description for CONFIG_LCD_TDO24M has redundant whitespace.
Trim it to keep the code tidy.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/video/backlight/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 3614a5d29c71..f2d7c4fe3ba5 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -70,7 +70,7 @@ config LCD_ILI9320
 	  then say y to include a power driver for it.
 
 config LCD_TDO24M
-	tristate "Toppoly TDO24M  and TDO35S LCD Panels support"
+	tristate "Toppoly TDO24M and TDO35S LCD Panels support"
 	depends on SPI_MASTER
 	help
 	  If you have a Toppoly TDO24M/TDO35S series LCD panel, say y here to
-- 
2.47.2

