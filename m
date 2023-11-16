Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwDoSdu6"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB68193
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:59:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso6101485e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700135977; x=1700740777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgu/OmIil+m+pgaiPX4vyBYRM7q2Oj3pmqGujW+IM1U=;
        b=EwDoSdu6WCK1MIdDIz1jTLvpPb3wwBdwPNTaR1K2t17RbxnH1Q5rnOjIBFGubGWcYb
         KHXb88YoNhvs9HnJIntN0/lWa8mpO+YpvIrrbYp0Nv/9LBPxSJ/ZdgkOb+P4SmjcpBpO
         Wb+l2JDXw2P7p7xvs6IDoW03YQSHVYzUzaObC2dgIaJ+PpzKPThE2VZ0jVfinFTBx0TY
         f2nm4hPBOqjJTPRaFa+DqFGb/Wbe8jVrGu15FP403cP98W6mH7iBlHvomPTXBJ8mBt1h
         ff0bwuJZm4SSvJ2y+3Gzo05PxqN/LuaEZn1aP6hHMqZOGKh5/JxsR+V1aBlioYpsleJx
         mBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135977; x=1700740777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgu/OmIil+m+pgaiPX4vyBYRM7q2Oj3pmqGujW+IM1U=;
        b=q2N18hEgm3TWTUeru2tkJ12p5sb4v1ZNrLqz4yKmcKLIAAEiq/qXyxtDDZkkuyF/Cu
         vN4bhoNhSext7MXSKm4+UmbKyF7a6qjpCN3QO9wBZge1EMSmKRmE/hnRXk6aKgtAN/CL
         GuifX6EyXIQwp30cTkz9ZXRzmlmd/XnNhb06Xp81Wi5zATqr+J+ShtfD1bmOlZ8gwUvu
         uTXfFYAb/hnQxQyy/psptvVYNRDeGEv+WJ9xuZEX7wcRosQqX0EreMbTRsr6t3XdpcWe
         KFReuFw+OrOUtFdZW+hgin+cuG5buDaE1h0Tun1X03PajPqmLLorK3tzXIQ1MoQvtSix
         r8NQ==
X-Gm-Message-State: AOJu0YwL95NOhEWb82qu6nujzeHfWRLNAMxpH92JsouOKJnkCQVGjr/X
	bPprikzyMPyNLgK64rGVUXMzPg==
X-Google-Smtp-Source: AGHT+IGgShwNUHy7UmmpWIBZdQEdCnXfXFJTSulfEi9aWAIItDdqiFC8s1dZy5fLM0CanEYV7W7KHQ==
X-Received: by 2002:a05:600c:310f:b0:408:3ac4:dc3f with SMTP id g15-20020a05600c310f00b004083ac4dc3fmr13808290wmo.29.1700135977363;
        Thu, 16 Nov 2023 03:59:37 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b00401b242e2e6sm3259951wmq.47.2023.11.16.03.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:59:36 -0800 (PST)
Date: Thu, 16 Nov 2023 11:59:35 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: backlight: mp3309c: remove two
 required properties
Message-ID: <20231116115935.GA56909@aspen.lan>
References: <20231116105319.957600-1-f.suligoi@asem.it>
 <20231116105319.957600-2-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116105319.957600-2-f.suligoi@asem.it>

On Thu, Nov 16, 2023 at 11:53:18AM +0100, Flavio Suligoi wrote:
> The two properties:
>
> - max-brightness
> - default brightness
>
> are not really required, so they can be removed from the "required"
> section.
> The "max-brightness" is no longer used in the current version
> of the driver (it was used only in the first version).
> The "default-brightness", if omitted in the DT, is managed by the
> device driver, using a default value. This value depends on the dimming
> mode used:
>
> - for the "analog mode", via I2C commands, this value is fixed by
>   hardware (=31)
> - while in case of pwm mode the default used is the last value of the
>   brightness-levels array.
>
> Also the brightness-levels array is not required:
>
> - in "analog mode", via I2C commands, the brightness-level array is
>   fixed by hardware (0..31).;
> - in pwm dimming mode, the driver uses a default array of 0..255 and
>   the "default-brightness" is the last one, which is "255"
>
> NOTE: there are no compatibility problems with the previous version,
>       since the device driver has not yet been included in any kernel.
>       Only this dt-binding yaml file is already included in the current
>       v6.7.0-rc1 kernel version.
>       No developer may have used it.
>
> Other changes:
>
> - improve the backlight working mode description, in the "description"
>   section
> - update the example, removing the "max-brightness" and introducing the
>   "brightess-levels" property
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
