Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1849B5B6
	for <linux-fbdev@vger.kernel.org>; Fri, 25 Sep 2026 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332991; cv=pass; b=aAr3M0eqaDAyqCytWraow+XHXPEAMvhEwinCFyPrF7WtuxYagHX3V1Qh0O7/rSWBgLZXXDmxs/y0ITGF9O472tgXsSejCmBfqstFQpYnOSLZDIJUoH6/bqMUnf0GKxwqI8lrJyMz/znjMOq+BiHwsvr/SuCelwXQoBxaRRGqg8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332991; c=relaxed/simple;
	bh=0jhBtxezo/BnEPs8cPVGYM+CZTI3dvgcBUXFhUlmG60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLhrjjCJMJVPD9OUCQwDacXaZERAs66pgOEEqtyHUwv6lqNsZHsyRZQJDBeGOciZla8DO7eHCj0pCZqZpOpb0Ya3bIl6Eqb7veHfeIwDKJwG749R2VMKp37lec+x+K4wVZjVI6c1O3f9x7uFRcjf8egAkzsfsu8GhYypL1Y352Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=CAe8qvdw; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="CAe8qvdw"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so467908a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Sep 2026 03:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790332988; cv=none;
        d=google.com; s=arc-20260327;
        b=V0i26V44j32TBJM6Oh9kV1lTdcMOqsrDcjQCmzqGO6uD5UPGmb+htFt34sTFao8Ucu
         qeDXWq/n1Vl29wXsoBTeFVxLIv7d6sndGRvHgSEzt8xaQI3H9vTnPZrC+ScalqB1jgco
         Ix3UlBul4QPaa8ky+izYgaZgxUWkwL02U7TwZw6x7azQGOnBluI+5xGqUniB+X4zsGgK
         QDgTYQyurAv6IJa0dMT2Sbj3gW2aC8PEdjDlp9Fj+cFnej3dBscVPwrBdGwwmetV2Se0
         zEfRSxxtK79Jrna5lsZp4niNk1SC0CbE9HQJGKH3IY0HfEwVP6Rh8uizrukyqo9ocpvf
         xRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BRpIuFoFTSYDMCEFJGiUusnifNbms8g6CYYPzdMnXGI=;
        fh=kVF6Ti2RyUAmDoLDJqNORmAUqtJ65n2iz06PgDrG+a4=;
        b=GgdR0wxOvKey5C7ybA/f8Fofc78h4N7J2942CyhgOa/toSKnDzSM5d3xKoyHh4YNyr
         OzS/8uOSNIdUFaiOHm9Q3qkASMnW9KmB3gaEg4nT1qcNElTJJyU70itgT/DcnTBfIXHT
         7+9Vhtu5SSCy07qi55644nLHRk47NEFl50lWJu0uLcmy0sYVrpu6RWVFQkjDO6j1jGQ2
         DzjW/yrOKz8Am/i3yAYsMV7RsjUHVRvOsLmcD9+dYYR0eEpP1BeXyc/TQPDj14TclCwj
         0qcx09Q4G0ObNLySHSqUj2azrSAOVl2sMVCCheqoQt8aJ+cLJfUNVEllRygD4uPASxI6
         kLVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1790332988; x=1790937788; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRpIuFoFTSYDMCEFJGiUusnifNbms8g6CYYPzdMnXGI=;
        b=CAe8qvdwdzWqIl8B+zTwTKPTXHI3B8qlX4wRv9GHGvAw6JAGZ8qiqkEqss+nXd9p17
         6oKTMoc/FaJPssk5tgVORNnk7wz3mnDICZlslwMGqiJfXRnJBxGfrw3wCXSPUaFZCr5N
         1P2MuGxaI+qc3USBlc0/Ur6pffC+KhBht5NqMdLuUsi9c7Jxn/ovQX8k9Rw+sOHiGMOV
         3D+x3N1O75s2Hi6En08OzX/CWdyutShl0inQNEFDMuZyxVMTNgSCYYnVm3q1An2cFxtq
         V3H1aQTC5m5l1703m/+tys8WF1iigtzh3dQkrIul8NUMVrucud08BjpuJVlFMxDmUdNs
         U5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790332988; x=1790937788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BRpIuFoFTSYDMCEFJGiUusnifNbms8g6CYYPzdMnXGI=;
        b=X0UxNS5Dp17a9BGuX1/xN/j/80v+ZIXzcZf8qf/fwH2CbQvLg3ctTywS5vLaHaljpX
         w/tSdEBDEeS/r71eFi7YKgcgf2W2lErXyj6miop8u/JNiY9ADF8vsVZs3ZqezDBdXOmU
         aGRn4bhWxV8tmPsTrmddbSqnxIKC6YbeY80pHL/C78HqtuRfOaf0TxNhkdkwVYhq9h8R
         VobeDhIRl9MMClnpclmH7bg4gu4/KIcr8mlaMzlQG/jsPnerzNgiGqYUuijAa74HIPmK
         F+e8iDE6CDtaFN8BNU+yo2nBvzRRt78JGYdMYPQvxywhokFHSRncwV0XZVMTnwimmnU2
         1wBw==
X-Forwarded-Encrypted: i=1; AKwUvBwpRGATE/wus7BmMAbA6wlsYK8WqkoMr0ZkRXgv1ocoVx+h0pgM/hTiHmSePPe0qEzuKT9XNMLVKfrdSA==@vger.kernel.org
X-Gm-Message-State: AFuF++kXPkStCJM3gru0JZn6aLibKMIE/5oP1qyVI/v1Gs6ap8ClwPhZ
	Ws4vnJ1sYVTIsjcJ4nIoGAZ1j6CzO5Rdgn/neW03+qv+pFfNYqQJ5jTosJ503GHkVPc4E4ho6yx
	MEs0Ei8ATIl52Rw5lp2QTHbxivjmQXSheXKK84i4BmQ==
X-Gm-Gg: AYBFou1pZqsjjZMlOPq13Mru/6JpAHNxohC8mKfnPBHKoJzTiwCGFRFopi0IyMAE/yi
	PdmMM6Em+Q2rxuC97yXWsNuC3f3R5Fyr5/S4jo7xR7+JgbgqVdafSiI8A2eZs6OansPWu6TPbAS
	gLYXT+xJmNvmcaQkOwE2dD+673+iY45Az86DSvnmNXaeKYSwqeJ/2h+PoiCOffmMw168sw9O+a3
	8nW/M05OlivnwxumlE6/7pHpSl9bQomFtyvmaUGDLa0jKTHB5BXqX4hPpky7MiIoKkhBf+YP+Af
	WSeKjKqw1nFCx62DzzdGbLFZFmqaegaiK6qSJNeHWAP4cxjJRPdX9RwV2Ot2+5qPpA==
X-Received: by 2002:a17:90b:3d46:b0:39d:f317:44cd with SMTP id
 98e67ed59e1d1-3a09860dff2mr4452158a91.14.1790332988129; Fri, 25 Sep 2026
 03:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com> <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
In-Reply-To: <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 25 Sep 2026 11:42:56 +0100
X-Gm-Features: AclHuK-I3v9LGdL8IGkTOXDiWq73AU-KwLgPcsiWlNH5IITVHFCCiS3M3P2Jw5E
Message-ID: <CAPj87rO2+oSA7KtocG-M1hqgQTJO=3Qxmg-OMC5MmOLaja_kRg@mail.gmail.com>
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, Leo Li <sunpeng.li@amd.com>, 
	Daniel Stone <daniels@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
	wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi Vidith,

On Fri, 25 Sept 2026 at 04:49, Vidith Madhu <vmadhu@nvidia.com> wrote:
> On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:
> > +     if (!crtc_state->vrr_enabled) {
> I don't think we should use the vrr_enabled CRTC property to determine
> VRR_EN in the VTEM EMP. Transitioning the VRR mode sink-side typically causes
> blanking, and it was discussed in patch [03/25] that drivers should be
> free to handle vrr_enabled changes as a seamless switch since it only
> concerns source-side VRR state (this is how the NVIDIA driver handles it).
> Maybe it would make sense to extend the qms_enabled connector property
> introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
> a standard path to control the VRR state on the sink, separately from
> vrr_enabled.

I remain cautious of putting this amount of policy inside the kernel
and/or left to individual IHV choices. It's relatively obvious for
NVIDIA and AMD to say 'we'll always enable FRL/VRR to smash the
maximum rate (unless it's contraindicated by USB-C bandwidth somehow)
because the power burn is inconsequential', but if you were MediaTek
or Rockchip you'd probably make a different decision. Then again, if
you were an MTK device living on AC power, maybe you'd make the same
decision. Or maybe AMD would want to make a different decision on
laptop parts because the bandwidth is noticeable then.

The point is that I don't think we should bury this down in implicit
kernel state. I'm with you on surfacing this as an explicit connector
property. Possibly a bitmask of modes the user will use? e.g. {
frr_only = 0, maybe_gaming_vrr = (1 << 0),  maybe_qms = (1 << 1), ...
}? Or perhaps just a flag for whether the link should be negotiated as
wide as possible or tight to the existing mode params?

Cheers,
Daniel
