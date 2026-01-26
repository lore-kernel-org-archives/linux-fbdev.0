Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A937335060;
	Mon, 26 Jan 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430480; cv=none; b=qusi6KuY6UHenRKzAZf5rzh0qyUpLz8HZvu7aTyGnbcNzdNzkRWOT6OUuzou0wAbAWJL3IZc90EyLTCTEcZTnKubwvLMLx1RQjo4cra4/XtQVHx4PvZUPE7/+SrDQ0RZACcnNqyMldb1kYvgtZ0bBW3Np+FDIotM/TvFfgyThDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430480; c=relaxed/simple;
	bh=31BvIU5fAtZYmY2o+PHO4IO3KgjSLJloMrHvxRhrjok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J30FZOqVg2r6YowPXD5VR4ntiDOYBVYP+9MFnLQ88B85oU3ees8r0MHSHcG+xfSced5V8TKl0H9bQsZtXzoWCHHOs4DmLDWudRt4Pijt+jBFgrbuKF0gDDePKhp8t85l8UoYLqo9whAoxNc9vCXRKiWEmvyh9erTwzGK/ay20Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=fESTUa/z; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="fESTUa/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769430462; x=1770035262; i=deller@gmx.de;
	bh=31BvIU5fAtZYmY2o+PHO4IO3KgjSLJloMrHvxRhrjok=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fESTUa/z5ZEQm747ibBX76G8ONgp6lD46tkVduPPQI6md/C+zoSiG3U1Oyaua1DK
	 xhV3ykXuaAbJs3l8ejvYV2Ou/iyISEuCdQqcAOhlRI0QRJsbzqJTNli0wrroz8ich
	 tPQRl5h8pq+ZQ/2tOZEiGYxO6LboNcCbI7nzKYpGXFt5fidXYMngWlEUlsdll8Iwk
	 LuB72YUi00Xmj43J+FMtcxo1G+E41HTsZS2rQm3dLA4EcshTmpD9jq3XsrJox+vtk
	 zRvE5JsgKpaw5B9IJhhZMSP0AY4lJqho4HxGcQuVs4r4iqgUsf1GGfWQvdgINrVk6
	 2qVTQq5QHzC9nvbX/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1vkLh00Dia-004Tp0; Mon, 26
 Jan 2026 13:27:42 +0100
Message-ID: <4c5dfd28-df86-41f3-8f73-57782c700004@gmx.de>
Date: Mon, 26 Jan 2026 13:27:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
To: Thomas Zimmermann <tzimmermann@suse.de>,
 pengfuyuan <pengfuyuan@kylinos.cn>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Hans de Goede <hansg@kernel.org>,
 Lee Jones <lee@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
 <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DLfaFJw+QU3qccW7Tp5Mtd89dzRL/wry16EsIXXwtpiEg73huaY
 wIkoXCDl+aPKQ+1xU/d7NHrxlLOXJd4je2a8kk+WTLYa5CdvHEPo4Hi2icfnDNyVVl6eM5f
 aCSBoKeyQIrDbH/ZnepoEh0gbguvHceVsVc0rfBh76OUh4HK7C+bz6LWKiSyrXmF15nKnrs
 zm/RKKNDKML9QgOfQ7X6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RJMhRxLHnxQ=;Cdy6myGdYaOGFMwSsl78eqRBJA9
 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
 Wsna7QSSTGIQ6Q/u796fiS6Qod1Qk0fSGjtHvO

On 1/26/26 11:01, Thomas Zimmermann wrote:
> Am 26.01.26 um 09:17 schrieb pengfuyuan:
>> This patch series adds Rust bindings and safe abstractions for the Linu=
x
>> framebuffer subsystem, enabling framebuffer drivers to be implemented i=
n Rust.
>=20
> The framebuffer subsystem is obsolete and has been deprecated for a
> decade. No new drivers accepted. Anything that really wants fbdev
> already has a driver. Can we please let it die?

Agreed. Adding rust bindings for fbdev doesn't make sense. Existing fbdev
drivers are often used on architectures, where rust isn't even available
(alpha, hppa, m68k, sh4, ..), so even the idea to "port" existing drivers
to rust is useless.

Helge
