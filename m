From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 16:11:42 +0000
Subject: Re: [PATCH] fbdev: controlfb: Add missing modes to fix out of bounds access
Message-Id: <3213289.UpBeyY0aCM@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171107140514epcas4p2988fc367b675dd8facef2f2dba0908db@epcas4p2.samsung.com>
 <1510063505-2063-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1510063505-2063-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Tuesday, November 07, 2017 03:05:05 PM Geert Uytterhoeven wrote:
> Dan's static analysis says:
> 
>     drivers/video/fbdev/controlfb.c:560 control_setup()
>     error: buffer overflow 'control_mac_modes' 20 <= 21
> 
> Indeed, control_mac_modes[] has only 20 elements, while VMODE_MAX is 22,
> which may lead to an out of bounds read when parsing vmode commandline
> options.
> 
> The bug was introduced in v2.4.5.6, when 2 new modes were added to
> macmodes.h, but control_mac_modes[] wasn't updated:
> 
> https://kernel.opensuse.org/cgit/kernel/diff/include/video/macmodes.h?h=v2.5.2&id)f279c764808560eaceb88fef36cbc35c529aad
> 
> Augment control_mac_modes[] with the two new video modes to fix this.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

