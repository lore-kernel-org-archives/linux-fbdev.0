Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134034CFCC;
	Thu,  6 Nov 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448448; cv=none; b=jRnJE/sCWeRYLXj9J4Bvfu0LoIj7U54+l7J45MrfdO0baZ82xII1A9IqHI9E8RsXRrzRY6iD2VeSgEBL4Kpv8zY7M8UKOrglh69G8kyKMDxQPJaThKbBWXwZYiJ2gXwSfPqkWCHgr425Ea/LSy2EBHngjD4iSprKgRx+4xAZcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448448; c=relaxed/simple;
	bh=wrgqo59yPdMKQ+qoBa8t2ahWgAq+kcaeZ6wytvG29Mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YvLE3G2JmjWBlUDWozmnnnCO6zKn6tEUA3fJkOWu1ScKHTjcLRF5iFBIYVR2n7or6KWy+92t7D/27SL69Sm+qbZLWiliHjIzHvZWomMa1PuIqRSaKSYKeBTwN49wgcxJTnwTohU/wlG15xSaa+DbISYQiAE+H/tQoV6FnSa53ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDVjEKim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDVjEKim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F04C116C6;
	Thu,  6 Nov 2025 17:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448445;
	bh=wrgqo59yPdMKQ+qoBa8t2ahWgAq+kcaeZ6wytvG29Mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CDVjEKimD+y61aHoCmYDX5QWMc8JR5fO97SM3VpqLixV4RVE5077KJOYoWMdLJ3Zs
	 kMT11WBAQApMK5IRZ+Nnai0nz+rAJSnUAOsev17qnR9OrBUMLbxjh65Q6/ikm5k5n0
	 XdA30hWHZZY65tHzbJF0+7VAJzGAowheI7mUZzFN05g5HGDD/RBqA96jfQMbxWRI8M
	 5RTfZcd5oCJ2Xyi78OzZ+fPnNOZowCslC110PCoaRhmIc+bMVyBe2gODV9qhtLKtjN
	 WmUeGSSJofZbYXfWtOYyxO0TuNjfn8aeoujoKUE091PMtFkuyuDkh8wHfx6f4nUqmQ
	 Puz/POu6iSt6A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20250519-led-backlight-add-devlink-to-supplier-class-device-v6-1-845224aeb2ce@bootlin.com>
References: <20250519-led-backlight-add-devlink-to-supplier-class-device-v6-1-845224aeb2ce@bootlin.com>
Subject: Re: (subset) [PATCH v6] backlight: led-backlight: add devlink to
 supplier LEDs
Message-Id: <176244844196.1963389.1499748337381220684.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 17:00:41 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Mon, 19 May 2025 22:19:11 +0200, Luca Ceresoli wrote:
> led-backlight is a consumer of one or multiple LED class devices, but
> devlink is currently unable to create correct supplier-producer links when
> the supplier is a class device. It creates instead a link where the
> supplier is the parent of the expected device.
> 
> One consequence is that removal order is not correctly enforced.
> 
> [...]

Applied, thanks!

[1/1] backlight: led-backlight: add devlink to supplier LEDs
      commit: 67d8eed26eadb1edd4873d24889be26aa9b73fe5

--
Lee Jones [李琼斯]

