From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 31 Jan 2013 09:38:23 +0000
Subject: Re: BUG: circular locking dependency detected
Message-Id: <CAKMK7uGF8jfOX8gbLO1=419eKUAbMtRjAnoDKSTR567D3HKwTg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130130200648.GA13298@flint.arm.linux.org.uk>
	<20130130215211.GA28418@flint.arm.linux.org.uk>
	<CAKMK7uHEggaGfLTq4c3MfY7csQSFpb=kRwdbJUQMN9Cz9K=V4A@mail.gmail.com>
	<20130130221946.GA14801@flint.arm.linux.org.uk>
	<CA+55aFyRHK3dmwQf_mdfB18dmoaRZqBG9FvHRqTs7cqBjgUs+g@mail.gmail.com>
	<CAPM=9tz6YBh2o3T8Ogt4K=wxSrC3Jc4PCJMzfpbyY=B132fA5g@mail.gmail.com>
	<20130131001339.GC14801@flint.arm.linux.org.uk>
	<CA+55aFxfeXWAiXV18qGgOk9+2HHiD7LUuyk55brHFXd+_c6eZQ@mail.gmail.com>
	<20130131054002.GA3697@kroah.com>
	<CAKMK7uGUrvh2dXza_b288kVdztiLjSCNpH304oBQgg_ZonEnzw@mail.gmail.com>
	<20130131092146.GB3361@kroah.com>
In-Reply-To: <20130131092146.GB3361@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Thu, Jan 31, 2013 at 10:21 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>> Can you please also pick up the (currently) three locking fixups
>> around fbcon? Just so that we don't repeat the same fun where people
>> complain about lockdep splats, but the fixes are stuck somewhere. And
>> I guess Dave would be happy to not end up as fbcon maintainer ;-) He
>> has a git branch with them at
>> http://cgit.freedesktop.org/~airlied/linux/log/?h=FBcon-locking-fixes
>> though I have a small bikeshed on his last patch pending.
>
> Care to just send me the patches through email when you all get done
> bikesheding?  And for some reason I thought Andrew was going to handle
> these fbcon patches, but if not, I'll be glad to take them.

Yeah, I'll annoy people again with patches until they're merged ;-)
Iirc Andrew picked them due to lack of an fbcon maintainer, and
everyone else likes to pass the bucket. Having looked through the code
a bit, imo understandable ...

btw, I've started to look into how we could fix the locking madness
around fbcon for good instead of with duct-tape [1]. I'll try to
discuss this with a few fbdev guys at fosdem (some at least should be
there). Certainly a long-term thing, but comments from whomever gets
volunteered to shepherd fbcon would be great.

Cheers, Daniel

1: http://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg33535.html
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
