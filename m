Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379A305066
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Nov 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769872; cv=none; b=GnkNdbypLsGwaOcbn78ExYraxSwrq4uxpJaj6UYqHLKneN/dcvn3nMurmtiUW7hFug5lEDsQV1XkkwTpaoPg6TXWbm97SN2XwwSkEKa2Iw5uIX/1fUxqajZsX/JlVm2dF6tltzp6abS4a2UpDP/lyh3J1/hEYWr0Swm+lLUMq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769872; c=relaxed/simple;
	bh=ytVSzmYaDqD0qwMAifjOEvYSRHFoM76EE2Q+SxLmLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBJ8SwHQrOvL/Xd+pL2Va7+A6JeUK1ktONKjr8snhluIzkPCIlZO1fyRo+PJjGLvtO4FAqH2Q+9gOI3yj6vLIfmotq4YnfAB2I+y8oejyVeyNHyc9HmzYfKVMG3nlpIfMMLJ/nr8WIuPpncMO2bx12nkJwpqypCF/CutAtnNBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Bc/nggo4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Bc/nggo4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so230240f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Nov 2025 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762769866; x=1763374666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cGOOrdlJvwUvrBTIxkNqf0S9KSK2YAvxzQBiD0nhFs=;
        b=Bc/nggo4DD+U+wO0qS71yHjtA7jHJNMLKFlQ4bOmL2fIOp2OT/FsuO1q66wZag0ZlS
         wcGRYBnT0zqQSZfATNyZHGrhXwJ9vHIWfS3tmBd8371aRKOZY5AIqkF2ZeRKCcpeYDTW
         0/L2STKrv2P9/MWfgqIb0Y7qwOO/pTN+17cn4GKmA4BrMh6Xv791vJS1GPyqzEfvuDQD
         8nC/kdZdz4nuA0f4mHmT8cvBjvWg48bb4k/G06dwlRU8in5PqCdwgkl1zp9xQNRLrBoe
         kROW6uuxpjM6Ta/EvddLHx+IRzoiDEs70lx4pWkFIciy5lo1qk0Ahddn4MN6rscJiDe7
         MVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769866; x=1763374666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cGOOrdlJvwUvrBTIxkNqf0S9KSK2YAvxzQBiD0nhFs=;
        b=ezAGvnxk2o4NUOvSiklhXU4avDscVDyiUT1smY8FQ+NgXVOhAdCSRrUMQ7CiGczG95
         gRJ+m8FUrj1PikS4TMFL8lzeVtcxW9B0bcdidoawMDowI3ecV9OrVy61kkLVWsa1HqqC
         sf5+COzHqDlx9BaGZxc/n4dFaHW5m46HJokuWDjs971xl5oqCfE621JyIBcRD9UWB2iT
         hFq1mJT2FN+oicLLVTk5spm4gRwL2e/F2Oy+VwjrXfeuVnrRrmr7ZsLAHyOf7XsrFlZa
         spqu1QqDCzFdaYi1JCnnVrNIle6CWaY57mX9bHolFriPkLQY3oaBfZHQ9iVD6tk8yhAz
         tLjw==
X-Forwarded-Encrypted: i=1; AJvYcCXaoIkvijdmJHXKGEpH3wc57YOWiv32NXd9GaxA5K7MAD3pKQ6cWb2R3bGmmcNoeQTWCq7vATk8ZJuCmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8Vul11JoBhO7ZZ2f0w/OiPP540cejqCpYJhWQGbwk7ryIeHK
	dbLi6jPoJHSIGOKCqPjpsSjgDrtBefGvdZ/j+ZwytCNxFsIbVgPr9UrkHAzlhzzA5Bk=
X-Gm-Gg: ASbGncsLhRJH3doxqlLcIvnwuW1Yq+2TwbBK1emwdZsKAT41SKoHHuoYxBEZBHWUAK2
	Zr3pshw8gUt2cBv9VaeCGqD09AsFcKnyf0ddjCXCebWI0lHqnrB0LddFGeDo+y6GfbhzbV1UNht
	YuG7h9Aj2FPMNd4D/AVTRjciXEW/2WSNyGfnivK4CFZuwTK8fhJr4NaTk01DP4Of0CdYr69pGRC
	KKMIMZ8ri8hlkAgSwKd2exWVQSYEDAo6CXybw3up05u5U4+3lJVDCybxTuulpxHQtpR3/H76cOg
	5HFmNmJ2rsoMbgNji2bj2EXyWw/8lnbZDVvZVP9g1b8xHrQ5VkOjdNm7ThM5qqlLMTPCrCqD1Tw
	MhJPtQLlEfXqF+AIWzGq+SH/iLHkAKRbDAfVS+Azd9S5sueerm41uSELMfQz2WeDctDkhD3u5t4
	rf8rKdG4eOYEiYl6zNycvBRRMtub0bZ433vF99WRl4ET+oov4tdX7zCUo7iFk=
X-Google-Smtp-Source: AGHT+IGUpHSfeagdIBM88vePaTs3yIVY9gCWpK2lN42s3k1Y6AfvZPuuxOVOOc+I4rI5U6e1xXLxSw==
X-Received: by 2002:a05:6000:228a:b0:429:f088:7fb with SMTP id ffacd0b85a97d-42b2c655058mr7359131f8f.7.1762769866339;
        Mon, 10 Nov 2025 02:17:46 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2e96441dsm13918929f8f.23.2025.11.10.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:17:44 -0800 (PST)
Date: Mon, 10 Nov 2025 10:19:56 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Maud Spierings <maudspierings@gocontroll.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] backlight: add max25014atg backlight
Message-ID: <aRG8TMqehv-oR6v1@aspen.lan>
References: <20251107-max25014-v5-0-9a6aa57306bf@gocontroll.com>
 <20251107-max25014-v5-2-9a6aa57306bf@gocontroll.com>
 <aQ4a2SBDldYgQb56@aspen.lan>
 <f4e52cc1-9c5f-4069-9079-83be794ab2b3@gocontroll.com>
 <aRG359gIeP48V2ZZ@aspen.lan>
 <59c36699-ee54-467f-9342-6756a0092a98@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c36699-ee54-467f-9342-6756a0092a98@gocontroll.com>

On Mon, Nov 10, 2025 at 11:03:27AM +0100, Maud Spierings wrote:
> On 11/10/25 11:01, Daniel Thompson wrote:
> > On Mon, Nov 10, 2025 at 09:40:07AM +0100, Maud Spierings wrote:
> > > On 11/7/25 17:14, Daniel Thompson wrote:
> > > > On Fri, Nov 07, 2025 at 01:49:59PM +0100, Maud Spierings via B4 Relay wrote:
> > > > > +/*
> > > > > + * 1. disable unused strings
> > > > > + * 2. set dim mode
> > > > > + * 3. set initial brightness
> > > >
> > > > How does this code set the initial brightness? It doens't set the
> > > > MAX25014_TON* registers.
> > >
> > > Yep forgot to remove that, I discovered the backlight core takes care of the
> > > default brightness, so I removed it from here.
> >
> > What do you mean by this? Are you sure you aren't relying on another
> > driver to enable the backlight rather than the backlight core?
>
> Not that I know of, there is the systemd backlight service, but I am pretty
> sure I can see it first turn on, then get switched to the old value by the
> systemd service. Unless the simple-panel driver controls it? The backlight
> is linked to that.

I think you should look at the code. I think it's likely the backlight
is only coming on due to the link to simple-panel.

Normal way to handle that case (if you want to avoid the backlight
turning on "too early") is to set the power mode to BACKLIGHT_POWER_OFF
if (and only off) the backlight is linked to a panel. See
pwm_backlight_initial_power_state() for an example.

If you are relying on "the backlight core [to take] care of the default
brightness" then you have to request it in the driver (by calling
backlight_update_status() after registering the backlight).


> > > > > + * 4. set setting register
> > > > > + * 5. enable the backlight
> > > > > + */
> > > > > +static int max25014_configure(struct max25014 *maxim)
> >
> >
> > > > > +static int max25014_probe(struct i2c_client *cl)
> > > > > <snip>
> > > > > +
> > > > > +	/* Enable can be tied to vin rail wait if either is available */
> > > > > +	if (maxim->enable || maxim->vin) {
> > > > > +		/* Datasheet Electrical Characteristics tSTARTUP 2ms */
> > > > > +		usleep_range(2000, 2500);
> > > > > +	}
> > > >
> > > > If you really want to keep the devm_regulator_get_optional() I guess
> > > > maybe you could persuade me it's need to avoid this sleep... although
> > > > I'd be fairly happy to remove the NULL checks here too!
> > >
> > > Just wait unconditionally?
> >
> > If you think it will be unusual for the driver to be used without enable
> > or regulator then it's ok to wait unconditionally (all examples you
> > have added so far have an enable pin).
>
> I think it may actually be a very common implementation to have the enable
> pin attached to Vin, we don't have it set up that way. But it is displayed
> that way in an example schematic in the datasheet.

Your call.


Daniel.
