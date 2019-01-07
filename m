From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Mon, 07 Jan 2019 10:09:42 +0000
Subject: Re: [PATCH v3] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20190107100942.GA11039@jagdpanzerIV>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181030154456epcas4p19e91c78daad3f1f48e8260601e5fdfec@epcas4p1.samsung.com>
 <20181030154419.2889-1-prarit@redhat.com>
 <3de54c0d-3e9b-769f-5cc6-e69dbb399426@samsung.com>
In-Reply-To: <3de54c0d-3e9b-769f-5cc6-e69dbb399426@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

On (12/20/18 17:31), Bartlomiej Zolnierkiewicz wrote:
[..]
> > +++ b/kernel/printk/printk.c
> > @@ -66,6 +66,7 @@ int console_printk[4] = {
> >  	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
> >  	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
> >  };
> > +EXPORT_SYMBOL(console_printk);
> 
> You need printk Maintainers Ack on it.

I would prefer this to be in a separate patch, probably.

Exporting (I think EXPORT_SYMBOL_GPL would be better) console_printk[4]
seems to be the simplest solution.

Alternatively, we can have a new fbcon function which would be called
from quiet_kernel() and would set logo_shown accordingly.

	-ss
