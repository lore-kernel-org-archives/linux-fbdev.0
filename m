From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:41:39 +0000
Subject: Re: [PATCH 1/2] video: fbdev: sh_mobile_lcdcfb: fix sparse warnings about using incorrect types
Message-Id: <25ce3896-7f70-7638-8c53-1b1c984ff2cd@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3@eucas1p2.samsung.com>
 <c687dbc5-cf5a-9508-2a61-e757a1a14568@samsung.com>
 <CAMuHMdW0qSAn3S+bpFieP=xukK5SapAq1oRC8XouuMJ6fgqOBA@mail.gmail.com>
In-Reply-To: <CAMuHMdW0qSAn3S+bpFieP=xukK5SapAq1oRC8XouuMJ6fgqOBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>


On 1/17/20 3:08 PM, Geert Uytterhoeven wrote:
> On Thu, Jan 16, 2020 at 3:51 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>>
>> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>>   pointer") for details. ]
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, patch queued for v5.7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
