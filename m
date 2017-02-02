From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Thu, 02 Feb 2017 13:31:48 +0000
Subject: Re: [PATCH v2] printk: Correctly handle preemption in console_unlock()
Message-Id: <20170202133148.GA1845@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1485353325-26591-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1485353325-26591-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On (01/25/17 15:08), Petr Mladek wrote:
[..]
> Fixes: 6b97a20d3a7909 ("printk: set may_schedule for some of console_trylock() callers")
> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
