From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Mon, 29 Jan 2007 15:37:22 +0100
Message-ID: <cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org>
	 <20070128160831.fb51347f.akpm@osdl.org>
	 <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	 <20070128162907.370f5476.akpm@osdl.org>
	 <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752503AbXA2OhZ@vger.kernel.org>
In-Reply-To: <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 1/29/07, Dave Airlie <airlied@gmail.com> wrote:
> > > > Because most users won't even be aware of the module option: they'll just
> > > > know that their card doesn't work right.
> > >
> > > This isn't a card problem this is a monitor problem, the card just
> > > passes through the edid data from the monitor... or else the
> > > programming of the card registers from edid is wrong..
> >
> > In which case the same problem would occur with different video cards, so
> > this patch should be some generic thing, available to all drivers, no?
>
> It should be in the fb layer not card specific.. as it may happen on any card...

Although solving the problem at the fb layer level is probably the
correct/best way to do it, I am not aware of people having problems
with broken EDIDs and non-nVidia cards. By contrast, workarounds for
nVidia and broken EDIDs is a very common thing to do even on Windows.
Both the Windows and the Linux proprietary drivers need SoftEDID
specifications to work around these problems. I don't know if this is
just because of the way the driver are written, though, or if nVidia
cards are particularly unable to handle monitors with broken EDIDs.

Plus, providing an fb-layer-level solution is way beyond my kernel
programming experience :)

-- 
Giuseppe "Oblomov" Bilotta
