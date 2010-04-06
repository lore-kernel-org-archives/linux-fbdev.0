From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 06 Apr 2010 08:14:46 +0000
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <87pr2datft.fsf@small.ssi.corp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roger Quadros <roger.quadros@nokia.com>
Cc: tony@atomide.com, Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Roger,

Roger Quadros <roger.quadros@nokia.com> writes:

> These patches get the N900 LCD panel working.
> Apply's cleanly on 2.6.34-rc2
>
> Pre-requisites:
> https://patchwork.kernel.org/patch/86318/
> https://patchwork.kernel.org/patch/86319/
> https://patchwork.kernel.org/patch/86320/

First, thanks for pushing the missing bits for N900 hardware support
upstream! I wanted to give your patches a try and test a l-o kernel on
my N900 (I know I won't have full hardware support ... at the moment).

Using current l-o tree with your 5 panel patches and the 3 you link on
patchwork, I initially ended up with a kernel panic in
omap3_onenand_write_bufferram() (i.e. unrelated to your patches).

With http://patchwork.ozlabs.org/patch/48337/ (mtd: OneNAND: OMAP3:
unmap correct DMA buffer), I am able to get the official Nokia
/sbin/preinit called: then, getbootstate reports a malfunction but
AFAICT, the panel is working ok.

If there are additional patches I should be aware of regarding N900
support, I am also interested.

Cheers,

a+
