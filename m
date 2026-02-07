Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB42701C4
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484375; cv=none; b=jUCXk2m6ZLOfnrOMeQvByK9Np2LjrafmxP/bjXrJ6Py+eb4X1BJo+BbcdjR9/j1rS8iz7ladwufjZw4Yl49+FMGug8o+f6wWZETAVWb1D9adUDFNcpcvQM8zJo3pkQclODwRXSPbVLzXNkfye6ietZrXie5fOBiwmXkMEgu9flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484375; c=relaxed/simple;
	bh=WJU23aVH+0sUbAyuhM36QZU69ipw8Ieg+NYdGvrvLeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rm/5ezXqG5ngPNz42BOtM+TqZrhRHR+pusc1pPP0g4BlRO2hORfxwsutwvKfMC+RBT4JM5g9xGGCPk9PxwQdw5e6qP4rvhjNcC7zAsaUM+SXj7HRMcmMsIG8ynx6JQsJRV8VCjmZsOv9q/A1kXDfTMZIT0BPP2kKMcqr/hhBtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lfXc6Exn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lfXc6Exn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so19289365e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770484373; x=1771089173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsGgjQ+pwkibaJQBma83cuqHyIeglUS8yUfBuSxo7Lg=;
        b=lfXc6Exn3x3rSUM8gOBhM3VQ+6S5SbnU6W/WMMkBDbiJzAw/w2U7anAeptueqcdQv6
         88G34QoHAJ7v1sTIMMY88gTb2Dm58llA+JftEe3YemoRqz6JBvMaHogFcb4krzLlil8s
         1LQyFdiknfoumSAAkD45Y3vR4DHbZLVFrhsooSG8nMGh5usbdkMqj2Tv9hzkoBtITwJA
         HdGePCMRlFtkTqQuqIjOdgQof3GO0mSv1bfyWYRFOeBIW5CFxMYhw3jCqRJ596fTtubf
         lzPUyx/o/2SgO1ofbPuyXkTmkzUWr81GIMTL44CLZ9sUBAwd/ReUTweDP3LaWiwl3qdg
         XDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484373; x=1771089173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsGgjQ+pwkibaJQBma83cuqHyIeglUS8yUfBuSxo7Lg=;
        b=AQOtTBprdikjLfQpdamJ0VhyqKW0ltN1BEO8NfcmD90jIKvK5miWqeNlmFSvpKd0Iu
         eL9Ff/Gc1zYcS3wzT1/sD6RCsioTaa3aBBc8eZaCo6we57a69LJsxSA0b0EbuFZKS/3f
         Y4fkS6b6mKh2uQ2mpqZRtfMSak/jP5Kh3j+kNI+Rq70mIHNn36e/6ON+dRMsAkbOpuhZ
         ZPREYGCY79AcrrHO2sDApa2YJjZbeRrVD1z5e0vSIOvPLfMgZgJ17o+xOcCpw8mA+a9S
         kr3JbQmf/a4kK0OlJxxpINTEybiRKO77Kgbw8E+pzR+MNBn5ggpIIwN9Zsq2lVqq8Xxa
         B5ig==
X-Forwarded-Encrypted: i=1; AJvYcCV/NPPKZO6wuWs2qCGzkkABPCUYFUPz/ASpQsXyEx2W7hd36tnpyI7gsl9Vc2g/Kc3T81OXNgPAmHqUVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdabcziZ3x1j1TS6CGzzkpggX8aoNeFsn3gtJm3ng70nCHgTR
	dAdUy77DJvv4u9RwbFh9KfTFBjfY/8NV/zZy/9VgWH6AoXjrTf/kukHkwE3i/KFoFg0=
X-Gm-Gg: AZuq6aIPf5h+aX+9bn0VxSnmZcWLcbAVuzCUgAxSiKxfegH+4opgzDDNJi9Rf6UT63I
	LpuSKhbGJgtZeiBu/936yOeAjzllYfi8gsHFBSw01VOjKHfdRJ/dg2H6THBlBsVBYd7+uirFxpC
	3Su10MSK4057TtTBp7ztqyqPUz62KHwVFtfh/BJZZ/QYZ8aS9dWNd0C1PeacMGmq+IEs4gdh7IG
	b0qUBN8V5W/UlzqlfaHGUTfzh915ymj0jAXned9v/GZtrW/cI/Lx/cJPHeTFZOdrxaZwefJBzWi
	6OzAfFZmC17fwHrxtcvMbA9hRq8gei7s0zZ9JfDMOHywFofc8vdYwmgKgEuzQbTYx8Bl9fND1QC
	s3nu/wtezjVYNPPUqAkar1FmPR7m95dfnKwzPpBRjjKYTUIfBYMoPb0NkoEZJhs1/wEIB2dDv6n
	SBfsYsPYOHuyBnbZ8/
X-Received: by 2002:a05:600c:8b76:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-483201e267emr93459715e9.12.1770484372306;
        Sat, 07 Feb 2026 09:12:52 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-436309ed238sm9322002f8f.19.2026.02.07.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:12:51 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/4] fbdev: au1100fb: support COMPILE_TEST and fix multi-device support
Date: Sat,  7 Feb 2026 18:12:33 +0100
Message-ID: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WJU23aVH+0sUbAyuhM36QZU69ipw8Ieg+NYdGvrvLeY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBph3KDnNMH1/JdOcqL0z3I6M6ieN3Fv7tNS64Oc 2PyksJ6E3+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYdygwAKCRCPgPtYfRL+ Tsd7CACLPH0Qdyo0BISW7Y282uaaXnVl3Oatqm9AQpM2A8eCFibYA5/hFBTmwGkBKCCPpuWvoUI l5uReTC8pthgHoplTeynhWF6XA3HlpodJYZFwQ7xaERB4wPM0dytytv+wV4vDIyyVcD2rhmRREM toywxjN/YzzD8qA6WU7pO+USqnW3K2L0WplgiS3+3mslY5gKMBS+axISoTjsmbcF5J0TKj/5MWk LtmW0mKP7Z9Tg2sP4l6ESQ9+AmhB/Uh71q76dSnN7bMEQ853bcv18wKIMYBgz73+qYM5b0KO+0p ExYkERfp+HqwLEd7nT+u3t2eHNMKbf9MGohezqh6U9CK6saG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

v1 is available at
https://lore.kernel.org/linux-fbdev/cover.1770196161.git.u.kleine-koenig@baylibre.com
.

I reshuffled the series to have the only really relevant fix at the
start. Patch #3 is new in this revision and so is the s390 specific
#ifdef in patch #4. Patches #2 and #3 fix issues that pop up when
compiling the driver for arm and arm64 and s390. The last patch drops
the hard dependency on MIPS_ALCHEMY. For that the above mentioned s390
specfic #ifdef block has to be added (or alternatively s390 excluded
from build testing) because s390 is the only platform where pgprot_val
is not an l-value. The things that happen in that block are maybe very
mips-specific such that maybe this should be an #ifdef CONFIG_MIPS block
instead of an #ifndef CONFIG_S390 block?

Note that in the v1 thread Helge wrote to already having applied the
first two patches, they are not yet in next, so I included them here
again.

Best regards
Uwe

Uwe Kleine-König (4):
  fbdev: au1100fb: Don't store device specific data in global variables
  fbdev: au1100fb: Mark several local functions as static
  fbdev: au1100fb: Use %zu to printk a value of type size_t
  fbdev: au1100fb: Make driver compilable on non-mips platforms

 drivers/video/fbdev/Kconfig    |  3 +-
 drivers/video/fbdev/au1100fb.c | 89 ++++++++++++++++++----------------
 drivers/video/fbdev/au1100fb.h |  7 ++-
 3 files changed, 53 insertions(+), 46 deletions(-)


base-commit: 0636e6205beed850d985276dc56fd73d785bea5c
-- 
2.47.3

