From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 15:34:46 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: constify sh_mobile_lcdc_bl_ops.
Message-Id: <2065093.YRdVyAaroC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170612082519epcas2p27928191481400c88cd3ee18f614daea2@epcas2p2.samsung.com>
        <0628fdebc036ff76a6ff343aa0422498e6a0236f.1497255675.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <0628fdebc036ff76a6ff343aa0422498e6a0236f.1497255675.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: geert+renesas@glider.be, keescook@chromium.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 12, 2017 01:54:47 PM Arvind Yadav wrote:
> File size before:
> text	data	 bss    dec      hex filename
>  17525	 952	   0  18477	482d drivers/video/fbdev/sh_mobile_lcdcfb.o
> 
> File size After adding 'const':
> text	data	 bss	 dec	 hex filename
>  17557	 920	   0   18477	482d drivers/video/fbdev/sh_mobile_lcdcfb.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

