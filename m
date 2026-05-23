Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E8277C96;
	Sat, 23 May 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550512; cv=none; b=Xx/nFIh2ARDaC3UbeHvkXnlJyFbFeZAkenFl270er8GM7WaVDnRGtpqXkdqs3JyuD8gfPgO0gYHpOAVC/kXP0miLsI25bWX0nCj+AxRPdwrrHppZdjEMAXtPckF5pWvuZzmIEilUrJRaKG/MsxTzYEDglYyhjAbjypjIuwcXwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550512; c=relaxed/simple;
	bh=9j51KcnQqO/hzcrvIcEEIe7yAPccc4JE0GqrANWKFtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqNgqRLXikojvIaCZY0nywz/Z8v5XwaMPnEKzxWVFwLD1UzOnRxEEKiogtsTNFU/hQxV2wItxTweoJZLvtdnkpcyLd48dKoBeTtlIrIHflsaGsjo9HhUPIc65ePWHQkoeq0e+BAmFB4Lkp2vLKJEOl1Y5mbItusH9I1Gc+bdDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=mK1ktyCV; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="mK1ktyCV"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id E390CC009B;
	Sat, 23 May 2026 18:35:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp) with ESMTPSA id 1ZXKP9PgKKo0-QkxHiJbk;
	Sat, 23 May 2026 18:35:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779550504;
	bh=55rKda37+9P8+aIKvnZzZS7sKx4mXnkI6oxyQkvpmtM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=mK1ktyCVmyt4oCyufO7XQ2NUyEvKnSsjKPoXOAX8894/zHuadehPM5br2F5XLDdyC
	 YbOIpBKr2tzM36hQjBv116TObkGGlHw4RH8ZZDukS4PefFftWb5L5YzX1hNZMNXA3Q
	 Z9pXswawd+//GiSg8MKoDPi+KKx4sum8vUfIJibk=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v2 0/4] staging: sm750fb: various code cleanups
Date: Sat, 23 May 2026 15:34:55 +0000
Message-ID: <20260523153459.177488-1-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs several cleanups on the sm750fb staging driver
to improve code readability and remove redundancy.

The changes include:
- Removing a block of commented-out forward declarations.
- Removing redundant variable initializations.
- Removing unused struct fields.
- Deduplicating per-index fbinfo handling in suspend/resume using
  a loop.

No functional changes are intended.

Changes since v1:
- Dropped "staging: sm750fb: use ARRAY_SIZE macro in fb_find_mode
  loop" per Dan Carpenter's review.
  Link: <https://lore.kernel.org/linux-staging/ahF8dacOkX0tdxGf@stanley.mountain/>

v1: <https://lore.kernel.org/all/20260523051509.166152-1-ahmet@sezginduran.net>


Ahmet Sezgin Duran (4):
  staging: sm750fb: remove commented-out forward declarations
  staging: sm750fb: remove unnecessary initializations
  staging: sm750fb: remove unused struct fields
  staging: sm750fb: deduplicate fbinfo loop in suspend/resume

 drivers/staging/sm750fb/sm750.c | 45 ++++++++++-----------------------
 drivers/staging/sm750fb/sm750.h |  3 ---
 2 files changed, 13 insertions(+), 35 deletions(-)


base-commit: 7cb1c5b32a2bfde961fff8d5204526b609bcb30a
-- 
2.53.0

