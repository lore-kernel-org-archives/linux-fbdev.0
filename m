Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9A4A5EB2
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403037; cv=none; b=IbdhY0ZS+mfHJO/gxBp7wU67Bm+RqhWBtrsPLeIapRUKaXvJ32FCbOb62GbJZ8yemcj26P6m1Xdlv94R8p+AegykRCiJDIKGgyv4ap/rnIuA6OPg+vE+kcr/u6iZ7XZMD+VENAZyKWIcDGQuq4rx3VPFC8kLU2NdItmCO3SLU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403037; c=relaxed/simple;
	bh=Pf5auVrKMgDnMWWbNxu/l4Lc3KB3RvGuDckatQ4rOPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qc9bp9IMAJYlZ6kp9spH/FjvfwqN4A/PTD6MCYKLJEplvUtCu6K1vA5fFyLDhbBH3jyHfZSI4QsQEDFtTt1tHktyab6mqKLnImvbB65xdWAM/T933TaITTv97UvntATNHbwmZWZABQBDq1UOQ7c5NrEwrUHxPcO7QfPQlG2dnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz6njLRr; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz6njLRr"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso4272961eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403025; x=1793007825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=knrHyzES/QXTzztJhLzmWRpJR+Ay5sPD9k7TLCcmxn4=;
        b=cz6njLRr26uzvJQnM2o1NsSJ9ZuB92ZxbzhPCjyjAw4PilfbmQ17Kpa5UThDuSblUY
         QekfGhmB4o/PFjeWgDj2dVA3uoOlwBlKUU5g3HcJkFooVBvaySyg58GZ6EVDPp7/5Dyc
         z+cZu/8pQkg44ad6wsIR0XftKSnnOH7Jto+mpYX386u4EfhHLvwd876U0Xnw/5/assbW
         Rju2jEkW92ilvS0n9JiQRctJd8i1J8W+gE8edsq0OefbMf1d7qfYXnOJD96yGHOzqjW/
         znHjtm4I81DzFBeOy+dYsxF6D1fwY22wW8zL17GUXCdxRMVv3sv6O4kutTObevmWeFFM
         wUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403025; x=1793007825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knrHyzES/QXTzztJhLzmWRpJR+Ay5sPD9k7TLCcmxn4=;
        b=GeabYSmyaGK/gQ7l7lnfoico5NYIloqEvkmJFzV9qaaao2K6LFWr8zbWWwL3B44Me3
         iW6669ToQCDNqG1fSVeETMV1+8z5PcHEU8VMDCbysYatvHRv1rC9LuvZvaeY/bSPoBDw
         86ExY+3wVvrX7MC4/vf99AgnIEogwKkMuQ0MLhjdb0FJgmcSI7Ay5PPwchSbE75I6+IJ
         tQvcn6AunbWa9XnRYPTNWR3QTgiw0BeAF1au45mcCBYucza6df3DNpKYi37JqrOXUO73
         00NlhSNHBeTpVg9tR5/757yd4B3kTqYKfJ6NxEJa5ViVoVy3OAacaBtCKV1WH44pkuAA
         bL/Q==
X-Forwarded-Encrypted: i=1; AKwUvByQZ6/TEl8h24k2YT5EU3PaFPBip+2UqVESUZNCdzBo49fpWiZBw1jWZpo2+mbcTPZx6vbGfUDfCJxF6A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKbKLkRBbEzDDUDeRWLjdzQXyUUP2aKGGJQH6MMKfdEwEBppmhY
	rO67/XjB26JBPgajs1l13AAhp4F6vuQ8YQW+Pop5jzzRu79P6WVBW9fS
X-Gm-Gg: AYBFou2bga/YoP7G7zn0w1zlU3I9ew3YZbpo9OZDfXMeCREPih8rwGkL0b8D6csq4aW
	uidMXknonclO7ap9MP+E37C4brwp+Fwl9MY5rF5HKlAFtHFW1CNvkgFf8KS95pRWubI3uV54G5x
	FFRgg9ICHE4UCcSpS492wInf/dgtQOWw+H3+jqgS912EExJPHyV6EC4AVFlBErXPN/jqgbx+jS2
	+Px5QKXfi2AXYa0dlt4gAEGRQbAvwO19Vr4LWL1nnlzYfFKFGIslDxCwiNsCHPglTyup1pd4hac
	tC83X3viJ6v717QCLaiaHKQ5tKukR5JcjQGLw6xJ8EGWi08IJBMbAxaBRtWmFLrfwfjtoFOZ5ql
	FD4p68S3prK3YBDnUMINVz6k3aVrEhVPCpkYCG852uFj3nxbn6zg0fFphdGu6vVHrdfQV2F6z4g
	I75HVN0lmlkXvhIc40Olal/o+O+yFMyd3oOsmNW2SiA1FBhnFNAFJatLu6Dxyspd97+25ddTJHu
	aXp3Yvyf270tyGWMKlm8EdzxP8SWyRS8bKK
X-Received: by 2002:a05:7301:2727:b0:35d:a10d:11ef with SMTP id 5a478bee46e88-361a186599emr11742279eec.11.1792403025311;
        Mon, 19 Oct 2026 02:43:45 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm34370074eec.0.2026.10.19.02.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:43:44 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>
Subject: [PATCH v5 0/3] fbcon: fix rotated font buffer handling on font change
Date: Mon, 19 Oct 2026 17:43:28 +0800
Message-ID: <20261019094331.1128871-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix out-of-bounds reads of the rotated font buffer when the console
font changes on a rotated console (fbcon=rotate:N). KDFONTOP installs
the new geometry and vc_resize() redraws before par->rotated.buf is
updated, so the old buffer is indexed with the new cell size.

Patch 1 keys the rotated font cache on the font geometry. Patch 2
rebuilds it on font changes, saving and restoring the whole cache if
the change fails. Patch 3 retries a failed allocation.

Changes since v4: save, clear and restore the entire par->rotated
state instead of only the buffer; restoring just the buffer left the
cache key describing the rejected font, which could make a later
switch skip the rebuild and index the smaller buffer with the larger
font's geometry (found by the Sashiko review).

v4: https://lore.kernel.org/all/20261019090206.1094958-1-yyaqia@gmail.com/
v1: https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/

Yao Yiqi (3):
  fbcon: Include font geometry in the rotated font cache
  fbcon: Rebuild rotated font buffer on font change
  fbcon: Retry rotated font allocation after failure

 drivers/video/fbdev/core/fbcon.c        | 46 ++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h        | 19 ++++++----
 drivers/video/fbdev/core/fbcon_rotate.c | 10 ++++++-
 3 files changed, 68 insertions(+), 7 deletions(-)

-- 
2.56.0

