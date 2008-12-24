From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 04/05] video: deferred io sys helpers - metronome
Date: Wed, 24 Dec 2008 01:44:12 -0500
Message-ID: <45a44e480812232244o257e4878g61e283fcc1595f65@mail.gmail.com>
References: <20081222055233.27821.68008.sendpatchset@rx1.opensource.se>
	 <20081222055309.27821.40219.sendpatchset@rx1.opensource.se>
	 <45a44e480812232058g5e81ee97r95c4b9c1ed81066@mail.gmail.com>
	 <aec7e5c30812232146t5dff36act9f4d5badc25bef22@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <aec7e5c30812232146t5dff36act9f4d5badc25bef22@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

On Wed, Dec 24, 2008 at 12:46 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
> Btw, patch [1/5] is somewhat broken today with the handling of
> sysdelay vs delay. Ideally I'd like to get rid of sysdelay and let
> write/blit/* use the same delay as mmap(). Not sure if you are keen on
> that though since it changes the behavior of your drivers. Otoh that
> may make fbcon usable on e-paper since it decouples the soft cursor
> refresh rate from the screen refresh rate.

You're right that that would make fbcon be better. I don't think there
are too many users currently so now would be a good time to change. So
yes, I agree with changing the current behavior and droping the
sysdelay stuff.

Thanks,
jaya
