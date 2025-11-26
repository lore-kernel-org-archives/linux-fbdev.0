Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC632721F;
	Wed, 26 Nov 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160423; cv=none; b=fVdYb6yJcesxXQztdrFHdCHwlm+iD/AxPMklhjjUdSnuH7kpznNqFIiXDw2eKTISTTCutFCsCG98cBgohe9+MntkQm41dBbtnWb7NVqSXcCTWMqf8t9gyx3BZfnbOfCAgy2teqxy8kSUzekHcvnXlciA6t26mJnRmL6pVfnpzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160423; c=relaxed/simple;
	bh=WlUVaShN9mH14jqFXquyf1gKUl8dks8bpJbxLKEl6qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFCH3gMYb2stkIE7JM8U9eWzjRun+h7XRJ8YwIHH7P872kRFK+4S0d0uHXUqNFui/2HipKsSNChnHRY0M8yB9gRw5c8nNAcDy7C+nKURxsHaSBw1aIgWEuGjBw/r5iS7rkD1262LQSIc91lHF6aTcRELWzCS02W1fdLas3MeQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2r7N7ky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2r7N7ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF495C113D0;
	Wed, 26 Nov 2025 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764160422;
	bh=WlUVaShN9mH14jqFXquyf1gKUl8dks8bpJbxLKEl6qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2r7N7kyyi4co3v569XomNC7tcLFiWTQdGkehyrtCqFmicHOw0ojaoMcAHVK/sd1s
	 5Oyd0Uquzy4MoCNJkS4O8kNhdTSehll91vqyB9mmQVBdTFHsbeYu7BZaWpQVVAJbqf
	 uYATE4Uug2cXlv3wWzMuWWfPmzMwg8bPKS986x2tRYh71EW0kbSWHl9GUU/9UKo8zI
	 CqJYXb/o4ToCrPTGZ8ZaWjDZKlQnrlYq0LHlcfyklJHSufAv5987qW90EsR9QZZKFL
	 52yulW8Ocv0nNrhjkJ9HTj5ku1V5isCBR2c6XT5JflD/8vXwK42c1zTqA6EJWhXp49
	 Mf2xT7MeHUHtg==
Date: Wed, 26 Nov 2025 12:33:38 +0000
From: Daniel Thompson <danielt@kernel.org>
To: petri.karhula@novatron.fi
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] backlight: Add Congatec Board Controller (CGBC)
 backlight support
Message-ID: <aSbzomGqb4g98ADZ@aspen.lan>
References: <20251125-cgbc-backlight-v3-0-18ae42689411@novatron.fi>
 <20251125-cgbc-backlight-v3-1-18ae42689411@novatron.fi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-cgbc-backlight-v3-1-18ae42689411@novatron.fi>

On Tue, Nov 25, 2025 at 03:29:39PM +0000, Petri Karhula via B4 Relay wrote:
> From: Petri Karhula <petri.karhula@novatron.fi>
>
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
>
> Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>
> ---
>  drivers/video/backlight/Kconfig   |  11 +++
>  drivers/video/backlight/Makefile  |   1 +
>  drivers/video/backlight/cgbc_bl.c | 177 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 189 insertions(+)


> +static int cgbc_bl_probe(struct platform_device *pdev)
> +{
> +	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
> +	struct backlight_properties props = { };
> +	u8 cmd_buf[4] = { CGBC_CMD_BLT0_PWM };
> +	struct backlight_device *bl_dev;
> +	struct cgbc_bl_data *bl_data;
> +	u8 reply_buf[3];
> +	int ret;
> +
> +	bl_data = devm_kzalloc(&pdev->dev, sizeof(*bl_data), GFP_KERNEL);
> +	if (!bl_data)
> +		return -ENOMEM;
> +
> +	bl_data->dev = &pdev->dev;
> +	bl_data->cgbc = cgbc;
> +
> +	ret = cgbc_command(bl_data->cgbc, cmd_buf, sizeof(cmd_buf), reply_buf,
> +			   sizeof(reply_buf), NULL);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to read initial brightness\n");
> +
> +	/*
> +	 * Get only PWM duty factor percentage,
> +	 * ignore polarity inversion bit (bit 7)
> +	 */
> +	bl_data->current_brightness = FIELD_GET(BLT_PWM_DUTY_MASK, reply_buf[0]);

It would good to common this up with cgbc_bl_get_brightness() by
providing a helper that takes struct cgbc_bl_data * and calling it
from both places.


> +
> +	props.type = BACKLIGHT_PLATFORM;
> +	props.max_brightness = CGBC_BL_MAX_BRIGHTNESS;
> +	props.brightness = bl_data->current_brightness;

New drivers should always set props.scale .
> +

> +	bl_dev = devm_backlight_device_register(&pdev->dev, "cgbc-backlight",
> +						&pdev->dev, bl_data,
> +						&cgbc_bl_ops, &props);
> +	if (IS_ERR(bl_dev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(bl_dev),
> +			     "Failed to register backlight device\n");
> +
> +	platform_set_drvdata(pdev, bl_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cgbc_bl_driver = {
> +	.driver = {
> +		.name = "cgbc-backlight",
> +	},
> +	.probe = cgbc_bl_probe,
> +};


Daniel.
