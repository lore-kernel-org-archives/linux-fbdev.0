Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16333F787B
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jul 2026 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547792; cv=none; b=dfMd1lzRF0vnmXCFEGUFiZcOzzdnrVZg6KanyXl4VtOF1HdjElrOKxViParzHiw4iG+ZvDZIBhXFcUeCBgOY0JF9mVFcW938t0ZzWSji0xCG8luQCbSjGDsAuSxv6js/oeaEdZoV/VLGWYESQL6ES9JDMDUNts1/JeFAYcA5LEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547792; c=relaxed/simple;
	bh=btjBlfn1gEh32xkLC16toOwaofpK3E2AbdoJxAP/F/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvsSqL8ke/3CDGCikmOaqsT0dc9JJ/lnjsj1Id49zCK81iO7Y41mearxlgV7ndUtiZ+VXGyoads9u6Hbb4QYI6lvl527I/0tGuVhR3uTApOyy3vLnOk/xWDQa2d3mdppyqI4BBX1Wc1M5M5OPd4e00T/OcF/ITAzCUJv7ZkmO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOoddEpW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCNGK80Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOoddEpW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCNGK80Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783547789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btjBlfn1gEh32xkLC16toOwaofpK3E2AbdoJxAP/F/4=;
	b=JOoddEpW9Tb0/6eKbkj2lDDfo+YHD8u0RR9zx65OqXXdUtL4ETe5C5KMzULjE5CGGiuro+
	9/bS9aAvA5n3FQV2HfqKpg9pAYTdm+GPH+Junv03FCBEEqc3p82LNn98OEM2+kh4VFrUVJ
	NLHAWv9zXT+STJw9PWvFYGlUQY2hlU8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-dWcmzbD8PSy_9rSzt_icbQ-1; Wed, 08 Jul 2026 17:56:28 -0400
X-MC-Unique: dWcmzbD8PSy_9rSzt_icbQ-1
X-Mimecast-MFC-AGG-ID: dWcmzbD8PSy_9rSzt_icbQ_1783547788
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e63df032bso34792285a.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jul 2026 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783547788; x=1784152588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=btjBlfn1gEh32xkLC16toOwaofpK3E2AbdoJxAP/F/4=;
        b=dCNGK80Z37CZVB7Cs5E4oqPSmRHPVhpfT/yXieehof08Mm/yr1PClJeL4kswxWouuy
         eDoML5BR9MEYjFV1ggSN5tNATKSyEmpKf7OUn+znFu/oauuL25Oub1+KHHJ5QNFTAiO5
         uCsbEQAbTNOJAEldkFC4ugt+Kw5SHu+QFgtmxlEh92ndXN/EZqbHCHwlSpDM6xNslUEc
         9fPZEcVOBRvoRd17g2JdLJO0ga+YRwFB/z1X0xq8Zq024zn6sH4WOHTxmVtS/yhr/X0I
         ivJZZMMrkVd3VNUE7WIs6A1G8Qpj/lVOggmZs9V0RODe/F5WJbBK0TBWGKvF5xgtSPHw
         cggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547788; x=1784152588;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btjBlfn1gEh32xkLC16toOwaofpK3E2AbdoJxAP/F/4=;
        b=RTY+n1YQ7V74McuVKJlL5II5MryJ/DToVdcvaKA+ntYOq/EkIba0lYDXNzPLa8EkKl
         15Bz3klEKt6pjl5nm1cBZgQIaoA2pGcsmE6A+hKUkT3AaGi/WqRAPwIAXG3VUtACxC9Q
         qqi/PfgnBipVdVWTaH+ccl5pJKdU64aSLkZrI4S1DcxG7aBjLc1C7dvTkvM5y6hYu7MZ
         VimRltcQm9uwgV9LL09wovge0FOlFJ3WHixNq0s1fUX3H5pCdU8922rUt4u1B99tS46l
         5+umxD3bldYa96VFUOocgBRO3/ppiZl85eYEBw5VyIQT+0hLNdczl3H/FzmQqAMvHjaj
         aOqw==
X-Forwarded-Encrypted: i=1; AHgh+RoiGPJpbZ5edB+SnVmflXz9M7DI3afl4vVLg6yhe2l6tumCZa8tJ2veSN4P5/mCgSL7276uvvqp61jFzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnhnCC3Z0YaBF/tV+YV+SyK3SwF9Kg8gKJELIwjiSzbU4rVBy
	gDxveGUR2mou83z/CVbpgjE9MUG/PBqpf+VME9z6mlXuz3TQ5MyPkR89yPp9Hz3A/omT8Y/q+7m
	lfv4TvDVQUrPsp0ncldPBXNOOpFkJIuxXLlLjBX3r+O3yuzDWN2pYGZJoA0KGe3sv
X-Gm-Gg: AfdE7clB31qjEgiYaYr+UUPvD0xeHYMNL6UYK9tGEjIHJB6/T8zecrwL4wCT93HZvgn
	3yF1cs8xfFfYuIQFy4mxkxpfxjwuYwiASFprjcNSrbr3d5GxdeAtzYXAcDLfAiWvrnd8kGy5/5j
	K8DgTVXwyfFpa+6N/tBMGAS9+amiCOrjB195mszZoqRx00HGzcbNR2RBgmc9M3QiaQFxIML3New
	l5KNBGwc0UPWH6MvNOST8DgdVTiUNQdofgMSS6cdsHZ9EERR6nb2vfWDb3tBnKOHMbR7jhg7bR6
	RQX8KaddMuyN3QXh3utXALyFHcvdeWDUXyh+VRfbEBFIFMtdA7jF8WlaeVe69J2QBiehepTywlT
	BzAv7Icw=
X-Received: by 2002:a05:620a:444a:b0:911:e11e:dc0d with SMTP id af79cd13be357-92edac0d694mr13100985a.24.1783547788074;
        Wed, 08 Jul 2026 14:56:28 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:911:e11e:dc0d with SMTP id af79cd13be357-92edac0d694mr13096985a.24.1783547787628;
        Wed, 08 Jul 2026 14:56:27 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca90a5sm1483479985a.32.2026.07.08.14.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:56:26 -0700 (PDT)
Message-ID: <b6b58477af57eb25e28eefb1a979a65aa250dc45.camel@redhat.com>
Subject: Re: [PATCH 00/10] vga_switcheroo, drm: Push fbcon handling into DRM
 clients
From: lyude@redhat.com
To: Thomas Zimmermann <tzimmermann@suse.de>, lukas@wunner.de, 
	jfalempe@redhat.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, 	rodrigo.vivi@intel.com,
 tursulin@ursulin.net, dakr@kernel.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, sashiko-reviews@lists.linux.dev
Date: Wed, 08 Jul 2026 17:56:25 -0400
In-Reply-To: <20260707135724.247562-1-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

For both nouveau patches:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2026-07-07 at 15:38 +0200, Thomas Zimmermann wrote:
> Vga_switcheroo currently invokes fb_switch_outputs() to inform fbcon
> about switching of the physical outputs among framebuffer devices.
> But
> new DRM clients to not use fbdev/fbcon and might require their own
> vga_switcheroo support. Let's strictly separate them from each other.
>=20
> Remove fbdev/fbcon from vga_switcheroo. Introduce a pre_switch
> callback
> for vga_switcheroo clients to do the fbcon update. Allows for
> removing
> all direct interactions between vga_switcheroo and fbdev/fbcon.
>=20
> Also replace the existing reprobe hook with post_switch for symetry.
>=20
> At the same time, push the fbcon update into DRM's client for fbdev
> emulation. Do this with the new DRM client callback acquire_outputs,
> so that other clients can have their own handling of vga_switcheroo.
>=20
> There are only four drivers that support vga_switcheroo: amdgpu,
> radeon, i915 and nouveau. Update each of them with the new callbacks.
> When vga_switcheroo now invokes pre_switch, each DRM driver forwards
> to aquire_outputs and lets the DRM clients handle the new outputs.
>=20
> Tested with radeon on a notebook with Radeon HD 4225 and HD 5430.
>=20
> Thomas Zimmermann (10):
> =C2=A0 drm/edid: Include <linux/fb.h>
> =C2=A0 drm/client: Add acquire_outputs callback; implement for fbdev
> =C2=A0=C2=A0=C2=A0 emulation
> =C2=A0 vga_switcheroo: Add pre_switch callback to client ops
> =C2=A0 vga_switcheroo: Add post_switch callback to client ops
> =C2=A0 drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch
> =C2=A0 drm/i915: Implement vga_switcheroo_client_ops.pre_switch
> =C2=A0 drm/nouveau: Implement vga_switcheroo_client_ops.pre_switch
> =C2=A0 drm/nouveau: Implement vga_switcheroo_client_ops.post_switch
> =C2=A0 drm/radeon: Implement struct vga_switcheroo_client_ops.pre_switch
> =C2=A0 vga-switcheroo: Remove unused interfaces
>=20
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 9 ++++-
> =C2=A0drivers/gpu/drm/clients/drm_fbdev_client.c | 23 ++++++++----
> =C2=A0drivers/gpu/drm/drm_client_event.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 ++++++++++
> =C2=A0drivers/gpu/drm/drm_edid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/gpu/drm/i915/i915_switcheroo.c=C2=A0=C2=A0=C2=A0=C2=A0 | 11=
 +++++-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_vga.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 28 +++++++++------
> =C2=A0drivers/gpu/drm/radeon/radeon_device.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 ++++-
> =C2=A0drivers/gpu/vga/vga_switcheroo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++---------------
> --
> =C2=A0drivers/video/fbdev/core/fbcon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 -----
> =C2=A0include/drm/drm_client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++=
+++++
> =C2=A0include/drm/drm_client_event.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A0include/linux/vga_switcheroo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++++++++-------
> =C2=A012 files changed, 122 insertions(+), 73 deletions(-)
>=20
>=20
> base-commit: cd8abe2554ec7eba16c1d48ab508732bf93534eb

