From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 11:52:50 +0000
Subject: Re: [PATCH] video/macfb: Remove redundant code
Message-Id: <6fa80c4d-1f20-deb0-e254-74f0147f4a81@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
        <CGME20190215082549epcas4p1d0901964a98383cefc42cab0dfeee178@epcas4p1.samsung.com>
        <CAMuHMdUN1SGHd-BbEWY9xwc5jkybLQ_xbLaE0-jzskorso6brw@mail.gmail.com>
In-Reply-To: <CAMuHMdUN1SGHd-BbEWY9xwc5jkybLQ_xbLaE0-jzskorso6brw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


On 02/15/2019 09:25 AM, Geert Uytterhoeven wrote:
> On Fri, Feb 15, 2019 at 3:19 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>> The value of info->var.bits_per_pixel get checked in macfb_setcolreg().
>> Remove additional checks as they are redundant.
>>
>> macfb_defined.activate gets initialized to FB_ACTIVATE_NOW by the struct
>> initializer. Remove redundant assignments.
>>
>> macfb_defined.bits_per_pixel, .width and .height all get assigned
>> unconditionally. Remove redundant initializers.
>>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Tested-by: Stan Johnson <userm57@yahoo.com>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
