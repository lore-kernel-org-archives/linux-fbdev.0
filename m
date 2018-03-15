From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Mar 2018 09:48:35 +0000
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Message-Id: <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
In-Reply-To: <2929.1521106970@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-spi <linux-spi@vger.kernel.org>, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-input@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-rtc@vger.kernel.org

Hi David,

On Thu, Mar 15, 2018 at 10:42 AM, David Howells <dhowells@redhat.com> wrote:
> Do we have anything left that still implements NOMMU?

Sure: arm, c6x, m68k, microblaze, and  sh.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
