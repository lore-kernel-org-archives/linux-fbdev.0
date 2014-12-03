From: "Kim, Milo" <milo.kim@ti.com>
Date: Wed, 03 Dec 2014 00:54:52 +0000
Subject: Re: [PATCH v2 2/2] backlight/lp855x: Add supply regulator to lp855x
Message-Id: <547E5F5C.40406@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54767F43.2060901@ti.com> <1417468079-4990-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417468079-4990-1-git-send-email-seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Aaron Durbin <adurbin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On 12/2/2014 6:07 AM, Sean Paul wrote:
> This patch adds a supply regulator to the lp855x platform data to facilit=
ate
> powering on/off the 3V rail attached to the controller.
>
> Cc: St=C3=A9phane Marchesin<marcheu@chromium.org>
> Cc: Aaron Durbin<adurbin@chromium.org>
> Signed-off-by: Sean Paul<seanpaul@chromium.org>

Acked-by: Milo Kim <milo.kim@ti.com>

For effective power consumption, regulator could be enabled/disabled=20
based on backlight control flow.
For example, when the brightness is 0, then call regulator_disable()
when the brightness is > 0 and regulator is off, then call=20
regulator_enable().
However, I'd like to send ACK to this patch.

Sean,
Could you send the patch-set with the first one - 'backlight/lp855x:=20
Refactor dt parsing code'? I'll send my ACK as well.
For the backlight maintainers, it would be better to apply them together.

Thanks!

Best regards,
Milo
