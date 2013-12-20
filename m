From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Dec 2013 16:20:31 +0000
Subject: Re: [PATCH] video/logo: don't look for the logo after system boot
Message-Id: <CAMuHMdUkHMoZ=g6N_WkP-qtPdqYCy9BYrN-tSwEHwgu5Eh1ndg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 20, 2013 at 4:49 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 12/20/2013 04:31 PM, Sebastian Andrzej Siewior wrote:
>> On 12/20/2013 04:27 PM, Geert Uytterhoeven wrote:
>>> On Fri, Dec 20, 2013 at 3:24 PM, Sebastian Andrzej Siewior
>>> <bigeasy@linutronix.de> wrote:
>>>> If the primary GPU driver has been loaded _after_ system as a module
>>>> then this logo memory is no longer valid.
>>>> Managed to crash the system by booting a box without a GPU and then
>>>> hotpluggin => BOOM.
>>>
>>> drivers/video/fbmem.c:fb_prepare_logo() has protection against this:
>>>
>>>         if (info->flags & FBINFO_MISC_TILEBLITTING ||
>>>             info->flags & FBINFO_MODULE)
>>>                 return 0;
>>
>> but gpu driver is built-in. I just add PCI device at run-time. The same
>> thing should happen if you go to sysfs and remove the PCI device and
>> then do
>
> No I see where you are going with this. My description of the problem
> is wrong. The problem is nothing to do with the driver being a module.

Yes, I got confused by the "as a module".

> If nobody objects this or suggests a different solution then I'm going
> to provide a patch with a proper description.

Is "system_state != SYSTEM_BOOTING" the right check?
How long is is in the SYSTEM_BOOTING state?

Ah, kernel_init() does:

        free_initmem();
        mark_rodata_ro();
        system_state = SYSTEM_RUNNING;

So this looks OK to me.

We used to have an initmem_freed flag, but it was removed 15 years
ago. 11 years ago, we got system_state, for the same purpose ;-)

Looking at commit 70802c60379fb843c485dfd4cab9e8f527d8fe81
Author: Antonino A. Daplas <adaplas@gmail.com>
Date:   Tue May 8 00:38:14 2007 -0700

    fbdev: don't show logo if driver or fbcon are modular

it seems we were not aware of the existence of system_state....
I guess you can remove FBINFO_MODULE after your fix?

BTW, I'm wondering if modprobing newport_con.ko crashes, too, as
it seems to call fb_find_logo() without any protection.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
