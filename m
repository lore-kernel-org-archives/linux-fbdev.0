From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Wed, 23 Nov 2016 17:33:55 +0000
Subject: Re: [PATCH v5 2/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1479922435.5446.13.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161118005309.GC26324@dell-m4800.home>
         <1479679088-3015-1-git-send-email-manuel.schoelling@gmx.de>
         <1479679088-3015-3-git-send-email-manuel.schoelling@gmx.de>
         <20161121201704.GA29655@angband.pl>
In-Reply-To: <20161121201704.GA29655@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey_utkin@fastmail.com

On Mo, 2016-11-21 at 21:17 +0100, Adam Borowski wrote:
> On Sun, Nov 20, 2016 at 10:58:08PM +0100, Manuel Schölling wrote:
> > Add a scrollback buffers for each VGA console. The benefit is that
> > the scrollback history is not flushed when switching between consoles
> > but is persistent.
> > The buffers are allocated on demand when a new console is opened.
> > 
> > This breaks tools like clear_console that rely on flushing the
> > scrollback history by switching back and forth between consoles
> > which is why this feature is disabled by default.
> > Use the escape sequence \e[3J instead for flushing the buffer.
> > 
> > Signed-off-by: Manuel Schölling <manuel.schoelling@gmx.de>
> > ---

> But alas, this commit breaks that very \e[3J.  It does only a \e[2J, leaving
> the scrollback uncleared.  For comparison, both mainline and with just your
> preparatory commit, \e[3J works as expected.
Thanks again for reporting this issue. I was finally able to reproduce
it.
Looks like the same problem arises when implementing persistent
scrollback buffers for framebuffer consoles. I will have to think about
the underlying issue a bit more, but I guess that the consw struct needs
another field for a function that flushes the scrollback buffer.
Before this was just done by switching the console, which is fine if you
just have one buffer. But now each console has its own buffer, so simply
calling vc_data's vc_sw->con_switch() won't be sufficient anymore.


