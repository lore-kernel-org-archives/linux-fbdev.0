Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075F1A7ADD
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Sep 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187191; cv=none; b=kDU67ajkOspbQwQflyDhIyPcbBbu9HJRI9gpgO0yOpJCvrzJGOdFULxZU73vBqas1D68nXVvU8BGVXJUxSfYlGGZdFVl5c6YfLYQpDJygwrSA4x2Fsalf6ZXbJy9Brop2GXmrRsO9g4TEgCdf9FRyCDuBL2MtHkhCxoK7cGzUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187191; c=relaxed/simple;
	bh=Ove6qA9Uz/Pwc/8UDs6UkdWbzk3LrAkv03HZ9MpURmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZWl4vg0AuOQhcKJfKck/vyZKcNQ+kHrr3eyXNlNeKaS8IcoTGFjdHc2gIM8m/sk6dorkBtF7HH7n51RNsvp6W1RZcl3qHyqiRgPGdfhYIua9GC3S+ylpF83OdaZy79U8MLPnQpFytY0I7WAsRuqBZtJm8wvRiuJoeXxQBMxDGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1cCaQfz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1cCaQfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF6AC4CECD;
	Tue, 24 Sep 2024 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727187191;
	bh=Ove6qA9Uz/Pwc/8UDs6UkdWbzk3LrAkv03HZ9MpURmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=f1cCaQfzj9yf9Jls9lys+/W835C5/lgW/6mB3B8XUeucAH1QG1QnwuJXqdDXOQAt2
	 X01T00TkkFpL6HWFwgCCpx9tc0pHMOFMbNGuLm2EJAF73sord2VNArloQ+VexeGxtQ
	 bjNRuNv/F7YR8O4AlyZ6zb+I+GZsYEYbekDBqyRyvzvdpgS+j2iWxZzh/HD/48fWCI
	 pNzOAIrknk6a9yh6oudEvRkur8PakTWwMO1Vo2f9iED/mzGPaRUBAhnt5tNk4UTIvW
	 REOxQXeyu+91/qUCfzlh0HMlWFeRwvFIbh9sNWv3U/m4Id97AprvZgXIxdtb/Z8dis
	 9O2ep7fy6KLeg==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, 
 Derek Foreman <derek.foreman@collabora.com>
Cc: kernel@collabora.com, Jani Nikula <jani.nikula@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
In-Reply-To: <20240827163918.48160-1-derek.foreman@collabora.com>
References: <20240827163918.48160-1-derek.foreman@collabora.com>
Subject: Re: [PATCH v4] drm/connector: hdmi: Fix writing Dynamic Range
 Mastering infoframes
Message-Id: <172718718877.90582.18381097503447839347.b4-ty@kernel.org>
Date: Tue, 24 Sep 2024 16:13:08 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 27 Aug 2024 11:39:04 -0500, Derek Foreman wrote:
> The largest infoframe we create is the DRM (Dynamic Range Mastering)
> infoframe which is 26 bytes + a 4 byte header, for a total of 30
> bytes.
> 
> With HDMI_MAX_INFOFRAME_SIZE set to 29 bytes, as it is now, we
> allocate too little space to pack a DRM infoframe in
> write_device_infoframe(), leading to an ENOSPC return from
> hdmi_infoframe_pack(), and never calling the connector's
> write_infoframe() vfunc.
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime

