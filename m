From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 03 Jul 2018 16:14:29 +0000
Subject: Re: [PATCH v5 3/3] console/fbcon: Add support for deferred console takeover
Message-Id: <20180703121429.283faef0@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-4-hdegoede@redhat.com>
 <20180703161327.GA391@tigerII.localdomain>
In-Reply-To: <20180703161327.GA391@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>

On Wed, 4 Jul 2018 01:13:27 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (06/28/18 11:03), Hans de Goede wrote:
> [..]
> >  
> > +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> > +	bool "Framebuffer Console Deferred Takeover"
> > +	depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y  
> 
> +	default n
> 
> > +	help
> > +	  If enabled this defers the framebuffer console taking over the
> > +	  console from the dummy console until the first text is displayed on
> > +	  the console. This is useful in combination with the "quiet" kernel
> > +	  commandline option to keep the framebuffer contents initially put up
> > +	  by the firmware in place, rather then replacing the contents with a
> > +	  black screen as soon as fbcon loads.  
> 
> Can we please default this to 'n'?
>

No explicit default means 'n'. You don't need to specify it.

-- Steve
