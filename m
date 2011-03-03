From: Yong Zhang <yong.zhang0@gmail.com>
Date: Thu, 03 Mar 2011 09:12:12 +0000
Subject: Re: (WARNING) possible deadlock in del_timer_sync, called from fbcon_del_cursor_timer
Message-Id: <AANLkTi=q72vKVi0frZefzBAS2_CfHKqOtTadWvyhGwcE@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D6BB403.9000908@ladisch.de>
	<20110302181223.GD9288@home.goodmis.org>
In-Reply-To: <20110302181223.GD9288@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Denys Vlasenko <vda.linux@googlemail.com>, Jason Wessel <jason.wessel@windriver.com>

On Thu, Mar 3, 2011 at 2:12 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, Feb 28, 2011 at 03:41:07PM +0100, Clemens Ladisch wrote:
>> While using the FB console, I tried to change the console log level
>> with SysRq, and got this warning that del_timer_sync() is used in
>> an interrupt handler:
>
> Ug, del_timer_sync() can be called from interrupt context:
>
> printk -> vt_console_print -> hide_cursor -> fbcon_cursor
> -> fbcon_del_cursor_time -> del_timer_sync()
>
> printk is allowed to be called from interrupt context. This is indeed a
> true bug.

Yeah.

And more explanation for that WARN_ON() :)

run_timer_softirq(SOFTIRQ context)
  cursor_timer_handler()
  Interrupt comes in(IRQ context)
    ...
      del_timer_sync()
        deadlock

So fbcon guys:
Could above situation happen?

Cc'ing people from:
./scripts/get_maintainer.pl -f drivers/video/console/fbcon.c

Thanks,
Yong


-- 
Only stand for myself
