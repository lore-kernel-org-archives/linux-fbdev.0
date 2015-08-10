From: Scot Doyle <lkml14@scotdoyle.com>
Date: Mon, 10 Aug 2015 14:05:53 +0000
Subject: Re: [PATCH] fbcon: unconditionally initialize cursor blink interval
Message-Id: <alpine.DEB.2.11.1508101358210.1286@local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1508041215100.1151@local> <20150804203250.GA655@amd>
In-Reply-To: <20150804203250.GA655@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Liu <net147@gmail.com>, Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 4 Aug 2015, Pavel Machek wrote:
> On Tue 2015-08-04 12:33:32, Scot Doyle wrote:
> > A sun7i-a20-olinuxino-micro fails to boot when kernel parameter
> > vt.global_cursor_default=0. The value is copied to vc->vc_deccm
> > causing the initialization of ops->cur_blink_jiffies to be skipped.
> > Unconditionally initialize it.
> > 
> > Reported-and-tested-by: Jonathan Liu <net147@gmail.com>
> > Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 

Tomi, this one should also go in 4.2 fixes.

