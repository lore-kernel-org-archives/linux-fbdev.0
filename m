From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH 04/05] video: deferred io sys helpers - metronome
Date: Wed, 24 Dec 2008 14:46:59 +0900
Message-ID: <aec7e5c30812232146t5dff36act9f4d5badc25bef22@mail.gmail.com>
References: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se>
	 <20081222055309.27821.40219.sendpatchset@rx1.opensource.se>
	 <45a44e480812232058g5e81ee97r95c4b9c1ed81066@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <45a44e480812232058g5e81ee97r95c4b9c1ed81066@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

On Wed, Dec 24, 2008 at 1:58 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Mon, Dec 22, 2008 at 12:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> +       if (fbdefio->dx != -1) {
>> +               /* update the entire screen */
>> +               metronomefb_dpy_update(par);
>
> Okay, overall seems okay. But I'm not confident about this specific
> change above. The meaning of dx, etc is not clear to me. Okay, I think
> I found a problem with above. Here's my explanation, please correct me
> if I'm wrong in my reading of the code you've posted. The typical use
> case is just a single mmap client (eg: Xfbdev) and nothing else. No
> fbcon. The only code path I see that sets defio->dx is in the
> write/blit/* paths via the defio_touch in patch 1/5 and none in the
> mmap path so with this implementation, all mmap clients would
> repeatedly only hit the above full update scenario and never use the
> page based update mechanism.

Hm, I wonder if I reversed the logic by mistake, but I don't think so.
The idea is that dx should be set to -1 by default and stay that way
unless write/blit/* has been used. After each deferred io work dx is
reset to -1. If dx is not -1 in the deferred io callback then we need
to refresh the area specified by dx, dy, width, height _and_ the
pages. The xen driver does this.

In the metronome driver case we update the entire screen if dx has
been set which means we can skip the pages since they are considered
part of the entire screen. This should be the same behavior as before,
the local write/bit/* functions all call metronome_dpy_update()
without this patch.

Or maybe my logic is broken?

Btw, patch [1/5] is somewhat broken today with the handling of
sysdelay vs delay. Ideally I'd like to get rid of sysdelay and let
write/blit/* use the same delay as mmap(). Not sure if you are keen on
that though since it changes the behavior of your drivers. Otoh that
may make fbcon usable on e-paper since it decouples the soft cursor
refresh rate from the screen refresh rate.

> Other than the above problem, looks okay and its nice to get rid of
> all that stuff above. :-)

Excellent, thanks!

Cheers,

/ magnus
