Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562C14A8B
	for <linux-fbdev@vger.kernel.org>; Wed, 29 May 2024 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940909; cv=none; b=fED7qWLYOmU8K8a4AD8Moid8oQ97IS1JnjFpnVw0W+tSIXmCu6roy8OAUCe0bHBWvBNvEmZ1t2RZAdmyZ9CtkJzlBsOFWNOM5inZX9zRm56XRFodekg+YDEFNCtEWKr8etFaDxqw0ZgV7HZrMWWrSMXZJUPzbCFhZtOrIqIxqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940909; c=relaxed/simple;
	bh=RBwkYvZvQ7HcRtcbWXlW1lKInMy240xUm9Azw4zpgn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuUeduW2u4l57g+X/klg46zuI4SBF+lZpDGjwnEDOkzyB1oTLnzbG/XPylegCRgzANsALDFWG8dofYMKUoO137dHNXJ3neMcPFQIaRwjo3+Zl2BUoTlXNYaeaE+KZxF7HNYksIFMJTyjkrbhKZcVJR0vWS/PBqNRWaaLJOFrPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TygEclyH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TygEclyH"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e719bab882so14406811fa.3
        for <linux-fbdev@vger.kernel.org>; Tue, 28 May 2024 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716940906; x=1717545706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbSUJZ3lWVi558UySXJCbOkQXUwg/BY6swouuGo3h3M=;
        b=TygEclyHoAGDPHl/RQojVEJU5saV7tYC/bemAcsJSTf3oytcZYW0LTlJ5tFgqDKPFS
         jrlboJQiumh9t0s7EscXglycE5n1HB5ofKoT+53Zb2AVE25hJxAIRRPFPyzTdq0uYYtz
         K7i4zz1fgUsfO6HgndT4A+s40OZ6zavXTtvqcNvOBLC/Ml31bxE8nDASdIEEJbrfjLiD
         umZF5NE5/ihnBOl+gUcvLbm5EQY9gtUY9KkURa73wNCMmirkH6Gpv4EOquWkiSZ4EqmC
         LsDSHMXJzHRYnuLr9XDhLzSHS6l1yZRqUAHj9RLJ0DowDPP8mVmj4DNC58zHURqsfQtz
         M1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940906; x=1717545706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbSUJZ3lWVi558UySXJCbOkQXUwg/BY6swouuGo3h3M=;
        b=HVCyVT3y6yST/VGjH43vYBctWFOVqwbo7kja324SuoWu2CDiafa/vwblIfZfEZa3SY
         2nPzvQlIiujXimdylEgaRiV2ZU6udbHHpBpSsHq3jMVi4b3BANn0u17AYP1JOyhgNH5I
         AzFSq0p0nfya/Fdk7FjkEA78wyTn4bVO1JB8BYW+eVH3hUtYLRY4EcFBxLjMpDUXeSRk
         3R5FN3XlOUutxBBQ43pW85QXupwgN/Y2E532yCwPmLrZL/oTnRVgflh+DpGltKF72Olo
         nyurCSMQERXAXX/0tR9kI+NnOMy+nMBGzG/uNrF5vMYm9izXZck5UBzetfJyfERZSwTt
         jSQw==
X-Forwarded-Encrypted: i=1; AJvYcCVwqudiYVEYVgy+KjExeOPFxv3g2qur1/UcsiSxzAIgpQ9jKKLSUxMEqJWgK2ji1q+aV5eTxHgLf/B2/XXkX5WcTf7M7F1zOyN2JoU=
X-Gm-Message-State: AOJu0YyQTH1wJG5bsR0GjwLbPZkonv5Gyk1k/ncXcV2FfDHCuiUkGbmY
	PGomATGG/rWxBCsbBvxsKNMNTS19E/+MV16zPJhbL/b8ys5ITjY/R5U0wcDUOFE=
X-Google-Smtp-Source: AGHT+IGMFvu7tNMpu3hd4ZI4DzSWJEhLR+W1+ptB5RwKxDpz/xmWeD3EGSsLralZrE8N3ltg8VCBsw==
X-Received: by 2002:a2e:9e57:0:b0:2e9:795a:c25c with SMTP id 38308e7fff4ca-2e9795ac301mr46868491fa.39.1716940905814;
        Tue, 28 May 2024 17:01:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdd159fsm23674921fa.94.2024.05.28.17.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:01:45 -0700 (PDT)
Date: Wed, 29 May 2024 03:01:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: prabhakar.csengg@gmail.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Eugen Hristev <eugen.hristev@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Helge Deller <deller@gmx.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Rob Herring <robh+dt@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, coresight@lists.linaro.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 resend 1/8] gpu: drm: use for_each_endpoint_of_node()
Message-ID: <3wxib4xs4shnhn6ekokmi2uwo5daqhomefqosmocvyuashxqsq@wwp6a6yrl7ag>
References: <87ikyx4hm1.wl-kuninori.morimoto.gx@renesas.com>
 <87h6eh4hld.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6eh4hld.wl-kuninori.morimoto.gx@renesas.com>

On Tue, May 28, 2024 at 11:55:26PM +0000, Kuninori Morimoto wrote:
> We already have for_each_endpoint_of_node(), don't use
> of_graph_get_next_endpoint() directly. Replace it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
