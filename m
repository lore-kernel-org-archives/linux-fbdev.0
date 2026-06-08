Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D437F019
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950374; cv=none; b=iQUuw4yCh/P+md1ant+cBDD5kbQjPCRTtmcP/cxSx9IPuksP5o72epU3fCkFkQCIFOzXHQyPb081GQDjBZ5PCiCNY8338/fUdl5AFGj/IDi+QIi/gFb4601ddcK4SiXWvvWSk33GalulBJWpH4AeRFqp53gzzw+Lolw3jDhYgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950374; c=relaxed/simple;
	bh=usY3JkZcI6otiNtVBFPivDIypxFYx8fvoLMHXfBpkIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS/u/6RvN5lMEHtX6bcRs5HmMZE9Xf6DRgUS2EhoYMh9sL4Gn9BidDaSMRrjLCS4Z6HaokYp9n1xVCYaAxs8dzeY9jf9I+zmIwCSekBajx2+2SIoqGAbgTVJiv+XiEpPkxTyIxSg7WxLfZ+YSlqVEeHc3xYo8WXPp0TbElFoyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/EqL3Jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/EqL3Jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C936A1F00893;
	Mon,  8 Jun 2026 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950373;
	bh=rRsm1N2Zeki1YKmV16kRz5ZHI24Uv1SVyHcMj3z0AfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V/EqL3Jmckht0FSRjp+qMmL6bg3fdSaiXFtr9YlRkkUGsLlb1vXOFiMjpUph7hEib
	 zsYHIcHJ9Kt+r0X2vfvXfhkIe4MQD0r5AzBYwudxQu8YjTFBwyRDQDRBAY+4IGxX8X
	 5DbyamWT4ca8z80osALum0iUjuXjV9tCeoEmzuDqG4ab7G/NKWySfvmh67vnMI5PQC
	 jh8dl0dMGnC76SmbkQauDP7CslECL97tLA9QUgGJUo5u6tnYBSDDkLey5FT4vU9Xfi
	 gZ9OqbBFov+GuzCNeH/B1HBDdbdOFmlEz+IiVUV71jjesI5m0FSuY6Bkt2pqvoTaL1
	 20HSKAKUx46Jg==
Date: Mon, 8 Jun 2026 22:26:09 +0200
From: Helge Deller <deller@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
Message-ID: <aiclYUfQvMokMu64@carbonx1>
References: <20260607210203.229613-1-deller@gmx.de>
 <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
 <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
 <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>

* Ethan Nelson-Moore <enelsonmoore@gmail.com>:
> Hi, Helge and Thomas,
> 
> On Mon, Jun 8, 2026 at 12:58 PM Helge Deller <deller@gmx.de> wrote:
> >
> > On 6/8/26 13:25, Thomas Zimmermann wrote:
> > > Why is there a 64-bit division at all?
> >
> > Not sure. Might be platform specific.
> > Maybe, because you add two integers and divide by an integer, that the
> > compiler then chooses to use 64-bit integer division by 32-bit integer.
> 
> Actually, I think the real issue is that
> arch/arm/boot/compressed/Makefile defines "static" to nothing when
> compiling its copy of lib/fonts/font_acorn_8x8.c (via font.c), so that
> the font array is available outside of the object file. I assume that
> this causes various unused static inline functions in the headers it
> includes (such as <linux/math.h>) to be included in the object file
> because they become normal inline functions.

Does this patch fix the issue then?

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index a159120d1e42..e3f550d62857 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -157,4 +157,4 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
 
 $(obj)/piggy.o: $(obj)/piggy_data
 
-CFLAGS_font.o := -Dstatic=
+CFLAGS_font.o := -DBOOTLOADER
diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index 36c51016769d..3327aa6d161d 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -5,7 +5,11 @@
 
 #define FONTDATAMAX 2048
 
+#ifndef BOOTLOADER
 static const struct font_data acorndata_8x8 = {
+#else
+const struct font_data acorndata_8x8 = {
+#endif
 { 0, 0, FONTDATAMAX, 0 }, {
 /* 00 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* ^@ */
 /* 01 */  0x7e, 0x81, 0xa5, 0x81, 0xbd, 0x99, 0x81, 0x7e, /* ^A */
