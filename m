Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E633C520;
	Wed, 29 Oct 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759857; cv=none; b=mceCAc+8jjjwtF2K2XBIZ0MLydERxNdgqHA53uTYtO4hrRbtOm7wvhL+net7jQ6lItAH9mVZw81Bzdl8TrgZhp6sJTtqN0fMLJVaMMAmJFaa3MPNRSKs66lcUSHl/bxRNWKpdVyfHZkTnCQQM0KE7RitC0BFI4Q71qjtlex730M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759857; c=relaxed/simple;
	bh=MFX7L/AI8JM0uO4N5k58xVcU7FqcMiBcizefUKUgzz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhypoYa9CmxkIYFJqCrDD5Sw5BHSMjyORZlxfMFGGAgjQFVjQFVyavGRyO4L95ssjbf921rXhr6ln8Bp+T8+ylGRH6oAK1KqkA3eXUzp6CKcPKVXhKe9tpJGD04b3brpBbOdEOyOipoAGi9ER0pXmOvs+GE/jdwJS5APhVfJj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNJC3HSu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNJC3HSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3798CC4CEF7;
	Wed, 29 Oct 2025 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759857;
	bh=MFX7L/AI8JM0uO4N5k58xVcU7FqcMiBcizefUKUgzz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNJC3HSuFqsitCic1quYkNQly3HBPAfIaRu2tJjyfsk6r6Sr/yfBkMh3mwR114OwK
	 eC6p1rE8dXwEAbr3Ft/sYyjg1nR+eTwkeNVwlo6jAB5/SvKyUboTW9f1YIXIJ0eoEx
	 QjJ3fnPAW3tIv1HHlw+grkirs2ocSSf3HSfL/noxHLOj4MQnT5ozy30+GFtUjyvmhI
	 6uEsq491dCQ6o52rEuwviY9Pu0wWX8kT+alGypvU4xPDdQBGSRmgDH6p1LU0jAHyxb
	 HvK59t4JqRx54FGEb7AI58k5JxDtDBBvdkzbkGVT42IKAxV5OiLJhev8QXqcr0TfiP
	 OPEFEXpRjAHng==
Date: Wed, 29 Oct 2025 17:45:12 +0000
From: Daniel Thompson <danielt@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
	"lee@kernel.org" <lee@kernel.org>,
	"luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>,
	"tony@atomide.com" <tony@atomide.com>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "deller@gmx.de" <deller@gmx.de>,
	"jjhiblot@ti.com" <jjhiblot@ti.com>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"saravanak@google.com" <saravanak@google.com>,
	"herve.codina@bootlin.com" <herve.codina@bootlin.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"alexander.sverdlin@gmail.com" <alexander.sverdlin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v6] backlight: led-backlight: add devlink to supplier LEDs
Message-ID: <aQJSqJOrtETMKt8x@aspen.lan>
References: <20250519-led-backlight-add-devlink-to-supplier-class-device-v6-1-845224aeb2ce@bootlin.com>
 <6e6039c815c7125e35b43ca2f8d32a0fa3103fea.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6039c815c7125e35b43ca2f8d32a0fa3103fea.camel@siemens.com>

On Thu, Oct 23, 2025 at 12:41:30PM +0000, Sverdlin, Alexander wrote:
> Hi Lee, Daniel, Jingoo,
>
> On Mon, 2025-05-19 at 22:19 +0200, Luca Ceresoli wrote:
> > led-backlight is a consumer of one or multiple LED class devices, but
> > devlink is currently unable to create correct supplier-producer links when
> > the supplier is a class device. It creates instead a link where the
> > supplier is the parent of the expected device.
> > <snip>
> > Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
>
> I've noticed that the patch in archived in the patchwork [1] but I wasn't
> able to find it in any branch of the backlight tree [2].
>
> Could it be that the patch somehow slipped through?
> It does solve a real-world crash, could you please consider to apply it?

Sorry folks. I overlooked this in my backlog and never posted the R-b
(which helps Lee figure out what to hoover up).

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
