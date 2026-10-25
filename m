Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792922003;
	b=iSmqKAQBv1LNYWHOvTuCGo3zxj4AVEiq8v97XgG28sXz8eySR65z6B5GILff4071R4Rl
	 GevqoD/XWV5AGwP4ubrKACfruxecxfo9zw01QSQzJautBwBMUTeXpUe5VAlgcOUiRQtyx
	 007OvHOoDIRgUtLju9ZXKUKlWh2VHYOnk0Am+iwxQ+4q3BzP1OLaf6VUvywTIb5FX46Nm
	 qbphSIY2wIKECtX92hueIf2SSBZNurKQYPv8wdQ0VauHSmYVIf2VIze1WjlgyzrQv5Ds3
	 7iNAzcJvue6vg5VQ5acj+lC/HyeBwhnl62/rIcSqI3Z6PWpz7Tw4Y0iYee3CjtvgTOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6PtEA2UtMTqcqVdkWoMV++OnOcpG82BOix7xLgA714w=;
	b=BbJE8sUs22llyKn3+1cO5ZM2Cd7RFonHPqpUx84pg5bfwUbasUI8omEkctwvgXMVyTrm
	 gRGQ6v/rgj/lKBvFMyFxMf4XgGlVNO/E7Q4miAo4rQGtUnTbjCF8p50yENkfCt8rvovbK
	 jR+pxOabpxVVEercmDJKI2CrLvkz0hL0qpzcaeQP15A+RM7ZTc2GZg4wUoQRryZnXTx4S
	 oqllwt6sx0b4HPaYJgAmRy1zmaxp2FSoZRPZQlXiG0DheshMO7HzVfZVgplVJNuYbsblA
	 b1wmKdQSesRH1acgAgouCXo0jqOhJIKGxcBprDX8y0ImPpuZymQxjb1XWZ/i7L8pWqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Vy60/HuI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA423606A31A
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 09:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA423606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vy60/HuI
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso2965378a12.2
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 02:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792922001; cv=none;
        d=google.com; s=arc-20260327;
        b=JdgnXdvZakK11VjMbfOg/Ii4Ds8iCj/J3y5qbqOX+1M5H42uB+LqpS+WigIZJhw2c4
         ok4Vo1OWCDRrQyM9f2/FNuXRFU7eslzCHEMBSGA/XHaV6pCTEimhCKCrsornl30Skonf
         hGXY99Hh1mSXIlsfOhOJFlCPcJh9sryQjUgXYp8r+du/3DF3OZexpZ8elGPHMveDihPR
         tQzh40ptcSbdZlsu8hXgh//I5zLFw4oQBuJGEnjStDtA/Ude6RbPgv7fUmgFUvdmJ1MO
         O+OV1vrjEjsILvEItCQeIje6OCF0Wgta6XleaU6P82JplDuQGRLl+oiVHaQgLpkQwjTc
         HnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6PtEA2UtMTqcqVdkWoMV++OnOcpG82BOix7xLgA714w=;
        fh=eNKu950M1VM68y02MPL4+kkpmIzvFBS+nTbeERKEvvw=;
        b=TFitQF+bGVEV++Jcxgxhc3DKlUX6PzCBYxHjXSAyhdUb1uPA5cAfWLVJrX3cDk+kjq
         TOWkKUsrV+HavcsF188YBj1nN0SBSpxvq9cIYfWDUkWmTQMxiV9Glea6P4kkTWYDLWc0
         5NAQFBGJOeEL13jhNzisa1piAZpu3GpImnU/y6G2m8+p2rqqfdcT3HV3//GthchK9Tg0
         6EaHPUFGilIr6Bt9wqZRqKFSvuEUBBaPq/3a3kU0TO2hQmHiqpmnREDM+f2W/OPnaO4X
         b2TgbnHfLF4+zv4dYZFocvUcQksY9i7qffzgtO2Bh96gLfoOO/4qwDF1JNSw2EXlrtIR
         3eiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792922001; x=1793526801; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PtEA2UtMTqcqVdkWoMV++OnOcpG82BOix7xLgA714w=;
        b=Vy60/HuIOOHGkECakw9qQeSwY7OX8plnS0WVLz8+4hCtE+H+FdizqKoXsRIodYiqWm
         waLxD8Lk9Mh5BV/UGp5eZxlIxFM3LX/MTou2H2VyYTI0XZZ/izLuLJNx/gTaeZF8tLxG
         hV+bSizw71J5ks7psvQO8YYUnOeQlzOv3y4zyA+3A/5tAGmgrJOtrCwb4RkxebFp0kHQ
         hUT5FLoewOEUExXqWkHbuELYNSbjZlSnSEFAzEWHdkehYOnaaChz4zpwQl2EK45dKedu
         FGfGHk34oPwNaZRh+Fy6pkHK7sYS5CvbcJxvQjRhYHjiehqkIYtiUhs+MgGirPzaYMKz
         Q78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792922001; x=1793526801;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6PtEA2UtMTqcqVdkWoMV++OnOcpG82BOix7xLgA714w=;
        b=ekVkiVR6qBd2yhQP1B+7nvJR2HE8q/lEuKYvVzn24y3yHzSbmeZCE/UgehKw8Nj/WQ
         hVg0hV2HLLwPriMlQZm+M6bd7rBJVPJMJLAOAWSQKp2VxFkpKICvRBlbd1f4UKQB2uqZ
         EI2rFpuc+9fCXl9T98L+6dMuPsVBNLwt61DJa177B+EXuNA/xH4zQ6EiWjRG7V170kO7
         m6InyHCwNN8EttcAq9VpZD2Py2G72gK4scO7z6jnqBkT9OExCQeg55dMP066+0gpKWU1
         NngD7perGFG0hA/Sthz1bjKQwilCZLLDc7Zc3vRMkRr1WYgXTHSpSh+7nyorIIpravBJ
         4n3w==
X-Forwarded-Encrypted: i=1; AKwUvByH1dAwvC3tR/bFV9XuhsPtQpybdhH0DnIyS+RaEFRVCcXxgslrFN4z+ZJ1v9Soro9xov98DApGUy9GvA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK/d3o5OQWMb8lEc42RkiY8hCpfixi6UR2YICJodLzk8s7gCtZ1
	svO2B97lnRWl5EHzWhwXYZvCWgj3Ta4OYloxbu/ZPLmau3m3I5OL48fV3W5uAyobh0okgGUra9w
	fkN60GoEd5pRFrMbRhD3jbSeuFb1Qyfw=
X-Gm-Gg: AYBFou0kKA7lQo/twjVa5CpK8j0qCqqdQF6GBm33uolHTLHmUxRrPGpodWRhUIzfuM7
	zfvWXk11N9uovB6kWOh3loEq0cuU0vNcJmtBaIRnvleQDJ1aiDV78Z2llpPg2LEYUHsOseYmwFo
	PlJmsqqDi3JfnjBZxXhIBVqdI0oKb1w9mi3fwb6bHzrK2MBDI0C/74v8lq0gAtzp7kyWcScajue
	v6QArpSzI6DbP/ngnaHgnkdzZWpFqmatCRhpjiNXFH0qQdOJvTEDewmCNJXD07vkdatAbjwGNKw
	eA+hs/yO5+nLEh4ctDG/S3IU11XbP1LpQONhvG73/brYJRHMW0MMRwncA/EwzoJL6u55NMP2ckr
	GkrTEyAFiLcmCp98btFj5uzU8ylTS9M01ssVI8WG1KudNFqvRJs2l/sqns43K2XiBzWo=
X-Received: by 2002:a17:907:9d1a:b0:c2e:2d8c:4585 with SMTP id
 a640c23a62f3a-c46bde8a1f2mr445903566b.36.1792922000889; Sun, 25 Oct 2026
 02:53:20 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
Date: Sun, 25 Oct 2026 10:53:07 +0100
X-Gm-Features: AclHuK_xZzMIUgzgDxUYS0S8n_we1GNSKAQQHoI-f2BeDz1YvWNvfoIENaxJN_0
Message-ID: <CAHxSwT_ya=kxLdQkx5iY6DdVbxDv9MP5shRUF5-yDUvM=cFpKw@mail.gmail.com>
Subject: [PATCH v2] staging: fbtft: fb_upd161704: Replace udelay() with usleep_range()
To: andy@kernel.org, gregkh@linuxfoundation.org, outreachy@lists.linux.dev, 
	julia.lawall@inria.fr
Cc: linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 778030aa9291e3a7d40ffb03b19e6877041cddc8 Mon Sep 17 00:00:00 2001
From: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
Date: Sat, 24 Oct 2026 12:02:25 +0100
Subject: [PATCH v2] staging: fbtft: fb_upd161704: Replace udelay() with
 usleep_range()

Signed-off-by: Abubakar Musa Samaila <abubakarmusasamaila@gmail.com>
---
v2:
- Send patch inline in the email body rather than as an attachment.
- No functional changes to the code diff itself.

v1:
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c
b/drivers/staging/fbtft/fb_upd161704.c
index 7288140e7..94ae5bbf0 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)

        /* oscillator start */
        write_reg(par, 0x003A, 0x0001); /*Oscillator 0: stop, 1: operation */
-       udelay(100);
+       usleep_range(100, 150);

        /* y-setting */
        write_reg(par, 0x0024, 0x007B); /* amplitude setting */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0025, 0x003B); /* amplitude setting */
        write_reg(par, 0x0026, 0x0034); /* amplitude setting */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0027, 0x0004); /* amplitude setting */
        write_reg(par, 0x0052, 0x0025); /* circuit setting 1 */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0053, 0x0033); /* circuit setting 2 */
        write_reg(par, 0x0061, 0x001C); /* adjustment V10 positive polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0062, 0x002C); /* adjustment V9 negative polarity */
        write_reg(par, 0x0063, 0x0022); /* adjustment V34 positive polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0064, 0x0027); /* adjustment V31 negative polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0065, 0x0014); /* adjustment V61 negative polarity */
-       udelay(10);
+       usleep_range(10, 20);
        write_reg(par, 0x0066, 0x0010); /* adjustment V61 negative polarity */

        /* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)

        /* Power supply setting */
        write_reg(par, 0x0019, 0x0000); /* DC/DC output setting */
-       udelay(200);
+       usleep_range(200, 250);
        write_reg(par, 0x001A, 0x1000); /* DC/DC frequency setting */
        write_reg(par, 0x001B, 0x0023); /* DC/DC rising setting */
        write_reg(par, 0x001C, 0x0C01); /* Regulator voltage setting */
-- 
2.34.1
