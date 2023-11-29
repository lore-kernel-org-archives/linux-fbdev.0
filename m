Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SN4hC+FN"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37760B0
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Nov 2023 08:53:07 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b5484fbe6so69677027b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Nov 2023 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701276786; x=1701881586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPGbfDWwX47hn9c1TMZWvz82zmR4+7EsCG8Vv2EabG0=;
        b=SN4hC+FNTDurfIyFfIsHAfkfZ5mqCfFrrK7epLVqG2cuH+DzfdmN2xJIzzqPKbG2pF
         feq00LXuGCjMHsqd2S7Vz+0mZ7FI0pzllRkFRR3eoIDK0OpYq2jn0UwrGZQ5B2XF/gIJ
         XaUULQLHf7+Va4xixfPcGsXg/HLFr6NBXBhwhMDPUSnf+2DmubJl2JL4c34jClrZ1g3B
         VsVuWxdw7UfbRU5VXxiww1yWbQrZITj+vw5zUUr256LVGZNfMKeV+tvWxbDOMMygXaqS
         V6K6CkSeHN7XYxcjCjc0PkAdFje1zFdhbns/kppQLdmke0y+JWGSRso5UftegeuOdYoo
         95Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276786; x=1701881586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPGbfDWwX47hn9c1TMZWvz82zmR4+7EsCG8Vv2EabG0=;
        b=NnLkdzkib0OVz07Eas8ZYbcg2lCONCjv1bo89utiSuDfrF1uPTZ7wXENaS4pvWIAmF
         QE4L+Xd2anGM2Y+KO7GU5vNJ6zxumlWC68Rj7I0L26+nsL/CNOnJfmyt4or4bLJaFmpg
         EAnS/++6WECqBBQkd8oY2i/fncyDXMMBUBvKer+Y2/jRUBFJRa1aFjZhXi2RRwm7HBJ4
         yFS9k1mTOCmPaEZshHRCQnT1ScnK5D0CBOIYiCOWXYdWi6mazt9Fwu2LSL7FLMAWt844
         ufmex09HyQQMhNCRHNNOpvLR4BfSlAIVEPn+WpD9Dhs1kQWWTW1pAl90tPt+c0rheSXZ
         rtNQ==
X-Gm-Message-State: AOJu0Yy1liGwIIVJk7oe/hzJFl1z4UOPSu9mYrR6ojJaxeCA7LUJzxzV
	UlamF/zbnwf9dlBZ/Kyf89d/ag==
X-Google-Smtp-Source: AGHT+IGmGSM5NJDfl50YO5yRCBQhZORbGm64vh+8LM76PvjgpggOwuowAv/8NruJzpZ7nIsrkCFYqA==
X-Received: by 2002:a05:690c:26c5:b0:5ce:2148:d4cf with SMTP id eb5-20020a05690c26c500b005ce2148d4cfmr17974677ywb.7.1701276786078;
        Wed, 29 Nov 2023 08:53:06 -0800 (PST)
Received: from aspen.lan ([209.120.180.235])
        by smtp.gmail.com with ESMTPSA id kd26-20020a05622a269a00b00421b14f7e7csm5700786qtb.48.2023.11.29.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:53:05 -0800 (PST)
Date: Wed, 29 Nov 2023 11:53:02 -0500
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: mp3309c: fix uninitialized local variable
Message-ID: <20231129165302.GA18064@aspen.lan>
References: <20231129164514.2772719-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129164514.2772719-1-f.suligoi@asem.it>
X-Spam-Level: *

On Wed, Nov 29, 2023 at 05:45:14PM +0100, Flavio Suligoi wrote:
> In the function "pm3309c_parse_dt_node", when the dimming analog control
> mode (by I2C messages) is enabled, the local variable "prop_levels" is
> tested without any initialization, as indicated by the following smatch
> warning:
>
> drivers/video/backlight/mp3309c.c:279 pm3309c_parse_dt_node() error: uninitialized symbol 'prop_levels'.
>
> To avoid any problem in case of undefined behavior, we need to initialize
> it to "NULL".
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/af0a1870-693b-442f-9b11-0503cfcd944a@moroto.mountain/
> Fixes: 2e914516a58c ("backlight: mp3309c: Add support for MPS MP3309C")
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
