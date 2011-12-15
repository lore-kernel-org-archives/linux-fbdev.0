From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Date: Thu, 15 Dec 2011 07:49:57 +0000
Subject: Re: [PATCH 2/2] offb: Add palette hack for qemu "standard vga" framebuffer
Message-Id: <4EE9A6A5.2050600@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323907109.21839.28.camel@pasglop>
In-Reply-To: <1323907109.21839.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org

Am 15.12.2011 00:58, schrieb Benjamin Herrenschmidt:
> We rename the mach64 hack to "simple" since that's also applicable
> to anything using VGA-style DAC IO ports (set to 8-bit DAC) and we
> use it for qemu vga.
> 
> Note that this is keyed on a device-tree "compatible" property that
> is currently only set by an upcoming version of SLOF when using the
> qemu "pseries" platform. This is on purpose as other qemu ppc platforms
> using OpenBIOS aren't properly setting the DAC to 8-bit at the time of
> the writing of this patch.
> 
> We can fix OpenBIOS later to do that and add the required property, in
> which case it will be matched by this change.

Just let me know what's needed for OpenBIOS.
Is this just for -vga std as opposed to the default cirrus?

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer; HRB 16746 AG Nürnberg
