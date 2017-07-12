From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 12 Jul 2017 16:31:21 +0000
Subject: Re: [PATCH] atyfb: hide unused variable
Message-Id: <2581869.RWDtV5qma6@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170710111335epcas4p38f91ea2aa1c12161af113766b989e8f1@epcas4p3.samsung.com>
        <20170710111312.747154-1-arnd@arndb.de>
In-Reply-To: <20170710111312.747154-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, July 10, 2017 01:12:46 PM Arnd Bergmann wrote:
> The vdisplay variable is now only accessed inside of an #ifdef, producing
> a harmless warning:
> 
> drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_var_to_crtc':
> drivers/video/fbdev/aty/atyfb_base.c:805:19: error: unused variable 'vdisplay' [-Werror=unused-variable]
> 
> This moves the declaration into the ifdef as well.
> 
> Fixes: dd7d958ae912 ("video: fbdev: aty: remove useless variable assignments in aty_var_to_crtc()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

