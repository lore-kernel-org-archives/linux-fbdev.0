Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684C199D8
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353932; cv=none; b=N9WilkVfKlGk7Dvpmk+C898+6r3/T2LX22L/TYnjohiiAtbGTNU2aiRZldeAxJ19MW0bT2OPMAVTEslMXgg2O2S2NMWPj41q3FGKcxLiKVc1E0j1uWUpZaQ9HJuCb0kkGqbMtQNqpJ3FYEkR2Q9CUhgWDsTHmrj6NdnrjI3mNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353932; c=relaxed/simple;
	bh=vC91ZiiJ5BU9SrRPuTCwWy7Du7qL/KT6rWKp1nW+tuU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dJO9km+ldor+/JDaVXsDymOu5PF9m8Pgcjhxg7iZvr7bXdEyZxmlph6gzPXcLClIC7K2m8hIpQhWTb+k3woy42q8itNFm2BTveTO60R/mKTvNNBUeOv4jZZCaiP/qg1DVJsToYUnIX+iPYCBGl/IFWe4pszHyC2eI5gdsHNVHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HqLL1mr7; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HqLL1mr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784353925; x=1784613125;
	bh=wZDg2TnCLHGYdKblywpLkhnTuVnukUT5tuoRB9Al0uQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HqLL1mr7yrNlR5M5SUcEYE3YEpRkv2xcxHVKSjkszDP2LOHZtqbmHCc9Kqmma0mmY
	 5nqucRVeJqDfThmMWAvgNOrQi7mljxmdGbgCyeojqARxNvtFu1HXfDivxWSia77YDO
	 uQss0WN6M/gTXFQn7deYag1WahRotL3w/n+0D0ToX6Io0vYJcCp2LwMmy1wuRreNPN
	 c/Yck3ElKAgmuDlxHm9Sc0KxCUaicfdOEsAj/raZ62CSjxtHu88Rswr6EGDAAahshx
	 fDwn9CGFPakHRUYq+vcBkXiUzTPn16i28wl5Xn30Cy4bVR3WMX2e6KPvW7FLeEfLkK
	 PMi6c5lbf9ljw==
Date: Sat, 18 Jul 2026 05:51:58 +0000
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Nils Lehnen <nils.lehnen@proton.me>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Nils Lehnen <nils.lehnen@proton.me>
Subject: [PATCH 0/2] staging: sm750fb: remove dead VALIDATION_CHIP code
Message-ID: <20260718055132.441-1-nils.lehnen@proton.me>
Feedback-ID: 188354734:user:proton
X-Pm-Message-ID: 3101530fc5d2da68fd37222b300a0adcc3114eec
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

VALIDATION_CHIP is defined nowhere in the tree, yet fourteen
preprocessor conditionals in the sm750fb DDK files still test it.
Patch 1 resolves all of them (dead branches dropped, always-true
branches kept), as the driver TODO asks under "remove unused code";
patch 2 cleans up the indentation and blank lines the removal leaves
behind.

Verification, both patches: the disassembly of all ten sm750fb object
files (objdump -d, x86, CONFIG_FB_SM750=3Dm) is bit-identical across the
series. Compile-tested only; no SM750 hardware available.

All English text in this series (cover letter, commit messages, code
comments) was translated from a German draft with the assistance of
Claude Fable 5.

Nils Lehnen (2):
  staging: sm750fb: remove dead VALIDATION_CHIP conditionals
  staging: sm750fb: unindent defines left by conditional removal

 drivers/staging/sm750fb/ddk750_reg.h   | 84 ++++++++------------------
 drivers/staging/sm750fb/ddk750_chip.c  |  4 --
 drivers/staging/sm750fb/ddk750_power.c |  6 --
 3 files changed, 24 insertions(+), 70 deletions(-)


base-commit: 64276d9bfe4d1fdd5cf2636f1065f7ea55c2defb
--=20
2.43.0


