Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2C30FC25
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Dec 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594792; cv=none; b=PAQGWf3mLUdBLDluCVVpNTkcADcc4OUf1E/bxB3kS0tEio3S66Uw3Dc0MU+yvBcl7lHGyqznK/KsHpgfo7ZcBcqOliTUusjt4WQO/qsPOKKCevNt16V2ezQ+A0uaYnjR8JGgq5v8ioylI7DfDWke5EeZTQsmzMUbdGTn5bEVDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594792; c=relaxed/simple;
	bh=PCJVEwldbTm5ZBlmGgpIAN4Ymo77aALiVTsZI5zgLx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+f/6Z+t9Hrn2WNxTAb7QQHbwvuTGPkpMemATeFsH9ocHfmWvgjIePZv4CqN5cGo1ECi9Gw3qQeHCfd00iv1mFEjqV4+YpOAEXy1+Zf04RymZ915M4K983bhke7xi5UskUCA65buUATXZ5m1VykslgEuZ/CZdP4AC1rYkXZrpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EB+wolPF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EB+wolPF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5F4384E419B6;
	Mon,  1 Dec 2025 13:13:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B8E7606BB;
	Mon,  1 Dec 2025 13:13:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68FC81191817C;
	Mon,  1 Dec 2025 14:13:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764594787; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fBRDi0A4o9YmsnBRCqreFxadvyrDZVlPJ4NIul79DiI=;
	b=EB+wolPFmTG8gw6JMI6Ev653l4ibvW4Q32N68/5VkdZ6OI77sE495kI3TQPzNOIjTK3WPf
	DKfd7IsZC0/S+fiPgUPX9RZjQChZz+WyJYACH04dkVpbh6msxy7znLDdRAhts8+GQjNHyN
	MoHT9DSk2bqj/W//Rq1OgZJ0xw7tOJUI7Aq9CfAA2Vtz7xFwtGMI2mizIFuY8QhAqAA8pF
	96iDG7W/Z+ns8mECFnuOKCWVHsF/s1P5VHIolIy2KTymFqlAwxUiH/LAw0SblblTlsiKs2
	h5M9M3GTlYYcZN0v3rpiT+7cY234wGLOJdrofaHUHTZcFbSQBUTG1yIsISa1tQ==
Message-ID: <9222543c-5e67-4fe5-b598-e1bab8f6da2e@bootlin.com>
Date: Mon, 1 Dec 2025 14:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] backlight: Add Congatec Board Controller (CGBC)
 backlight support
To: petri.karhula@novatron.fi, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
References: <20251127-cgbc-backlight-v4-0-626523b7173d@novatron.fi>
 <20251127-cgbc-backlight-v4-1-626523b7173d@novatron.fi>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251127-cgbc-backlight-v4-1-626523b7173d@novatron.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/27/25 4:21 PM, Petri Karhula via B4 Relay wrote:
> From: Petri Karhula <petri.karhula@novatron.fi>
> 
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
Tested on a conga-SA7 module with conga-SEVAL carrier board.

Tested-by: Thomas Richard <thomas.richard@bootlin.com>

Best Regards,
Thomas
