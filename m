Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D2877E2;
	Wed,  9 Jul 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054848; cv=none; b=gxBoMaRs9C14hVFbAOibVdXFFrxhD6X5KfL8atxRKSDbutLmz5pRDVpPbF0B022G6ZyLldHxATrCT7KNK9hC4d6yMevgKJo+SE+88ZbAJAxrhKr9waKedtsJvVABXnxZdpPGqdELiHWcv2RDeeC+T5RbM6M3ilbqIPPeNk6WzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054848; c=relaxed/simple;
	bh=VUc7ASKV7a/DitzLj+EgNpv5KmlgCFGx5YqSPWgeSfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzCEiJZV0o6u3Fpxtv7yl4WHLmztG0pFZ84a0hgNLFyXDyUeG7MpbvpdBV1GExD1sntnKL26A+Ogvv/7aGWCWcCBT5klXcHhVmR8uh/9j0iRuEgb3XisOgRX1xxMNHvUfk8VofS8jnQWTw1DrpzQP3xmUCNEFBi6fcOY5KWOJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVuRh+OE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVuRh+OE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8595573a12.3;
        Wed, 09 Jul 2025 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054845; x=1752659645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0kHpP5i2ngSA3Sw3J1NI+quQCnNlgoAbETX3ByAGJI=;
        b=iVuRh+OE+PwXdlKlycdxFC/EIGnEvb75idFbfKUCiuoATdSNBT3hTyqW33ChcsOFas
         JOJ+RwfluA5Jxr2KedVWMBXr2+Rc2BaKITVLgj2XkAHU/tXofYL5YWVfluF4/3AfZ+ob
         wBOSnJBr5p4BVpHEJ48NPXNjESPlSJqUm5PWz8CYXFlPpm6auBP+tsLqSN5xysPEe5Ul
         0ydWnY5GTNNBCU8/gJ/T9zkW4YGLP81WCEgZosO7F1qLjufqu9E5ENvoqq993IRQC7Py
         WLGaMA4Sgm+/YLr7sg7vO5TcN0kkN8fcY7GjhadEe76kDIKV4wBIPr02utQ+ou9gz825
         204Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054845; x=1752659645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0kHpP5i2ngSA3Sw3J1NI+quQCnNlgoAbETX3ByAGJI=;
        b=iiO+4isfKByjVeSScBdhBncHZdZ0EmKQwGX07AcSjB/IWcg1RLcY7jzIaQh8cecuyp
         XdjKsI1qNpDmaHSIvspExQEySfu0Rojv5+O1D4MOeWi6RFJoyCarD0UDAcm0NXPcXT+3
         hyxIYqdyZot0MUBaUgtABnjMb7xsinsirR1unLKj11B3q79Nw6JdGSoSi19EuNai6uJT
         ZlM7LhCg6iCWzhUwPal6WOrE13LNnyQbujn70Vxx35OeZDyZK0tU36zqbGibmf0xja+X
         VGGsn/WBzvZXYEeL4pN410bXoVeUmBC4KZXbSgYZFVlUR2KmNlPApPNBeXXr+QP6MV3T
         RlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfRDxAciBpzqPy0v7OD/TiwtQBKL5seZRsuXcVeuMPwyYMEnha8cJeKyjuyQP/z0VXZMCBTvm0qPbpc3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHK0eRGG2bYQKrHd/RAoI4rpOrsbu39eyiUfcWwvkW6elosrar
	1CsQ11C65Q92EBIZ3j72QAa0Bk79aKOH0WY30+A9dQSNNQi9hlgjtYyW
X-Gm-Gg: ASbGncvS8/b2irlicDOCA7qGH8HZSq0fSJWB/VnXE2G2BhNY+E9ty6ufNYkQFkWp7k+
	6AQxXxeKSwu9SLxTI11+UZ3aQVJwsWIeTjwwMHby7qQPXwygrQRXqNeduoGIlGlatyEWZXjRpXH
	7ww0j7BZ98IbwFWyYsODmufkIcdou+AjFOQNYCqw0AfnWIimOrhNwewvg3zQPAzX/b2S0+8NTHj
	vOLBPV3qc9jwXv6z7iGXCYXVc0HtJAZvo2iGElWnwp0xdAL1sBqXFYyIPmmf5zK0rvZhMnszin1
	g4ZCJaP0+IRE7Uun2xLZWcaX+BYzbQ/kdmbCdgu6iq/ZCkIMgBzB59i6cceP9puE0Ay/sGp1IGV
	H8jX/OjhT0K8KP87P91e7xh8uw6cPXUCL62KDMFEWiO1c6F8URwFanLxKjX7rtnlD7REzW8yCmG
	jmToVKpBVY8ebH
X-Google-Smtp-Source: AGHT+IGjd7FZzn2E4+1+r3KAfN0fmCjMp6g2KB2CfdNSgBMVIEYmZJPa8CZAYUipGL+5OBEmOiH7Mg==
X-Received: by 2002:a17:907:84a:b0:ae3:24c:6a21 with SMTP id a640c23a62f3a-ae6cf6035b4mr181071566b.26.1752054844679;
        Wed, 09 Jul 2025 02:54:04 -0700 (PDT)
Received: from kubuntu-e14.homenet.telecomitalia.it (host-87-21-242-88.retail.telecomitalia.it. [87.21.242.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949cb2sm1074172266b.67.2025.07.09.02.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:54:04 -0700 (PDT)
From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
To: tzimmermann@suse.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Subject: [PATCH v3 0/3] fbdev: kyro: Convert to managed device resources
Date: Wed,  9 Jul 2025 11:53:51 +0200
Message-ID: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to address the TODO item "Request memory regions in all
fbdev drivers" from Documentation/gpu/todo.rst.
Additionally, it also converts the kyro framebuffer driver to use managed device
functions.

In summary, it converts the driver to use:
1. Managed PCI device enable and region request functions
2. Managed ioremap for MMIO registers  
3. Managed ioremap_wc for screen memory

This simplifies error handling and removes the need for manual cleanup
in the remove function.

Changes in v3:
- Split into a patch series as suggested by Thomas Zimmermann [1]
- Convert ioremap calls to devm_ variants

Changes in v2:
- Use pcim_enable_device() instead of pci_enable_device()
- Use pcim_request_all_regions() instead of pci_request_regions()
- Removed manual cleanup code as it's now automatic

[1] https://lore.kernel.org/lkml/fd6403d7-93f4-4fa4-ad0d-3ab91cba8183@suse.de/

Giovanni Di Santi (3):
  fbdev: kyro: Add missing PCI memory region request
  fbdev: kyro: Use devm_ioremap() for mmio registers
  fbdev: kyro: Use devm_ioremap_wc() for screen mem

 drivers/video/fbdev/kyro/fbdev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.43.0

