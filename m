Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438928;
	b=t6i1CQvtziQdH1isLbKmUup/eqaOhYMsKwWlLKlq8AkNJclf50yAHxOjAcCToO3zebCU
	 igvRWphyJjmZ368umZ/+/grffUYM23hqifJbLpGVnEKcDVuHhpsUn8/D0ufbV77ndRJqU
	 G1qVcGCmHMB4TLb8f5NCC4N/sY+4Bvb/Z9E8KBo0P60r1H4JbRQblh37uSxFjN3M4yF3b
	 gQlNAzYf8aWyOLdZnO21ESXpz2gJ286WSMutsvcCSM84zDc/iB+3pLnpAjykrUHcM7m8T
	 W7xbKbMY3WXXx0mW9KS8XmqJs1/WkgC6ec5sx2R1nCg5vKBWnt5COoMsTDgJtqfDV3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438928;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=TJ2A87nOClwrvrq6t2auqPCfNpbW4imX0mx2kNoeTLo=;
	b=tkLffA8+UYGTzka2lZnEPZhIlgbpkLN54SZufWuI0khbezKxfOjX5x6R1goCbuT2lwLA
	 Hx6fRwt3nsBlMK8bHFsNqwQIafFS9s1uc3FFHBTsbeDUEMJSKICCgH8c/D/OVdA7r7MM6
	 2hL4nWkdS/Y7Wra2xktj0L5Od0RUw5lrymsb4aSPlSiUKG3K3srojsKK834LkypbcjeaM
	 CWa+RxP3n7fn+eoS23+7VE9dcsiBnUDO35UxucS2W1bpve7eQ3nlrJrbZkm2b5MiqsaKI
	 nVGjwIA9+Pzv8k+JoMLHe7g9M5ZdEa/Ptmcalw/A4e70/vgNvXx/OeHEBUcYmcp+epA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn0X8FZZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234B606A31A;
	Mon, 23 Nov 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn0X8FZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C91F000C4;
	Mon, 23 Nov 2026 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438927;
	bh=TJ2A87nOClwrvrq6t2auqPCfNpbW4imX0mx2kNoeTLo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=hn0X8FZZh4Mjm5RDchkTDW5x555D25XzaKP3/VwujyCBP8DyWqtYBD3Ok7J5QyWr2
	 JghiuQAsOMq7eMwOIo6V8nmhWZ8CpE/rIWZGsEugUvi7oRcQ6KhLEBfgaWUq8J/Bqy
	 ZUt7tYli/3VI3AJR3mwWihDjG0Ng6kET74+L7U5Ule6hD1vJIvoFr8AGz12+sN8zn3
	 SfdIHoTmFZqeuTIEGHzw1iLq4FyD8iCLZ09bwdl8D1rYSB9U4paqEy3PL5pfADH7wM
	 l0CU5qNJlPQmTaZRJ0fFPsAls3Q61rABNf43CX+oI86jpuhPqs1Z7KJEIjJ5FC21Ak
	 xzpnS4XoUO6yg==
Message-ID: <a7ab0adec79adca2dba948c634f45d6c@kernel.org>
Date: Mon, 23 Nov 2026 13:02:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 07/25] drm/connector: Remove drmm_connector_hdmi_ini2()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-7-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-7-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>, "Hans
 Verkuil" <hverkuil@kernel.org>, "Helge Deller" <deller@gmx.de>, "Igor
 Paunovic" <royalnet026@gmail.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?Um9iaW4gUsOkYmVy?= <robin.raebi@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thierry Reding" <treding@nvidia.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list

On Sat, 14 Nov 2026 20:03:31 +0200, Cristian Ciocaltea wrote:
> All callers have been converted to the new drmm_connector_hdmi_init()
> signature, so drop the transitional drmm_connector_hdmi_init2() helper
> along with its declaration, EXPORT_SYMBOL() and kernel-doc.
>=20
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, R=
ock 5B
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
