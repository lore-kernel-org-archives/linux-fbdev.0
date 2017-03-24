From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Fri, 24 Mar 2017 23:57:06 +0000
Subject: Re: [PATCH v3] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170324235706.GB6356@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170202093011.1e067ea7@gandalf.local.home>
 <1490372045-22288-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1490372045-22288-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (03/24/17 17:14), Petr Mladek wrote:
[..]
> Fixes: 6b97a20d3a7909 ("printk: set may_schedule for some of console_trylock() callers")
> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
