From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 16:01:25 +0000
Subject: Re: [PATCH] fbmem: Adjust indentation in fb_prepare_logo and fb_blank
Message-Id: <b6d5a48e-f1e5-4c51-bf48-a08f1e5e7388@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191218030025.10064-1-natechancellor@gmail.com>
 <CGME20191220180959eucas1p134233cbd0a32573e8bc7460d5ddd5906@eucas1p1.samsung.com>
 <CAKwvOdk0hz-Eu00yRwRT6MFDmxPWdgnuYZWxGxASicCq68NivQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk0hz-Eu00yRwRT6MFDmxPWdgnuYZWxGxASicCq68NivQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
Cc: clang-built-linux <clang-built-linux@googlegroups.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>


On 12/20/19 7:09 PM, Nick Desaulniers wrote:
> On Tue, Dec 17, 2019 at 7:00 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> Clang warns:
>>
>> ../drivers/video/fbdev/core/fbmem.c:665:3: warning: misleading
>> indentation; statement is not part of the previous 'else'
>> [-Wmisleading-indentation]
>>         if (fb_logo.depth > 4 && depth > 4) {
>>         ^
>> ../drivers/video/fbdev/core/fbmem.c:661:2: note: previous statement is
>> here
>>         else
>>         ^
>> ../drivers/video/fbdev/core/fbmem.c:1075:3: warning: misleading
>> indentation; statement is not part of the previous 'if'
>> [-Wmisleading-indentation]
>>         return ret;
>>         ^
>> ../drivers/video/fbdev/core/fbmem.c:1072:2: note: previous statement is
>> here
>>         if (!ret)
>>         ^
>> 2 warnings generated.
>>
>> This warning occurs because there are spaces before the tabs on these
>> lines. Normalize the indentation in these functions so that it is
>> consistent with the Linux kernel coding style and clang no longer warns.
>>
>> Fixes: 1692b37c99d5 ("fbdev: Fix logo if logo depth is less than framebu=
ffer depth")
>> Link: https://protect2.fireeye.com/url?k`92966e-3d083fcd-60931d21-002590=
f5b904-0ba0d782b5b6272b&u=3Dhttps://github.com/ClangBuiltLinux/linux/issues=
/825
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>=20
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Patch queued for v5.6, thanks.
=20
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> ---
>>  drivers/video/fbdev/core/fbmem.c | 36 ++++++++++++++++----------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core=
/fbmem.c
>> index 0662b61fdb50..bf63cc0e6b65 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -662,20 +662,20 @@ int fb_prepare_logo(struct fb_info *info, int rota=
te)
>>                 fb_logo.depth =3D 1;
>>
>>
>> -       if (fb_logo.depth > 4 && depth > 4) {
>> -               switch (info->fix.visual) {
>> -               case FB_VISUAL_TRUECOLOR:
>> -                       fb_logo.needs_truepalette =3D 1;
>> -                       break;
>> -               case FB_VISUAL_DIRECTCOLOR:
>> -                       fb_logo.needs_directpalette =3D 1;
>> -                       fb_logo.needs_cmapreset =3D 1;
>> -                       break;
>> -               case FB_VISUAL_PSEUDOCOLOR:
>> -                       fb_logo.needs_cmapreset =3D 1;
>> -                       break;
>> -               }
>> -       }
>> +       if (fb_logo.depth > 4 && depth > 4) {
>> +               switch (info->fix.visual) {
>> +               case FB_VISUAL_TRUECOLOR:
>> +                       fb_logo.needs_truepalette =3D 1;
>> +                       break;
>> +               case FB_VISUAL_DIRECTCOLOR:
>> +                       fb_logo.needs_directpalette =3D 1;
>> +                       fb_logo.needs_cmapreset =3D 1;
>> +                       break;
>> +               case FB_VISUAL_PSEUDOCOLOR:
>> +                       fb_logo.needs_cmapreset =3D 1;
>> +                       break;
>> +               }
>> +       }
>>
>>         height =3D fb_logo.logo->height;
>>         if (fb_center_logo)
>> @@ -1060,19 +1060,19 @@ fb_blank(struct fb_info *info, int blank)
>>         struct fb_event event;
>>         int ret =3D -EINVAL;
>>
>> -       if (blank > FB_BLANK_POWERDOWN)
>> -               blank =3D FB_BLANK_POWERDOWN;
>> +       if (blank > FB_BLANK_POWERDOWN)
>> +               blank =3D FB_BLANK_POWERDOWN;
>>
>>         event.info =3D info;
>>         event.data =3D &blank;
>>
>>         if (info->fbops->fb_blank)
>> -               ret =3D info->fbops->fb_blank(blank, info);
>> +               ret =3D info->fbops->fb_blank(blank, info);
>>
>>         if (!ret)
>>                 fb_notifier_call_chain(FB_EVENT_BLANK, &event);
>>
>> -       return ret;
>> +       return ret;
>>  }
>>  EXPORT_SYMBOL(fb_blank);
>>
>> --
>> 2.24.1
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to clang-built-linux+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://protect2.fireeye.com/ur=
l?k=D7e70d81-8a7da422-d7e686ce-002590f5b904-15caafb1f7cc41ea&u=3Dhttps://gr=
oups.google.com/d/msgid/clang-built-linux/20191218030025.10064-1-natechance=
llor%40gmail.com.
