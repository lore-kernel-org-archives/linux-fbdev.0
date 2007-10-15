From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control with ATI Radeon display support on HP nx6125.
Date: Mon, 15 Oct 2007 22:32:34 +0200
Message-ID: <200710152232.35324.rjw@sisk.pl>
References: <bug-9155-10286@http.bugzilla.kernel.org/> <200710142155.09345.rjw@sisk.pl> <1192468342.6249.9.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1192468342.6249.9.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
To: Daniel =?utf-8?q?W=C3=BCrfel?= <daniel.wuerfel@gmx.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, bugme-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>

On Monday, 15 October 2007 19:12, Daniel W=C3=BCrfel wrote:
> Am Sonntag, den 14.10.2007, 21:55 +0200 schrieb Rafael J. Wysocki:
> > On Sunday, 14 October 2007 16:18, Daniel W=C3=BCrfel wrote:
> > > Am Sonntag, den 14.10.2007, 16:02 +0200 schrieb Rafael J. Wysocki=
:
> > > > On Sunday, 14 October 2007 09:26, Daniel W=C3=BCrfel wrote:
> > > > > Hi there,
> > > > >=20
> > > > > at first great respect for your fast answers.=20
> > > > > I don't think, that the binary ati driver is the problem, bec=
ause:
> > > > > 1. with switched of "ati radeon display support" in the kerne=
l, the fan
> > > > > control works correctly (and i still using the ati-driver)
> > > >=20
> > > > How do you know, however, that the "ati radeon display support"=
 in the kernel
> > > > does not interfere with the ATI driver in a destructive way?
> > >=20
> > > I think, but im not sure, that the ati driver is loaded, if X was
> > > started. But at this moment X was not started.
> >=20
> > Well, the kernel module part is probably loaded earlier.
> > =20
> > > > > 2. the fan starts spinning at the boot screen even if the rad=
eon display
> > > > > driver was loaded (and the ati driver is not just loaded yet)=
=2E
> > > >=20
> > > > I'm not sure what you mean exactly.  Can you clarify, please?da=
nn
> > >=20
> > > Well, i see it looks a little bit confused what i wrote. What i m=
ean is,
> > > that the fan at this time starts to rotate, when the "radeon disp=
lay
> > > support" is loaded at boot time.
> >=20
> > I see.
> >=20
> > Can you please check:
> > - What happens if you don't use the ATI driver at all (please unloa=
d its kernel
> >   module before loading the kernel's radeon one)?
> > - Does the loading of the radeon module trigger the fan automatical=
ly?
> > - What happens if the fan module is not loaded at that time?
>=20
> I think i got the problem:
> I made some test. The problem is the module radeonfb. If i compile
> radeonfb as a module there is no problem with the fan control. But if=
 i
> compile it into the kernel, than fan control will be destroyed and th=
e
> fan doesn't stop working from the beginning of the system start.=20
> The other modules (fglrx, agp_gart) have no influence to the fan
> behaviour.

Thanks for having narrowed this, good job.

Now, the question is why the radeonfb compiled in statically has this e=
ffect.

Can you please attach your current .config to the bugzilla entry?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
