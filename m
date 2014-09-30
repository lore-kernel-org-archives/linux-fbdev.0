From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 30 Sep 2014 11:53:16 +0000
Subject: Re: [PATCH 1/2] video/fbdev: Always built-in video= cmdline parsing
Message-Id: <CAKMK7uFgdwNFvu4m4KO+uSHOfm6dYP8-POxUWVJdffZQKWZHfg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407312512-6533-1-git-send-email-daniel.vetter@ffwll.ch>
 <1407329562-10832-1-git-send-email-daniel.vetter@ffwll.ch>
 <542A96BF.7080303@ti.com>
In-Reply-To: <542A96BF.7080303@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Plagniol-Villard <plagnioj@jcrosoft.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Tue, Sep 30, 2014 at 1:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 06/08/14 15:52, Daniel Vetter wrote:
>> In drm/i915 we want to get at the video= cmdline modes even when we
>> don't have fbdev support enabled, so that users can always override
>> the kernel's initial mode selection.
>>
>> But that gives us a direct depency upon the parsing code in the fbdev
>> subsystem. Since it's so little code just extract these 2 functions
>> and always build them in.
>>
>> Whiel at it fix the checkpatch fail in this code.
>>
>> v2: Also move fb_mode_option. Spotted by the kbuild.
>>
>> v3: Review from Geert:
>> - Keep the old copyright notice from fb_mem.c, although I have no
>> idea what exactly applies.
>> - Only compile this when needed.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Plagniol-Villard <plagnioj@jcrosoft.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> --
>>
>> I prefer if we can merge this through drm-next since we'll use it
>> there in follow-up patches.
>> -Daniel
>> ---
>>  drivers/video/fbdev/Kconfig           |   4 ++
>>  drivers/video/fbdev/core/Makefile     |   1 +
>>  drivers/video/fbdev/core/fb_cmdline.c | 110 ++++++++++++++++++++++++++++++++++
>>  drivers/video/fbdev/core/fbmem.c      |  92 ----------------------------
>>  drivers/video/fbdev/core/modedb.c     |   3 -
>>  5 files changed, 115 insertions(+), 95 deletions(-)
>>  create mode 100644 drivers/video/fbdev/core/fb_cmdline.c
>
> Sorry for late response.
>
> Looks fine for me, and I'm fine merging it via drm-next.
>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Well totally forgotten about this one here - I even forgot to drop the
"pls ack this" text from the commit message before sending the pull
request to Dave :(

Anyway, thanks for having a look.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
