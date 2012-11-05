From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 05 Nov 2012 20:15:07 +0000
Subject: Re: tty, vt: lockdep warnings
Message-Id: <20121105201507.79fe47d7@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50899507.1040900@oracle.com>
	<20121026143754.50277bd8@pyramind.ukuu.org.uk>
	<CA+1xoqdEesjh1EZvR_r7Hn0GUc7741EDWn59qagngcxg4=9bjQ@mail.gmail.com>
	<20121105175937.26f31d2a@pyramind.ukuu.org.uk>
	<5097FEA9.2090603@oracle.com>
	<alpine.LNX.2.00.1211051106590.1709@eggly.anvils>
In-Reply-To: <alpine.LNX.2.00.1211051106590.1709@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hugh Dickins <hughd@google.com>
Cc: Sasha Levin <sasha.levin@oracle.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sasha Levin <levinsasha928@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, linux-fbdev@vger.kernel.org, florianSchandinat@gmx.de

> The fbdev potential for deadlock may be years old, but the warning
> (and consequent disabling of lockdep from that point on - making it
> useless to everybody else in need of it) is new, and comes from the
> commit below in linux-next.
> 
> I revert it in my own testing: if there is no quick fix to the
> fbdev issue on the way, Daniel, please revert it from your tree.

If you revert it you swap it for a different deadlock - and one that
happens more often I would expect. Not very useful.

I'm hoping the framebuffer maintainer will bother to respond to this
because that's the only way it can be sorted out.

Alan
