From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 22:42:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410182242.04749.oliver@neukum.org>
References: <416E6ADC.3007.294DF20D@localhost> <20041018121033.GB5106@bytesex> <20041018202147.GA28720@hh.idb.hist.no>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267367AbUJRUtf@vger.kernel.org>
In-Reply-To: <20041018202147.GA28720@hh.idb.hist.no>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

Am Montag, 18. Oktober 2004 22:21 schrieb Helge Hafting:
> > On first access only, and even that only if the driver doesn't map =
the
> > pages at mmap() time already. =A0Not a single fb driver seems to ma=
p the
> > pages lazy today, grepping in drivers/video for nopage handles show=
s
> > nothing. =A0I'm not sure you can actually do that for iomem mapping=
s.
> >=20
> Isn't it possible for the driver to unmap the mapping when
> suspending? =A0Then you're guaranteed to get that first access.

But what would you do then? Block everything that is using a terminal?

	Regards
		Oliver
