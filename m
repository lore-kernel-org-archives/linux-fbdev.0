Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bniw8I4O"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D693783
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 07:08:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2c8e91afso2184255e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 07:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700579337; x=1701184137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nae4JbWQBA2aia/B95hNasr3I++DT3K8V5bSC8i7lEI=;
        b=Bniw8I4O8xww1+R9CFSXtkVwY5De5uZmI1EaZgyhAKu5rQfSLt5wvDnElgWndu6wRA
         GmtHIJL1do8SEBYu755CjIeZ6HDorS21qwWMZmHrk70Z2UWoESfqnlSui6rTeJ1AVkv9
         W5uOAaX4zrVSPpFcRXKhcAwt9kqOdcXglRmYTGqju3ottZdaPdy+FZ4dq+UtRH4W3Og0
         mHstYY3E8z/y3/UFcOYd43i5VaxshdCsE0Jd+EcVejPIPwDizCnNdzYELdtWI49HWspW
         BJT8JK5mNeVOrRxPzo7ikMPt1ioD0dyGb6N+WkjRqkO9wcc50sZkMC+28sP+0QgEWR3m
         47Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579337; x=1701184137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nae4JbWQBA2aia/B95hNasr3I++DT3K8V5bSC8i7lEI=;
        b=LIMZzmzNSE5SYrdcUP/ib3przAp15ljKcMxh9C2A17j9XA1sbJPNlzBfEthMI97qM9
         MfN1xIS9U2gzvtH9YIdDrMbYQcFpQeMGQCp3PG/gBhF77x0wcbmb98XMXm9w6A9RIzSH
         LjMwvPxoWI1BCvYBMPoDGGWu2R21ax/UJ0JjsxMSDORlLvIHe96+F8bVN5Bl8Cppzgxj
         vncnl4ANOpukD7EgmwJJ/tGQMtv++3T3yapp28UmBR/09U9Jm7/4ytQVfFeOMOJ+d3ZA
         5a29UAU0ahd5zKHNjzPFIrW6QIK0OVgq2nfs5QaxQkMBezeV/UlTX+S4o1WEzc+5hmwv
         44iw==
X-Gm-Message-State: AOJu0YxRO8KmSZHEKSzs7jQZPLlsz91yuQL8teBiTvg4jGIufRRZvXIL
	VcE2OkPTStBHF/36D6RJfA4DYw==
X-Google-Smtp-Source: AGHT+IH55XwOpCbTpm2nlb6uk8LPDmWMNuN4gHEZr7xfOXoov1mRLB8htGKYmkK0xC2O/BYriy6t0w==
X-Received: by 2002:a05:600c:4ed2:b0:405:4a78:a890 with SMTP id g18-20020a05600c4ed200b004054a78a890mr8499401wmq.8.1700579337271;
        Tue, 21 Nov 2023 07:08:57 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b004068495910csm21858114wmq.23.2023.11.21.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:08:56 -0800 (PST)
Date: Tue, 21 Nov 2023 15:08:54 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/1] backlight: pwm_bl: Use dev_err_probe
Message-ID: <20231121150854.GC4740@aspen.lan>
References: <20231117120625.2398417-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117120625.2398417-1-alexander.stein@ew.tq-group.com>

On Fri, Nov 17, 2023 at 01:06:25PM +0100, Alexander Stein wrote:
> Use dev_err_probe to simplify error paths. Also let dev_err_probe handle
> the -EPROBE_DEFER case and add an entry to
> /sys/kernel/debug/devices_deferred when deferred.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
