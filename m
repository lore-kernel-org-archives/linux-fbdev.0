From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 26 Jul 2020 08:58:20 +0000
Subject: Re: [PATCH] [video/fbdev] fb_flashcursor: Remove redundant null check
Message-Id: <CAHp75Vf0F+vtgg_NB0dL5Ck9m4_7fEHyH84mWrhTOXrEoL5SGA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200726050713.9461-1-gaurav1086@gmail.com>
In-Reply-To: <20200726050713.9461-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gaurav Singh <gaurav1086@gmail.com>
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Nathan Chancellor <natechancellor@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Qiujun Huang <hqjagain@gmail.com>

On Sun, Jul 26, 2020 at 8:17 AM Gaurav Singh <gaurav1086@gmail.com> wrote:
>
> ops cannot be NULL as its being accessed later without

it's

> checks. Remove the redundant NULL check.

Commit message doesn't clarify why your fix is the correct one.
Maybe it's the other way around, missed check in the rest of the code there?

-- 
With Best Regards,
Andy Shevchenko
