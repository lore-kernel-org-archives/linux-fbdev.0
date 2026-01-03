Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D93176ADE;
	Sat,  3 Jan 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445311; cv=pass; b=T6lYeZ2h76RKwwpSTXC4v0cEdq3eKWsmRWluqGe6Ntuj1HAs0IFQXpXjTTNKpYel6wNiFzFlDkNed0YbJ8dibvWv6wyRX1UwAnGpMYlEqAigKzOQE6YSVnmxOuK9o/yT7Jvb+Y4umUSEmayQabYWRK7LYO08WRpJd0JHmterL8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445311; c=relaxed/simple;
	bh=Kni+ALOf0SmXO5HjT3FmQtt5s7alI1o8bjgFe8pbzMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpOigF270CGtCEVAY2dDDSVsd3LjkhHTDmgapL1iwbGMLhl8iMPop2bB0j+rUxptpV/dhyW2xRZn9dF5nFB36skTme8zKU6l2JAmh04hMitzRpj1d795lB+B6bVnxzHmpGDUy0ZHYB8dQybpx+P0BmlJhAJFjPtGx6wQZctqKmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=j7H50wh4; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="j7H50wh4"
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 603C8Uqp025816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 3 Jan 2026 21:08:31 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 9FF8E109EFAE6;
	Sat,  3 Jan 2026 21:08:30 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3iWl4XW8LZRY; Sat,  3 Jan 2026 21:08:27 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 15174109EFAE2; Sat,  3 Jan 2026 21:08:27 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1767442107;
	cv=none; b=YTvZR+T/SBh7fOvZxg8HkhDHuAr11REbaWi1Doae5+FztuBz8ItGJ7AQo1v5sjEU7AdW5+qrIzTfRNLzvLKO0rX+rrkpzicyLhRas5ukEesikyhlS3/qGxPYZXLayvPRuzuXCHZR9Ca4sqC3wmPySAVQRHaIRgNCx/3V+muqvPE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1767442107; c=relaxed/relaxed;
	bh=UKbt6mJywnCUvdREcRbT7IioK/DgJePwglUtLe9nS7M=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=hzHHCLg745SCB7XCgmQCIvazw3JHtiJXZlEjzl6Zz/YPXzq+0qGJFpXlMHFh0qKJWAa/R637Xsa9g5KYtG1uPeZeKjJMN7O+XAQKZ/xchXEztVJhckix3a+IoK54Go0yj1jdiayIRYRkECD4S27FwNqCvevrNm5y96hkVV0TSIU=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 15174109EFAE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1767442107;
	bh=UKbt6mJywnCUvdREcRbT7IioK/DgJePwglUtLe9nS7M=;
	h=From:To:Cc:Subject:Date:From;
	b=j7H50wh4vixl7CY7dqtei1IJ3G/17d14wVgym4FvqQgySjcnORBiqet/PDQye/h02
	 +QjeWVpAtwyXx56HJHgAvOCDgunFnR3nJeo59fDju3gwP+dHBdbah3MkK3uNSyNeBE
	 R5fwz8A4H+lCFV4B/ARLPHJJwTcXeIm1Kf/DYD90=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: sm750fb: fix typo 'resetted' -> 'reset'
Date: Sat,  3 Jan 2026 21:08:24 +0900
Message-ID: <20260103120824.1275574-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a typo in a comment.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750f=
b/ddk750_chip.c
index 025dae3756aa..136692b00804 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -249,7 +249,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 	 * Reset the memory controller.
 	 * If the memory controller is not reset in SM750,
 	 * the system might hang when sw accesses the memory.
-	 * The memory should be resetted after changing the MXCLK.
+	 * The memory should be reset after changing the MXCLK.
 	 */
 	if (p_init_param->reset_memory =3D=3D 1) {
 		reg =3D peek32(MISC_CTRL);
--=20
2.47.3

