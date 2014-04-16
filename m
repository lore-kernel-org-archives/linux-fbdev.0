From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Apr 2014 23:04:39 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.15
Message-Id: <CA+55aFz7Hgjc9wmiriqGT8VXNF-7b0aUKf96r=TCP+1NOTSVeQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <534E4775.8010009@ti.com>
In-Reply-To: <534E4775.8010009@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>

On Wed, Apr 16, 2014 at 2:03 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> The drivers/video/Kconfig change in this pull request will conflict with the
> fbdev reorder series, which is not yet in your tree. If that's an issue, I can
> resend this without the Kconfig change.

I was actually hoping/expecting you to just resend the renaming
rebased on top of 3.15-rc1. Or maybe you could do it on top of this.

            Linus
