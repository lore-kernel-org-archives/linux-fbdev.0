Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAB366079
	for <linux-fbdev@vger.kernel.org>; Fri,  8 May 2026 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242113; cv=none; b=ZFUeh3frS333VLK6KUrSRgEqIZNjWLQqQzChpATCFZlJQnlnzhv4HtXC/cM2GBFn1yzr/P96wkMPS0UXX/eMgciqcEq/VmlCPVpOpjVMUsYnl3SXl2TmpVFODWiRZqC124SGSI8sxJsAMs12eIOYSvf8JeAzT9IHXdDe65Za/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242113; c=relaxed/simple;
	bh=J4J0L9K34E/EsqGHJEnDmP3LolYyIs547tbsD5L8ljc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdLlk9p0oFcUPMCXqJyun9hPH88lpYWgtDm8byaDQEFphWC41mkFoLnFYTOFmIsTYDrkVHyqi5gK7AH0pPKnogwWNFQOmWHN/EGNBFlVnYBiC8NJRkzL5ZPVz2lNgZd9P+/l4sWFqsapJZ17PyZq2KEvf2r3YO0wBsyZFd3qLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7IphFhs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B42tJdOT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7IphFhs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B42tJdOT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7IphFhs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B42tJdOT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7IphFhs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B42tJdOT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF3446AB35;
	Fri,  8 May 2026 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778242108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ouXbRHXqDvlDRSogcQYsz0p3KRAlsRGMRuhAVNS8L4k=;
	b=Q7IphFhsJUVDsg6d5w2YU7q8x+/RG88Qtecf7W2nQkZMK7UM4yDcq8QHlwGWNa8aaIlPnk
	pQTvol8aVkLZnRCzeZOvumYaSi4aKmgMnm+DzuUocg6Pi3fen4lIbWmBwct263nYXzvX1J
	QjcmsoCkBq5wIOfzzbMUEP1Hhvj+g5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778242108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ouXbRHXqDvlDRSogcQYsz0p3KRAlsRGMRuhAVNS8L4k=;
	b=B42tJdOTOHMfCLFGqh4R9/23YpVllgYgvrJqHTiD2lE4ggOsztu6OICkuLZUz2/Xx89frC
	6mtQGq6vvVRvp1Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778242108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ouXbRHXqDvlDRSogcQYsz0p3KRAlsRGMRuhAVNS8L4k=;
	b=Q7IphFhsJUVDsg6d5w2YU7q8x+/RG88Qtecf7W2nQkZMK7UM4yDcq8QHlwGWNa8aaIlPnk
	pQTvol8aVkLZnRCzeZOvumYaSi4aKmgMnm+DzuUocg6Pi3fen4lIbWmBwct263nYXzvX1J
	QjcmsoCkBq5wIOfzzbMUEP1Hhvj+g5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778242108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ouXbRHXqDvlDRSogcQYsz0p3KRAlsRGMRuhAVNS8L4k=;
	b=B42tJdOTOHMfCLFGqh4R9/23YpVllgYgvrJqHTiD2lE4ggOsztu6OICkuLZUz2/Xx89frC
	6mtQGq6vvVRvp1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59F76593A7;
	Fri,  8 May 2026 12:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8khFFDzS/WkFOAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 12:08:28 +0000
Message-ID: <00b7e7f2-98e2-45af-b3c6-43140443cbe9@suse.de>
Date: Fri, 8 May 2026 14:08:27 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: remove Hercules monochrome ISA graphics
 adapter driver
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-fbdev@vger.kernel.org
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Helge Deller <deller@gmx.de>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>,
 =?UTF-8?Q?Martin_Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
 Diego Viola <diego.viola@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 robgithub <rob.github@jumpstation.co.uk>, Hardik Phalet <hardik.phalet@pm.me>
References: <20260503045653.33522-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260503045653.33522-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[drama.obuda.kando.hu,gmx.de,kernel.org,linux-foundation.org,gmail.com,posteo.de,linux.microsoft.com,jumpstation.co.uk,pm.me];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi

Am 03.05.26 um 06:56 schrieb Ethan Nelson-Moore:
> The hgafb supports graphics adapters compatible with the Hercules
> adapter from 1984. These were ISA cards or onboard devices that
> supported monochrome 720x348 graphics. This driver was created in 1999
> by Ferenc Bakonyi. In the entire Git history (since Linux 2.6.12-rc2),
> there has only been one commit in 2010 which indicated that the driver
> was in use, commit 529ed806d454 ("video: Fix the HGA framebuffer
> driver"). The commit message states:
>      Only tested with fbcon, since most fbdev-based software appears
>      to only support 12bpp and up. It does not appear that this driver has
>      worked for at least the entire 2.6.x series, perhaps since 2002.
> Given the age and limited capabilities of the hardware and the lack of
> users, remove this driver and move the former maintainer to CREDITS.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

FWIW

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   CREDITS                      |   3 +
>   MAINTAINERS                  |   7 -
>   drivers/video/fbdev/Kconfig  |  13 -
>   drivers/video/fbdev/Makefile |   1 -
>   drivers/video/fbdev/hgafb.c  | 685 -----------------------------------
>   5 files changed, 3 insertions(+), 706 deletions(-)
>   delete mode 100644 drivers/video/fbdev/hgafb.c
>
> diff --git a/CREDITS b/CREDITS
> index 17962bdd6dbd..59d5de3eeb5b 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -197,6 +197,9 @@ S: Hauptstrasse 19
>   S: 79837 St. Blasien
>   S: Germany
>   
> +N: Ferenc Bakonyi
> +D: Hercules graphics adapter framebuffer driver
> +
>   N: Krishna Balasubramanian
>   E: balasub@cis.ohio-state.edu
>   D: Wrote SYS V IPC (part of standard kernel since 0.99.10)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..3194befa6a13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11373,13 +11373,6 @@ F:	Documentation/filesystems/hfsplus.rst
>   F:	fs/hfsplus/
>   F:	include/linux/hfs_common.h
>   
> -HGA FRAMEBUFFER DRIVER
> -M:	Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> -L:	linux-nvidia@lists.surfsouth.com
> -S:	Maintained
> -W:	http://drama.obuda.kando.hu/~fero/cgi-bin/hgafb.shtml
> -F:	drivers/video/fbdev/hgafb.c
> -
>   HIBERNATION (aka Software Suspend, aka swsusp)
>   M:	"Rafael J. Wysocki" <rafael@kernel.org>
>   R:	Pavel Machek <pavel@kernel.org>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 1c73d560f196..085d3a202148 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -453,19 +453,6 @@ config FB_N411
>   	  This enables support for the Apollo display controller in its
>   	  Hecuba form using the n411 devkit.
>   
> -config FB_HGA
> -	tristate "Hercules mono graphics support"
> -	depends on FB && X86
> -	select FB_IOMEM_FOPS
> -	help
> -	  Say Y here if you have a Hercules mono graphics card.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called hgafb.
> -
> -	  As this card technology is at least 25 years old,
> -	  most people will answer N here.
> -
>   config FB_GBE
>   	bool "SGI Graphics Backend frame buffer support"
>   	depends on (FB = y) && HAS_IOMEM
> diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
> index 36a18d958ba0..0b17c878154d 100644
> --- a/drivers/video/fbdev/Makefile
> +++ b/drivers/video/fbdev/Makefile
> @@ -59,7 +59,6 @@ obj-$(CONFIG_FB_ATARI)            += atafb.o c2p_iplan2.o atafb_mfb.o \
>   obj-$(CONFIG_FB_MAC)              += macfb.o
>   obj-$(CONFIG_FB_HECUBA)           += hecubafb.o
>   obj-$(CONFIG_FB_N411)             += n411.o
> -obj-$(CONFIG_FB_HGA)              += hgafb.o
>   obj-$(CONFIG_FB_XVR500)           += sunxvr500.o
>   obj-$(CONFIG_FB_XVR2500)          += sunxvr2500.o
>   obj-$(CONFIG_FB_XVR1000)          += sunxvr1000.o
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> deleted file mode 100644
> index d32fd1c5217c..000000000000
> --- a/drivers/video/fbdev/hgafb.c
> +++ /dev/null
> @@ -1,685 +0,0 @@
> -/*
> - * linux/drivers/video/hgafb.c -- Hercules graphics adaptor frame buffer device
> - *
> - *      Created 25 Nov 1999 by Ferenc Bakonyi (fero@drama.obuda.kando.hu)
> - *      Based on skeletonfb.c by Geert Uytterhoeven and
> - *               mdacon.c by Andrew Apted
> - *
> - * History:
> - *
> - * - Revision 0.1.8 (23 Oct 2002): Ported to new framebuffer api.
> - *
> - * - Revision 0.1.7 (23 Jan 2001): fix crash resulting from MDA only cards
> - *				   being detected as Hercules.	 (Paul G.)
> - * - Revision 0.1.6 (17 Aug 2000): new style structs
> - *                                 documentation
> - * - Revision 0.1.5 (13 Mar 2000): spinlocks instead of saveflags();cli();etc
> - *                                 minor fixes
> - * - Revision 0.1.4 (24 Jan 2000): fixed a bug in hga_card_detect() for
> - *                                  HGA-only systems
> - * - Revision 0.1.3 (22 Jan 2000): modified for the new fb_info structure
> - *                                 screen is cleared after rmmod
> - *                                 virtual resolutions
> - *                                 module parameter 'nologo={0|1}'
> - *                                 the most important: boot logo :)
> - * - Revision 0.1.0  (6 Dec 1999): faster scrolling and minor fixes
> - * - First release  (25 Nov 1999)
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file COPYING in the main directory of this archive
> - * for more details.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/spinlock.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/delay.h>
> -#include <linux/fb.h>
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -#include <linux/platform_device.h>
> -#include <asm/io.h>
> -#include <asm/vga.h>
> -
> -#if 0
> -#define DPRINTK(args...) printk(KERN_DEBUG __FILE__": " ##args)
> -#else
> -#define DPRINTK(args...)
> -#endif
> -
> -#if 0
> -#define CHKINFO(ret) if (info != &fb_info) { printk(KERN_DEBUG __FILE__": This should never happen, line:%d \n", __LINE__); return ret; }
> -#else
> -#define CHKINFO(ret)
> -#endif
> -
> -/* Description of the hardware layout */
> -
> -static void __iomem *hga_vram;			/* Base of video memory */
> -static unsigned long hga_vram_len;		/* Size of video memory */
> -
> -#define HGA_ROWADDR(row) ((row%4)*8192 + (row>>2)*90)
> -#define HGA_TXT			0
> -#define HGA_GFX			1
> -
> -static inline u8 __iomem * rowaddr(struct fb_info *info, u_int row)
> -{
> -	return info->screen_base + HGA_ROWADDR(row);
> -}
> -
> -static int hga_mode = -1;			/* 0 = txt, 1 = gfx mode */
> -
> -static enum { TYPE_HERC, TYPE_HERCPLUS, TYPE_HERCCOLOR } hga_type;
> -static char *hga_type_name;
> -
> -#define HGA_INDEX_PORT		0x3b4		/* Register select port */
> -#define HGA_VALUE_PORT		0x3b5		/* Register value port */
> -#define HGA_MODE_PORT		0x3b8		/* Mode control port */
> -#define HGA_STATUS_PORT		0x3ba		/* Status and Config port */
> -#define HGA_GFX_PORT		0x3bf		/* Graphics control port */
> -
> -/* HGA register values */
> -
> -#define HGA_CURSOR_BLINKING	0x00
> -#define HGA_CURSOR_OFF		0x20
> -#define HGA_CURSOR_SLOWBLINK	0x60
> -
> -#define HGA_MODE_GRAPHICS	0x02
> -#define HGA_MODE_VIDEO_EN	0x08
> -#define HGA_MODE_BLINK_EN	0x20
> -#define HGA_MODE_GFX_PAGE1	0x80
> -
> -#define HGA_STATUS_HSYNC	0x01
> -#define HGA_STATUS_VSYNC	0x80
> -#define HGA_STATUS_VIDEO	0x08
> -
> -#define HGA_CONFIG_COL132	0x08
> -#define HGA_GFX_MODE_EN		0x01
> -#define HGA_GFX_PAGE_EN		0x02
> -
> -/* Global locks */
> -
> -static DEFINE_SPINLOCK(hga_reg_lock);
> -
> -/* Framebuffer driver structures */
> -
> -static const struct fb_var_screeninfo hga_default_var = {
> -	.xres		= 720,
> -	.yres 		= 348,
> -	.xres_virtual 	= 720,
> -	.yres_virtual	= 348,
> -	.bits_per_pixel = 1,
> -	.red 		= {0, 1, 0},
> -	.green 		= {0, 1, 0},
> -	.blue 		= {0, 1, 0},
> -	.transp 	= {0, 0, 0},
> -	.height 	= -1,
> -	.width 		= -1,
> -};
> -
> -static struct fb_fix_screeninfo hga_fix = {
> -	.id 		= "HGA",
> -	.type 		= FB_TYPE_PACKED_PIXELS,	/* (not sure) */
> -	.visual 	= FB_VISUAL_MONO10,
> -	.xpanstep 	= 8,
> -	.ypanstep 	= 8,
> -	.line_length 	= 90,
> -	.accel 		= FB_ACCEL_NONE
> -};
> -
> -/* Don't assume that tty1 will be the initial current console. */
> -static int release_io_port = 0;
> -static int release_io_ports = 0;
> -static bool nologo = 0;
> -
> -/* -------------------------------------------------------------------------
> - *
> - * Low level hardware functions
> - *
> - * ------------------------------------------------------------------------- */
> -
> -static void write_hga_b(unsigned int val, unsigned char reg)
> -{
> -	outb_p(reg, HGA_INDEX_PORT);
> -	outb_p(val, HGA_VALUE_PORT);
> -}
> -
> -static void write_hga_w(unsigned int val, unsigned char reg)
> -{
> -	outb_p(reg,   HGA_INDEX_PORT); outb_p(val >> 8,   HGA_VALUE_PORT);
> -	outb_p(reg+1, HGA_INDEX_PORT); outb_p(val & 0xff, HGA_VALUE_PORT);
> -}
> -
> -static int test_hga_b(unsigned char val, unsigned char reg)
> -{
> -	outb_p(reg, HGA_INDEX_PORT);
> -	outb  (val, HGA_VALUE_PORT);
> -	udelay(20); val = (inb_p(HGA_VALUE_PORT) == val);
> -	return val;
> -}
> -
> -static void hga_clear_screen(void)
> -{
> -	unsigned char fillchar = 0xbf; /* magic */
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&hga_reg_lock, flags);
> -	if (hga_mode == HGA_TXT)
> -		fillchar = ' ';
> -	else if (hga_mode == HGA_GFX)
> -		fillchar = 0x00;
> -	spin_unlock_irqrestore(&hga_reg_lock, flags);
> -	if (fillchar != 0xbf)
> -		memset_io(hga_vram, fillchar, hga_vram_len);
> -}
> -
> -static void hga_txt_mode(void)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&hga_reg_lock, flags);
> -	outb_p(HGA_MODE_VIDEO_EN | HGA_MODE_BLINK_EN, HGA_MODE_PORT);
> -	outb_p(0x00, HGA_GFX_PORT);
> -	outb_p(0x00, HGA_STATUS_PORT);
> -
> -	write_hga_b(0x61, 0x00);	/* horizontal total */
> -	write_hga_b(0x50, 0x01);	/* horizontal displayed */
> -	write_hga_b(0x52, 0x02);	/* horizontal sync pos */
> -	write_hga_b(0x0f, 0x03);	/* horizontal sync width */
> -
> -	write_hga_b(0x19, 0x04);	/* vertical total */
> -	write_hga_b(0x06, 0x05);	/* vertical total adjust */
> -	write_hga_b(0x19, 0x06);	/* vertical displayed */
> -	write_hga_b(0x19, 0x07);	/* vertical sync pos */
> -
> -	write_hga_b(0x02, 0x08);	/* interlace mode */
> -	write_hga_b(0x0d, 0x09);	/* maximum scanline */
> -	write_hga_b(0x0c, 0x0a);	/* cursor start */
> -	write_hga_b(0x0d, 0x0b);	/* cursor end */
> -
> -	write_hga_w(0x0000, 0x0c);	/* start address */
> -	write_hga_w(0x0000, 0x0e);	/* cursor location */
> -
> -	hga_mode = HGA_TXT;
> -	spin_unlock_irqrestore(&hga_reg_lock, flags);
> -}
> -
> -static void hga_gfx_mode(void)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&hga_reg_lock, flags);
> -	outb_p(0x00, HGA_STATUS_PORT);
> -	outb_p(HGA_GFX_MODE_EN, HGA_GFX_PORT);
> -	outb_p(HGA_MODE_VIDEO_EN | HGA_MODE_GRAPHICS, HGA_MODE_PORT);
> -
> -	write_hga_b(0x35, 0x00);	/* horizontal total */
> -	write_hga_b(0x2d, 0x01);	/* horizontal displayed */
> -	write_hga_b(0x2e, 0x02);	/* horizontal sync pos */
> -	write_hga_b(0x07, 0x03);	/* horizontal sync width */
> -
> -	write_hga_b(0x5b, 0x04);	/* vertical total */
> -	write_hga_b(0x02, 0x05);	/* vertical total adjust */
> -	write_hga_b(0x57, 0x06);	/* vertical displayed */
> -	write_hga_b(0x57, 0x07);	/* vertical sync pos */
> -
> -	write_hga_b(0x02, 0x08);	/* interlace mode */
> -	write_hga_b(0x03, 0x09);	/* maximum scanline */
> -	write_hga_b(0x00, 0x0a);	/* cursor start */
> -	write_hga_b(0x00, 0x0b);	/* cursor end */
> -
> -	write_hga_w(0x0000, 0x0c);	/* start address */
> -	write_hga_w(0x0000, 0x0e);	/* cursor location */
> -
> -	hga_mode = HGA_GFX;
> -	spin_unlock_irqrestore(&hga_reg_lock, flags);
> -}
> -
> -static void hga_show_logo(struct fb_info *info)
> -{
> -/*
> -	void __iomem *dest = hga_vram;
> -	char *logo = linux_logo_bw;
> -	int x, y;
> -
> -	for (y = 134; y < 134 + 80 ; y++) * this needs some cleanup *
> -		for (x = 0; x < 10 ; x++)
> -			writeb(~*(logo++),(dest + HGA_ROWADDR(y) + x + 40));
> -*/
> -}
> -
> -static void hga_pan(unsigned int xoffset, unsigned int yoffset)
> -{
> -	unsigned int base;
> -	unsigned long flags;
> -
> -	base = (yoffset / 8) * 90 + xoffset;
> -	spin_lock_irqsave(&hga_reg_lock, flags);
> -	write_hga_w(base, 0x0c);	/* start address */
> -	spin_unlock_irqrestore(&hga_reg_lock, flags);
> -	DPRINTK("hga_pan: base:%d\n", base);
> -}
> -
> -static void hga_blank(int blank_mode)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&hga_reg_lock, flags);
> -	if (blank_mode) {
> -		outb_p(0x00, HGA_MODE_PORT);	/* disable video */
> -	} else {
> -		outb_p(HGA_MODE_VIDEO_EN | HGA_MODE_GRAPHICS, HGA_MODE_PORT);
> -	}
> -	spin_unlock_irqrestore(&hga_reg_lock, flags);
> -}
> -
> -static int hga_card_detect(struct platform_device *pdev)
> -{
> -	int count = 0;
> -	void __iomem *p, *q;
> -	unsigned short p_save, q_save;
> -
> -	hga_vram_len  = 0x08000;
> -
> -	if (!devm_request_mem_region(&pdev->dev, 0xb0000, hga_vram_len, "hgafb")) {
> -		dev_err(&pdev->dev, "cannot reserve video memory at 0xb0000\n");
> -		return -EBUSY;
> -	}
> -
> -	hga_vram = ioremap(0xb0000, hga_vram_len);
> -	if (!hga_vram)
> -		return -ENOMEM;
> -
> -	if (request_region(0x3b0, 12, "hgafb"))
> -		release_io_ports = 1;
> -	if (request_region(0x3bf, 1, "hgafb"))
> -		release_io_port = 1;
> -
> -	/* do a memory check */
> -
> -	p = hga_vram;
> -	q = hga_vram + 0x01000;
> -
> -	p_save = readw(p); q_save = readw(q);
> -
> -	writew(0xaa55, p); if (readw(p) == 0xaa55) count++;
> -	writew(0x55aa, p); if (readw(p) == 0x55aa) count++;
> -	writew(p_save, p);
> -
> -	if (count != 2)
> -		goto error;
> -
> -	/* Ok, there is definitely a card registering at the correct
> -	 * memory location, so now we do an I/O port test.
> -	 */
> -
> -	if (!test_hga_b(0x66, 0x0f))	    /* cursor low register */
> -		goto error;
> -
> -	if (!test_hga_b(0x99, 0x0f))     /* cursor low register */
> -		goto error;
> -
> -	/* See if the card is a Hercules, by checking whether the vsync
> -	 * bit of the status register is changing.  This test lasts for
> -	 * approximately 1/10th of a second.
> -	 */
> -
> -	p_save = q_save = inb_p(HGA_STATUS_PORT) & HGA_STATUS_VSYNC;
> -
> -	for (count=0; count < 50000 && p_save == q_save; count++) {
> -		q_save = inb(HGA_STATUS_PORT) & HGA_STATUS_VSYNC;
> -		udelay(2);
> -	}
> -
> -	if (p_save == q_save)
> -		goto error;
> -
> -	switch (inb_p(HGA_STATUS_PORT) & 0x70) {
> -		case 0x10:
> -			hga_type = TYPE_HERCPLUS;
> -			hga_type_name = "HerculesPlus";
> -			break;
> -		case 0x50:
> -			hga_type = TYPE_HERCCOLOR;
> -			hga_type_name = "HerculesColor";
> -			break;
> -		default:
> -			hga_type = TYPE_HERC;
> -			hga_type_name = "Hercules";
> -			break;
> -	}
> -	return 0;
> -error:
> -	if (release_io_ports)
> -		release_region(0x3b0, 12);
> -	if (release_io_port)
> -		release_region(0x3bf, 1);
> -
> -	iounmap(hga_vram);
> -
> -	pr_err("hgafb: HGA card not detected.\n");
> -
> -	return -EINVAL;
> -}
> -
> -/**
> - *	hgafb_open - open the framebuffer device
> - *	@info: pointer to fb_info object containing info for current hga board
> - *	@init: open by console system or userland.
> - *
> - *	Returns: %0
> - */
> -
> -static int hgafb_open(struct fb_info *info, int init)
> -{
> -	hga_gfx_mode();
> -	hga_clear_screen();
> -	if (!nologo) hga_show_logo(info);
> -	return 0;
> -}
> -
> -/**
> - *	hgafb_release - open the framebuffer device
> - *	@info: pointer to fb_info object containing info for current hga board
> - *	@init: open by console system or userland.
> - *
> - *	Returns: %0
> - */
> -
> -static int hgafb_release(struct fb_info *info, int init)
> -{
> -	hga_txt_mode();
> -	hga_clear_screen();
> -	return 0;
> -}
> -
> -/**
> - *	hgafb_setcolreg - set color registers
> - *	@regno:register index to set
> - *	@red:red value, unused
> - *	@green:green value, unused
> - *	@blue:blue value, unused
> - *	@transp:transparency value, unused
> - *	@info:unused
> - *
> - *	This callback function is used to set the color registers of a HGA
> - *	board. Since we have only two fixed colors only @regno is checked.
> - *	A zero is returned on success and 1 for failure.
> - *
> - *	Returns: %0
> - */
> -
> -static int hgafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
> -			   u_int transp, struct fb_info *info)
> -{
> -	if (regno > 1)
> -		return 1;
> -	return 0;
> -}
> -
> -/**
> - *	hgafb_pan_display - pan or wrap the display
> - *	@var:contains new xoffset, yoffset and vmode values
> - *	@info:pointer to fb_info object containing info for current hga board
> - *
> - *	This function looks only at xoffset, yoffset and the %FB_VMODE_YWRAP
> - *	flag in @var. If input parameters are correct it calls hga_pan() to
> - *	program the hardware. @info->var is updated to the new values.
> - *
> - *	Returns: %0 on success or %-EINVAL for failure.
> - */
> -
> -static int hgafb_pan_display(struct fb_var_screeninfo *var,
> -			     struct fb_info *info)
> -{
> -	if (var->vmode & FB_VMODE_YWRAP) {
> -		if (var->yoffset >= info->var.yres_virtual ||
> -		    var->xoffset)
> -			return -EINVAL;
> -	} else {
> -		if (var->xoffset + info->var.xres > info->var.xres_virtual
> -		 || var->yoffset + info->var.yres > info->var.yres_virtual
> -		 || var->yoffset % 8)
> -			return -EINVAL;
> -	}
> -
> -	hga_pan(var->xoffset, var->yoffset);
> -	return 0;
> -}
> -
> -/**
> - *	hgafb_blank - (un)blank the screen
> - *	@blank_mode:blanking method to use
> - *	@info:unused
> - *
> - *	Blank the screen if blank_mode != 0, else unblank.
> - *	Implements VESA suspend and powerdown modes on hardware that supports
> - *	disabling hsync/vsync:
> - *		@blank_mode == 2 means suspend vsync,
> - *		@blank_mode == 3 means suspend hsync,
> - *		@blank_mode == 4 means powerdown.
> - *
> - * Returns: %0
> - */
> -
> -static int hgafb_blank(int blank_mode, struct fb_info *info)
> -{
> -	hga_blank(blank_mode);
> -	return 0;
> -}
> -
> -/*
> - * Accel functions
> - */
> -static void hgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
> -{
> -	u_int rows, y;
> -	u8 __iomem *dest;
> -
> -	y = rect->dy;
> -
> -	for (rows = rect->height; rows--; y++) {
> -		dest = rowaddr(info, y) + (rect->dx >> 3);
> -		switch (rect->rop) {
> -		case ROP_COPY:
> -			memset_io(dest, rect->color, (rect->width >> 3));
> -			break;
> -		case ROP_XOR:
> -			fb_writeb(~(fb_readb(dest)), dest);
> -			break;
> -		}
> -	}
> -}
> -
> -static void hgafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
> -{
> -	u_int rows, y1, y2;
> -	u8 __iomem *src;
> -	u8 __iomem *dest;
> -
> -	if (area->dy <= area->sy) {
> -		y1 = area->sy;
> -		y2 = area->dy;
> -
> -		for (rows = area->height; rows--; ) {
> -			src = rowaddr(info, y1) + (area->sx >> 3);
> -			dest = rowaddr(info, y2) + (area->dx >> 3);
> -			memmove(dest, src, (area->width >> 3));
> -			y1++;
> -			y2++;
> -		}
> -	} else {
> -		y1 = area->sy + area->height - 1;
> -		y2 = area->dy + area->height - 1;
> -
> -		for (rows = area->height; rows--;) {
> -			src = rowaddr(info, y1) + (area->sx >> 3);
> -			dest = rowaddr(info, y2) + (area->dx >> 3);
> -			memmove(dest, src, (area->width >> 3));
> -			y1--;
> -			y2--;
> -		}
> -	}
> -}
> -
> -static void hgafb_imageblit(struct fb_info *info, const struct fb_image *image)
> -{
> -	u8 __iomem *dest;
> -	u8 *cdat = (u8 *) image->data;
> -	u_int rows, y = image->dy;
> -	u_int x;
> -	u8 d;
> -
> -	for (rows = image->height; rows--; y++) {
> -		for (x = 0; x < image->width; x+= 8) {
> -			d = *cdat++;
> -			dest = rowaddr(info, y) + ((image->dx + x)>> 3);
> -			fb_writeb(d, dest);
> -		}
> -	}
> -}
> -
> -static const struct fb_ops hgafb_ops = {
> -	.owner		= THIS_MODULE,
> -	.fb_open	= hgafb_open,
> -	.fb_release	= hgafb_release,
> -	__FB_DEFAULT_IOMEM_OPS_RDWR,
> -	.fb_setcolreg	= hgafb_setcolreg,
> -	.fb_pan_display	= hgafb_pan_display,
> -	.fb_blank	= hgafb_blank,
> -	.fb_fillrect	= hgafb_fillrect,
> -	.fb_copyarea	= hgafb_copyarea,
> -	.fb_imageblit	= hgafb_imageblit,
> -	__FB_DEFAULT_IOMEM_OPS_MMAP,
> -};
> -
> -/* ------------------------------------------------------------------------- *
> - *
> - * Functions in fb_info
> - *
> - * ------------------------------------------------------------------------- */
> -
> -/* ------------------------------------------------------------------------- */
> -
> -	/*
> -	 *  Initialization
> -	 */
> -
> -static int hgafb_probe(struct platform_device *pdev)
> -{
> -	struct fb_info *info;
> -	int ret;
> -
> -	ret = hga_card_detect(pdev);
> -	if (ret)
> -		return ret;
> -
> -	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
> -		hga_type_name, hga_vram_len/1024);
> -
> -	info = framebuffer_alloc(0, &pdev->dev);
> -	if (!info) {
> -		iounmap(hga_vram);
> -		return -ENOMEM;
> -	}
> -
> -	hga_fix.smem_start = (unsigned long)hga_vram;
> -	hga_fix.smem_len = hga_vram_len;
> -
> -	info->flags = FBINFO_HWACCEL_YPAN;
> -	info->var = hga_default_var;
> -	info->fix = hga_fix;
> -	info->monspecs.hfmin = 0;
> -	info->monspecs.hfmax = 0;
> -	info->monspecs.vfmin = 10000;
> -	info->monspecs.vfmax = 10000;
> -	info->monspecs.dpms = 0;
> -	info->fbops = &hgafb_ops;
> -	info->screen_base = hga_vram;
> -
> -        if (register_framebuffer(info) < 0) {
> -		framebuffer_release(info);
> -		iounmap(hga_vram);
> -		return -EINVAL;
> -	}
> -
> -	fb_info(info, "%s frame buffer device\n", info->fix.id);
> -	platform_set_drvdata(pdev, info);
> -	return 0;
> -}
> -
> -static void hgafb_remove(struct platform_device *pdev)
> -{
> -	struct fb_info *info = platform_get_drvdata(pdev);
> -
> -	hga_txt_mode();
> -	hga_clear_screen();
> -
> -	if (info) {
> -		unregister_framebuffer(info);
> -		framebuffer_release(info);
> -	}
> -
> -	iounmap(hga_vram);
> -
> -	if (release_io_ports)
> -		release_region(0x3b0, 12);
> -
> -	if (release_io_port)
> -		release_region(0x3bf, 1);
> -}
> -
> -static struct platform_driver hgafb_driver = {
> -	.probe = hgafb_probe,
> -	.remove = hgafb_remove,
> -	.driver = {
> -		.name = "hgafb",
> -	},
> -};
> -
> -static struct platform_device *hgafb_device;
> -
> -static int __init hgafb_init(void)
> -{
> -	int ret;
> -
> -	if (fb_get_options("hgafb", NULL))
> -		return -ENODEV;
> -
> -	ret = platform_driver_register(&hgafb_driver);
> -
> -	if (!ret) {
> -		hgafb_device = platform_device_register_simple("hgafb", 0, NULL, 0);
> -
> -		if (IS_ERR(hgafb_device)) {
> -			platform_driver_unregister(&hgafb_driver);
> -			ret = PTR_ERR(hgafb_device);
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -static void __exit hgafb_exit(void)
> -{
> -	platform_device_unregister(hgafb_device);
> -	platform_driver_unregister(&hgafb_driver);
> -}
> -
> -/* -------------------------------------------------------------------------
> - *
> - *  Modularization
> - *
> - * ------------------------------------------------------------------------- */
> -
> -MODULE_AUTHOR("Ferenc Bakonyi <fero@drama.obuda.kando.hu>");
> -MODULE_DESCRIPTION("FBDev driver for Hercules Graphics Adaptor");
> -MODULE_LICENSE("GPL");
> -
> -module_param(nologo, bool, 0);
> -MODULE_PARM_DESC(nologo, "Disables startup logo if != 0 (default=0)");
> -module_init(hgafb_init);
> -module_exit(hgafb_exit);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


