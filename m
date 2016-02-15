From: Scot Doyle <lkml14@scotdoyle.com>
Date: Mon, 15 Feb 2016 21:12:43 +0000
Subject: Re: [PATCH] fbcon: set a default value to blink interval
Message-Id: <alpine.DEB.2.10.1602151500060.14844@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455561693-28615-1-git-send-email-jean-philippe.brucker@arm.com>
In-Reply-To: <1455561693-28615-1-git-send-email-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Thierry Reding <treding@nvidia.com>, stable@vger.kernel.org

On Mon, 15 Feb 2016, Jean-Philippe Brucker wrote:
> Since commit 27a4c827c34ac4256a190cc9d24607f953c1c459
> 	fbcon: use the cursor blink interval provided by vt
> 
> two attempts have been made at fixing a possible hang caused by
> cursor_timer_handler. That function registers a timer to be triggered at
> "jiffies + fbcon_ops.cur_blink_jiffies".
...
> Instead of patching all possible paths that lead to this case one at a
> time, fix the issue at the source and initialise cur_blink_jiffies to
> 200ms when allocating fbcon_ops. This was its default value before
> aforesaid commit. fbcon_cursor or fbcon_init will refine this value
> downstream.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: <stable@vger.kernel.org> # v4.2

I agree with the approach and the patch works on my x86_64.

Tested-by: Scot Doyle <lkml14@scotdoyle.com>

