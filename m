Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9771A0BDB
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Feb 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912729; cv=none; b=W2IU6ewoaBhY9F+4R/Iw4XxKTMT6OYiIV4x6bKP9FYnPItlenEorWzK8CXoP0wtG6C/pDx7kSO4/3y2BFKXBcIPLO7OLFEkzM9JHE48BDzikgp3veJ98ziqT9jHfbS8c84iYQEr0iwNglpHFbvdUiHdFLOhiBR3YRev40zRJfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912729; c=relaxed/simple;
	bh=yo8pv27BYKDIj+lQ7iObwDt9zAHiAsnLZv4UZd/tdXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OTSzv+Yl/1G4wMfznzJrcjrFR/gzXZ1YeZ+Jw6AZrTwKcbFprnhzqJJ798De5H7EiVaMRjdoXRvzB1HnThhguq6trqlaTSqlNFFVipZvKBUPj+4aCd/l0EEewBV1+f7fGA9sTfmXUKPIvLB51ikLx305OXWDB+KBCyqCIXHgPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=L7GtF5IP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="L7GtF5IP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738912717; x=1739517517; i=deller@gmx.de;
	bh=kAKZCo3esVGnp3evNk4iZUTTO8n3Hjp4Ic3UjHG0NBY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L7GtF5IPIgxRo6LO5lQQhjimTsBwHPComxfcbLTEGtK35ZUomVLb1tASVW1Jj61J
	 iLpzCJQTvLmqDE4u5G3DZjEoWKPynvFKPWLcmbyJPzv//c/nzzv/u02k2+XhqAYUM
	 96n2ephP23DmoJkyFB0YuahmKkXTKpUKwvY8RIOX4EMVMBroD6Uvca0bFb2eGYClO
	 XvOjN9ncW0wt7wA4W5hyYV6TujhtxTCHdqu7fAU/gTVuCZExbKgiO0dTWkMc/qvwF
	 cFOaey1ZoixsMwrt3yfNsQWYsHm5z7AphDj6fjygGe3WOB7G57Dtrt9fWvmcSY23V
	 DrZ8A2LCu8WE75xIlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1tsgxf39l9-00U6ee; Fri, 07
 Feb 2025 08:18:36 +0100
Message-ID: <9c5c609e-04f5-4fe0-86ad-107559f14140@gmx.de>
Date: Fri, 7 Feb 2025 08:18:35 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/13] fbdev: core: Deduplicate cfb/sys drawing
 fbops
To: Zsolt Kajtar <soci@c64.rulez.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250207041818.4031-1-soci@c64.rulez.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250207041818.4031-1-soci@c64.rulez.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K9ek2KXy2tESx8+HLfP1xN97i42Tu+rQIYGrapn9rJZtOBsY9FS
 vY41UZOKtTzE9fiqeHCRvBpZuoX8sHLMOXhA6DADbQ/RSz/5kj0XfxaXn4Fd9In0cWZShFd
 nbDP65w0R9o17lbrDIeByvYgf5R4pdMgl6Lqy4OxCBPSzqegQgLs8OPsdaW0LNwCuNRE0RD
 vla3bp+KpCCKcwErBMRBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BQGy8F0VMTg=;jMdwWXKnNfRvjgd2OuDPuaWexse
 nzOMyB3m5kEpXqqpjNmciLKIEB4Kk6I6rg4hiOcCgCNQLMLm51Yl6KaPApQAlEHGvP4FkMUg3
 aqPzbA5MnpNl8o1F+yZAWXX5qU+1etziDWIJtepWRN0IxDCF5esnxgkZsUsojjaW8cnEQ9PjC
 Ltf2OnHGmuhAh8JbT9n1rjIK2ZFR3fI+sELcgSrC89RNvNVQk2OEmeP6rBDUvvDlue+4AXuM3
 mVc2tQKtFsFVmy2FkW5LhAST2A60+wqtsBa71ACEfJ3Jy7WMB0zFiejrkdjDAZN7TAfsl47f8
 arjuH169OLuayLLJqvwo/CC3OI4G6GRE1IWBwFSak+DNenKKEOdZ0nOCZ+KkbptbchkpDJSGY
 /YxNOLXFT1e0UdhA+0qgUgqXsuQOxvXpOOfVF4Yxc5PctMTl5KSkN5ulbwdkIVzQJIMeZx8Xl
 NNWq86dRO4+Lo5Id0VL/uvA8DF7p0g+rVW40GNkFZKKlANz1Y1YFxZQyTpODCzfjXrkkvdh34
 kEccNQMXUp0+wQEPj280/Mcq6k0G6lonrahdgQBeHnOmjOMsiz2stPTgB9ZalZndWDpeh5TP4
 Q6JjzoogIdBPQ8BKHbe89jiLrrnAwr0xBD7Pg7MN+8XDUQydo74aPLyLre/FM/vXXDU1iGHTo
 tx22BPVhhBqwJkEatB0KbB0Lg9tZyRrtRzyGQIHMkn49MRfrn1j7L59FfUJ0eLDxzoPWgSgZQ
 KHNQWktdSvjVj7GbzJ7hrLIuBFVjTVkReJc7qh/hFN87/u2f3r/h0PMLM27OiDuDOuGLX8/um
 +PD5zW7R+3D1PUdGyVxT1ntuKLNiH2j1L0zWp6A6fPkl/Q4rk36WMIBuBJbyFjQVOJ+08vwhZ
 Iui7caxNjpicTk8EhrUJZb55MYoAguAeTc6lH6iyGR9UWYyUfy0TpxIELd8jj+fEcfd9onTRl
 pToE8xIHxKut09nNJndgkjR84Dfg1pvfunFLlEHY9OqRPCivxqkL+sUyXK8ytG4ukFstU4zR5
 2W+65GgaB/V5sqm8P90/xOl5/rmekybMbF3yN/rK0Amw9dPZ2gYNEZezZe9qcd40kfNuOVqcz
 K7Iy//GtU2riUZnHDSvgXq/O1kvLfirSLgLmxJFGysFgD43IHFjcW3nQpaqYlHetrAQdeDxf4
 7aycJmKlfc5eBkGJ0yT0/lSta6mNQclQDy4gb5amh7VVXBAzC/50Nkvd2g4CX7ClIE/UQLwaZ
 6izQhOEtN/IValZ6LzLzFN6MGre0TsNHuxUF7FUMeOtsNiWo/crHL+QYYuOoha8SHj2v6d4my
 z8nLO+kQ61edLNzvvy3gDLuFwo/3K9Z35BrDwtaoOFQ2zbPU3aJhPPHiZ6EKqhV2j9ODnD8o4
 JykRNy3jm0bXqJ5W7i2HEwyQyhgrui0anKjyPCEx5S0ZFDguPtaJniVtlK

On 2/7/25 05:18, Zsolt Kajtar wrote:
> In 68648ed1f58d98b8e8d994022e5e25331fbfe42a the drawing routines were
> duplicated to have separate I/O and system memory versions.
>
> Later the pixel reversing in 779121e9f17525769c04a00475fd85600c8c04eb
> was only added to the I/O version and not to system.
>
> That's unfortunate as reversing is not something only applicable for
> I/O memory and I happen to need both I/O and system version now.
>
> One option is to bring the system version up to date, but from the
> maintenance perspective it's better to not have two versions in the
> first place.
>
> The drawing routines (based on the cfb version) were moved to header
> files. These are now included in both cfb and sys modules. The memory
> access and other minor differences were handled with a few macros.
>
> The last patch adds a separate config option for the system version.
>
> Zsolt Kajtar (13):
>    fbdev: core: Copy cfbcopyarea to fb_copyarea
>    fbdev: core: Make fb_copyarea generic
>    fbdev: core: Use generic copyarea for as cfb_copyarea
>    fbdev: core: Use generic copyarea for as sys_copyarea
>    fbdev: core: Copy cfbfillrect to fb_fillrect
>    fbdev: core: Make fb_fillrect generic
>    fbdev: core: Use generic fillrect for as cfb_fillrect
>    fbdev: core: Use generic fillrect for as sys_fillrect
>    fbdev: core: Copy cfbimgblt to fb_imageblit
>    fbdev: core: Make fb_imageblit generic
>    fbdev: core: Use generic imageblit for as cfb_imageblit
>    fbdev: core: Use generic imageblit for as sys_imageblit
>    fbdev: core: Split CFB and SYS pixel reversing configuration
>
>   drivers/video/fbdev/core/Kconfig        |  10 +-
>   drivers/video/fbdev/core/cfbcopyarea.c  | 427 +-----------------------
>   drivers/video/fbdev/core/cfbfillrect.c  | 363 +-------------------
>   drivers/video/fbdev/core/cfbimgblt.c    | 358 +-------------------
>   drivers/video/fbdev/core/fb_copyarea.h  | 421 +++++++++++++++++++++++
>   drivers/video/fbdev/core/fb_draw.h      |   6 +-
>   drivers/video/fbdev/core/fb_fillrect.h  | 359 ++++++++++++++++++++
>   drivers/video/fbdev/core/fb_imageblit.h | 356 ++++++++++++++++++++
>   drivers/video/fbdev/core/syscopyarea.c  | 358 +-------------------
>   drivers/video/fbdev/core/sysfillrect.c  | 315 +----------------
>   drivers/video/fbdev/core/sysimgblt.c    | 326 +-----------------
>   11 files changed, 1208 insertions(+), 2091 deletions(-)
>   create mode 100644 drivers/video/fbdev/core/fb_copyarea.h
>   create mode 100644 drivers/video/fbdev/core/fb_fillrect.h
>   create mode 100644 drivers/video/fbdev/core/fb_imageblit.h

It's a bigger change.
I've applied the series to the fbdev for-next git tree to give
it some compile- and runtime testing.

Helge
