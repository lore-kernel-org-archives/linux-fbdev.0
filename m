Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496941;
	b=ojQVqcTT4hV6KZrhXL3+VLNNTbDp+sPuOYWBS8SNaK0R/7PqVh2QPb1/sWNp8TB/vEK3
	 ZButLDfspJPKoPqEY6umQYpg2eKo+d6khu/hetw29BBpFBv2eLvaTbsbgAf1cdBdea/j9
	 RjfYwoTxs+Jte+W9nEkfPh8qlvyeAwIPn44ioGlsxgldTrE/SWK/fgcYuuo2CRkFYu41J
	 KliFniTnzpvlYTMZ7k1DABd4/EGIOePRJ+nsXv8gJxoFY2u8OXCNYMDgyNMe/HPBoKfKM
	 1ZHKIJ11mM1JUwQFCLbn37NXL7EdMy3c/LI3O1sFm+qGvNwnxJ2sXxqvRIZ01NxL7XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E8QRxqca6MPKKmYjqBq9RkAfrZBWcYxQ/ymz9RyAO8Y=;
	b=MrO4dHzunYuBpOPufIZ5e3fYwGfHK1i8QaMbpFYUPBOTCWC+PFqjmlnplcm4DFBSyJs3
	 c8694tWQJRo95IhsOwVj7bg3SdhYm+w2LY+WE+oA4QPL8u4jg/l/s2TBgv1v7wc2c5I2W
	 xhpeUnWgrPYBNp4Vf/8tUPh/T5WuPadBu7UM9e8aD14wev7XiXaYArQ522cI3tMMSvAjJ
	 zegWYSculF8/GsZhTmNOf9I6bMEGic++qukWZLPqJPjCFbXMbtTRocgNihIJb8Ru3EOLq
	 cwArHaYrKWhSs1S+Od2OR4lOSUL/9VQwfJZb9/r8JsiDJ9GgD/NnBm3RAp0splMWOZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFNCS1RQ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC060A3827
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 15:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62BC060A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFNCS1RQ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso30772695e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794496940; x=1795101740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E8QRxqca6MPKKmYjqBq9RkAfrZBWcYxQ/ymz9RyAO8Y=;
        b=CFNCS1RQhtbSxMwdv4RT7HaDOzw5D755nrRVwkL4k/OwRxOF9nDaPmGgbE6aBTSXWH
         msk1dQ3pVIxMk4yUT4CG9M7TNrpwaoIvNpJ3/pm/e0iSCd4XEBJKI8p9xJEwtSIfutCC
         stsi/5l34qljqB3RcnE4mIfJDNGptsv048CrwnBwOr0aEQYAk0b59wCbdRvQ6o8OL+fb
         cvAtr7bg4Ikai7/soQQ6V0PODVJ4pPFSeLLwUnbQMGtni8xKfY3UKMvp3w+fEstsPVjc
         i5FAdugW53dj2trdg9Fn6RkfhC18gt5RpmdSGsBIKL2h48wr0gH7pQH+a3qJOwITfh9h
         SU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496940; x=1795101740;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8QRxqca6MPKKmYjqBq9RkAfrZBWcYxQ/ymz9RyAO8Y=;
        b=0PE6Qq5NpRQtoyjtP71rCobJ+PBFqxtCgIKHW/nn7L/2Kyn2MMjDBglWRu/kKO15Vh
         RdAqLvHhasMNjnMgum5NzZ8d1MAKvEqU56m4hbCT9yBlDGE6tSYlY1u+6WD820lldjMj
         BU0UL7J+5+o6px2m+oUkaOmF5+I1IHcWHWD1PmgQXkPCluC65ggGjVI99zyTfBh4ZunR
         UVtMsRyxFcLfsC6JdNtMgFYHC9yifnHShqoBy37c1RotprMWPpgkVEOly0Frxu4G0H5b
         sjABMxyiOfku96AhOL779gqVRii715IldkQWSFxYc95GOdLgZrbjAb4Tqt/rLHstaXms
         N2WA==
X-Forwarded-Encrypted: i=1; AL+hErG9Bn6YdZ9E5+yjvPOgLNxWkWtMYzYBTa+/rm1NfaB5cOGwC7RaGO3IK327BQ/5sFnPNPnA2u+Uc1T6rw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vOtf57lYW4HtN9cMjWsNw9m+aG67ofjSH/FiY3P67sOVQiKN/
	ar6Dete2wE2qYRygy8g8k9mIjSDrL8Xc8bm1nZ/lJadNow1rNDGkyYtb
X-Gm-Gg: AYBFou2DKMX4NhSbiAy3FosmK29YKYQZxVXdXy5BjgW9FZynBstVh6pM4DVaGSj2s8O
	Dy9RhKm9AglDtgFtA57Zq/07TVZfTf8hetXp+N5JJ8xRUEMINoYLGw6CfxkBndMndhA7VtivWES
	iq2XqviKm4F0eLdeuTbTSSYhdjfSTc2OkwoI+2uG54/8SqxwNcln7xyEbEsjU5wuHBhQw0wtK8c
	4gefnujC3Zff4pRebnh9Wxv4BBG+TDEZXO7pv2Eeb05+sj4tJg/5Lzia7snkUlQjD8Pe7qgKbDY
	P5FlHnEh06v52TYRvPa20e5XaObT8LPJ+q5ODiRm5UjYGO4f6ScwjO106gUlDeZRe5cH8vHwbv+
	ZbBVjZqs/JzsqAnPljeENQ2YMaTEJ4rrXQFb01yrEPRykkatdkceq2gkcIlhrApjOGtnvXL9ajq
	YpvsaPqQn27xeZbCpxw+0Xpm6q9CmkFdKl9QhLJmka/OvIk1YqueFlsxC51EJ669k8/WJHjWkAh
	e2sva996SKZ2ScLIPuMAAaj/QvZDOEf6MQnrYsq4v4Jof7VBuAl2BG5XitV2X60iXm2yUSy/w+Z
	bsuzDEwzeMZV1kvHjerPEfAsC9EBslj2abSJuCLC37Vru2z9I5ZZKzE=
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr132094285e9.28.1794496939343;
        Thu, 12 Nov 2026 07:22:19 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm84746205e9.2.2026.11.12.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:22:18 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Francesco Valla <francesco@valla.it>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Helge Deller <deller@gmx.de>,
	Peter Jones <pjones@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Add splash DRM client
Date: Thu, 12 Nov 2026 16:22:09 +0100
Message-Id: <20261112152209.3297409-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <066197a1-aa2b-455b-84d8-4e2215fad764@suse.de>
References: <20261027135342.2003632-1-maximpedraza@gmail.com> <066197a1-aa2b-455b-84d8-4e2215fad764@suse.de>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas, Javier, Francesco,

Thanks a lot for the reviews. I'm answering everything here in one go.

On 11/11/26 14:52, Thomas Zimmermann wrote:
> So shall we merge patches 1 to 6 and 8 first? You'd have something in
> upstream already and not chase a moving target. From there, we can merge
> the other features in the coming weeks.

Yes, that sounds great. v7 is ready and holds just those: patches 1 to 4,
6 and 8 of v6, with the MAINTAINERS entry squashed into the patch that
adds drm_splash.c, so six patches in all. The DT binding, the placement
and rotation, and the connector orientation will follow as a separate
series once this one is in.

What changes in v7 from your comments:

- the Assisted-by tags are gone from every patch (Javier)
- MAINTAINERS: I'm listed as M: and Francesco as R: (thanks, Francesco),
  in the same patch as drm_splash.c
- the firmware source is now DRM_SPLASH_SRC_FW, and the Kconfig options
  DRM_CLIENT_SPLASH_SRC_FW and DRM_CLIENT_SPLASH_FW_NAME; the BMP decoder
  keeps its name, since the BGRT goes through it too
- the drm_splash_fw_load() stub returns 0

On the CONFIG_X86 around the BGRT check in patch 4: it comes from efifb,
where efifb_bgrt_sanity_check() is x86 only too, and its comment says
that all x86 firmwares centre the image horizontally. I haven't found
that promised for other architectures, and there the check could reject
a logo that is fine, so I'd rather keep it as efifb does. If you prefer
it on every architecture, or gone, I'll change it.

The issue Sashiko found on v6 (a restore deferred while the device was
suspended) is fixed in v7, together with a few more that a later Sashiko
run found; the changelog of patch 4 lists them.

About your Reviewed-by on patch 4: since v6 the work has changed quite a
bit. Restore now leaves the commit to the work, a hotplug while userspace
holds the display waits for the next restore as fbdev does, and
unregister waits for the work before it looks for a pending firmware
request. Shall I keep your tag, or drop it so you can look at the new
version first? Whichever you prefer.

I'll send v7 shortly.

Best regards,
Màxim
