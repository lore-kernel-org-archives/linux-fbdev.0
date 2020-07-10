From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:27 +0000
Subject: Re: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS support
Message-Id: <ccb3ca73-8f22-990a-b8bd-1f9c8d642f10@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com>
 <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
In-Reply-To: <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>


On 6/2/20 2:03 PM, Geert Uytterhoeven wrote:
> On Tue, Jun 2, 2020 at 1:50 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
>>> These #ifdefs are relics from APUS (Amiga Power-Up System), which
>>> added a PPC board.  APUS support was killed off a long time ago,
>>> when arch/ppc/ was still king, but these #ifdefs were missed, because
>>> they didn't test for CONFIG_APUS.
>>
>> Add FIXME about using the C code variants (APUS ones) in the future.
>>
>> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to drm-misc-next tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
