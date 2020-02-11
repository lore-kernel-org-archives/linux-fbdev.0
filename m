From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 11 Feb 2020 10:59:40 +0000
Subject: Re: [PATCH] fbdev: c2p: Use BUILD_BUG() instead of custom solution
Message-Id: <09dba4da-5fd7-cafb-22a3-4baffb12c155@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200112171521.22443-1-geert@linux-m68k.org>
 <CAMuHMdX9M25O9MOQ5tb-cLs36E8qCf1M4YCbYN9BU+h1N3n0MQ@mail.gmail.com>
 <CGME20200211084935eucas1p2f151e2ea9157c4e6b0766bf1f7cf2f84@eucas1p2.samsung.com>
 <CAMuHMdWgGyt8w4zG-rf-b9uyfEx1aHV-CoLz4h_T3MpvzdniWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWgGyt8w4zG-rf-b9uyfEx1aHV-CoLz4h_T3MpvzdniWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>


On 2/11/20 9:49 AM, Geert Uytterhoeven wrote:
> On Mon, Feb 10, 2020 at 12:16 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sun, Jan 12, 2020 at 6:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> Replace the call to the custom non-existing function by a standard
>>> BUILD_BUG() invocation.
>>>
>>> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Thanks, applied and queued for v5.7.
> 
> Sorry, this is fbdev-material, not m68k-material.
> If you mind, I can drop it from the m68k for-v5.7 branch again.

I don't mind, lets keep it m68k tree (it should not cause any
conflicts with other fbdev changes).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
