Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A11836DD;
	Wed, 26 Jun 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417009; cv=none; b=U/K/XT/nnHo+6XQHijRug7gBncbgIViJK/NYs0st/rOIrxq1oxwz64+tZXjEOK/ZCZa28SXCaf1dFI98pmTXVCzzdGsSFm0Knmq2lZhn4bl4OAUHtMDgoflIo6f49RuzflUQsB472q7nu0ImQ1qV2qYfDxAP8hAZfqbCVH9DUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417009; c=relaxed/simple;
	bh=MpTrKsJUpc3vIWujjuh/gx4N6wsWK1H9HtIbFojUBqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FjqUaEvdOpgNvaCF4iWEJ2q3bxa8kcNXF2m8G7zVX7G0+V3SBOsrWzCijAuCiG0HbLFzZR+T32ujsfOKhMIqtbD8WWUPrJdppmpn0AEyJOWBsZoPB6jBY1UkYOQ4SyCJOy+KV7HzpeqK3wq1GJcwKVLsd0dxtlugJYCX25JC6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBreXn76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBreXn76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B98CC116B1;
	Wed, 26 Jun 2024 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417009;
	bh=MpTrKsJUpc3vIWujjuh/gx4N6wsWK1H9HtIbFojUBqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BBreXn76aoPBMO8gmGLsb8fv02MT/QD+Lg/K/mQ0q0IG/L1E+S71HO111ec2CEmT2
	 OPXYe0sxsNtkfwcwc3YjQ3NVrpCYbYxbRYV1vwAqu/TeqCRLslw1eNATLdr8mT1yoS
	 nqsaqspv4mQ0ZMOiFTOzyeQaJhw6RdTmqmVm79f9nu8IEsHtz4B4i/GIY8Ik9HFZ7p
	 A9i82eNNgBClHb9unPHpdrJbnAAn6Y6BtOMZ6CX2ni1A4IrIHZmzye4m/xotaOjnhJ
	 KmA39VtHg7mdSA75d/wbugzmQfHowwGVQ8biWs64vsb3MlXbN4TGyMNJF/Lpu/uS4B
	 iZif98AMGeLzQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20240624-lm3509_bl_scoped-v1-1-ceba9df38f23@gmail.com>
References: <20240624-lm3509_bl_scoped-v1-1-ceba9df38f23@gmail.com>
Subject: Re: (subset) [PATCH] backlight: lm3509_bl: Fix early returns in
 for_each_child_of_node()
Message-Id: <171941700713.2526873.6218687584902221299.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 16:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 24 Jun 2024 17:30:50 +0200, Javier Carrasco wrote:
> The for_each_child_of_node() macro automatically decrements the child
> refcount at the end of every iteration. On early exits, of_node_put()
> must be used to manually decrement the refcount and avoid memory leaks.
> 
> The scoped version of the macro accounts for such early breaks, fixing
> the early exits without the need for explicit calls to of_node_put().
> 
> [...]

Applied, thanks!

[1/1] backlight: lm3509_bl: Fix early returns in for_each_child_of_node()
      commit: b337cc3ce47549528fc3ee0b8c7ebd33348a3126

--
Lee Jones [李琼斯]

