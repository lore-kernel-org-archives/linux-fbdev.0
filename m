From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Thu, 25 Jul 2013 10:02:21 +0000
Subject: Re: [PATCH] driver/vga16fb.c: remove the unused variable "dev" of function vga16fb_destroy()
Message-Id: <51F0F7AD.5000408@cn.fujitsu.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51F09D5E.70304@cn.fujitsu.com> <CAMuHMdVxXLrUXQno+vtHQrT_mmc9C6q42HZ6F1TujLBeEZt+Mw@mail.gmail.com>
In-Reply-To: <CAMuHMdVxXLrUXQno+vtHQrT_mmc9C6q42HZ6F1TujLBeEZt+Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 07/25/2013 05:58 PM, Geert Uytterhoeven wrote:

> On Thu, Jul 25, 2013 at 5:37 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>> Commit  e21d2170f36602ae2708 removed the unnecessary platform_set_drvdata(),
>> but left the variable "dev" unused, delete it.
> 
> When referring to another commit, please also include the oneline summary of
> the commit, to make it easier for people to see what it's about.

Got it, thanks for your reminder.:)

> 
> E.g. "Commit  e21d2170f36602ae2708 ("video: remove unnecessary
> platform_set_drvdata()") removed the unnecessary platform_set_drvdata(),
> but left the variable "dev" unused, delete it."

This is easier reading. I'll update it.

Regards,
Gu


> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


