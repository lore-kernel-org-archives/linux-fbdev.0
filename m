From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 06 May 2019 13:32:52 +0000
Subject: Re: [PATCH] fbcon: Don't reset logo_shown when logo is currently shown
Message-Id: <4a5fe468-c153-910a-098e-3d6cff3432c8@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190129134350.24049-1-prarit@redhat.com>
 <20190129134350.24049-3-prarit@redhat.com> <87ftr1ed4h.fsf@igel.home>
 <8590ff59-a4fb-5a02-fda4-086476efcbe6@redhat.com>
 <CGME20190402180939epcas4p15a2bd8dc16a3e56a5f62cdcf396a2404@epcas4p1.samsung.com>
 <87imvwp9d4.fsf_-_@igel.home>
In-Reply-To: <87imvwp9d4.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Marko Myllynen <myllynen@redhat.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>


On 04/02/2019 08:09 PM, Andreas Schwab wrote:
> When the logo is currently drawn on a virtual console, and the console
> loglevel is reduced to quiet, logo_shown must be left alone, so that it
> the scrolling region on that virtual console is properly reset.
> 
> Fixes: 10993504d647 ("fbcon: Silence fbcon logo on 'quiet' boots")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
