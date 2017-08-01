From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 14:06:06 +0000
Subject: Re: [PATCH] omapfb: panel-tpo-td043mtea1: constify attribute_group structures.
Message-Id: <4879588.Re4nTIH29Q@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170719052351epcas4p20dce52e9c9754e094195d57458529ecb@epcas4p2.samsung.com>
        <fe9b4aed7a13f673cbc9419c43840443052ebaa8.1500441685.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <fe9b4aed7a13f673cbc9419c43840443052ebaa8.1500441685.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, July 19, 2017 10:53:11 AM Arvind Yadav wrote:
> attribute_group are not supposed to change at runtime. All functions
> working with attribute_group provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    2673	    368	      0	   3041	    be1	panel-tpo-td043mtea1.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    2737	    304	      0	   3041	    be1	panel-tpo-td043mtea1.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

