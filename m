Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEAA38837A;
	Mon, 23 Mar 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259844; cv=none; b=sRY41W1Z164rIVM/j3d7qGerzO/GU7M6jB5blRaSNgYGI2gICYolX4gQk+e4EZBQocNfFWQTgXA4YOO2Tlbn22kYIz50gyMtbYfHY57BH9rOaBc08r+WfvOpSHQT0mkj0DmIbyIlZ/cKXYtY8El3tDUTvwnfgyNAxx4/HJvkRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259844; c=relaxed/simple;
	bh=gRh5APmEZoL+PCyEZvnv2xN1B3en8Ns9D/n0z8iaxBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPUPYH4rHOvH0dBP4lztO7Spk9poJw81KdDySCeMSxyTB3you9DLry2w0kU//QTOZqSodgOSYJTc4Xt4I/UdeBW7cdMl4ump02RhPxVF/ylRXBuX4E2SnhPkfUsqRxz9er7+FioY3Ns6cdDlB+IaW9lT9bSKnU5pc0OVTKA9dJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4R0izOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4R0izOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB4C4CEF7;
	Mon, 23 Mar 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774259844;
	bh=gRh5APmEZoL+PCyEZvnv2xN1B3en8Ns9D/n0z8iaxBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4R0izOFJoLr+RY7wW6q6gHNB7yQudIc04pJgXeAIwJ239kqv/JbRYRpU5JH+iUAv
	 JupXG4sO7npwob97zlSwBJW8vYP9+qAPTQ5RK7aT5ZO7tueXiBsQGxtcbkeyU9wj5S
	 Qo/JSFcbGOf83jTPZsXwi7JyePUxC/32UrQfXUNdRRO7ziRgQcSDns54jkSUUL99YP
	 W/tflhveyuTEIrhtcKgT1u757xG2aBFRhafGEVM5FqqWib075dpzVdmzut0hO6BMkX
	 KqTBw8JAf3AgkPT/3/L7mvJxLn5KYCWrfAvPv/vNVkm+3cokYm5jhueSZjggTy5QV4
	 WD2kCDP+tbEKQ==
Date: Mon, 23 Mar 2026 09:57:19 +0000
From: Daniel Thompson <danielt@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lee Jones <lee@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
Message-ID: <acEOf2pI_NpfA4EP@aspen.lan>
References: <5084777.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5084777.GXAFRqVoOG@rafael.j.wysocki>

On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the Apple Backlight ACPI driver to a
> platform one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
