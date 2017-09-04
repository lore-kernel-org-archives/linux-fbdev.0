From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 12:40:31 +0000
Subject: Re: [PATCH] video: fbdev: annotate fb_fix_screeninfo with const and __initconst
Message-Id: <17101194.VCoQWdOLM3@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170820193005epcas2p3fe5314badbe003db0b74b0f9fde40e9f@epcas2p3.samsung.com>
 <1503251091-23485-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503251091-23485-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, nicolas.ferre@microchip.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Sunday, August 20, 2017 11:14:51 PM Bhumika Goyal wrote:
> Make these const as they are only used during a copy operation.
> Some structures are used as a copy operation inside __init functions, so
> make them const and replace __initdata with __initconst to avoid section
> conflict error.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

