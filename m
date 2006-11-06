From: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Subject: RE: 2.6.19-rc4-mm2
Date: Mon, 6 Nov 2006 13:27:12 -0500
Message-ID: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A040@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753779AbWKFS1g@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, andrew.j.wade@gmail.com
Cc: linux-kernel@vger.kernel.org, Kimball Murray <kimball.murray@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hi, Andrew & Andrew -

Kimball said to work this through you; I modified this fix so that it
only applies to RV100-based Radeons, since evidently some of them (like
your RV200-based Radeon) really do NOT do 24bpp, as retro as that seems
to me. I'm certain this is actually overly-restrictive, but the only
Radeon chips I have here are ES1000s (RN50, device id 0x515E): I did
drivers
for three earlier Radeon chips at my previous job several years ago, all
of which did 24bpp just fine, but I do not recall what their device ids
were
anymore. What's the device id of your VC1? What I'd ideally like to do
is
to allow 24bpp for all the Radeons for which it works and disallow it
for
all the ones where it doesn't, rather than disallow it for ALL of them,
or
only allow it for the ES1000 (RN50) that we happen to have in our
hardware
here. Your thoughts?

/Charlotte

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Friday, November 03, 2006 4:52 PM
> To: andrew.j.wade@gmail.com
> Cc: linux-kernel@vger.kernel.org; Richardson, Charlotte; Kimball
Murray;
> linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: 2.6.19-rc4-mm2
> 
> On Fri, 3 Nov 2006 16:42:33 -0500
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > On Thursday 02 November 2006 02:54, Andrew Morton wrote:
> > > - Lots of fbdev updates.  We haven't heard from Tony in several
> months, so I
> > >   went on a linux-fbdev-devel fishing expedition.
> >
> > radeonfb-support-24bpp-32bpp-minus-alpha.patch broke my video: my
> > screen ended up garbled. (vc1 was ok, strangely enough). Reverting
> > fixed things.
> >
> > lspci -v:
> >
> > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
> RV200 QW [Radeon 7500] (prog-if 00 [VGA])
> >         Subsystem: ATI Technologies Inc Radeon 7500
> >         Flags: bus master, stepping, 66MHz, medium devsel, latency
64,
> IRQ 16
> >         Memory at d8000000 (32-bit, prefetchable) [size=128M]
> >         I/O ports at d800 [size=256]
> >         Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
> >         Expansion ROM at d7fe0000 [disabled] [size=128K]
> >         Capabilities: <available only to root>
> >
> 
> Great, thanks for working that out.  I'll drop the patch.
