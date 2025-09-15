Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF434320B;
	Mon, 15 Sep 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947790; cv=none; b=Vn7SnudWHTKiVImz8j5ZWJCUDy+xXW+abq4RFOQGxo23s4zZr2FYPVyIhmzsXLF1DNbNeUB6cNvuV7B3qZKVZRLXhT32mG3Gw9mKxENciBYcU2cP3VxhIeyZ/tLM6Es8wHuiE+V3foA67gooI6RWwJYZPmTv+SXmKF/d8hSJbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947790; c=relaxed/simple;
	bh=nrpws9n9MkXC9vi1VL6ygDXUL8fjD2xYcDoZxFTVUaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ouh1P+Z1na5CnrOGGOQ7i3egO6h4XZ7aeWTr5lKztG8kNg+4eJpAAgYzrqyPTUV9RjglxlQzg05ihofRhjSgXRiL+lBTvDqFLHOp0KWTLWwL/wVugL/8NKw2M3EP8tnitrkzbSp1wU5PfW0nbO3JKdkADOqAo5Q8nmGKXshpAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6sAMMnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6sAMMnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780EBC4CEF1;
	Mon, 15 Sep 2025 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947789;
	bh=nrpws9n9MkXC9vi1VL6ygDXUL8fjD2xYcDoZxFTVUaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6sAMMncrMLJO//JNi/b3zFwf5hBbeUa+KqInij8EsEasDj2PnaRUTSI0oy4GOJE7
	 8SLXNTTH+I2Q6Ms7vV8KBsQcLr91IE1Yfumc72WTJpUpQcXayRV6laRMsb3luf/OZ6
	 4gmytXYzMv+38RZ23uV+VH6/nVxmxu0P8mRISazzHOT72ay9tkcccTSCALVsfFaB6v
	 NhuJpU7ijOH1Gxx5tS6jRGDe6sS+cQZP+BpQKW3SMbQ5ak/4sezhD/1GXW42C1cpXw
	 NcPDDoeApdOzdfMTns6oIKEMWVoRx4Y6+Q5mwpKry97SNBpok9GXqluE9s8B0WGXc5
	 lY9NNYYlusiEA==
Date: Mon, 15 Sep 2025 15:49:42 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com, deller@gmx.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, fnkl.kernel@gmail.com,
	j@jannau.net, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	sven@kernel.org, alyssa@rosenzweig.io, neal@gompa.dev,
	support.opensource@diasemi.com, duje.mihanovic@skole.hr,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 08/15] backlight: as3711_bl: Include <linux/of.h>
Message-ID: <aMgnhlFj_44gARiH@aspen.lan>
References: <20250715122643.137027-1-tzimmermann@suse.de>
 <20250715122643.137027-9-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715122643.137027-9-tzimmermann@suse.de>

On Tue, Jul 15, 2025 at 02:24:45PM +0200, Thomas Zimmermann wrote:
> Include <linux/of.h> to declare various OF helpers. Avoids dependency
> on backlight header to include it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
