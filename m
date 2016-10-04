From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 04 Oct 2016 07:09:04 +0000
Subject: Re: [PATCH -resend 4/6] mdacon: enable COMPILE_TEST build
Message-Id: <6c80ac98-8034-0007-0e98-755609b78fcd@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161003090736.19926-1-jslaby@suse.cz>
 <20161003090736.19926-4-jslaby@suse.cz>
 <CAMuHMdVv+z926OUd6v-P9CBEhKHWkFJFgLxdt=Cizw8JMh2VVg@mail.gmail.com>
In-Reply-To: <CAMuHMdVv+z926OUd6v-P9CBEhKHWkFJFgLxdt=Cizw8JMh2VVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On 10/03/2016, 11:35 AM, Geert Uytterhoeven wrote:
>> -       depends on !M68K && !PARISC && ISA
>> +       depends on !M68K && !PARISC && (ISA || COMPILE_TEST)
> 
> My first thought was
> 
>     depends on (!M68K && !PARISC && ISA) || COMPILE_TEST
> 
> but arch/m68k/include/asm/vga.h doesn't define VGA_MAP_MEM().
> Adding #include <asm-generic/vga.h> at the end of arch/m68k/include/asm/vga.h
> fixes that.
> 
> Do we want that?

The driver is not used much nowadays, so compile-testing on other
architectures is not worth it IMHO.

thanks,
-- 
js
suse labs
