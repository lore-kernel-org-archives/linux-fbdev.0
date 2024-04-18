Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A252E403
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Apr 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429719; cv=none; b=B/TJ8G+wJCh+D7q+xgKr9xyPSK4FCgGXpxptw61K4Pzy13ofuUGj5Y2X659D07vT55d4fvluoax7bK+WUiJ5lHhfeCLrcbk/dRf09+ynlh60vK352dioJceGdecF8Ew4xskiyKsbr7uARf3Ihkev2ZTEBfFWTwaxmbqkat4zgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429719; c=relaxed/simple;
	bh=lcAKWCMj+reGzv/SxgQTObCQDHvEXKI5uKBcKnB6ORw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ2hNqjyt9PVBmgTe3oJe6mwESnnmyyk9R53VRG04lXyVRdLtdcA4Hev4L/g+LTXmg0OBHGdDvaG8pYiW41RY2Y0BBGcsce1L8MFf92iYEAkoFzV4Jx0stB9cpfcfyh6tyWZiWxNQQiRyCvw7/jwES+Dt61r+Tcelq0z09W+gpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtrbtFfU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtrbtFfU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-418dc00a31dso4947575e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Apr 2024 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713429715; x=1714034515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcAKWCMj+reGzv/SxgQTObCQDHvEXKI5uKBcKnB6ORw=;
        b=gtrbtFfUUdhicm878kFdTF6Isf4skHahi/1MuSlK4Z7HcYM8AA2y2KsviQ/of+c9X4
         eY9SOJoIudA01qadgFIacWC4EpAIgPhq50/VimmTJYZW0r4zh8AQHM78HL+7MsZ6FmzJ
         pM4RRXPJrm6/s3lB1dkuUk99ghDYFvBq1TyfmdOEviYl4jQ3iPrQ75UJ+gebDdu8JUbD
         Gtop9FCaNMyMWUtcIj2T4itJWKQB/h28sjDw7SLBn8cXZNJkaVAbMz19006A528aWIRf
         R1BWJ3Pq5M+FcuOyuy2gKU8hWXCL55tXzrMLrTXjRZ1bvzAhtpkdSk5z1WEriQKp6MVp
         6gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429715; x=1714034515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcAKWCMj+reGzv/SxgQTObCQDHvEXKI5uKBcKnB6ORw=;
        b=tCQATeW1w6vywvwPsHGT2LuhkoL0fm6IDVrJ9RT+orj7E4vVGzjlwo8GdSDr7XFJvQ
         cpdNgOZHBpwi7ReBkY+yk4i7iGO1GBueBA1MWadPLbgFB765C46/O+tzTFmuCQeK6KXc
         26bTgTmt+vnCay0liXfhu1zzsFnWrs78RVhNabT65YbzIHa2h2RSDPP2i7aiD1LEUwFo
         /hG1ta6aFlWWIHRPppSp17U7DdgrslM3LTNe30M7RXAPfbr/VsmftO28ZFaZx9bGRaHg
         553oHJndN0mdCF1lHZn90GXJ6iXZShYiJEdcWtrnJ7OL+yunXFh8sJG8deNUq/aOGEF/
         hWhw==
X-Forwarded-Encrypted: i=1; AJvYcCWXqMQjLClNo0gp1g6LCS/SypmqhrmxhLEzTsblMB/TIR3uPxgvwDhXTi9zwZlLMigrINwOGl28PjxE4RkGe/UyYtBWeF7dFV8H3H0=
X-Gm-Message-State: AOJu0Yz97k9sHawM0ypmw9Knh9F20R1p3+qFUlGAbxDuFslZvoJhIdSg
	GfpTZOuQUWBg8MBlmukAhn8SCkU1TyXippxfnmQuvsU/7y/o14R5N6yiJgryIn4=
X-Google-Smtp-Source: AGHT+IGtSojqwzGCY7o8kpFDZjkynQ3UI+S+NsFqETzKmtJMJWjWSr5MyuisF3yopc1Ssg3dQzg7tg==
X-Received: by 2002:a05:600c:3555:b0:418:f400:4af1 with SMTP id i21-20020a05600c355500b00418f4004af1mr12010wmq.38.1713429715231;
        Thu, 18 Apr 2024 01:41:55 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00417ee784fcasm1894342wmq.45.2024.04.18.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:41:54 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:41:57 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] backlight: mp3309c: fix leds flickering in pwm
 mode
Message-ID: <20240418084157.GA162404@aspen.lan>
References: <20240417153105.1794134-1-f.suligoi@asem.it>
 <20240417153105.1794134-2-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417153105.1794134-2-f.suligoi@asem.it>

On Wed, Apr 17, 2024 at 05:31:05PM +0200, Flavio Suligoi wrote:
> The mp3309 has two configuration registers, named according to their
> address (0x00 and 0x01).
> In the second register (0x01), the bit DIMS (Dimming Mode Select) must
> be always 0 (zero), in both analog (via i2c commands) and pwm dimming
> mode.
>
> In the initial driver version, the DIMS bit was set in pwm mode and
> reset in analog mode.
> But if the DIMS bit is set in pwm dimming mode and other devices are
> connected on the same i2c bus, every i2c commands on the bus generates a
> flickering on the LEDs powered by the mp3309c.
>
> This change concerns the chip initialization and does not impact any
> existing device-tree configuration.
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
