From: Petr Mladek <pmladek@suse.com>
Date: Wed, 27 Jun 2018 13:31:40 +0000
Subject: Re: [PATCH v3 1/3] printk: Export is_console_locked
Message-Id: <20180627133140.l3qhhy5g5h5vwhc5@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
 <20180626183612.321-2-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org

On Tue 2018-06-26 20:36:10, Hans de Goede wrote:
> This is a preparation patch for adding a number of WARN_CONSOLE_UNLOCKED()
> calls to the fbcon code, which may be built as a module (event though
> usually it is not).
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
