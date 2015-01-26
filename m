From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Jan 2015 23:29:32 +0000
Subject: Re: [PATCH v4 0/2] fbcon: user-defined cursor blink interval
Message-Id: <54C6CDDC.5010507@nod.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501262305150.2783@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501262305150.2783@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard.weinberger@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am 27.01.2015 um 00:09 schrieb Scot Doyle:
> Since users prefer different fbcon cursor blink intervals, allow the
> interval to be set via sysfs. The current interval of 200 milliseconds
> is retained as the default. Tested with intelfb.
> 
> v2:  Use kstrtos16() instead of kstrtoul() and min_t() as suggested by
>      Geert Uytterhoeven
> v3:  Add error messages as suggested by Tomi Valkeinen
> v4:  Add rationale into patch descriptions as suggested by
>      Richard Weinberger

Hehe, no need to resend immediately a v4, I'm just curios about the use case. :)
Why do users want a different blink interval? What is the use case?
And what are these users? Most people use a fbcon only for a few moments
to fix/restart X11.

Thanks,
//richard
