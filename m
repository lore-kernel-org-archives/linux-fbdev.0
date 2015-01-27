From: Scot Doyle <lkml14@scotdoyle.com>
Date: Tue, 27 Jan 2015 01:06:29 +0000
Subject: Re: [PATCH v4 0/2] fbcon: user-defined cursor blink interval
Message-Id: <alpine.DEB.2.11.1501262331180.1638@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501262305150.2783@localhost.localdomain> <54C6CDDC.5010507@nod.at>
In-Reply-To: <54C6CDDC.5010507@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard.weinberger@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 27 Jan 2015, Richard Weinberger wrote:

> Am 27.01.2015 um 00:09 schrieb Scot Doyle:
> > Since users prefer different fbcon cursor blink intervals, allow the
> > interval to be set via sysfs. The current interval of 200 milliseconds
> > is retained as the default. Tested with intelfb.
> > 
> > v2:  Use kstrtos16() instead of kstrtoul() and min_t() as suggested by
> >      Geert Uytterhoeven
> > v3:  Add error messages as suggested by Tomi Valkeinen
> > v4:  Add rationale into patch descriptions as suggested by
> >      Richard Weinberger
> 
> Hehe, no need to resend immediately a v4, I'm just curios about the use case. :)
> Why do users want a different blink interval? What is the use case?
> And what are these users? Most people use a fbcon only for a few moments
> to fix/restart X11.
> 
> Thanks,
> //richard

Ah, I see! With multiple ncurses windows, some of which contain reversed 
characters, a blinking underscore is helpful for locating the cursor.
But, the 200 millisecond interval can be distracting. Another example is 
http://unix.stackexchange.com/questions/55423/how-to-change-cursor-shape-color-and-blinkrate-of-linux-console
