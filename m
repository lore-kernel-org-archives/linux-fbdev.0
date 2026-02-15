Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E732231A23
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198438; cv=none; b=XolPzO1femck8bELsoDp5nMKk5RyouPPOnooZjmDVzMSC/jty9okksLHTutE/2rfKtK/Tuv0z76WmCxQ/9VZLagsCU0hZ69bJRzPz6ccupIacs0eyY+424lNE4ZEDck533ld6JTaSXxME2wQbpYz2iDM1DrIpFKPxMHY83jGgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198438; c=relaxed/simple;
	bh=8/ayvd93vuKuZqoV2oaXZ3cZ3yxFe6ENShkM6M1S1aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjRN5O7xyBPg6jIG9VLQvm3GpXLUXALJfm/Psulrkqnm50SEZqSgYGKFtvstbDps1zEULPKbfit0Zt0Pr1WzoU+6PXle1W5Gxb3NUJ52r/iCzlZge81eFHWD3nps3dlUYbGWQHoyGzEJ0gp5IRqQfOM7B7qPgreShVyljiotIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kLIQ/qcn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kLIQ/qcn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so19885495e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198435; x=1771803235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hivvhDiZwwsZ5SBCswCqVh6HFKDtUwRY3yPIgVgk+WU=;
        b=kLIQ/qcnYhHL4Z0vqqbBA7uIbe3U5lRa2i1lMsgGE89/X/VYGUeANbY5fOQ+Gy3fM9
         SJc8lRnv9l4fXwVNb6iEMD2HYtkOTBO9qTCSjiDhrREixl+M/fsD7clL3Y2Pal2mE+X/
         pWa/52P6Gjea+jbapLCx8apzjm26EnN3zF70YiHhurHm7RTC/iqgNhCCXuEcPs9EQXoY
         zcBBehcLGGsa52kgbXZeZdHmboQptD0GhO0IzhuTKi2yONYXrytY9AGki5lYcQe/hdNQ
         Kb50a0tpsIv/4/PfmkkQgpCbBjzp1P3hG52rsSvIz1tEjTh1NwYMBM61IDWv0i4uNRvm
         UZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198435; x=1771803235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hivvhDiZwwsZ5SBCswCqVh6HFKDtUwRY3yPIgVgk+WU=;
        b=fbQmyGVy0Aw6kPLqUD8tNA/mKpn1Ffjz1hbKpIjovDWG2rppx7MUPa1VDSeqK0U6/x
         iqcUzMfEU4w8n90J7+SCVNzbmmhz6qc0JX9EBYAuJxehmomcKHRltCQwAnJLDKXj4tiF
         yDrkbEoCDZFPMK5LHidGKZwfd7UwhnjO6vuhwPqx+Qw9LNLD2oCHbVpSo6RaKpxfWsco
         DIityg0UbisuxniviZO4IinHWo8iV+tKY+Ta9k2OIuYyD+q7MjAN+RFiiA3ynud1IQXH
         CQYJ6+X/VvVSDH8Tx60nH46tpXfmzymf6COC3Y/E/3rKJB4RjTIgbxy8ZogMji4dja8S
         9A8A==
X-Forwarded-Encrypted: i=1; AJvYcCWUVl+c2wsmLWLeeR24Diz8LyPobip+y2BK866zEWXG0YG0yHq0IbP6tzp9MdJoEI9BvIi/I9oe9PnTFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6FVBxqYfa5AvUVlaMIfWwP8lpgUZxBFbN3C8vCbjI51W8UyV
	oArIWImCBYNy1VHAd9PDnjFZQZo7DsRh8HNj4LqJBvGzMsRkEeMW8+bHZQCa6lfg1I8=
X-Gm-Gg: AZuq6aIPxrq98Z6a9ZRpxNZLJ6h20/xPn0SOXRUH2n5Z4PumJyMNWWgwZ+88rfjzaBY
	vFxPoKY7RsD/HHGU4FO517i2bg6SRDy3n261RelwzNFoAtE4G+K66jJ1B8E14jQ5251P5jUv11H
	O17W1jnT9arbQYksrAKAqZOE6D+5qEecI4R14Arr8eM5WP/VZfHQ3xOFi5NjVClkWvyM7vu7TjC
	R/kd/2cKKrDr7wc2fGxeILY4OIPaPtw7IDryMtCalYpxpECTe404Jf8m6hfd3sg1/qIjNnsQVC2
	n5qxDaJcvCAoEqNjtx3r3o0KkNK7ktxkfBhneWSo1XiC94ypOxx7bNWP4gQmkhCtd+fM0414BPB
	E00Skt0EvdsmOU50+Ivh0LjoajKbwI+Ql4rltsBX+YGEJ5GNXjX/ReuDVcw2xmoqkj1oQyBUZl1
	3zr4llu2t4LUEjxESxlq9DBQjiYVIF
X-Received: by 2002:a05:600c:8b4c:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4837105240amr157188025e9.12.1771198435582;
        Sun, 15 Feb 2026 15:33:55 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796abd793sm22707278f8f.25.2026.02.15.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 7/7] fbdev: au1100fb: Replace license boilerplate by SPDX header
Date: Mon, 16 Feb 2026 00:33:23 +0100
Message-ID: <b6117b045f637ed5e0bc9a363f470cc687e4b2f9.1771198101.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
References: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8/ayvd93vuKuZqoV2oaXZ3cZ3yxFe6ENShkM6M1S1aU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpklfONAOswvfwLXTWMe6bmvCEvTCbsTYtNtgMg a1PdRJcTNOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXzgAKCRCPgPtYfRL+ Tr9bB/97oKns3CJ8YtEMzxiCZ6P68I6s9orVbWJ5k3fpQJ4ilOQ1zzu43vD18hwB5P3yUsqsbvI EnMEk9PsDn+/VhuyQDaCLACkruFjR69RbuZA9UsUJ4gQahht6rVd78LIshw49KisqYStBJc4WoZ uaLTin2wd10gBmtwQwW66bgBtknv/1IMe9h42OgXmsvoyFTrf4DfLDTA78yRtVgkPhF7+YoFz3d HI9Hw+VUPwxRjvXlFDTZTQzKzNiCPpIxGj2I/qXXgnBEG4Xg4nhLukT8pGQsxcK2XRJq2RR3jZL +l/fszukh+zz++OsND61hioWUdZr3sLYWdRuvRFTlDRemPLK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This also gets rid of an old address of the FSF.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 13605337d724..1a04154bc535 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * BRIEF MODULE DESCRIPTION
  *	Au1100 LCD Driver.
@@ -20,26 +21,6 @@
  * Based on:
  * linux/drivers/video/skeletonfb.c -- Skeleton for a frame buffer device
  *  Created 28 Dec 1997 by Geert Uytterhoeven
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define pr_fmt(fmt) "au1100fb:" fmt "\n"
-- 
2.47.3

