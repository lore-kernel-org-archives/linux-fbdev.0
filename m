Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4B21D3E8
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Aug 2026 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895346; cv=pass; b=K9Zjw7jTR4yx3mOFjbNGT+TyuqTX66VZs63Yy+3SnDDfl6O1BuMRObFChgONFzcYnErhEmWlC4OQEnSFfS+n7JxvYPBf2DsxjwX/tiUiMm78SX+yxXoSd8vGXWNo0QqMk3mp4QYH+8u7sLXWcGypVep2dVjjqTltfG1l7taMHQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895346; c=relaxed/simple;
	bh=p1v1IVzRIDgNx/N8eH1pS5FUDeCgq5tkPUQHyB+es3w=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=cJLLycIVO+fOQN6kvTpTwNDYS58WuaowpG6nq41GHGPVYGVoQDAOmBWrFFv8QQSLYVFl2hKuNhoB5TTW8l5EyvHP/ZMPCfKAuuhhcJ+2Ev+tc2vgjS3Pf3MlrIOUqiQGx8qzUcr8xrgdA3L5zChGylHipG38okkZ4uf8kH0UpdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=DyN81XPm; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="DyN81XPm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d5335cf904so5964605ad.2
        for <linux-fbdev@vger.kernel.org>; Thu, 27 Aug 2026 22:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895344; cv=none;
        d=google.com; s=arc-20260327;
        b=XR7MCqS7QtrQTWb2CYJ0cRLNrt1q9xi0ZbdQPqc7nJo8dRhTbRaqnd8w3gdeh+H5+w
         Gc2bN515jga5dZohy7yRvFEU/zmVhd6qSV7hRdw3ul9+3Msgf3TaOw9wqsQjkiroqw0V
         DLLxefY7SN+Oph+zIrWS+9LLwg06z4Q7MCSs7HmMh99FpJaXBoj8u9QL5BSF2jwaVHjs
         injzuruD48HixvJXpWmhqnUismCHj5JYQIrGiGsMF2zjVkb3BpwarqsH6j/sxv4LnDCG
         ILXBOOvcGvMUd+lNRFZp/0rjMwejOg6CNEQflVdXzRTnL1zI8sOvyNSZewmTWrwcbbwV
         8zLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=LT4To0OsjX1/jK+rL4EorTsovtuZzKeOb1eHUmWtFGk=;
        fh=7rIS6FJctVNsFBN0SrbtBbG4zu1EboNgMga+Z0ENpkE=;
        b=gdlrsRat9K7Ol/Yb0PMYgOOcOzfSbiQVzU+HCOc8je7RzE0Iz0SxT4xr+/Qge1f4gq
         GRCZowFNE+g3O52uzh1xsu4ROX9xOA5DMBR2PQFrIDnEUVkNDWxeBZ5fjIm4uCFFSE5R
         ktatphUOJgnvAu3GqtYAqyghZuDvUMHw5POsLORd07PgqsBosDRV/8Iorq/GArtRlRQU
         WqocpLLfNc6WWtl2dm/3y0lUXW2KRFmoPfrUI8k41LBtcaKNckGQZA4Kd7nLMIi/KjmP
         vxjzELGuplWZ62YITAuIEWh5kjcgEk5UiINzIbAPByhsi+R8/rBPXsqZO0ZscmTkwsn+
         v+AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895344; x=1788500144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LT4To0OsjX1/jK+rL4EorTsovtuZzKeOb1eHUmWtFGk=;
        b=DyN81XPm5L1yPoMoypvFNvYw/+qE7t1U961tPx2an9bkhjo8M53rrXvnraqatq0mwD
         /KCqmaSfaDSAd75nFy8wZwMGv5dJV1G9A0fkSYHlNTjRq5FSoEfDgaFe6hm12KIy9Je2
         Ba8xYxhpfZ32ZGkkB7ncT3i2S4/7sFI20KXYYA1f68ZqQHZmwRx/7dPn5KCy98w1kSa+
         GcrDgbaYjUpxduxgs8UoEiPnriELi1TbQF6ZwDOxMWjJO5Ch4kF+XyGJdp6+VKKjqfjk
         hMFAmYwm2uTnbQb7tqnEPHgmfpxj5YAJx96il49nlTrO/4xYYykDMvhAVCP4kOv2jO9B
         ra/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895344; x=1788500144;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LT4To0OsjX1/jK+rL4EorTsovtuZzKeOb1eHUmWtFGk=;
        b=hleAeBuctyyT4rO6+LiGOBbFJadpdJ4/VB9Pzky9twFaln/oPhRXyAZcmUDjwV4GIL
         VOAq/vDPDjiHvFCMLYaVCkeC4MZOmvznB0Am4jXIyhTSYWtNaMJi2vSfz5VQV7EWpS8V
         V1Xj/RaOyY+oVN2zIpEpgn/vCM4RP1Iru37NGQAXChTVZrWgTFR4JGQvsMU8ZKXKD4iS
         O2ur68/XJNwelzpTiJ5w586TXa69/kPhWTdyzCFRm6B4qRwT8/meAdR1NsIyK6/lzT3m
         zb6dQKAzVRpm7bMVtiMzGXOBeRse0dnIiHGguu96+q0vz1hiq7EXmvGrAg1eDDETtyEU
         59SQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkHmQv5St7faikhWva0Z5E9p4HqbVAZn+k5DSbORIFyQwmtRMs+awhJ4S05QhHFjbu8wWYWW0NTml3Nw==@vger.kernel.org
X-Gm-Message-State: AFuF++nkFRjGJFSoyueFkcLA+6nk+YqhPWs/W9eupRfSyTUJpHSZLXn0
	QCB4dBFhz/vpHOO8YpgMhwfB/bllD7oJr/3RkxD4TfQGJDMmHRnEEA16HP/ygffH9s8YyVRSlZq
	wxT0VwDEIitSKtqAxzFzegWfJBPyKQlNP32vv/ft/
X-Gm-Gg: AR+sD1095T9CPZD+1CUraUAfcss2FSzhl/kgdROd7aZELyGL/ZxawpqlfEkFWPhEI4k
	RcwMqoKCaUlAqa43h9Ym5GjVzQWJwbAkFSYf3AYZHMLJQzW3MJjaky0u6BTSHzFVvG7koqdYh0P
	0pgdkt0x8iH0vBeQsTQzmFAL02VpSETDRgU8iHnJFxVyBQA/mkZyMJTY7OLRQkuepbawvwSERO2
	1Gw0Sn1eW1T2UTrsTHqMbMhYVAKqVKP4MJJ7Julyw22x/gXq56ZbuMAKd/s4vI0gxl3H6Ouu4FT
	HWEtn0RWGWIBNS6IHaqvpXMOXFc3nMIdy9I3JR+yeOVGA0TZLmbM8lzxZn6IV9M88VZQ6KujbIa
	rECd8UVHzPJcuqOf7HVraX01wX0FiAdDW
X-Received: by 2002:a17:903:22ca:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2d74dc111bcmr73203035ad.3.1787895343268; Thu, 27 Aug 2026
 22:35:43 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:35:42 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:35:41 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:35:41 -0700
X-Gm-Features: AcwNN1VyngbgcKs50N3MJkg3MeaR66VvRj9F8NMxHZOvLMicNByVpJwrJCJE87E
Message-ID: <CA+0ovCgxQ3_H-5BWXLR_o=AG8EJ_bofmx_E07VazDm44KiZKgA@mail.gmail.com>
Subject: [BUG] vga16fb_probe -- KASAN slab-out-of-bounds reading platform_data
To: Helge Deller <deller@gmx.de>
Cc: falemi@asu.edu, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/151-fbdev-vga16fb-vesafb-efifb-platdata-size-check/

  BUG: KASAN: slab-out-of-bounds in vga16fb_probe+0x828/0x9e0
  Read of size 1 at addr ffff888105ba2dcf by task repro/9494
  Call Trace:
   vga16fb_probe+0x828/0x9e0
   platform_probe+0xf9/0x190
   really_probe+0x267/0xaf0
   __driver_probe_device+0x1e2/0x350
   device_driver_attach+0xe0/0x1d0
   bind_store+0x1d0/0x220
   kernfs_fop_write_iter+0x3af/0x540
   vfs_write+0x61d/0xb90
   ksys_write+0x150/0x270

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
