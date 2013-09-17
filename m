From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 17 Sep 2013 16:51:56 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <1379436716.9205.25.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
In-Reply-To: <1379435799.9205.16.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Uh, sorry, missed one...

On Tue, 2013-09-17 at 17:36 +0100, Pawel Moll wrote:
> On Mon, 2013-09-16 at 20:52 +0100, Stephen Warren wrote:
> > > +- arm,pl11x,panel-data-pads: array of 24 cells, each of them describ=
ing
> > > +				a function of one of the CLD pads,
> > > +				starting from 0 up to 23; each pad can
> > > +				be described by one of the following values:
> > > +	- 0: reserved (not connected)
> > > +	- 0x100-0x107: color upper STN panel data 0 to 7
> > ...
> >=20
> > I assume those are the raw values that go into the HW?

No, they can be considered "labels", defining the way pads are used
(wired). Then, basing on this information, the driver is configuring the
cell, eg. selecting STN or TFT mode (thus switching the output between
panel formatter and raw RGB data source).

Pawe=C5=82


