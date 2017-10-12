From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 12 Oct 2017 15:30:49 +0000
Subject: Re: [PATCH] video: fbdev: sis: make const array specialtv static, reduces object code size
Message-Id: <502610747.RoFXOuGC48@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170913154142epcas2p41e38ee4285ed856ee6b98edf267da1de@epcas2p4.samsung.com>
        <20170913154137.6886-1-colin.king@canonical.com>
In-Reply-To: <20170913154137.6886-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday, September 13, 2017 04:41:37 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const array specialtv on the stack, instead make it
> static.  Makes the object code smaller by over 1100 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>  179899	   7504	      0	 187403	  2dc0b	drivers/video/fbdev/sis/init301.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>  178720	   7568	      0	 186288	  2d7b0	drivers/video/fbdev/sis/init301.o
> 
> (gcc version 7.2.0, x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

