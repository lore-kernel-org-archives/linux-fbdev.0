Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35A18C008;
	Wed,  9 Oct 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469355; cv=none; b=oWb777jo5whu5tMMywWwN/eW1hymtuLpM1Yu0vQhzG+JAReEvrykQYOlJgy5Rrmj0p2rx2KFTP+vJOF5JwPQLJn6aogpl+pY8JLskueBU6EwC+DAd9UQR5vEqlrce+zdY90XqWY66FeiM9Yh3A/Uj8GGblK6kDnh3AFzWanVQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469355; c=relaxed/simple;
	bh=VFcBkxZ4J3EDCbEzwJmVFvS5hoL2XFg812Ad/nKdu6M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsP1znGjQSw58HZcocT3MXxNHnSyxO/voALpdWlkILTAIcv9Eyl7sCl33Ac0oU4fbWsNwgyT3rzM0znWMftBcTjplp3AqDtHI5aOx8N7vSSgQMx4Xqev21RL4W/o5Pn8R1MYbV6Zdkx0Nxt4Vg+pUhFqiCIUcz3sHK46PFaJU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erm6bTvP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erm6bTvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04BBC4CEC5;
	Wed,  9 Oct 2024 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469355;
	bh=VFcBkxZ4J3EDCbEzwJmVFvS5hoL2XFg812Ad/nKdu6M=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=erm6bTvPLu+Jozq9xiK58EcfjyS+AmhhYmg7lUwo+0Yd8FF7osWGajOcNJQZ7Dk3Y
	 0269RxtC7FzXlF/79CyKQfz67PP0qABXyI4nI1qJXYrdCCzAYXcA/kacOLNQjBHCb9
	 e9IzEseQSiqSuMImoMQJGDnumS6c7o/kgEuFdolb51ORHiPqZFH/zfBrMVTifXRpC9
	 B2GyOBGG3RzElY+DxBPM0l8Lgd7W+E8NZK54M7vHT6fhI/AdafVN8bMR3dnO6JUmV6
	 Lfv9f/LaMtefr1DzdJ1aJn2sFushE/Q8NWmxhYH90owPj/ohA4s5DMaL8BVoG6s/HW
	 DIXDmdAh5LA3g==
Date: Wed, 9 Oct 2024 11:22:30 +0100
From: Lee Jones <lee@kernel.org>
To: linux@treblig.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	hdegoede@redhat.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: Remove notifier
Message-ID: <20241009102230.GC276481@google.com>
References: <20240919232758.639925-1-linux@treblig.org>
 <ZvKgo8RUImafDRPE@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvKgo8RUImafDRPE@phenom.ffwll.local>

On Tue, 24 Sep 2024, Simona Vetter wrote:

> On Fri, Sep 20, 2024 at 12:27:58AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > backlight_register_notifier and backlight_unregister_notifier have
> > been unused since
> >   commit 6cb634d0dc85 ("ACPI: video: Remove code to unregister acpi_video
> > backlight when a native backlight registers")
> > 
> > With those not being called, it means that the backlight_notifier
> > list is always empty.
> > 
> > Remove the functions, the list itself and the enum used in the
> > notifications.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> 
> I think Lee Jones or Daniel Thompson will pick this up.

I will pick this up with Daniel's review.

-- 
Lee Jones [李琼斯]
