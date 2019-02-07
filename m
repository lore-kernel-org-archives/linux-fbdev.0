From: Petr Mladek <pmladek@suse.com>
Date: Thu, 07 Feb 2019 11:55:34 +0000
Subject: Re: [PATCH v5 1/2] printk: Export console_printk
Message-Id: <20190207115534.65pr5vclmdrqts4y@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue 2019-01-29 08:43:49, Prarit Bhargava wrote:
> The fbcon can be built as a module and requires console_printk.
> 
> Export console_printk.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>

Acked-by: Petr Mladek <pmladek@suse.com>

BTW: Also the 2nd patch looks good. But I could not reply
on it because I was neither on CC nor I am subscribed
to the used mailing lists.

I personally prefer to send the entire patchset to all
affected people. It helps to review even a single patch
in the context of the others.

Best Regards,
Petr
