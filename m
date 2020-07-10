From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:31 +0000
Subject: Re: [PATCH v2 2/2] video: fbdev: amifb: add FIXMEs about {put,get}_user() failures
Message-Id: <cab5be13-a7df-7765-bb6e-b6302253c1fb@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <380c0494-ed02-b2be-65b0-d385627fb894@samsung.com>
 <CAMuHMdVYuk9+=3OTufOo98Dd3ijXS6JBH9RqK2v+9mwogxbnXA@mail.gmail.com>
In-Reply-To: <CAMuHMdVYuk9+=3OTufOo98Dd3ijXS6JBH9RqK2v+9mwogxbnXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>



On 6/2/20 2:03 PM, Geert Uytterhoeven wrote:
> On Tue, Jun 2, 2020 at 1:52 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> Since we lack the hardware (or proper emulator setup) for
>> testing needed changes add FIXMEs to document the issues
>> (so at least they are not forgotten).
>>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to drm-misc-next tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
