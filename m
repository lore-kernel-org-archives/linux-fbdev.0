Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D32F6586
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433696; cv=none; b=jdviA+9EzAb2tSFueSUppEkd50PH9pO8RhXVIwN6/Dz9YGoEXnH57UuBFiG1PmWdiRJs4Owxyi+MN7ZN+VcybEQweLInM0l/91trSpc/ooXPr7uaKDVG0CZc2yet3Lg0w2LBX7mcKNJbQ/Lgj8jhAL2GNya2pfOVjnKxUJWTTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433696; c=relaxed/simple;
	bh=jtsnuA5ycq+UgmN6OOcXxBfjzv8pUq5mMUCzSwpDgSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYgzlEne/0dYajFS8R87GUf0lEfbFlteanB0Ntv7EPtVfV24FRpRHvg0qX1rgSR0Sp4nMPBYEE1/kvTmeqKW+scNcZapAf4b3JV7C2+n/jtgCRvBlVfcisOsSHHCERgzKkFv2yZ7/RzGlSXDRrjQ1UfU8Jb/DZjwdRcCjdoSXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swiF4wzJ; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swiF4wzJ"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd6so290504285a.3
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789433693; x=1790038493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wPbpaLTfdjYqHBQHnPbcqcrKPKopAanNoJX+x2503BM=;
        b=swiF4wzJBxx6UGfZG0rpviFm9wPmwjrjWSMG9zDmsvGRpz38aL/Hs7YUMziiYkjFk6
         jvSMwyIBNAgIBe4mCQgK7Gzcmm6RtS/ZU8ehoOGiv4p0nBlR/cH7JGz5sJsHbcsbApHQ
         RIabwAJERaT1cK+qSRVogsATexOXfibcyQUFr02jrEP67u/p3N1/sl+i3rnx8MZLT5V9
         VFJfy2G5oBv3g6zYdD8rfI2kUdl4tm2h3k0KxMdY3iUvXab7iMH/AzxUFQz/7La0PhMM
         AaftwdqzsmTLchTj0qDYXa7ickQ48SWEmphN7jkqJCsX9/WTVPHutQqC1Rj5Y0jl1Pc5
         a9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789433693; x=1790038493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wPbpaLTfdjYqHBQHnPbcqcrKPKopAanNoJX+x2503BM=;
        b=uU/6KlEFib3DpRQiDSjnmzpEpi4MnDUE4Jn4o3gfKhvqFm+E/JQTY2SM7dGotO4A19
         ajtYgmA/fSvVNHbxAdlGJX4kRnz1RlH/lmuWsdRhpQaRrZrUUhxleEo9Pya5Ouv+5NHC
         eAAiwMMZNMGDGo3HWSroJkdphndksebKnd9kVBgkOxjyULDbt+kuoDvznn9cEDwj16DV
         WCw5/QDAiAbgdEPNgYq7eGM3af3RNl4kLMGzfqtN55nMoT9TuFe1O5cVqGkh/C3FhSLp
         xhfiMcMffP6ZGwobRaGuot/9UbWw8CLzj9bxb/CNMSBsXTxz1MiuaIWWgjaDbBhljfWp
         xaMg==
X-Gm-Message-State: AFuF++l+tF3QmsYmqcfucGSvXTXtgKq0/i07t4GSoE3tXGYxLM6QqcKg
	Bs3APs5wvg8ruUUReFem1eWdgGMIe63WPzZMvH7uP3cLOv4KMDKqsCY=
X-Gm-Gg: AYBFou2Uk3pG8aL3H/CyXMEhO8rxIacHhCAQx7/+17/wHoRCeswA5ohUaFDuGC18O+D
	tCbMZkNtWnvsJodG4vQp9WWbna7HEf+VwxT3zzmowKarS0pp6Xe6bgOi56R/qrDZFW1BV0UWHCk
	hOe0x1rDb1t5Dqf9BXDGYmTGmcFUNwB85uz+T3CrDh/zagMnkAPmM5uS62vz/xY3cSl/bwjoAFu
	RCK/INdmQWCxitdHnYDQjl4u7xE6X8y3d1X3Fmc4n91b9kc3JYTyPb7cZH2QoPWfx80nTy3T3Gl
	ctg9uAKuwUwdR4kEXJixtDzU2KQskvMvdj4vrUt6A6FHjzD8RpXGVOgok3ZqPX5CGz/zuzFWzf+
	e7jjRDrE8SmgTF5V2Ku9i8PEp62VfEofVT1E6rPJn8364VKeAlQnGBjWUFJrywXIMoyjl0w2Xa6
	Q+i2v3Dp6Oz2n3nnXTFZSo+ib2xdaKN5REROo+3+zKLtk3yLLuonuUUbZDxtUoCumLUMxsffhvM
	VRS1BYKuBNe5XE0SyYrBM7CsMuyiaEOtiugl2qbFHusrYAIHIs+uq4ZlQY9bLDz+B12MuNko+6E
	n2ljYst8JO60I5zlA6bESQC0eSI5I3iEPkXGQsgl8mZPQ8a+ONNFIEC0WcGR4zPKjEAPe6SAFSk
	=
X-Received: by 2002:a05:620a:43a2:b0:939:6c31:2318 with SMTP id af79cd13be357-93a29a13b19mr830053485a.34.1789433693467;
        Mon, 14 Sep 2026 17:54:53 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b3dcesm108370476d6.31.2026.09.14.17.54.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 17:54:52 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: nvidia: Release write-combining handle on probe failure
Date: Mon, 14 Sep 2026 20:54:47 -0400
Message-ID: <20260915005447.51995-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1424,6 +1424,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.51.0
