From: "Aguirre, Sergio" <saaguirre@ti.com>
Date: Fri, 05 Mar 2010 15:28:43 +0000
Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
Message-Id: <A24693684029E5489D1D202277BE894453CC5CD3@dlee02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
	 <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
	 <A24693684029E5489D1D202277BE894453CC5CA0@dlee02.ent.ti.com>
 <1267802713.25148.146.camel@tubuntu.research.nokia.com>
In-Reply-To: <1267802713.25148.146.camel@tubuntu.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Friday, March 05, 2010 9:25 AM
> To: Aguirre, Sergio
> Cc: Syrjala Ville (Nokia-D/Helsinki); linux-fbdev@vger.kernel.org; linux-
> omap@vger.kernel.org
> Subject: RE: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
>=20
> On Fri, 2010-03-05 at 16:19 +0100, ext Aguirre, Sergio wrote:
> > Hi Ville,
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of ville.syrjala@nokia.com
> > > Sent: Friday, March 05, 2010 7:26 AM
> > > To: Tomi Valkeinen
> > > Cc: linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; Ville
> Syrj=E4l=E4
> > > Subject: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
> > >
> > > From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> > >
> > > When DSS transitions from off mode to on VENC may generate a spurious
> > > SYNC_LOST_DIGIT error. Just ack it when restoring the context. Also
> > > restore IRQENABLE last to avoid triggering interrupts before the
> > > context is fully restored.
> >
> > (Tomi or anyone can correct me if I'm wrong)
> >
> > AFAIK, The solution for spurious interrupts is to flush posted bus
> writes during interrupt handling, which can be achieved by reading the
> same register just after you have written it.
> >
> > Tomi, what do you think?
>=20
> That's a different spurious interrupt =3D).
>=20
> In this case the IRQ mechanism from CPU side is working fine, but VENC
> is just spamming the error interrupts, for unknown reason.

Ohh ok, I see.

Thanks for clarifying. And sorry for the noise.

I'm trying to learn about DSS subsystem, but I'm just a n00b for the moment=
 :)

Regards,
Sergio
>=20
>  Tomi
>=20

