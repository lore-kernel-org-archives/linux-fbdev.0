From: Daniel =?ISO-8859-1?Q?W=FCrfel?= <daniel.wuerfel@gmx.net>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control with ATI Radeon
	display support on HP nx6125.
Date: Sun, 14 Oct 2007 16:18:23 +0200
Message-ID: <1192371504.6265.46.camel@localhost>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
	 <200710132030.20826.rjw@sisk.pl> <1192346817.6265.22.camel@localhost>
	 <200710141602.48206.rjw@sisk.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200710141602.48206.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, bugme-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>

Am Sonntag, den 14.10.2007, 16:02 +0200 schrieb Rafael J. Wysocki:
> On Sunday, 14 October 2007 09:26, Daniel W=C3=BCrfel wrote:
> > Hi there,
> >=20
> > at first great respect for your fast answers.=20
> > I don't think, that the binary ati driver is the problem, because:
> > 1. with switched of "ati radeon display support" in the kernel, the=
 fan
> > control works correctly (and i still using the ati-driver)
>=20
> How do you know, however, that the "ati radeon display support" in th=
e kernel
> does not interfere with the ATI driver in a destructive way?

I think, but im not sure, that the ati driver is loaded, if X was
started. But at this moment X was not started.
>=20
> > 2. the fan starts spinning at the boot screen even if the radeon di=
splay
> > driver was loaded (and the ati driver is not just loaded yet).
>=20
> I'm not sure what you mean exactly.  Can you clarify, please?dann

Well, i see it looks a little bit confused what i wrote. What i mean is=
,
that the fan at this time starts to rotate, when the "radeon display
support" is loaded at boot time. Normally the fan should start to work
if a special temperature threshold is reached.=20
>=20
> > Here you see the difference between 2.6.21, when it all works corre=
ctly, and
> > 2.6.22 and 2.6.23: the screen resolution of the boot screen changed=
 to
> > the native resolution 1024x768 (in 2.6.21 it still the default term=
inal
> > resolution)=20
>=20
> This only means that the kernel's radeon driver has changed.
>=20
> It's difficult to say what's going wrong.
>=20
> What's the CPU load when the fan is spinning?
>=20
> Greetings,
> Rafael

The rest of the systems works fine. I notice no anomaly.

Greetings,
Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
