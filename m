From: Brian Swetland <swetland@google.com>
Subject: Re: Framebuffer support for HTC Dream
Date: Mon, 29 Jun 2009 13:00:33 -0700
Message-ID: <a55d774e0906291300u3bb9b491r124f27fdf832b495@mail.gmail.com>
References: <20090629111029.GA15514@elf.ucw.cz>
	 <20090629123840.1e20f17d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759383AbZF2UAo@vger.kernel.org>
In-Reply-To: <20090629123840.1e20f17d.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Andrew Morton <akpm@linux-foundation.org>, Rebecca Schultz Zavin <rebecca@android.com>, Dima Zavin <dima@android.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, Jun 29, 2009 at 12:38 PM, Andrew
Morton<akpm@linux-foundation.org> wrote:
> On Mon, 29 Jun 2009 13:10:30 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
>> I cleaned up dead code, a lot of debugging infastructure and horrifi=
c
>> logo code. I had to remove earlysuspend support, because neccessary
>> headers are not in mainline. The driver still works :-).
>
> So you didn't wrote the code?
>
>> This adds support for framebuffer on HTC Dream smartphone (aka
>> T-Mobile G1, aka ADP1).
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>> Cc: Brian Swetland <swetland@google.com>
>
> Someone did. =C2=A0Are the signoffs and attributions correct and
> appropriate? =C2=A0Should we at least mention the driver's history in=
 the
> changelog?
>
> Will it have a maintainer?

I did the original quick and dirty version for bringup.  Rebecca took
over and (re)wrote the bulk of the driver, getting things stable for
production ship of Dream and Sapphire, and Dima is currently adding
support for later Qualcomm chipsets (QSD8x50, etc).  Looping them into
this discussion.

It would probably be worth referring to drivers like this as "for
Qualcomm MSM/QSD SoCs" or the like, since they do work with a lot of
hardware beyond just Dream.

Brian
