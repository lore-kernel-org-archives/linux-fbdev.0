From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 19 May 2016 09:01:39 +0000
Subject: Re: [PATCH] fbcon: use default if cursor blink interval is not valid
Message-Id: <20160519090139.GA1539@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com>
 <20160517204912.GA29719@amd>
 <CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com>
 <alpine.DEB.2.10.1605181519540.8967@laptop>
 <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
 <alpine.DEB.2.10.1605182252230.12118@laptop>
In-Reply-To: <alpine.DEB.2.10.1605182252230.12118@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Jonathan Liu <net147@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, David Daney <david.daney@cavium.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Dann Frazier <dann.frazier@canonical.com>, Ming Lei <ming.lei@canonical.com>, Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, "Chintakuntla,
 Radha" <Radha.Chintakuntla@caviumnetworks.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, stable@vger.kernel.org, ddaney.cavm@gmail.com, Alistair Popple <alistair@popple.id.au>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org

Hi!

> Two current [1] and three previous [2] systems locked during boot
> because the cursor flash timer was set using an ops->cur_blink_jiffies
> value of 0. Previous patches attempted to solve the problem by moving
> variable initialization earlier in the setup sequence [2].
> 
> Use the normal cursor blink default interval of 200 ms if
> ops->cur_blink_jiffies is not in the range specified in commit
> bd63364caa8d. Since invalid values are not used, specific system
> initialization timings should not cause lockups.
> 
> [1] https://bugs.launchpad.net/bugs/1574814
> [2] see commits: 2a17d7e80f1d, f235f664a8af, a1e533ec07d5

Acked-by: Pavel Machek <pavel@ucw.cz>

>  static void cursor_timer_handler(unsigned long dev_addr)
>  {
>  	struct fb_info *info = (struct fb_info *) dev_addr;
>  	struct fbcon_ops *ops = info->fbcon_par;
>  
>  	queue_work(system_power_efficient_wq, &info->queue);
> -	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
> +	mod_timer(&ops->cursor_timer, jiffies +
> +	    cursor_blink_jiffies(ops->cur_blink_jiffies));
>  }
>  
>  static void fbcon_add_cursor_timer(struct fb_info *info)

And actually... perhaps mod_timer should have some check for too low
timeouts..?

WARN_ON?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
