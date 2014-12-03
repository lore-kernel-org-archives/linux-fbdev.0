From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 03 Dec 2014 01:01:25 +0000
Subject: Re: [PATCH v2 2/2] backlight/lp855x: Add supply regulator to lp855x
Message-Id: <CAOw6vbLB=3An9+Juda=5Yx1vnuCgDsp=ucKNQ3B6AtiLv=FLYg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54767F43.2060901@ti.com> <1417468079-4990-1-git-send-email-seanpaul@chromium.org>
 <547E5F5C.40406@ti.com>
In-Reply-To: <547E5F5C.40406-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Kim, Milo" <milo.kim-l0cyMroinI0@public.gmane.org>
Cc: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-fbdev <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Aaron Durbin <adurbin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On Tue, Dec 2, 2014 at 4:54 PM, Kim, Milo <milo.kim@ti.com> wrote:
> On 12/2/2014 6:07 AM, Sean Paul wrote:
>>
>> This patch adds a supply regulator to the lp855x platform data to
>> facilitate
>> powering on/off the 3V rail attached to the controller.
>>
>> Cc: St=C3=A9phane Marchesin<marcheu@chromium.org>
>> Cc: Aaron Durbin<adurbin@chromium.org>
>> Signed-off-by: Sean Paul<seanpaul@chromium.org>
>
>
> Acked-by: Milo Kim <milo.kim@ti.com>
>
> For effective power consumption, regulator could be enabled/disabled based
> on backlight control flow.
> For example, when the brightness is 0, then call regulator_disable()
> when the brightness is > 0 and regulator is off, then call
> regulator_enable().
> However, I'd like to send ACK to this patch.
>
> Sean,
> Could you send the patch-set with the first one - 'backlight/lp855x:
> Refactor dt parsing code'? I'll send my ACK as well.

Hi Milo,
Thanks for looking at these. There aren't any changes to PATCH 1/2, is
there any value in resending the same patches?

Sean



> For the backlight maintainers, it would be better to apply them together.
>
> Thanks!
>
> Best regards,
> Milo
