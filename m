From: Ming Lei <ming.lei@canonical.com>
Date: Thu, 19 May 2016 15:31:43 +0000
Subject: Re: [PATCH] fbcon: use default if cursor blink interval is not valid
Message-Id: <CACVXFVOQymQ1HdPOMdB8cZ_Bas-fChPR3-ffhCWAWGxYhkWKBA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com>
	<20160517204912.GA29719@amd>
	<CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com>
	<alpine.DEB.2.10.1605181519540.8967@laptop>
	<ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
	<alpine.DEB.2.10.1605182252230.12118@laptop>
	<20160519090139.GA1539@amd>
	<alpine.DEB.2.10.1605190903170.13857@laptop>
In-Reply-To: <alpine.DEB.2.10.1605190903170.13857@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Pavel Machek <pavel@ucw.cz>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, David Daney <david.daney@cavium.com>, Dann Frazier <dann.frazier@canonical.com>, Jeremy Kerr <jk@ozlabs.org>, Peter Hurley <peter@hurleysoftware.com>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, May 19, 2016 at 10:22 PM, Scot Doyle <lkml14@scotdoyle.com> wrote:
> On Thu, 19 May 2016, Pavel Machek wrote:
>> Hi!
>>
>> > Two current [1] and three previous [2] systems locked during boot
>> > because the cursor flash timer was set using an ops->cur_blink_jiffies
>> > value of 0. Previous patches attempted to solve the problem by moving
>> > variable initialization earlier in the setup sequence [2].
>> >
>> > Use the normal cursor blink default interval of 200 ms if
>> > ops->cur_blink_jiffies is not in the range specified in commit
>> > bd63364caa8d. Since invalid values are not used, specific system
>> > initialization timings should not cause lockups.
>> >
>> > [1] https://bugs.launchpad.net/bugs/1574814
>> > [2] see commits: 2a17d7e80f1d, f235f664a8af, a1e533ec07d5
>>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>
>> >  static void cursor_timer_handler(unsigned long dev_addr)
>> >  {
>> >     struct fb_info *info = (struct fb_info *) dev_addr;
>> >     struct fbcon_ops *ops = info->fbcon_par;
>> >
>> >     queue_work(system_power_efficient_wq, &info->queue);
>> > -   mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
>> > +   mod_timer(&ops->cursor_timer, jiffies +
>> > +       cursor_blink_jiffies(ops->cur_blink_jiffies));
>> >  }
>> >
>> >  static void fbcon_add_cursor_timer(struct fb_info *info)
>>
>> And actually... perhaps mod_timer should have some check for too low
>> timeouts..?
>>
>> WARN_ON?
>>                                                                       Pavel
>
>
> Interesting idea. I applied this patch to a couple systems and
> receive the same warning on both:

If 'jiffies' is passed to mod_timer() for same timer unusually OR
mod_timer() isn't called from the timer handler, it shoudln't cause
soft lockup.

In the case of fbcon, 'jiffies' is always passed to mod_timer() and
mod_timer() is called from the timer handler meantime, that is a
real lockup.

>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 73164c3..f6c0b69 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -788,6 +788,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
>
>         timer_stats_timer_set_start_info(timer);
>         BUG_ON(!timer->function);
> +       WARN_ONCE(expires = jiffies, "timer should expire in the future");
>
>         base = lock_timer_base(timer, &flags);
>
> ------
>
> [    2.060474] ------------[ cut here ]------------
> [    2.061613] WARNING: CPU: 0 PID: 164 at kernel/time/timer.c:791 mod_timer+0x233/0x240
> [    2.062740] timer should expire in the future
> [    2.062757] CPU: 0 PID: 164 Comm: kworker/0:2 Not tainted 4.6.0+ #7
> [    2.065870] Hardware name: Toshiba Leon, BIOS          12/04/2013
> [    2.067828] Workqueue: events_power_efficient hub_init_func3
> [    2.069762]  0000000000000000 ffff88007443bbb8 ffffffff8139932b ffff88007443bc08
> [    2.071701]  0000000000000000 ffff88007443bbf8 ffffffff8112e57c 0000031700000000
> [    2.073655]  ffff88007486a0b0 00000000fffea2da ffff88007486a000 0000000000000202
> [    2.075594] Call Trace:
> [    2.077503]  [<ffffffff8139932b>] dump_stack+0x4d/0x72
> [    2.079426]  [<ffffffff8112e57c>] __warn+0xcc/0xf0
> [    2.081325]  [<ffffffff8112e5ef>] warn_slowpath_fmt+0x4f/0x60
> [    2.083212]  [<ffffffff813ad5e5>] ? find_next_bit+0x15/0x20
> [    2.085022]  [<ffffffff8139914f>] ? cpumask_next_and+0x2f/0x40
> [    2.086696]  [<ffffffff81188a93>] mod_timer+0x233/0x240
> [    2.088362]  [<ffffffff815fff02>] usb_hcd_submit_urb+0x3f2/0x8c0
> [    2.090026]  [<ffffffff81601dc4>] ? urb_destroy+0x24/0x30
> [    2.091698]  [<ffffffff81142ba8>] ? insert_work+0x58/0xb0
> [    2.093349]  [<ffffffff81602297>] usb_submit_urb+0x287/0x530
> [    2.094985]  [<ffffffff815f986d>] hub_activate+0x1fd/0x5d0
> [    2.096625]  [<ffffffff81150188>] ? finish_task_switch+0x78/0x1f0
> [    2.098268]  [<ffffffff815f9cca>] hub_init_func3+0x1a/0x20
> [    2.099908]  [<ffffffff811438e0>] process_one_work+0x140/0x3e0
> [    2.101539]  [<ffffffff81143bce>] worker_thread+0x4e/0x480
> [    2.103173]  [<ffffffff81143b80>] ? process_one_work+0x3e0/0x3e0
> [    2.104790]  [<ffffffff81143b80>] ? process_one_work+0x3e0/0x3e0
> [    2.106259]  [<ffffffff81149829>] kthread+0xc9/0xe0
> [    2.107731]  [<ffffffff81856152>] ret_from_fork+0x22/0x40
> [    2.109215]  [<ffffffff81149760>] ? __kthread_parkme+0x70/0x70
> [    2.110704] ---[ end trace 3519886a1a990d99 ]---
>
> mod_timer is called from over a thousand places. Should timers always
> expire in the future?
>
