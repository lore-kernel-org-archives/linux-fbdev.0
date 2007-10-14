From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control with ATI Radeon display support on HP nx6125.
Date: Sun, 14 Oct 2007 21:55:08 +0200
Message-ID: <200710142155.09345.rjw@sisk.pl>
References: <bug-9155-10286@http.bugzilla.kernel.org/> <200710141602.48206.rjw@sisk.pl> <1192371504.6265.46.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1192371504.6265.46.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
To: Daniel =?utf-8?q?W=C3=BCrfel?= <daniel.wuerfel@gmx.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, bugme-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>

On Sunday, 14 October 2007 16:18, Daniel W=C3=BCrfel wrote:
> Am Sonntag, den 14.10.2007, 16:02 +0200 schrieb Rafael J. Wysocki:
> > On Sunday, 14 October 2007 09:26, Daniel W=C3=BCrfel wrote:
> > > Hi there,
> > >=20
> > > at first great respect for your fast answers.=20
> > > I don't think, that the binary ati driver is the problem, because=
:
> > > 1. with switched of "ati radeon display support" in the kernel, t=
he fan
> > > control works correctly (and i still using the ati-driver)
> >=20
> > How do you know, however, that the "ati radeon display support" in =
the kernel
> > does not interfere with the ATI driver in a destructive way?
>=20
> I think, but im not sure, that the ati driver is loaded, if X was
> started. But at this moment X was not started.

Well, the kernel module part is probably loaded earlier.
=20
> > > 2. the fan starts spinning at the boot screen even if the radeon =
display
> > > driver was loaded (and the ati driver is not just loaded yet).
> >=20
> > I'm not sure what you mean exactly.  Can you clarify, please?dann
>=20
> Well, i see it looks a little bit confused what i wrote. What i mean =
is,
> that the fan at this time starts to rotate, when the "radeon display
> support" is loaded at boot time.

I see.

Can you please check:
- What happens if you don't use the ATI driver at all (please unload it=
s kernel
  module before loading the kernel's radeon one)?
- Does the loading of the radeon module trigger the fan automatically?
- What happens if the fan module is not loaded at that time?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
