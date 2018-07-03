From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Tue, 03 Jul 2018 16:36:36 +0000
Subject: Re: [PATCH v5 3/3] console/fbcon: Add support for deferred console takeover
Message-Id: <20180703163636.GC391@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-4-hdegoede@redhat.com>
 <20180703161327.GA391@tigerII.localdomain>
 <20180703121429.283faef0@gandalf.local.home>
In-Reply-To: <20180703121429.283faef0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hans de Goede <hdegoede@redhat.com>

On (07/03/18 12:14), Steven Rostedt wrote:
> > Can we please default this to 'n'?
> >
> 
> No explicit default means 'n'. You don't need to specify it.

Ah, OK. Thanks.

	-ss
