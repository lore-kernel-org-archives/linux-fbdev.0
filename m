Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5014A4C6
	for <linux-fbdev@vger.kernel.org>; Wed, 20 Nov 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121102; cv=none; b=t4mIAgKf0w7jU0MZ5Gz5F9EJOWe2hYS+qhrW70seBDn/NuMYSzzf52q158g1MvQz6jEwDohE09+YKnI777gbew93CqYgYEZTcRwVlQLYiS4nyfNG93X1CPGhptHooCqtpseAcHygknG3XiCEhzEgkPSMeAZLkXNzCOzj1APwZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121102; c=relaxed/simple;
	bh=eElI0PQS6RM/KBvZvT/6wjNMvQDv0TOKHZU5Ee9F190=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=LPLyODfdb5fUKarxX+dlgtMz4inq4+B2blYYmcmkMsvbFBXoSWmApGVyjs6Uh0+CPOKvqveFMesRC9D+zZ2LuBYDnn5txfW96nKaAim605V3ZhaQcGZMSYcLueMtAt7sU2+kOxQGbUpXwva+tyF8NX5TKd25CGYAG3Oq54XEvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasom.in; spf=pass smtp.mailfrom=rasom.in; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasom.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasom.in
Date: Wed, 20 Nov 2024 16:44:39 +0000
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Cheolu Choi <ray@rasom.in>
Subject: [PATCH] staging: sm750fb: Remove unnecessary parentheses
Message-ID: <Zz4R8L7493vTJmry@rasomin>
Feedback-ID: 125224831:user:proton
X-Pm-Message-ID: 9d4c393f2b28920b1b9ee299cf8b3e9568236fdc
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adhere to Linux kernel coding style.

Reported by checkpatch:
CHECK: Unnecessary parentheses around 'clk_gpio > 31'
CHECK: Unnecessary parentheses around 'data_gpio > 31'

Signed-off-by: Cheolu Choi <ray@rasom.in>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750=
fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..50e51d730d86 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -393,7 +393,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned=
 char data_gpio)
 =09 * Return 0 if the GPIO pins to be used is out of range. The
 =09 * range is only from [0..63]
 =09 */
-=09if ((clk_gpio > 31) || (data_gpio > 31))
+=09if (clk_gpio > 31 || data_gpio > 31)
 =09=09return -1;
=20
 =09if (sm750_get_chip_type() =3D=3D SM750LE)
--=20
2.34.1


