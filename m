Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D831ED80
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181890; cv=none; b=ME7bzqNTJWRrEVhNSO2oxdWCx/f+Qka/28rALKF1mZoG9w1Er3pV6Qw10iWMZIU4aajnwKyX8+srcYRKqECZA5ELaL4r8d7fKNiG+Q1+KimXXdfsgyU23LXuG9KvwjRDyDY+aLVT0OcTBB5h5m8dRmieJFcr85aRaX1E7Cw4v2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181890; c=relaxed/simple;
	bh=GA/ws2LYv6piWac5ud42DGFv9hbkBVI/O7uf0WPkcHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sir5dDSz1E16xzyiwaTMB7FdP4doVU9yDdodzr2NnG9baKmKxuIp+bGIRZMvrn4u2WC/b8eR98ovJKluE5YcTHYmB2fSkwOz9f6PhbvxIeFFLYVXVIvS+CVD2GAN+QEpHXKeFnkx9aYG/QMLzFEbSkOdo/S/E+QkAWMRaTQEjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8pO5iWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8pO5iWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CACCC2BCC6;
	Tue, 19 May 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181889;
	bh=GA/ws2LYv6piWac5ud42DGFv9hbkBVI/O7uf0WPkcHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8pO5iWXD7wstIaOm88fc3dpYMmginT3MjYyVFjpzR0bthityzXSo6FXg/NY5f5Fy
	 18+YpnLIUeJh9n2F8ncJGMuK8X5ZyjTnxBRPJtN2MZNDTbfwQ7jqu/Fr1s1kRHkUMl
	 A+p3BCbRqc4GC2i3zOlDF8ji+Jjk8ZjZuVv/6cE+QOPnR29kwmFrcd/2S5UJ+ijVjQ
	 AKLwSeHntG+7nbkr/YFHefC3/Q29CkZq7oKA2i1bmHQmrJdWJ3cHMfXgsHc7h+OwKW
	 d8ej1Ut3ugQHcznZqEzDNy1zm/TqjFFkbs5Cojq0V9fD7MHaze6dwAnxoCRXVNYPGC
	 w/5+M9GTHVqUg==
Date: Tue, 19 May 2026 11:11:24 +0200
From: Helge Deller <deller@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: mach-rpc: fix zImage build after recent
 font-related changes
Message-ID: <agwpPFGkN3zHKdCj@carbonx1>
References: <20260510023941.190396-1-enelsonmoore@gmail.com>
 <d0bb399f-1285-495b-babe-8bae608729e8@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bb399f-1285-495b-babe-8bae608729e8@gmx.de>

* Helge Deller <deller@gmx.de>:
> On 5/10/26 04:39, Ethan Nelson-Moore wrote:
> > The text display code used in the Risc PC kernel image decompression
> > code uses arch/arm/boot/compressed/font.c, which includes
> > lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
> > 
> > Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
> > glyph pitch and size") <linux/font.h> contains inline functions that
> > require __do_div64, which is not linked into the ARM kernel
> > decompressor. This makes Risc PC zImages fail to build.
> > 
> > Resolve this issue in the least intrusive way possible by preventing
> > the inclusion of <linux/font.h> (and the definition of a struct that
> > relies on it) when the decompressor is being built.
> 
> I don't think we really require 64-bit integer support/division in the
> font code, as 32-bit should be sufficient.
> Can't you try to find out where this 64-bit division is done, and fix
> this instead?

Ethan, does this compile-only-tested patch fix the issue?
Maybe only the first hunk is necessary.

Helge


diff --git a/include/linux/font.h b/include/linux/font.h
index 6845f02d739a..c8f3d6ef54c8 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -35,7 +35,7 @@ struct console_font;
  */
 static inline unsigned int font_glyph_pitch(unsigned int width)
 {
-	return DIV_ROUND_UP(width, 8);
+	return (width + 7) >> 3;
 }
 
 /**
diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index f5d5333450a0..5bd7af5f2111 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -71,24 +71,24 @@ static void font_data_free(font_data_t *fd)
 font_data_t *font_data_import(const struct console_font *font, unsigned int vpitch,
 			      u32 (*calc_csum)(u32, const void *, size_t))
 {
-	unsigned int pitch = console_font_pitch(font);
-	unsigned int h = font->height;
-	unsigned int charcount = font->charcount;
+	uint8_t pitch = console_font_pitch(font);
+	uint8_t h = font->height;
+	uint16_t charcount = font->charcount;
 	const unsigned char *data = font->data;
 	u32 csum = 0;
 	struct font_data *font_data;
-	int size, alloc_size;
+	unsigned long size, alloc_size;
 	unsigned int i;
 	font_data_t *fd;
 
-	/* Check for integer overflow in font-size calculation */
-	if (check_mul_overflow(h, pitch, &size) ||
-	    check_mul_overflow(size, charcount, &size))
+	/* size-check user provided font values */
+	if ((pitch != console_font_pitch(font)) ||
+	    (h != font->height) ||
+	    (charcount != font->charcount))
 		return ERR_PTR(-EINVAL);
 
-	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(sizeof(*font_data), size, &alloc_size))
-		return ERR_PTR(-EINVAL);
+	size = h * pitch;
+	alloc_size = size + sizeof(*font_data);
 
 	font_data = kmalloc(alloc_size, GFP_USER);
 	if (!font_data)
