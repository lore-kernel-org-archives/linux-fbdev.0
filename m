Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548D28688C;
	Tue, 31 Mar 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954110; cv=none; b=iaeMlAE9zDD67+1JS9TsNm47++2S3QFu1izy63UGAnl4YRwX/c0uoG29OAeTUt1eX4rewSwd5Fua6XCRNUGSTVEo/vevtZGJSdyK9ml401NY/E5bbsoJgWjAHNdk4Zz519cOUre3xvBdHqExwmWP4HxdumPLsURM704GahSMSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954110; c=relaxed/simple;
	bh=+pdx9CboE/37M0KLJVQhp4sepscwIcmqL2aP3WoAHi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gGSubcxCKyq9fxmXdtUc+Az122XhSZYeIP9FI1fExg3KUdYOI6RY3EZanKALkzet0pAYLVosVZTOY0zlxHmWorZlTbXZim6jOJ104RoYEmxXnVhlLGr2uCUIlNStJbIJ5qvnidZpcvoRcU/XEZByxOV07C2UAXwWbLANPTWyZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQV6GpZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQV6GpZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE43C19423;
	Tue, 31 Mar 2026 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774954110;
	bh=+pdx9CboE/37M0KLJVQhp4sepscwIcmqL2aP3WoAHi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bQV6GpZ3+QpAb1HXoZY/vUrBxToOG4ZidqJttDRquwa6vTqViKJUxhBWKD7RkIMJZ
	 bgRB0oeSDXMecE9GvXtjE2mcG0Foy7jaOFPkJA5BndyVsLwzlQzY02VnmVFcIM73uJ
	 jJ3HZLkD5DqRbBKEgs8L7OZlkrq3VwMZXWU2KxHjsZc0rHg5yjL/Bw/MuAlNVt3c7G
	 2L8GbRmX46I7dies1f/80rLZSNwzZMbtSHJva75faWSh6tE4AnHpsFiHDaduS02f+L
	 LKdtyyKp3VbAEUty7ttD2T9AOOWIZ6puR2Uv84fNrzrwe3BLjumpk0qf5R/Q13i5sW
	 jED+bI6jEN17Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <5084777.GXAFRqVoOG@rafael.j.wysocki>
References: <5084777.GXAFRqVoOG@rafael.j.wysocki>
Subject: Re: (subset) [PATCH v1] backlight: apple_bl: Convert to a platform
 driver
Message-Id: <177495410819.3826141.10439293270550177913.b4-ty@b4>
Date: Tue, 31 Mar 2026 11:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sat, 14 Mar 2026 12:50:11 +0100, Rafael J. Wysocki wrote:
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> [...]

Applied, thanks!

[1/1] backlight: apple_bl: Convert to a platform driver
      commit: 04d8f3fd0b52ead84eb722989afa094b8fca9129

--
Lee Jones [李琼斯]

