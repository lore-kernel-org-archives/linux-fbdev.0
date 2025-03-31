Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526A1E1E14
	for <linux-fbdev@vger.kernel.org>; Mon, 31 Mar 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419499; cv=none; b=f8aarxlG3ufLJMa0ZYXIxUBhlvfnGT17Jig332MCytWkoWm5a+yVwsHMulNM/mHjZ+ia6Q4ibFolCbDo2993jlv2Zh0zEhpMPV9iW0Kqfh8tIzT9i/b9iinlPrJvVxvU9pPAz3tgIhePFlTpYoUwkkoxikgnj3jzLhX6yqjsEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419499; c=relaxed/simple;
	bh=bQvxaj99iKc9Prh5cmtyf4pcZBD8XtodfthaYAnrzqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttLjIzdgNhLCCGAo3SQGU2nkJuBXSk0K4Tzp6nDABcA+3jwHykukvis2uF2nL7xScOFaPpzvWpHfLmis4Sl5wi/fRAd3xSMTQzlTw+AXpv0wKoQbxZeHVqidBT35a5nqaK+YeUS4Ygn7ZpxOmqhyhw1ORIdYP2OoJa66jCds7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vI1nH82f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vI1nH82f"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so194225f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Mar 2025 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1743419496; x=1744024296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/z9KaeViB+nABb+i0f3FPF1rJaPqOeT5WIFGvfG0zY=;
        b=vI1nH82fHnBbiYc3zwyDDW6ktusaYpVukZlitKv1Zz47qrTBB/ZGhoDb3W5V8R+DKl
         71Y89xmA+ow4E2I1kibEEREy52NDffzJ9G7VJENloJdJtChGVRYpdThatvZNNd0wVaH7
         r9uxQOUSIQafYmdEN4c5/6RHQY/9+gRhBa8Mav2hS6BOyA4xdutssdkpmVDQM3RjeIDJ
         KyZp5guxTi78K0HNsMYpJW+e26TwYg9rNMwx9fru6GVVfhuQz9ZRFPAQFFBxmLFtSU90
         5rAMiUjr9hq6xxOiFjqHwXOdqs5u/9lSvFLC2I1kqXhQa4v3Zva2hLX7pyIgDdYb8Qse
         Ytdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743419496; x=1744024296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/z9KaeViB+nABb+i0f3FPF1rJaPqOeT5WIFGvfG0zY=;
        b=xTzPSyHp0jEc+0Gqd5yV5WcKJmOdFTpe1YVViZV5SHqwwQh7AvTacNQq7zx2Xr9HoG
         h4+xBhMzZK2YBO0LtTVOEW+d0xvr3RIqqm0RhDu3jVzuasd/YlfIkv8M2X6gVXjgI2vK
         iqUWunRKcwMdmjy7Qbs7UK2qnG3wUIfT35zqNaLuS0+IvtxeXoeI7RK7ftKGe/dPdKsW
         rCeVZ+9d3tzikzABygwVqx8cUaPp3YDf9vVPYHubQFdylgry4unPMmAsEoMUAiIzkmYj
         yq3deEXGL9HOHg17+Qi9zkQiv+LfAqCaI5Dh4KBJ/y5c6OdmWhf4X+nNrhU+kl6yUeC3
         49ig==
X-Forwarded-Encrypted: i=1; AJvYcCX7JBGafr9mxojjVFtCEDmd+hLaMhHeGWi7c8/K6VXFKZwtOIuGwcKegAZIhY852P7jVt+Hd46cj50gIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVk2eeCQZrdCSvLtgyPa2BcNcAl461eCy/M3eiDTu9WNwGusTK
	emGtJiYykU75R7kJw3z8rvxFuB+qRJcNdjLTflaG1bIccdHHh0yCHW0//kjAoNE=
X-Gm-Gg: ASbGncv9+sKxO3NlrvEZwyQ0pr+o+d6NhMdgMlPayNOteRWXZxntcabWoASjOGYQ2Ba
	2FoOux4iMim6XoGXihmPBOurZ3p7ey7IIW/aLB0tL45AAssVDiefcL63GK0qvsimlLNb2//CPWT
	ntkV/SovdlmAKdDyeZ30JWoE2SfFOI1BZzVR/2H0Qilqn3LFbYZEAbAuU0sXErHfgSOyxjt+vme
	8+CsJQxe+lXRmu3DO0Md+L74rCap3G7Xcu5lp59gacHuqVB1yvEgfoRs/oAJj83wJfnm/XzQjNq
	miK3oCp8YhlJW7EvTD6rp3qXklZnPOLTMPLoX1hLBqcMGFcXirnf43tazsfx1iPpNtI/YAzV4dZ
	tMGMHGnufOeDvPog8EbC521l26gpoc3dqOfr3yQ==
X-Google-Smtp-Source: AGHT+IHbzgndrMf5AmHgtnob+9Zffklj+mzgcK1rt8g4VD0vaNiQLwfQIes1v+pMENrKBCJDAmITYA==
X-Received: by 2002:a05:6000:2d10:b0:38f:23f4:2d7a with SMTP id ffacd0b85a97d-39c12117dc4mr4659354f8f.40.1743419495944;
        Mon, 31 Mar 2025 04:11:35 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdff2sm161702445e9.17.2025.03.31.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:11:34 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:11:32 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: qcom-wled: Add NULL check in the
 wled_configure
Message-ID: <Z-p4ZLkyIIeyVzPm@aspen.lan>
References: <20250331091245.6668-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331091245.6668-1-bsdhenrymartin@gmail.com>

On Mon, Mar 31, 2025 at 05:12:45PM +0800, Henry Martin wrote:
> When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function wled_configure.
>
> A NULL check should be added after the devm_kasprintf call to prevent potential NULL pointer dereference error.
>
> Fixes: f86b77583d88c ("backlight: pm8941: Convert to using %pOFn instead of device_node.name")
>
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  drivers/video/backlight/qcom-wled.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 9afe701b2a1b..db5eda8ec37e 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1406,8 +1406,14 @@ static int wled_configure(struct wled *wled)
>  	wled->ctrl_addr = be32_to_cpu(*prop_addr);
>
>  	rc = of_property_read_string(dev->of_node, "label", &wled->name);
> -	if (rc)
> +	if (rc) {
>  		wled->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
> +		if (!wled->name) {
> +			dev_err(dev, "Failed to allocate memory for wled name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +

No objections to the check but I don't think it needs a dev_err(). It
is a waste of .text to store a string that is likely never to be
printed.


Daniel.
