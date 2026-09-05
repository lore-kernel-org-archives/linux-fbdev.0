Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96144A2A42
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613787; cv=none; b=SjLIz3sgto418R+JutUohW5syQPRP7O0NuePRcKX3IKC0aSPs0M/7+t53ZIezyw6b/KIEkVWMaedRXJT8IvmbDJaG/J8q6NRU3QgGw3OO7SG4k0B0LvsAT9d35S6lWRc/mhpX4pr7ivW384Hu53QgY6Qo+5FDugqataHE70g84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613787; c=relaxed/simple;
	bh=9oavKokRiGlYKumk2qr2nWS7TMcpdvvTbgd4joGd2sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZo3BZKgJduVWAoLFBsZHjCPup4XFaVbMK7aF6J4prPoCbAgxCzkaIp+LiflF1EPo2/E66L4THW+YFdq140WthayGu5pkGwm/WVHsFgOrr4Ia+/N0QdtumzBXbcq6CBuIhoJPcEbD13brHtCYAK4HqHpZ+oLexh4ic76BlMHJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLW5/HO5; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLW5/HO5"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-789fef9422fso630729137.2
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613784; x=1789218584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7EzzJgiv2Lpk9t8SNtDocd6qJ1tIEeCqMQeAGgeJvM0=;
        b=tLW5/HO5Brdmek9dqA2ZcqMQpbN3lzz1pLbf1F51K2+fE1a7THTcmyKKfwVBBukyKW
         447MV7tzp87JRp/Mx/8HvZ/PJCUpSAiHHNJXSN39/BDEQkeDflU1mMyVRb4yyNAjqKLh
         F1yd4dwbWtwWtseSsA1FAzYma9jgB1tJ8bWmnG5IXtruTNwEohyXSzFeXpmmEaOSuQwn
         UA2JaYwNdZC/Lya1txighWG9dyLHLTl0gn7ZcVJ7XVNuCl6W22ccMce+UrdnGJ5tlYjp
         9SOFWDrG6NX7IedrhHVHFRnFr0d+6xr1TfMjKWm/g+MoCyO9ExYeQh9plWuBNR00rWSf
         0/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613784; x=1789218584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7EzzJgiv2Lpk9t8SNtDocd6qJ1tIEeCqMQeAGgeJvM0=;
        b=YVgs+bKpJgNKEFj15quvG+qBX1wyG4YJd74SfJBtzT6vnFeZD38U+h+R1Tb4UGVMs+
         azE7qDFl0kD7EIDOKTVNflB+HsSaRF0cb/wu5Tv4LueELYUNNqqhmMAeLO/RuuUg+ixY
         Rgq7leKva5WR0mQeZX2o8KegbM+kLJacdZMg/tJD9IAM8cUVg/ELyC5hdTaYvBney7aq
         PBz8yQIkLFTD5Rb5azev+BOro0qCBE6O/JGPlHFLns+YOP2g0ElWBLZ7k3/liFWcy5G6
         Yd2frkQ1OOWcRy8qiO7By6lnPvT+8JLmnhQNKqGPDSJI+z1TJZBHaViz+SZR/TWVkAGM
         XEiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwus8PpHvz462G5aq/e5ZRdqhZ6CNqmG87Je2ILCXxLxpwP2Dwp2FFvEbdqNvRwAqvQHSgz/Sxtkn5Eug==@vger.kernel.org
X-Gm-Message-State: AFuF++mRXJtY+VCvghNklYE/w0MqBeK01VY1pPF6ykK8bwBHiEqHnooQ
	tZodblIZvRpGzWrs+DoOAd0NjybdwCyXy9Ou4l2NQ4UuqbwCiDYY+jAU
X-Gm-Gg: AYBFou2s1PZVG8X7W+qlpy49rh7Ryq5mLE+kKd05dEicJBZHpsAMT00k0Uv4WE2qEQ2
	JCDjBAoSSfiDzfTx3f5LiEqUADkrI5nGkEvRurJJb0s11DwN24ZfTEUMXk73qm7kZdGIfSca3K7
	mPukDivhBdxl15K11CWBIOQUwrIhcAz9KPdRFN/NsTAjHsNfzytBjagjtqdZJ+JITkyeVfKnFgs
	EhV0r+ZP5yT89Kxds/AD8XVqWGohgv0o/JtL6tUav20Cxa/cv//K8zCTFnEpd/Y9NL4NC/toOtY
	Tp49wogf8if2XI7yZDIAGdCfAKPnmTU7ZRlJKKGsLxMMTdf9JgA1362406GZ0hgMZlPAzcC/4kK
	L5KSfGYzwcO2oA4czpOcjAt3aBdm+utdWlAuLyGM9e+NUoBJBWW9PTJs5GEKY6TNFZXqXFC5esz
	dR3pp2UXd1oNDouH+mfDUJWVoYEwz0k5XkpUhpaZCHgjrJBUNqw2C+8RcZ+HjCE6SLUGTT+Erf5
	opxF/bB16d8JB9fqmqH2qJ0+uFRUOXT
X-Received: by 2002:a05:6102:441b:b0:784:d83f:2a59 with SMTP id ada2fe7eead31-78a4aa99295mr3711296137.9.1788613783614;
        Sat, 05 Sep 2026 06:09:43 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47a76487sm3719782137.5.2026.09.05.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 06:09:43 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v9 3/3] media: dvb-core: extirpate defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 10:09:25 -0300
Message-ID: <20260905130925.7115-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905130925.7115-1-breno3011alves@gmail.com>
References: <20260905130925.7115-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition to eliminate severe lockless race
conditions and clean up unused function parameters.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/media/dvb-core/Kconfig   | 11 --------
 drivers/media/dvb-core/dvb_net.c | 46 --------------------------------
 2 files changed, 57 deletions(-)

diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
index 8b3f2d53c..c6a97add8 100644
--- a/drivers/media/dvb-core/Kconfig
+++ b/drivers/media/dvb-core/Kconfig
@@ -67,14 +67,3 @@ config DVB_DEMUX_SECTION_LOSS_LOG
 
 	  If you are unsure about this, say N here.
 
-config DVB_ULE_DEBUG
-	bool "Enable DVB net ULE packet debug messages"
-	depends on DVB_CORE
-	help
-	  Enable extra log messages meant to detect problems while
-	  handling DVB network ULE packet loss inside the Kernel.
-
-	  Should not be enabled on normal cases, as logs can
-	  be very verbose.
-
-	  If you are unsure about this, say N here.
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..29f99dfe2 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,19 +68,6 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
-/*
- * The code inside DVB_ULE_DEBUG keeps a history of the
- * last 100 TS cells processed.
- */
-static unsigned char ule_hist[100*TS_SZ] = { 0 };
-static unsigned char *ule_where = ule_hist, ule_dump;
-
-static void hexdump(const unsigned char *buf, unsigned short len)
-{
-	print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 16, 1, buf, len, true);
-}
-#endif
 
 struct dvb_net_priv {
 	int in_use;
@@ -320,16 +307,6 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
-	if (ule_where >= &ule_hist[100*TS_SZ])
-		ule_where = ule_hist;
-	memcpy(ule_where, h->ts, TS_SZ);
-	if (ule_dump) {
-		hexdump(ule_where, TS_SZ);
-		ule_dump = 0;
-	}
-	ule_where += TS_SZ;
-#endif
 
 	/*
 	 * Check TS h->error conditions: sync_byte, transport_error_indicator,
@@ -659,23 +636,6 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
-		hexdump(iov[0].iov_base, iov[0].iov_len);
-		hexdump(iov[1].iov_base, iov[1].iov_len);
-		hexdump(iov[2].iov_base, iov[2].iov_len);
-
-		if (ule_where == ule_hist) {
-			hexdump(&ule_hist[98*TS_SZ], TS_SZ);
-			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
-		} else if (ule_where == &ule_hist[TS_SZ]) {
-			hexdump(&ule_hist[99*TS_SZ], TS_SZ);
-			hexdump(ule_hist, TS_SZ);
-		} else {
-			hexdump(ule_where - TS_SZ - TS_SZ, TS_SZ);
-			hexdump(ule_where - TS_SZ, TS_SZ);
-		}
-		ule_dump = 1;
-	#endif
 
 		h->dev->stats.rx_errors++;
 		h->dev->stats.rx_crc_errors++;
@@ -823,12 +783,6 @@ static void dvb_net_ule(struct net_device *dev, const u8 *buf, size_t buf_len)
 			__be16 ulen = htons(h.priv->ule_sndu_len);
 			__be16 utype = htons(h.priv->ule_sndu_type);
 			const u8 *tail;
-			struct kvec iov[3] = {
-				{ &ulen, sizeof ulen },
-				{ &utype, sizeof utype },
-				{ h.priv->ule_skb->data,
-				  h.priv->ule_skb->len - 4 }
-			};
 			u32 ule_crc = ~0L, expected_crc;
 			if (h.priv->ule_dbit) {
 				/* Set D-bit for CRC32 verification,
-- 
2.43.0

