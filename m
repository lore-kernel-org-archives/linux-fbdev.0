Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D33EB7F4
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006920; cv=pass; b=TEXh3XU2NW03k4S5FEdWyhuSWKCMSch6XTIOFzjYikghg5+Rfk/9MR2xXLTH2MtZ4SyuVWaTfihP27bjvZmmh3PRK80Tk5x34MBsxip0XH+QRYSZbr8rzEveUWc7arqjvu32ibuBd9HfufZDVTkmApYYYBu/mUXHzHYm81EyxYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006920; c=relaxed/simple;
	bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hALQlZF1CGvmUI6UPn32C56Y1Z3ynuYZvDuQsj84oOBIZru2BOlXZOrPvufbj5Y0tArwlrV/IOnUw7NiyVbHcJuqigFoFJ50L1SB9V5wOlfFVMltXIOIhjbJwbvDEQ6CjDfh8eAZ4dBqVsfyxwlXwPSZXlq+02qXaiby67lRV0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzDYYo1L; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzDYYo1L"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15f020a223so557319766b.1
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 15:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787006917; cv=none;
        d=google.com; s=arc-20260327;
        b=BjJLexyc7FbUrRdBXF2vSOzhvqF3scwll6zQERDTG8srVeAuGYZAQtjM9KlkJmojs0
         py50FZVVPTpsbtELClGWVIyMbFi6QJA86TVoPtsH/0ySLvaR0Viq29i2eSLYyFs3l6DU
         oco9BKUL6j74X/mZPUs8arVG9nLj9JQG2gwppLzYX0Nl06gXXG04Y8uqcvE28nPZmEOr
         5nvEGPPNTHfD00tHrrvy8ZnOdCcUTYQgm2pghG5rBcYY6bi5Q1AaEck9+aTkb9tm+csK
         s4kAx3mK66QRMbbEBiIGevcQn7vUqDf6Mjx6aN3wJF4T6La2QVoAZgekaL6dW03FwRKi
         NhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
        fh=wxf/elXPC8r7uuDiXTZtrohJRqLcoK7H/6HP+9qqbvo=;
        b=LD3yyak7JeF7AHiZUgUxJ1yhLFszu99BotaBMidlusyk3R8ICHw5MsB69ekVypI1sT
         +0dv6OdkFRtjZHO/LPwa7Mtxa5BbbU/UL1SaZwP5WRUMw7vGsfMnRWUT6CYshzPgy6Pz
         9YSwXtPqEM/UICw/reB+OOp29ODv0FDYrX3HkgxD4kM6QGsQCZtUa7vKgJ3VRPpWcDoh
         iT/ZI1R+vK44R21Q25T1EJnOnY6V3Cf16/Y2BHEx3Dyrj40RX1QtpKFuMftLD+2Yj8BY
         zRmTPkoxbJnYLSCmyn2wlBotoyK9zEiNxcfAsErvwd0UYTavaY2uS/UsUaP/IoPmlBNC
         xdIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787006917; x=1787611717; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
        b=dzDYYo1LEmDAAtEoyETmq9YTwfuqkzZRIA6redFFfixVdtFns9rruf9LIWI6A+aHGW
         +2CKSWycMizrbqMTu1dYPcg5X4XMqNbnfgABZERu83/dvrs2rJKy7CmsBdyUVyKrlLN9
         G35+TQtKM0a5Bl7LyF2HAHILHGqFAMsTXZIJqxT2WIdY7tB+KFWCUyvkuBt+yOWYzVWb
         gSR9TrpfJg5I6iHUJVCXgDijnBXC5pmZqOQlfZODACmTudd4ItIrQ7FFNBduGFQGNlbv
         NYY/svFewepxwJDPQsndBELegWRaTiPbd4Np2WBrFC2UEiZu054J9xBEFjBk3n5zP0pg
         Vo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787006917; x=1787611717;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
        b=AWUxeysjvOs6ljeY/aG6AeLM+fE7U3BfeuLfKy4qiJ9i+W9pG6VNIsGa493RbTFrPd
         w+h1SVkUgXJ+2WT/zF1CfUakeEHz93GhCFly6s3u3+k0g4Pshd1iN7jpAn4dLb2pQ4iG
         LCkgKSr3rnCSiWmapjlT3ppcuaoRrcS8aBiVv79XbOQJh+YBLN4zCbOcBiXhxzOs6UQC
         68tCDihaXaqgYqrmpH66jiyoaAedAth+Sn0YaqJQB5G2GPpUw+12FzLJH7Apb605L4pT
         USVfSZfntOEyDcrd6f8gxeO5EGvbWXv+ufey6rfNIWceYcwhK/U6+g1HuE867wxz6TH6
         bdzA==
X-Forwarded-Encrypted: i=1; AHgh+RpMtpmtO35SMuw38c65AyaDqSf030tq+mdTDyEoGMwBhXvT97E/10W41bgw64GohWpEKpIkOxEXAkyMZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrWjj9d6+pnRGurNXxvXobbcEAqGjW6eBrO3y1m08k9RlIMWN
	erRy6bkOgKw2Y5n+fouPnMpT+YrbFrEqVylE6uvQPemmg560C5gBfscM0IEvF5XaTUMYt5tdKnb
	BiWesvOiXz8fiDIk098S17xqR9ZVDD3g=
X-Gm-Gg: AR+sD124F9TBUQ4yL2IRsf91GeIR4EgO20zkYlsviM4zSIGiXHzQxwAHpk8hFD7a04e
	G0t6ucdp/8gCGf5OuY1yMhWDi+93RjrJ8TxoTZAJgeZNMzA3ubwhKFC3Xqe6KXREQEpqjzzU5wV
	+QQf9KiFAWd5nNaHU0FOT41nx9HxOh6e6jpc19VlSBOM1uljlcTL0KZgKQUszBfaBJkfQadycbU
	hUpn5n8LSoktFWgwCL61OecyfUdMP+nnIw70dwdHX6FeO7AJgY6X+ETV0PQx1Qzhja25I3SyJol
	QfJcedJLvQV2cUCfDA1qaZRTZDcC5Vw2r4rUbRwXnyUEMmKoh0vvbXEa
X-Received: by 2002:a17:906:ef0a:b0:c21:61a6:8825 with SMTP id
 a640c23a62f3a-c218880200dmr169252666b.22.1787006916867; Mon, 17 Aug 2026
 15:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat> <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat> <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org>
In-Reply-To: <20260814155325.GB516994@ravnborg.org>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 18 Aug 2026 00:48:21 +0200
X-Gm-Features: AcwNN1VaOzcnJmtGbApjtL8xLM_RPNeMVubTf0qJSVEHqCGDhHuSQ3SwYRF67bI
Message-ID: <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"

Hi Sam,

Thank you -- that's a useful pointer, and it settles the question of how
a splash should be drawn without fbcon: a DRM client at
drm_client_setup(), next to drm_log, not a drm_fb_helper hook.

Francesco's series is genuinely inspiring work, and it would be very
useful to me if it could take a CLUT224 image -- unfortunately it can't.
It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
paletted, which is what keeps it small: 17 KiB for 800x480 rather than
around a megabyte. So as it stands the format doesn't line up with what
we carry.

Reading it did make the distinction clearer to me, though. drm_splash
*draws* an image into a fresh buffer, which means a first modeset and the
blanking that comes with it. What our hardware leaves us with is a
framebuffer U-Boot has already drawn and a CRTC still scanning it out, so
for our case the natural thing is to *adopt* that state rather than
redraw it -- which is what hardware state readout does, with no redraw
and no flicker.

Where drm_splash is the right tool is the case with no state to adopt --
Falcon boot, where U-Boot proper never runs, or a handover where the
buffer doesn't survive. I'll follow Francesco's series for that.

Thanks again -- it helped me draw the line between the two.

Max
