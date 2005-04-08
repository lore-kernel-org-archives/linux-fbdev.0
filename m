From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
 accesses
Date: Fri, 08 Apr 2005 23:11:12 +0200
Message-ID: <jezmw9ug7j.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	<1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	<1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	<21d7e9970504071422349426eb@mail.gmail.com>
	<1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	<1112923186.9567.349.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262955AbVDHVLT@vger.kernel.org>
In-Reply-To: <1112923186.9567.349.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 08 Apr 2005 11:19:46 +1000")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2005-04-08 at 01:58 +0200, Andreas Schwab wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>=20
>> > Yes, that's very extreme, I suspect somebody is banging on set_par=
 or
>> > something like that.
>>=20
>> fb_setcolreg is it.
>
> Ok, what about that patch:
>
> ---
>
> This patch adds to the fbdev interface a set_cmap callback that allow
> the driver to "batch" palette changes. This is useful for drivers lik=
e
> radeonfb which might require lenghtly workarounds on palette accesses=
,
> thus allowing to factor out those workarounds efficiently.

This makes it better. But there is still a delay of half a second, and
there is an annoying flicker when switching from X to the console.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
