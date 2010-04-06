From: Roger Quadros <roger.quadros@nokia.com>
Date: Tue, 06 Apr 2010 09:50:42 +0000
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Message-Id: <4BBB03F2.5050706@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com> <87pr2datft.fsf@small.ssi.corp>
In-Reply-To: <87pr2datft.fsf@small.ssi.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Arnaud Ebalard <arno@natisbad.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

ext Arnaud Ebalard wrote:
> Hi Roger,
> 
> Roger Quadros <roger.quadros@nokia.com> writes:
> 
>> These patches get the N900 LCD panel working.
>> Apply's cleanly on 2.6.34-rc2
>>
>> Pre-requisites:
>> https://patchwork.kernel.org/patch/86318/
>> https://patchwork.kernel.org/patch/86319/
>> https://patchwork.kernel.org/patch/86320/
> 
> First, thanks for pushing the missing bits for N900 hardware support
> upstream! I wanted to give your patches a try and test a l-o kernel on
> my N900 (I know I won't have full hardware support ... at the moment).
> 
> Using current l-o tree with your 5 panel patches and the 3 you link on
> patchwork, I initially ended up with a kernel panic in
> omap3_onenand_write_bufferram() (i.e. unrelated to your patches).
> 
> With http://patchwork.ozlabs.org/patch/48337/ (mtd: OneNAND: OMAP3:
> unmap correct DMA buffer), I am able to get the official Nokia
> /sbin/preinit called: then, getbootstate reports a malfunction but
> AFAICT, the panel is working ok.
> 
The getbootstate malfunction is expected as there is no support for it yet in 
mainline. But you should get to shell without that.

You could hack the startup script to spawn a getty on ttyS2. This should get you 
to shell.

so in /sbin/preinit, in start_shell()

-/sbin/getty 115200 ttyS0 -n -l /bin/sh
+/sbin/getty 115200 ttyS2 -n -l /bin/sh

cheers,
-roger
