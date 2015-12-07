From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Mon, 07 Dec 2015 16:14:15 +0000
Subject: Re: [PATCH RESEND] fbdev: Make fb-notify a no-op if CONFIG_FB=n
Message-Id: <CAAEAJfCOWm4zOZ-cu40bR0o8O4QBZeMzrJyQiLoR85510QZP5g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Tomi,

Thanks for looking at this patch.

On 7 December 2015 at 13:01, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 25/11/15 05:11, Ezequiel Garcia wrote:
>> There's no point in having support for framebuffer notifications
>> is CONFIG_FB is disabled. This commit adds the necessary stubs
>> for code to link properly when CONFIG_FB=3Dn and moves fb-notify.o
>> to be built only when CONFIG_FB=3Dy.
>
> Why do you add CONFIG_FB_NOTIFY, isn't plain CONFIG_FB enough? Oh,
> right, to have it built-in even if FB is a module.
>

Right.

> But this makes me wonder, why is fb_notify in obj-y list currently.
> Nobody just bothered to make it build only when needed, or has there
> been some use for it earlier... The commit descriptions in git history
> suggest the former.
>

Here's the patch that created fb_notify.c and put it in obj-y.

    [PATCH] fbdev: statically link the framebuffer notification functions

    The backlight and lcd subsystems can be notified by the framebuffer lay=
er
    of blanking events.  However, these subsystems, as a whole, can function
    independently from the framebuffer layer.  But in order to enable to the
    lcd and backlight subsystems, the framebuffer has to be compiled also,
    effectively sucking in a huge amount of unneeded code.

    To prevent dependency problems, separate out the framebuffer notificati=
on
    mechanism from the framebuffer layer and permanently link it to the ker=
nel.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


> Actually, looks like fb_notify.c was originally made to solve the same
> problem as your patch solves, but by separating the notify code from the
> main fbdev code. So I still wonder, was there some reason to keep the
> notification code built instead of having stub functions.
>
> Any thoughts?
>

I can't see any valid reason to keep the code around, since there's no
way it can be used.
Let's see if Ccing Antonino and Andrew -as per that commit- helps.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
