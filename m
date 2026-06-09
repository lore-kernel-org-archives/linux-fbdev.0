Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254243E4C65
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Jun 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998413; cv=none; b=lsTpPJjscoRrGuebAbRvjnQIQCIM+CKRLUBfJm2CeygDNhAJHYir2hrT0ZApdFcro9YkQTa95+I7B7/AH9Zb+MqRqO9JwDaOT2IZgDwK+etfDO4VU+JIJHxkQRcRNQ3lMwno1M1x5T0wa49GqcuDaWoA+hbLjZ45TeIueE86+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998413; c=relaxed/simple;
	bh=Rp19KIZdUM1rr0kh821Erp7s6nMUXWudrN8faOH1ZuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBaJtU00RkVBIwXp3/AhYu92m5DZyRfBM7D6vXlxegpNWq4lTe/rLKGwwxqAwfAuTbE7DcLI3qzRjJDPbu6FUUDtCdO0jFk5K59YonRKK9F5oUroPAg0TCqTv96qvZez63km09IUicKRVw+6uqYcpXtYlVe4QNspld5acLakU0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rI2a0MbT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rI2a0MbT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sw1opRUXcAw/1NhWQ+DjHthGw6A5mSCQCWdmv0WppA8=; b=rI2a0MbTWMwB/3rZkDrP74q/UO
	i3TT9fSM3f58ih8ydJ6Ch4Z18EcAsceHJaRcSitWe9Huvmzcnzmhcpm+YsXeKjhf7jjOVUePegtCr
	hbnvvyYlpN/GDs+VpIYaSSfh+hlbgM1IW69ApQOscaGfruBO8EGhKAgjIc+BRNpkT4kr+kY7wrgEj
	T5dvAEGruxhqDBVlQ1m7bu5WLPETHgXLi4lplfFNEnDczmEbY5gFCHr7tB1frRf2TYDTNreGinGbC
	gYfsjpvi6A0kIJuLga6bad/k1qJzZnHrx8ETlk37HTKDN55Koe7D1GWHbdDpp5aAWW/4QQqgNgsQT
	CQMzCRmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43128)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wWt2j-0000000063F-3tfB;
	Tue, 09 Jun 2026 10:46:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wWt2g-000000002ua-3S77;
	Tue, 09 Jun 2026 10:46:42 +0100
Date: Tue, 9 Jun 2026 10:46:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fbdev/arm: Export acorndata_8x8 font symbol for
 bootloader
Message-ID: <aifhAn2RMdxQ2p86@shell.armlinux.org.uk>
References: <20260609091056.265794-1-deller@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609091056.265794-1-deller@gmx.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Tue, Jun 09, 2026 at 11:10:56AM +0200, Helge Deller wrote:
> The text display code used in the Risc PC kernel image decompression
> code uses arch/arm/boot/compressed/font.c, which includes
> lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
> 
> Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
> glyph pitch and size") <linux/font.h> contains inline functions that
> require __do_div64, which is not linked into the ARM kernel
> decompressor. This makes Risc PC zImages fail to build.
> 
> Resolve this issue by defining the BOOTLOADER symbol and use it to avoid
> a static declaration of the acorndata_8x8 symbol. That way it can be
> referenced by the arm bootloader, and other static math functions and
> symbols (like __do_div64) stay static and don't get unneccesary included
> in the ARM kernel bootloader decompressor object file.

The decompressor font support has actually been broken since:

commit 6735b4632def0640dbdf4eb9f99816aca18c4f16
Author: Peilin Ye <yepeilin.cs@gmail.com>
Date:   Thu Sep 24 09:42:22 2020 -0400

    Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts

which added extra data to the beginning of the array of font
information:

ENTRY(ll_write_char)
        stmfd   sp!, {r4 - r7, lr}
...
        /*
         * calculate offset into character table
         */
        mov     r1, r1, lsl #3

r1 is the character, this multiplies the character value by 8.

        adr     ip, LC0
        ldmia   ip, {r3, r4, r5, r6, lr}
        sub     ip, ip, r3
        add     r6, r6, ip

in conjunction with the data table:

LC0:    .word   LC0
        .word   bytes_per_char_h
        .word   video_size_row
        .word   acorndata_8x8
        .word   con_charconvtable

results in r6 pointing at acorndata_8x8. We then index this using the
modified character value above:

        orr     r1, r1, #7
        ldrb    r7, [r6, r1]

This breaks if extra data is added to the start, and thus has been
broken since the above commit.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
