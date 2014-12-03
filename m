From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 03 Dec 2014 17:28:19 +0000
Subject: Re: [PATCH v2 2/2] backlight/lp855x: Add supply regulator to lp855x
Message-Id: <CAOw6vbKWhonBV30HsQWebec4bE_ogoL6RkgfZrAeKq4+=VnpJQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org>
 <1417570752-23633-2-git-send-email-seanpaul@chromium.org> <5204192.bzM5jPIgHv@wuerfel>
In-Reply-To: <5204192.bzM5jPIgHv@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Kim, Milo" <milo.kim-l0cyMroinI0@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Aaron Durbin <adurbin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On Wed, Dec 3, 2014 at 6:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 02 December 2014 17:39:12 Sean Paul wrote:
>>
>>  .../devicetree/bindings/video/backlight/lp855x.txt     |  2 ++
>>  drivers/video/backlight/lp855x_bl.c                    | 18 ++++++++++++++++++
>>  include/linux/platform_data/lp855x.h                   |  2 ++
>>  3 files changed, 22 insertions(+)
>
> While your two patches are both correct (and applied already), I took
> a look at the platform_data header and noticed that all users of this
> file have been converted to DT a while ago, so it would be nice to clean
> it up by integrating the linux/platform_data/lp855x.h header file into the
> drivers/video/backlight/lp855x_bl.c itself.
>
> You can then merge struct lp855x_platform_data into lp855x to avoid the
> extra dynamic allocation and remove all the 'pdata' references in the
> driver.
>

Hi Arnd,
Thanks for the suggestion. Indeed, that will be much cleaner, I'll
send a follow-up patch.

Sean

>         Arnd
