From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 22 Sep 2011 20:21:46 +0000
Subject: Re: [PATCH] gma500: gtt based hardware scrolling console
Message-Id: <20110922212146.609065b1@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110922184316.25068.54702.stgit@localhost.localdomain>
	<CAMuHMdWBz9+TCBUbaOY3HRv=khiDHkRCKdx5e53HCen54RUBVw@mail.gmail.com>
In-Reply-To: <CAMuHMdWBz9+TCBUbaOY3HRv=khiDHkRCKdx5e53HCen54RUBVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

> > +       info->fix.ywrapstep = gtt_roll;
> 
> Do you really want to set this? I didn't see any other wrapping
> support in your patch.
> However, I guess you can implement wrapping support using the same
> mapping trick?

It is actually wrapping - it writes the low pages back below the high
ones so it works the GTT as a circular buffer - or am I misunderstanding
this.

One thing I wasn't sure of on the fb side. If I've got a display width
that is annoying and can't fit on a 4Kbyte stride am I right in thinking
I can set this to say 8 and use a 512 byte stride and still get
acceleration for the usual font choice ?

Alan
