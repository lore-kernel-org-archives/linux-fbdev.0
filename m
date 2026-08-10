Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2493BAD95;
	Mon, 10 Aug 2026 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360277; cv=none; b=YXhfEvcZdQ6sufIvCxQ9Loktxl1LDnvNwx3p1x53lWkIjEjgv6R2kCE79R/Za+RH+bY5Y7dFL7jEI3MpBZf9T8FpBd48c/MV9eDJJt3htAUezRK6vSzXQThhFKcLGKc8U+xYeBGl7x1QvJ/9jFIijO1K9T1SwAz9aVQmM2fa924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360277; c=relaxed/simple;
	bh=OYpEnC1uFpNkW7CzGUa5yZRpTMO0OmVPr30M8mDEOxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnFRdB7ZEVvU59hxFCIk1lwC55D2Am83HrOwykZrqYcGfuLprbLYj02aTk9UDCEDkbkC3t4wClbgte8xf+EB/t4KrrqQGJSNDwZ+mx6JHeERtUjNzBc2KzDIE5qjdYwj2l3R5qqwKwIUxjx574Q5u3rAUbs+ocPeIZOqRnWcRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTFWa39W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTFWa39W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC51F00A3D;
	Mon, 10 Aug 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786360276;
	bh=OYpEnC1uFpNkW7CzGUa5yZRpTMO0OmVPr30M8mDEOxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dTFWa39W0wQurWMCPLwzB2dxPqXJ/lOtcb+6us+vUyvMEOgX5k/CfI3nn4IDIUQGh
	 1qcERn8pT0HE7ibBqEaHKHLZgtEn6OTWZOi3zwBDLMeO3aP5b9YZxe7XSw/Dz//uvi
	 Pf/SnikSROEv7l80Ae86SP0DgyK7xFojj0DkFQ+QTXFAJi146riZFPUiQ+ghVepxoP
	 6HQV8lIX1jmXK/acMxroLNlo2kvhm9kr7UmIQ3ZfP5CzmHRxArMhLVnTWOT2NyOkjo
	 QuJJ/jI/g0fc8xWqzqDgUrxZYv+mpdYvExw7o0GITcVHSZ0QUfWdPWT3hDCv9O+RtN
	 a+bdP7l3jAjvA==
Date: Mon, 10 Aug 2026 12:11:12 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	"open list:BACKLIGHT CLASS/SUBSYSTEM" <dri-devel@lists.freedesktop.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] backlight: qcom-wled: Remove redundant dev_err()
Message-ID: <anmx0GEAY0SeMdW_@aspen.lan>
References: <20260722065709.346072-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722065709.346072-1-panchuang@vivo.com>

On Wed, Jul 22, 2026 at 02:57:08PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
