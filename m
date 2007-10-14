From: Daniel =?ISO-8859-1?Q?W=FCrfel?= <daniel.wuerfel@gmx.net>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control with ATI Radeon
	display support on HP nx6125.
Date: Sun, 14 Oct 2007 09:26:57 +0200
Message-ID: <1192346817.6265.22.camel@localhost>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
	 <20071013105315.accef6aa.akpm@linux-foundation.org>
	 <200710132030.20826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200710132030.20826.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, bugme-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>

Hi there,

at first great respect for your fast answers. 
I don't think, that the binary ati driver is the problem, because:
1. with switched of "ati radeon display support" in the kernel, the fan
control works correctly (and i still using the ati-driver)
2. the fan starts spinning at the boot screen even if the radeon display
driver was loaded (and the ati driver is not just loaded yet). Here you
see the difference between 2.6.21, when it all works correctly, and
2.6.22 and 2.6.23: the screen resolution of the boot screen changed to
the native resolution 1024x768 (in 2.6.21 it still the default terminal
resolution) 

Am Samstag, den 13.10.2007, 20:30 +0200 schrieb Rafael J. Wysocki:
> On Saturday, 13 October 2007 19:53, Andrew Morton wrote:
> > On Sat, 13 Oct 2007 02:37:35 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> > 
> > > Most recent kernel where this bug did not occur:2.6.21
> > > Distribution:gentoo
> > > Hardware Environment:HP nx6125 BIOS version F.11
> > > Software Environment:Gnome 2.18, ati-driver 8.40.4
> 
> Looks like the binary ATI driver is used.
> 
> > > Problem Description:If you enable "support for frame buffer devices", "Vesa vga
> > > graphics support" and "ati radeon display support" under "graphics support" so
> > > you lost fan cantrol on your hp nx6125, that means the fan doens't stop
> > > working.
> > > 
> > > Steps to reproduce:Enable "support for frame buffer devices", "Vesa vga
> > > graphics support" and "ati radeon display support" under "graphics support" on
> > > your hp nx6125 and after the next boot the fan will not switched off.
> > > 
> > 
> > Does anyone know whether this is likely to be a radeon driver bug or an
> > acpi bug or something else??
> 
> It looks like a thermal issue to me, so I'd say ACPI or the ATI driver (or the
> combination of the two).

