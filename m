From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 06 Nov 2012 17:38:45 +0000
Subject: Re: tty, vt: lockdep warnings
Message-Id: <20121106173845.4a50d661@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50899507.1040900@oracle.com>
	<20121026143754.50277bd8@pyramind.ukuu.org.uk>
	<CA+1xoqdEesjh1EZvR_r7Hn0GUc7741EDWn59qagngcxg4=9bjQ@mail.gmail.com>
	<20121105175937.26f31d2a@pyramind.ukuu.org.uk>
	<5097FEA9.2090603@oracle.com>
	<alpine.LNX.2.00.1211051106590.1709@eggly.anvils>
	<20121105201507.79fe47d7@pyramind.ukuu.org.uk>
	<alpine.LNX.2.00.1211051231070.21645@eggly.anvils>
	<20121106161100.216c6d79@pyramind.ukuu.org.uk>
	<20121106164214.GA18246@redhat.com>
In-Reply-To: <20121106164214.GA18246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, Sasha Levin <sasha.levin@oracle.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sasha Levin <levinsasha928@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, florianSchandinat@gmx.de

>  > The root
>  > cause is loading two different framebuffers with one taking over from
>  > another - that should be an obscure corner case and once the fuzz testing
>  > can avoid.
>  > 
>  > I had a semi-informed poke at this and came up with a possible patch (not very tested)
> 
> If this fixes the real problems we've been seeing, I'll dance a jig.

Youtube...

At this point my bigger concern is that it'll just make something else
warn instead. The underlying problem is that fbcon layer implements a
single threaded notifier whose locking semantics are at best random. It's
not calld with a specific set of locks each time. Possibly it sohuld be
two notifiers (one for fb stuff, one for console layer stuff) but the
entire layer is horrible. I live in home the KMS guys will rip out the
useful bits and build a straight kms fb layer with refcounting and the
like 8)

Testing certainly needed and if it's still blowing up then hopefully
further traces will help fix up the other cases we don't know about.

Alan
