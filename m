Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99916D332;
	Fri, 30 Aug 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006347; cv=none; b=fMuprCTvR2ppPb4LwW0GHy9exk0/wvkNkaeewK1FVmbGmVPMBXfI0Tbj0tTAEjzHweWoQIwXMT2LaX6PIWr4Yx6PX7IHIh8jLW3xcGxMPGIGGSSBcWr6mak2ipDf2riFDNdy9es4WF1p7Xy9urpctOSVhuC4uRmPpr4mgvFLlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006347; c=relaxed/simple;
	bh=pNKIxLJE4wGsG4I7ubN5qge1eo8HE1IiZV9n0njwfow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B7lgaKvSvPaS3PxpUh5SZmHOj6ttFy0zzW1JOsCxCXDfPom3vpK7FqBpgCr7AIpk6VjGnRDeNv9lSCzybohqyLShOy737zVxZiBgQ5OpcOuXuRUjmaue6dsS0vUHTi+J9TrHNqbDPl+DYSNMPTfXqaKaVixcSKgkH4C8tk8GpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=whEbelLn; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="whEbelLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725006337; x=1725611137; i=spasswolf@web.de;
	bh=rLZNMuyCRmqs3FEvJHEFsz3u3ucAr75iaGC9Dy8BKeY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=whEbelLn2hSjnnNyiLpL6mMP+Pfx+JUh+Ua86RAIqke+k0qqMtWExoU0KKq5b487
	 Lr9Ta9HV61FfvtZjldD9t9M0lNuEZtmplfRDholm6BSPQu9lP/cg+QRUHae2ygfGl
	 6SeRT4kyVHnSRs98oXEW4z8y7QxiWQYe5sEYzzWAfmfSBZlPaU7LQoH8C2quFKEH1
	 /udxZ9qd17KKtmgWoAXOz1MDxepSvRQzbrD+hnHoilye36ufj5Cjzi8VyH35+ZH0J
	 qOftVbHG5lXhXgsBnGnGmqMewvKEM+TXXJ8nswhvHY32IWgtNFtdB4zpdbD+f1Fmo
	 WnN9tC1H536uQ4K96g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkElZ-1sLNqS2vqz-00qZcc; Fri, 30
 Aug 2024 10:25:37 +0200
Message-ID: <7fec4df2e44ea2b11ac617d1a4ed5cbb49214f7b.camel@web.de>
Subject: Re: [PATCH 3/5] fbdev: Introduce devm_register_framebuffer()
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Helge Deller
	 <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, Peter Jones
	 <pjones@redhat.com>, spasswolf@web.de
Date: Fri, 30 Aug 2024 10:25:37 +0200
In-Reply-To: <8b52669c-4c99-45e2-8b5e-9348e5e00f70@t-8ch.de>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
	 <20240827-efifb-sysfs-v1-3-c9cc3e052180@weissschuh.net>
	 <8b52669c-4c99-45e2-8b5e-9348e5e00f70@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FdI8o/2YrKjm68Lbh/q8MiS51hHZaxjW9Zbi2U4FBolgcbKulo
 LONFJnjTZHwQfC2kKD3MMzfPdlK50LqMksqoWPGQ3LKkuRRN9fHuLljGNOIAK/kX1pBkvK3
 NXEI1REb/ggvBmb3OCFLWdLoS9Bdc3y38EdmCG5RYlbRPY/tdVTfxxkr3MS+iLRkMe+zns5
 FH0LgYlG2BWUjo/b3uNGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CfBl2Kn8HZs=;9YkQpnR9CawyvMWZMzuLGWuBe1i
 dWwspHZi2hyg5I/AuGkBGWx57cItlhKEn4kkbOgkESzt5PxSsFyHZkIlsOg81QZ5dNur9NBXs
 GWNtf0MJ5mIm51K6e0/8u+6gCeNMOdoe6XL/oWfZTvO1BTDYv9fVzpql92t/np/JmUCiK0cSa
 jxE4vYaE+EbL2apwHWkGVKonGJvHzgD17YOnpZglIehkZAvkRULSHWJ9fu1hdUbuQqx0SC9vb
 RrHN2BVwZrau6MLfPADF1bETfGKmOI53omyyRqEeeNCgW+0cOYLp5ohJ9MstP1NrXCEkNEoL2
 j9Cq/4ApwdkDxU1YlDrhl9Z6wfczB/EzMlxR7DCRTLnT3Kuvelll+HdxJiHr6oVkvhxh0JQ/5
 ewKpyqcAIzUAMjFTd2EegfwcrFUETtc//MElGX52WXGzvS3BNhsdDeGaIyJi62hAX+DdhFP9h
 2jODfnB+N0ual2+sZghuXBMKy8aOiiyResJGMVhd+ugC//P4Aa7UfxQT41RoxncEoahtwAJ4P
 yQiHzFqud04yk8IaaqTRtOiwyoAxlZgS4rOQgsBUZby6OXzgW+qmEhOP3+qdqt5Ok3AYI9jpE
 fIDMjLBqFMlNXQOT63igWy19DS81/u8D/t8lfhHztjY/m3uCH9nv3o4pS7qj18hMh1EiNtUDE
 kHyFC9t/V1DTwnxjKgGmGtkoPg6Pahy7UWts5FE8kIc9aOluRyzrUz5mKnWSsSyB7s1ZRDzDF
 ZwCUMXxbAU3AXaNUXUZzQrplbmy/AIu3ODwePPOtHvzs1Kisk96GNvM7+LMcg2q8JENDJQgfL
 vFCx4rerxIl3+S2J5O9hKWCw==

Am Freitag, dem 30.08.2024 um 09:17 +0200 schrieb Thomas Wei=C3=9Fschuh:
> Hi everybody,
>
> On 2024-08-27 17:25:14+0000, Thomas Wei=C3=9Fschuh wrote:
> > Introduce a device-managed variant of register_framebuffer() which
> > automatically unregisters the framebuffer on device destruction.
> > This can simplify the error handling and resource management in driver=
s.
>
> Bert reported that this series broke his framebuffer ([0], [1]).
>
> [0] https://lore.kernel.org/lkml/20240829224124.2978-1-spasswolf@web.de/
> [1] https://lore.kernel.org/lkml/20240829230438.3226-1-spasswolf@web.de/
>
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> >  drivers/video/fbdev/core/fbmem.c | 24 ++++++++++++++++++++++++
> >  include/linux/fb.h               |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/co=
re/fbmem.c
> > index 4c4ad0a86a50..d17a2daa2483 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -544,6 +544,30 @@ unregister_framebuffer(struct fb_info *fb_info)
>
> [..]
>
> > +/**
> > + *	devm_register_framebuffer - resource-managed frame buffer device r=
egistration
> > + *	@dev: device the framebuffer belongs to
> > + *	@fb_info: frame buffer info structure
> > + *
> > + *	Registers a frame buffer device @fb_info to device @dev.
> > + *
> > + *	Returns negative errno on error, or zero for success.
> > + *
> > + */
> > +int
> > +devm_register_framebuffer(struct device *dev, struct fb_info *fb_info=
)
> > +{
> > +	return devm_add_action_or_reset(dev, devm_unregister_framebuffer, fb=
_info);
> > +}
> > +EXPORT_SYMBOL(devm_register_framebuffer);
>
> This implementation is wrong, it never actually registers the
> framebuffer. It should look like this:
>
> int
> devm_register_framebuffer(struct device *dev, struct fb_info *fb_info)
> {
> 	int ret;
>
> 	ret =3D register_framebuffer(fb_info);
> 	if (ret)
> 		return ret;
>
> 	return devm_add_action_or_reset(dev, devm_unregister_framebuffer, fb_in=
fo);
> }
> EXPORT_SYMBOL(devm_register_framebuffer);
>
> Bert, could you test this?
> Helge, do you want me to resend the series, minus the original patch 1?

Yes, this works for me. Thanks!

Bert Karwatzki

