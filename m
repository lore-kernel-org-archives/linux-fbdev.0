From: Fabio Erculiani <lxnay@sabayon.org>
Date: Wed, 25 May 2011 19:16:31 +0000
Subject: Re: [PATCH] fbmem: fix race condition between register_framebuffer()
Message-Id: <BANLkTikYXtYYV+stQMdgnKhg4MpxZBvgnA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
	<20110524224545.08c53b1d@neptune.home>
	<20110525181917.12cf97b8@neptune.home>
	<BANLkTimxi-LZFzwv=z6RRBCX098hr-ViUg@mail.gmail.com>
	<20110525204648.58983270@neptune.home>
	<BANLkTi=207-bVi3pnOWk7zG61u4=YU4GFg@mail.gmail.com>
	<20110525205707.12abc68c@neptune.home>
	<BANLkTimtYvcN8kj+jnaKHNGmN36YvMt7Rg@mail.gmail.com>
	<20110525211253.4985ee79@neptune.home>
In-Reply-To: <20110525211253.4985ee79@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org

On Wed, May 25, 2011 at 9:12 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
>> On Wed, May 25, 2011 at 8:57 PM, Bruno Prémont wrote:
>> > On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
>> >> On Wed, May 25, 2011 at 8:46 PM, Bruno Prémont wrote:
>> >> > On Wed, 25 May 2011 Fabio Erculiani <lxnay@sabayon.org> wrote:
>> >> >> I'm not a fbdev expert. So I leave the real fix to real men ( ;-) ).
>> >> >> It is causing deadlock during boot, so I would consider it quite critical.
>> >> >> Users using any fb driver will get into troubles.
>> >> >> The workaround is to boot with vga=normal.
>> >> >
>> >> > What is your system doing during boot? I've never seen it here but maybe
>> >> > my boot sequence is too simple.
>> >>
>> >> I'm using vesafb and vgay1. It is quite simple to reproduce.
>> >> Also see: http://bugs.gentoo.org/show_bug.cgi?id68109
>> >
>> > Looks like gentoo kernel, might be splash is related to the hang
>>
>> Then, if you say so, it must be the fbsplash patch for sure, I keep
>> forgetting of that :-/
>
> I've had a look at the bug report which points at fbcon_decore
> patch.
>
> Looking into that patch confirms my impression:
>  fbcon_decor calls a userspace helper at the time fbcon takes over
>  console and that userspace helper then tries to open fb device
>  with the aim of calling some IOCTLs.
>
> Probably changing fbcon_decor to just call the userspace helper in
> non-blocking mode (or having userspace helper "fork and detach") would
> avoid the deadlock as well.
> Though fbcon_decor seems to rely on helper's return code...
>
> What is the matching piece on userspace side so I can look at it as well?

I guess you're talking about this:
http://fbsplash.berlios.de/wiki/doku.php
the package is named splashutils, and contains userspace helpers.

>
> Bruno
>



-- 
Fabio Erculiani
