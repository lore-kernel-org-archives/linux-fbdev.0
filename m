From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 11 Jan 2019 06:02:05 +0000
Subject: Re: [PATCH v4 2/2] printk: Export console_printk
Message-Id: <20190111060205.GA5766@jagdpanzerIV>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181030154419.2889-1-prarit@redhat.com>
 <20190110190325.15241-1-prarit@redhat.com>
 <20190110190325.15241-3-prarit@redhat.com>
In-Reply-To: <20190110190325.15241-3-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Yisheng Xie <ysxie@foxmail.com>, Thierry Reding <treding@nvidia.com>

On (01/10/19 14:03), Prarit Bhargava wrote:
> The fbcon code can be built as a module and requires console_printk.
>
> Export console_printk.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Marko Myllynen <myllynen@redhat.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
