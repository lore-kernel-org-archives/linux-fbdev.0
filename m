Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B84B2FD1C2
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355669; cv=none; b=sFn6hWX44LhgekZqVL62p7PD9u1RtCR0V/NM9rkBTP6AHAk7dzNMp65TVx2vkYb0BzWqFf2nOYNl8FDYzuyBK5sZn3pcqHC12KQHu1ivnVXmrlV2E3XIbh2WvnHZ+W939i73uGYR2Oyhs1Kq00Y6joAuuJ7LL6Cpy8K8jGco664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355669; c=relaxed/simple;
	bh=pVcUIOUGh5kK5jlGqVA4PZwwb6K+9jee3yjfvFya9z0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YsJe6N5wTJrkxdBwlMqoZ6F5d5j6nidkogxyZSc4jx7SExRf35QT+f/QQ0KSIWDA4nV2qiBDQ6iGBcROc4u5iewb8tK+Z6InKWVFTNkOKtiTBpyav3+JnJnHWgZRYShlmW5txKEci/TPfHsZGqUkj3LyJPk+PA7I5sqmNI69eAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iBZ7OgaQ; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iBZ7OgaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784355661; x=1784614861;
	bh=xc+YKuq4IZ/4Zsvf8ssOShEEqKJKyXBDHocYrQccUL8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iBZ7OgaQL7Y9htMwK/s9uUkn3wypvU4nAbHgHq9GRzOP2HhLENpafEYk4L26RlVLQ
	 uW9FcgmrNjqdWlyewdFVOrz8xx6R9w3Da5Ok6O63Q569afqL+UfSzN1VLHkIZF7Zf3
	 RtLxYgWLey7s6mTEmNOqb+3lbkH+uL1sTi4reRkw9tqcNZxkjf/kIgmQi2mhFhcYCj
	 ods3p/VpIHonL0UyXwlm4v8M0u4z3VUMkx2x8p0xCgonnG3ezvw7x1w92wkxAb1n5N
	 A/UkrvuKQP2jy9/yit2RLTb+BiiI+YKFtK4Rdrj4BCTeK4G3ClUut3WMqHic/d9nIk
	 xV96Z2ouSo51w==
Date: Sat, 18 Jul 2026 06:20:56 +0000
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Nils Lehnen <nils.lehnen@proton.me>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Nils Lehnen <nils.lehnen@proton.me>
Subject: [PATCH v2 0/2] staging: sm750fb: remove dead VALIDATION_CHIP code
Message-ID: <20260718062027.5850-1-nils.lehnen@proton.me>
Feedback-ID: 188354734:user:proton
X-Pm-Message-ID: 6dcdab8aaf6d624f91cfd8a67b65f67a9795c5a4
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

v2: resend of v1 -- patch 1/2 of v1 arrived with an empty subject due
to a local send mishap; no code changes.
v1: https://lore.kernel.org/r/20260718055132.441-1-nils.lehnen@proton.me

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


