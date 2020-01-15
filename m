From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 15:59:10 +0000
Subject: Re: [PATCH] fbcon: Adjust indentation in set_con2fb_map
Message-Id: <02a247ea-6837-847b-c3cb-af881bc26850@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191218025337.35044-1-natechancellor@gmail.com>
 <CGME20191220180738eucas1p2c5a571666d1f75812de7078ca6b84ab3@eucas1p2.samsung.com>
 <CAKwvOd=DcXiA5d07bS_3qhr4F-mbsGzZic=OgomuhZchGaXeoQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=DcXiA5d07bS_3qhr4F-mbsGzZic=OgomuhZchGaXeoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
Cc: clang-built-linux <clang-built-linux@googlegroups.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>


On 12/20/19 7:07 PM, Nick Desaulniers wrote:
> On Tue, Dec 17, 2019 at 6:53 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> Clang warns:
>>
>> ../drivers/video/fbdev/core/fbcon.c:915:3: warning: misleading
>> indentation; statement is not part of the previous 'if'
>> [-Wmisleading-indentation]
>>         return err;
>>         ^
>> ../drivers/video/fbdev/core/fbcon.c:912:2: note: previous statement is
>> here
>>         if (!search_fb_in_map(info_idx))
>>         ^
>> 1 warning generated.
>>
>> This warning occurs because there is a space before the tab on this
>> line. This happens on several lines in this function; normalize them
>> so that the indentation is consistent with the Linux kernel coding
>> style and clang no longer warns.
>>
>> This warning was introduced before the beginning of git history so no
>> fixes tab.
>>
>> https://github.com/ClangBuiltLinux/linux/issues/824
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
>>  drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++--------------
>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
>> index c9235a2f42f8..9d2c43e345a4 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -866,7 +866,7 @@ static int set_con2fb_map(int unit, int newidx, int =
user)
>>         int oldidx =3D con2fb_map[unit];
>>         struct fb_info *info =3D registered_fb[newidx];
>>         struct fb_info *oldinfo =3D NULL;
>> -       int found, err =3D 0;
>> +       int found, err =3D 0;
>>
>>         WARN_CONSOLE_UNLOCKED();
>>
>> @@ -888,31 +888,30 @@ static int set_con2fb_map(int unit, int newidx, in=
t user)
>>
>>         con2fb_map[unit] =3D newidx;
>>         if (!err && !found)
>> -               err =3D con2fb_acquire_newinfo(vc, info, unit, oldidx);
>> -
>> +               err =3D con2fb_acquire_newinfo(vc, info, unit, oldidx);
>>
>>         /*
>>          * If old fb is not mapped to any of the consoles,
>>          * fbcon should release it.
>>          */
>> -       if (!err && oldinfo && !search_fb_in_map(oldidx))
>> -               err =3D con2fb_release_oldinfo(vc, oldinfo, info, unit, =
oldidx,
>> -                                            found);
>> +       if (!err && oldinfo && !search_fb_in_map(oldidx))
>> +               err =3D con2fb_release_oldinfo(vc, oldinfo, info, unit, =
oldidx,
>> +                                            found);
>>
>> -       if (!err) {
>> -               int show_logo =3D (fg_console =3D 0 && !user &&
>> -                                logo_shown !=3D FBCON_LOGO_DONTSHOW);
>> +       if (!err) {
>> +               int show_logo =3D (fg_console =3D 0 && !user &&
>> +                                logo_shown !=3D FBCON_LOGO_DONTSHOW);
>>
>> -               if (!found)
>> -                       fbcon_add_cursor_timer(info);
>> -               con2fb_map_boot[unit] =3D newidx;
>> -               con2fb_init_display(vc, info, unit, show_logo);
>> +               if (!found)
>> +                       fbcon_add_cursor_timer(info);
>> +               con2fb_map_boot[unit] =3D newidx;
>> +               con2fb_init_display(vc, info, unit, show_logo);
>>         }
>>
>>         if (!search_fb_in_map(info_idx))
>>                 info_idx =3D newidx;
>>
>> -       return err;
>> +       return err;
>>  }
>>
>>  /*
>> --
>> 2.24.1
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to clang-built-linux+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://protect2.fireeye.com/ur=
l?k=BB9fa192-e64db737-bb9e2add-0cc47a31bee8-3ce98548f51cd7a2&u=3Dhttps://gr=
oups.google.com/d/msgid/clang-built-linux/20191218025337.35044-1-natechance=
llor%40gmail.com.
