Received: from sonic304-22.consmr.mail.ir2.yahoo.com (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9933F8B4
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Feb 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512001; cv=none; b=m3nwEv41HxtXQYIsZbDNMtSZ36IxyBcs6uX3w21uhaXp9ocf2BAHRA6ic45TSCYXjLg/lVAG8nQExhmcxWeInPlG2g0Q7CdM7/UUgDI+jqaqYLqKZcsOKMXV9wwrX63VjSX5jjBFjqcgXJAF1z6RV8PuJH7f5gW4eBxlu6N45R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512001; c=relaxed/simple;
	bh=BEW5X6eIGVIRyQPrpbMM55g6Dm40Ivw1p74dnBhgBL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Doggq3AHeN1zHLD9ppiEX0NE+o5EQJ6lQnP/wY4Cg/N/37HIdbgTfYxr4Y74OeiTdIk3N5t9N4qjyzyehxX0gUUb9n1nOxwAmYLpXTt1RB8NXNuiN0f7l1HgehljEqfhYdDes/62Sh0KSRaXfPEa4CfS4RPJ6TKualraNFoRrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=IWb68ezF; arc=none smtp.client-ip=77.238.179.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="IWb68ezF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771511994; bh=VaWBo28dAnDUHCoe27rah1Dd7vMGiZtW4luXFceOsR8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=IWb68ezFPEgkcdb5ffveVEa5Zv6M2mU7cZrijGC/RXcyTmntn1NWE2EUjg7l/+28KPMOI+AFHlXXnbnJPrEUqMnyL8wC+NzoMaHuFLU7uA/ea1VdC2QUsUW3p0mR5JJwiLVKymyxwDMw43TbX5MjbjZ9y3RoTA0sauQ+xrN2gt10qimJ8CnbfmimZ1iyeiZZFFYErZxsVvw92lJSFIl/YSvCn7RR5A30qm5owlK/8KkDrHnvZF4g0c9ryOmq8uD3myqnne9ipxnC7SB9blwWcBesT9dvrrqc9I9JZcNIrkzav/5oEZHfNQHIKLPzxUCDGfNHFaA68GklVqUhNIiMKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771511994; bh=iUgRcycWk47BD8FHe4UWFfeDEDEnP5PTS6MHevYDX01=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aWdIBssWTAvkJ/gFMwdYkrf/kQQUI5VhsoRpYRzLiKIkI49XltH1REVo1ZzL//sL5Q1LSKECrlmS8f5FDzrfqc/TPOESxH/f4vBlnJ8grmFNrSjcwtcXdAHWIgkJQqpwH0E+aftc7QVzjzGgUxKyPrw2479pl/P5vcQKl3UJhqN7ATXJ0uV4gIgjpA3Pcp8P+CnxyLeHeq0oi+rK/u2e7RTVAmKSAKse9sHIGxh9DRHOLY5x1L2AU8icyt6XmQ4oVcB8akkFPV0XsOTiwskdnkoVMoxf5OlwCuX1JVnQ7jK3VTXV+mRoN6aFq+kQ93jPdUNldL7YSe0V45cU86b6Zw==
X-YMail-OSG: hKG6g38VM1kjQAph1KGJncCm6PCG1lp6B6am4wmamr1YwcT.tdBGJprRfGCBNG3
 9PANml9LdJknnHPQcF8DTt.GndYiyCM_an16l92eF9.6M_8roz.ewiSBfze1czBN7g3wpmkfgKb4
 nNpiaJYHcL363wMA77.jLnc4Cup3GCYyXevnxGBzBY6GXIKua4WalUAUinPf4WVa3NQJJLKEaWq6
 DKyL_69mv63BUrwSZwEi50ZxOyd2c8l_96BTiihm6LAkTXxX.8DzThf38q4NogPoXT7stVJ3gtKN
 MT6mvuOyqP3Cs5UsCsu11ni6POHWULl1d3.3Xx9QIpuJ8D0Wjxn93ZM9uy7yqVRJBxutBKIZNxJw
 jvzG0ndwcG_BFSEjExI41mylJCBhXPxgFjTVJcczGnqfLNelsW8DJLz8WojgLBQbSTpiALME8bRD
 Is7sHKBnsca1g5KYIBM12id83uGfN6arzzF.JJY0ReX5YqSEu7LSyK.WmjsiTFMZZ142z9S6qVEz
 lC_xri6ykOBltN25Y0DD4bSN5bt8xwbizekLMouOR7i6u0mjqsow4fwAAeddqUsxqUccCcegcNlE
 Vl_OG01r0Gi1m_6_rObZo25Il5eMkXEejaEZjeXUrZBhA1GkvBe1FHqurxmalwFAyGkxL3fba6hx
 q_izTfiLA5C5JBJMPFcH6Ski4JxfDZsLHQu.uGOHzb5tycEqXPKIkc4uu92oqbJ5iQmMFjiT2bGz
 QkZdwXJKmHTVSrI54cVba9fY5rmkzuQ20AUAUeSUXdPVxmsSgjvdrglW9ctSDJYQoSdRDoleyVlT
 LfVsT.rJWFG.Vio9S9t4vHpsMmhN6iN5HZS1yAHS8fIm7xItNYRct2geDznnJr1QW8irMxzAo3ia
 zrbdWTWbIc9YKTmZ87MDcWZ1v0R4PSYahfW_gnYDejtS6HaBMftZXAaC5uOQFaJtYjxLMtfNafSQ
 MsU0FyVDLuXF3mM7a5zngRhVCC_AHSC2oOz_PNs79CRzOdqxwcXKUmGgjVZksNHjP7ZFpo9wkxae
 qPQUqm58W8t4RosTX4JisnhVf6Dqv9.gNsQHpZv.Ngk6xEqB4gePutJkNgkl9qxC2Jtbb4Uj8YcK
 15XjA_udd_plYedgxNs807.de_bXU6Nkkmw9eOmQ7M91b.zDNO6cWwMR_GDxfWdLiwnvhxc34gbq
 DSqKOhAVkgYmgOgkVRzSTgNuUQIiQOAKzX4y4PY0wG6R8jIiPDaMfF5E5KFF7SuuMx6U2rjMZ11N
 ym5V.U_Q3Zm__ZI7XNhC9dwOGMdEo7T.7FUqx6KOYmDJ017MghmkbfusC7roS7CH_dXG.eWHuIl8
 q1OHk26c.Ai.D0Vvw55KLv_zURCF6LCHDaD5pLY4y_0WO6mWrNoCbUtudQcSm92RBwqpBq_LjytE
 YadprEhu0l3xceF1PuaejSPtM6eGDTcFW4zYH1wQOGFWxtRVnfuv5.YnhIeUM4lnCXunknvCJ0WN
 Kr1byvMfopC1OUV9PTVK4JzdGqzKCHXVUKqGEI.UIHER0TVlDtKl3s5eaVgqL3yc9Zmh_NdKkBVX
 9xXM21MPAGfnYjtU.fWBZ8pr8o9N4km5YuO4uO.DrwShUzt_mJq1udmRLmAflKR0Vh1D0Vbc5VNO
 xsKwm7Aso550jXaPKYACGewXqJLpZrNY3HGerABKV38NWopYm0V1N4Qvvssnl8kcAoqW2TkbH_O2
 WZuYULyjcZwlCvCsv8QGODLlS4qnW1EeVlrQYGpJGuM.9UWK7EssyxAHJoAWClXNKmt3IX7mTnb9
 FqAoRBOZ0cLNQL46jLzBEZ9cgpK65UiRPrTXzDTvJ2XYLx77A9UaDioIhmwZrZzi.QkF8l5Jyl5b
 Ru2DKCEybyp58roZBS.uXab.iViV7ub0qGBTiBY4EqE6TMq2VhYGDyMUShMFRLEu1EP47nzEFd12
 10c6GJohQbF5uOsGtLv1uyza_xRSu3MOHGN9gUM1PMxHRlgw.uLIeeSGb.wTiFsA_7nih1KmzbXU
 4NvZiQxfjHGpR6.1fddoD4XD005VecAfbU.e2ivJZv2IbN3MB74_33F.PXumUr68rsljxT1zExJC
 usrxt6WGGtXVIpyS6VjzOD379eCy.OXifobMaM_9KH1X9ZMQzktV6L4iqFm1xCh7lbBj4l5WEyS3
 coOe2u6fbD4vj6d.kt2t7qMQQwT6FK_.YTVOevSvmg0pJsSozbdbaIj3Z0PE4xNuPN9ag.0RslRS
 DKlQoxIEk4mowzdb_HU_s3XLAdFmG8_oCKX_UXzUHuXBvyztGJRF9CI.6r2NUV4YlflQExCdmQK7
 .WvrxQFKARZdp2OhN
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 1fb9b03f-ec83-47e9-91c1-112ee54bd454
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Thu, 19 Feb 2026 14:39:54 +0000
Received: by hermes--production-ir2-bbcfb4457-wbfpp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 986b859eb286868e95113c044e92cb9f;
          Thu, 19 Feb 2026 14:29:46 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH v2] staging: fbtft: fb_tinylcd: replace udelay() with fsleep()
Date: Thu, 19 Feb 2026 15:29:42 +0100
Message-ID: <20260219142942.74087-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260219142942.74087-1-tomasz.unger.ref@yahoo.pl>

From: Tomasz Unger <tomasz.unger@yahoo.pl>

fsleep() is the preferred modern API for flexible sleeping as it
automatically selects the best sleep mechanism based on the duration.
Replace udelay() with fsleep() to improve power efficiency.

init_display() is a driver initialization callback which runs in
sleeping context, so fsleep() is safe to use here.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Changes in v2:
- Added sleeping context justification to commit message
- Replaced usleep_range() with fsleep() as suggested by Andy Shevchenko 

 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..3fb15df31592 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
 		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	fsleep(250);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
-- 
2.53.0

