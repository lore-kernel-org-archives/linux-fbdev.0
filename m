Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A64438014;
	Thu, 13 Aug 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614171; cv=none; b=RYLK93/cKo2NeSh8XOdMkuRK4CPT0RO3ZqwCk9PSdogcz1Vab8owu8S95VAHZHDhELzXhfdCh+c3HXfbe942o7Q+oCxr4u0YLkypemL3qoRrqjDNPTCyshvYh6iZXj2TlDcXN7dkqkV8gNPNBiG9nWKRTF5xupd6cwR65zblvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614171; c=relaxed/simple;
	bh=O0GdR5HLPzTl9h8BXfupD23voEfJLfSuwylkuvGxcpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD6LBOzkuRjGhSoU+XGwXbrMP1/LGErvHGWTA26Oj2YLSFWxXghjSivlWhiw2gYMHP0cGxl6WRGnTXSO2pQ3fpfV9Gv96QxJLLH3355YGLBVwPOJPz/7XgLdHY8Z/HKFuBFzUnSQXtkkoX2bFMrNu0sn3NW04PLCmyRvDaL1Yr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0pXVMZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0pXVMZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5931F00A3A;
	Thu, 13 Aug 2026 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614170;
	bh=O0GdR5HLPzTl9h8BXfupD23voEfJLfSuwylkuvGxcpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M0pXVMZvCmT3435jyxqyZgQUuZg2oUdjZLNSPHMlcxKkUm691YeWvTn3AdNI0mmuA
	 KA7q1tTwkkM6SCypzcRlZ1PHzLI2VdALJWkXJ+/74ukzQURAZ4Mv5uFW/XJXvycafX
	 oE9ax0DMc/U7vTqguwRZs6Z5mtLKNOeQkA9kEL8hndHEQSpt+cCalem3xOK+f3is0q
	 GbudmnbYi2lUG7Kd1pF8Rg3cITjUkSYxbqY8o/r77zvxm9vLuaYg0gmSLCw97vQw6e
	 /E0xXef8bQgjbVF2069VrhO7AYIY5B8BaaIg5zNUnq3jn2bI6wzcZkLNnE5wNus7IJ
	 LuPB3C8KhQ8BA==
Date: Thu, 13 Aug 2026 10:42:45 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <an2RlSuqoH4EmLEO@aspen.lan>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>

On Wed, Aug 12, 2026 at 09:21:47PM +0200, Wim de With wrote:
> Add a driver for the Orient Chip OCP8178 backlight controller.
>
> The OCP8178 supports either PWM or a vendor-specific onewire protocol
> over GPIO. This driver implements the onewire protocol, which enables
> setting static brightness levels without requiring a continuous PWM
> signal from the host CPU. Note that while the vendor calls the protocol
> 1-Wire, it is not the 1-Wire protocol from Dallas Semiconductor as
> implemented in drivers/w1.
>
> Signed-off-by: Wim de With <wf@dewith.io>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
