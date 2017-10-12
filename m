From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 12 Oct 2017 15:26:56 +0000
Subject: Re: [PATCH] drivers/video/fbdev/atyfb: make const arrays static, reduces object code size
Message-Id: <10191317.Qqof1SveHP@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170913150314epcas1p4257193707b94242110eb6b9b7a9fdd4b@epcas1p4.samsung.com>
 <20170913150309.6250-1-colin.king@canonical.com>
In-Reply-To: <20170913150309.6250-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday, September 13, 2017 04:03:09 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const arrays ragepro_tbl and ragexl_tbl on the stack,
> instead make them static.  Makes the object code smaller by over 380 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   41089	  10592	    768	  52449	   cce1 atyfb_base.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   40544	  10752	    768	  52064	   cb60	atyfb_base.o
> 
> (gcc version 7.2.0, x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.15 (with patch description fixed to
"video: fbdev: aty: ..." for consistency with other patches),
thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

