From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 27 Feb 2014 18:16:13 +0000
Subject: Re: [PATCH 0/3] Reorder drivers/video directory
Message-Id: <530F80ED.1040509@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393502086-9433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393502086-9433-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 02/27/2014 03:54 AM, Tomi Valkeinen wrote:
> Hi,
> 
> This is a re-send of the series, with RFC removed from the subject, and a bunch
> of acks added.
> 
> I'm cc'ing more people, to make sure this doesn't come as a surprise, and to
> make sure this is not a bad idea, doomed to fail horribly.

What does this patch apply to?  I can't get it to apply cleanly to
-rc4 or Linus's current git tree.

I like what I see so far.

Thanks.

> So this series creates a new directory, drivers/video/fbdev/, to which all
> fbdev related files are moved. Also, a new directory, drivers/video/fbdev/core/
> is created, to which the core fbdev framework files are moved. This makes the
> drivers/video hierarchy much more clear.
> 
> Presuming no one has objections to this as such, I wonder what's the least
> painful way to merge this? Normally, like any other fbdev change? As a separate
> pull request, maybe at -rc2 time frame, based on -rc1? Something else?


-- 
~Randy
