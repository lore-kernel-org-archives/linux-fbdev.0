From: Fabio Erculiani <lxnay@sabayon.org>
Date: Wed, 25 May 2011 19:04:45 +0000
Subject: Re: [PATCH] fbmem: fix race condition between register_framebuffer()
Message-Id: <BANLkTimtYvcN8kj+jnaKHNGmN36YvMt7Rg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
	<BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
	<20110525204648.58983270@neptune.home>
	<BANLkTi=207-bVi3pnOWk7zG61u4=YU4GFg@mail.gmail.com>
	<20110525205707.12abc68c@neptune.home>
In-Reply-To: <20110525205707.12abc68c@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Wed, May 25, 2011 at 8:57 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
>> On Wed, May 25, 2011 at 8:46 PM, Bruno Prémont wrote:
>> > On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
>> >> I'm not a fbdev expert. So I leave the real fix to real men ( ;-) ).
>> >> It is causing deadlock during boot, so I would consider it quite critical.
>> >> Users using any fb driver will get into troubles.
>> >> The workaround is to boot with vga=normal.
>> >
>> > What is your system doing during boot? I've never seen it here but maybe
>> > my boot sequence is too simple.
>>
>> I'm using vesafb and vgay1. It is quite simple to reproduce.
>> Also see: http://bugs.gentoo.org/show_bug.cgi?id68109
>
> Looks like gentoo kernel, might be splash is related to the hang

Then, if you say so, it must be the fbsplash patch for sure, I keep
forgetting of that :-/

>
>> > Could you tell if it deadlocks before init gets started or afterwards,
>> > which fb drivers (and extra kernel patches if any) are in use.
>>
>> Exactly when register_framebuffer() is called, in my case, early in
>> the boot phase, before init.
>>
>> >
>> > If you have the complete backtrace of the deadlocked processes it would
>> > help getting a better idea of what is affected and how (and why just the
>> > framebuffer's lock is not causing trouble with earlier kernel versions).
>>
>> Because that code got a HUGE rewrite in the latest cycle, where
>> registration_lock has been introduce.
>> Just make a diff between 2.6.38 and 2.6.39. It will be easy to see
>> that SO MANY lines have changed ;-)
>> Anyway, since I'm out of office these days, I won't be able to send
>> you the traceback this week, but since so many people have run into
>> it, I guess it's fairly simple to reproduce.
>
> Rewrite was not so huge, and I'm not affected here (running with KMS
> compiled in though and vanilla kernel).
> Probably the cause is related to one of the extra patches provided by
> Gentoo and subscribing to framebuffer registration notifications.
>
> Will have a look.

Thanks a lot, let me know if I can help out next week.

>
> Bruno
>



-- 
Fabio Erculiani
