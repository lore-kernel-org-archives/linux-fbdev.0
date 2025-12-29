Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA638330B36
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045979; cv=none; b=eJ27odJjxtL89XBni2CGi3y3PxZtoaRp7OpiTc9jrTQaIuRcakZEwupQXTCX0JRfOBaddXHjMgqUBIdBrt2y9xXEoxPOrXWEBN946630kIPH+UdXGJG1kyHhwZf9aM2e1MD5PZpYJvWRiv6Xb9qdUo69j07Zy1mzzp8t2J0kkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045979; c=relaxed/simple;
	bh=y5YIqKVzOgea1hEskvVJXNFijZ0oP6nkRby64GmSm8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nH5gnsrRlc+I/P00jbUXFwMwOvY6MzUEZt1NN7bUNncd+C+bONc2fo5V2ZtiTujm9PW1dQO8LfkMaQFX1FYn42HD1E3rghJMnxqk/bgb5X0xLRGk5xFfxgFsLFj2fLySuKturpIQrd0HUS9JcIOjmx7SMBqMtHB9D9XtWPo1dM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nbeh+IaU; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nbeh+IaU"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so83983855ad.3
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 14:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045977; x=1767650777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=b3zog9NP+llqKZr9y3TcrD93TMhAUaIf6nYWxD6IQwi2JTG4CJtjYi/e81WH018/L/
         6TGnao3YDNblHSrtlTiYijcxAjofSnp4IsOpNGOFnmhCjuHRd8HZiAJiGntW9dpJo/jG
         D/vF89FoTEE38az/M03PlDFpxxZPkZ/wrr8QeHmU8Lkuj2p4FGJhcX122Ekg0PnF9cXe
         9A1vRZhJHz7+t2YFSinhTWt+ebBrngqKOMIVVTMq6zEaifUt4DueJvV3o6lSyK2m/+HF
         gc9jF68/bmztoEmdx9zak88MvKjqjBZokjkUrSeZr3wlBIabYTUds8+FfgQ/JD9WLvjQ
         nOIA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEjSUse8C74PfZI6n3hQPtaoDRLmdPPyJnKCnnMZJ23kl7FXLhOtVcuLX+NloavTcVHlpzvhMfetOQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5WyiNxkvr2gmjrfwPIvqVU8FKr1D+H4WbrtDVp+Nag6+ME39
	eS/LvaUSK9LZECnqYZeuDnrj3UT1ldAPhNcjFlFRqPGjWxaeWRkWelDEanoa/lwO9jtfbS0Isj1
	oPs5RWRKohPTfaAUxgFBX6j5/LIacF9qfc+lmST+2qSFuhADrxCEufB6kvTdUwpnZ60finTV9sw
	YdPGlaWPyBQ+ckyAGWIuAJiIlRurB5c1n/jXZtvs2OwEBhkqQ6oBOc+Cxxvl7EBJN0uUNsTdptu
	YLDVA8cuNB/gVU=
X-Gm-Gg: AY/fxX7LRUSZAgZw6qc+wwywwLij793V0iIO4+ipEAYtI1McdO3pGh9BYEdWTeVLJ1V
	06VkAcg+SPPQdlmAqZ314cEAgcGlDYhWsRPuHj3AzyzbPgD/xy7qJYvSfTJuJ3KiBSN/zmTTbQu
	dJdEEvgsVFNJAIiVa0HhoScq4x/GigbSxIf1ariWfVdYr9R+ry223Bv/wBHvhkc1GRaq/n78+X2
	xBIu2yltlcuVGQq1UdxquIK8nYGv409wk8hi0MYuzius54TKGEvMou4/b9UQc/oBlXeqCBJ/9sk
	vnQ83xG2FnYP5WHS8LwRxcPllC0iwjqlie1tuhN3ZtnQ4uNSfgP5wCr0tN67MBrvdyfJttXxkFV
	3qqIJQAnNjEQgDtdFAxTgG7En7Bwm73Vsv/XQ/KYrQCIk6pkpMPh7DnBrdMODbM9yC99G476yst
	/irSbvgFFb2xKIV2cDe9jBUZkRKqlGU5QNVDw93t12s3Os
X-Google-Smtp-Source: AGHT+IGkC/T5Ug40pBLB/PTYvd+HNF4u0/XJSbMf94cUjooX0FvhiVTm6OiXKpkHN10D6t12Rwnt5C5Y/pvh
X-Received: by 2002:a17:902:cf08:b0:2a2:ecb6:55ac with SMTP id d9443c01a7336-2a2f220cbf6mr365345675ad.7.1767045977171;
        Mon, 29 Dec 2025 14:06:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e7b784fedsm2277111a12.8.2025.12.29.14.06.16
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 14:06:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edaf9e48ecso264538841cf.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 14:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045976; x=1767650776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=Nbeh+IaU1WNR2p7QWDZlZWk5JailD90naOfx2AjXV8E7Z6PnlRMVr99k1OErloAJFs
         g/GFgxI8s+KNpRJTFCl7t9MRp0jd5W4KAPcdSrzXy8NRi3redB8AOqkBFKbFUWhxl7f8
         zyr7T4WNGkcM6MINCUY9IG9majzeGfgP5gh/4=
X-Forwarded-Encrypted: i=1; AJvYcCW41sNSDl+PM5/EQ37MEBLooz+eCts+ZDfU7scZ7Yx1wi96is5kNeynwbkqpF0OY+8mAE05C1A9t2TCmQ==@vger.kernel.org
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478636046d6.63.1767045551435;
        Mon, 29 Dec 2025 13:59:11 -0800 (PST)
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478635666d6.63.1767045550918;
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ce Sun <cesun102@amd.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Helge Deller <deller@gmx.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maxime Ripard <mripard@kernel.org>,
	nouveau@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	spice-devel@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 00/12] Recover sysfb after DRM probe failure
Date: Mon, 29 Dec 2025 16:58:06 -0500
Message-ID: <20251229215906.3688205-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Almost a rite of passage for every DRM developer and most Linux users
is upgrading your DRM driver/updating boot flags/changing some config
and having DRM driver fail at probe resulting in a blank screen.

Currently there's no way to recover from DRM driver probe failure. PCI
DRM driver explicitly throw out the existing sysfb to get exclusive
access to PCI resources so if the probe fails the system is left without
a functioning display driver.

Add code to sysfb to recever system framebuffer when DRM driver's probe
fails. This means that a DRM driver that fails to load reloads the system
framebuffer driver.

This works best with simpledrm. Without it Xorg won't recover because
it still tries to load the vendor specific driver which ends up usually
not working at all. With simpledrm the system recovers really nicely
ending up with a working console and not a blank screen.

There's a caveat in that some hardware might require some special magic
register write to recover EFI display. I'd appreciate it a lot if
maintainers could introduce a temporary failure in their drivers
probe to validate that the sysfb recovers and they get a working console.
The easiest way to double check it is by adding:
 /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
 dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
 ret = -EINVAL;
 goto out_error;
or such right after the devm_aperture_remove_conflicting_pci_devices .

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ce Sun <cesun102@amd.com>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Helge Deller <deller@gmx.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: nouveau@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: spice-devel@lists.freedesktop.org
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Timur Kristóf" <timur.kristof@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: virtualization@lists.linux.dev
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

Zack Rusin (12):
  video/aperture: Add sysfb restore on DRM probe failure
  drm/vmwgfx: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/xe: Use devm aperture helpers for sysfb restore on probe failure
  drm/amdgpu: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/virtio: Add sysfb restore on probe failure
  drm/nouveau: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/qxl: Use devm aperture helpers for sysfb restore on probe failure
  drm/vboxvideo: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/hyperv: Add sysfb restore on probe failure
  drm/ast: Use devm aperture helpers for sysfb restore on probe failure
  drm/radeon: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/i915: Use devm aperture helpers for sysfb restore on probe failure

 drivers/firmware/efi/sysfb_efi.c           |   2 +-
 drivers/firmware/sysfb.c                   | 191 +++++++++++++--------
 drivers/firmware/sysfb_simplefb.c          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   7 +
 drivers/gpu/drm/ast/ast_drv.c              |  13 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c    |  23 +++
 drivers/gpu/drm/i915/i915_driver.c         |  13 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c      |  16 +-
 drivers/gpu/drm/qxl/qxl_drv.c              |  14 +-
 drivers/gpu/drm/radeon/radeon_drv.c        |  15 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c       |  13 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c       |  29 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  13 +-
 drivers/gpu/drm/xe/xe_device.c             |   7 +-
 drivers/gpu/drm/xe/xe_pci.c                |   7 +
 drivers/video/aperture.c                   |  54 ++++++
 include/linux/aperture.h                   |  14 ++
 include/linux/sysfb.h                      |   6 +
 19 files changed, 368 insertions(+), 88 deletions(-)

-- 
2.48.1

