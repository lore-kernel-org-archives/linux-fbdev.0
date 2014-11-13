From: Jean-Francois Moine <moinejf@free.fr>
Date: Thu, 13 Nov 2014 09:17:38 +0000
Subject: Re: [alsa-devel] [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Message-Id: <20141113101738.6338bb1c@armhf>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
	<20141112222344.GU3815@sirena.org.uk>
	<54646648.5030807@ti.com>
In-Reply-To: <54646648.5030807@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, 13 Nov 2014 10:05:28 +0200
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
	[snip]
> I don't have much knowledge of the asoc architecture, so I probably
> can't comment much on the sound/ side design. For me the most important
> things are that 1) it works 2) I can easily unload/load the modules
> (which was broken in some of the earlier versions).
>=20
> As a more general discussion item, I'm still wondering why it feels like
> we (OMAP) are doing something totally new here. I'd imagine that almost
> every device with HDMI would need both video and audio side support, and
> those sides need to work together. And the audio side would need to get
> notified of things like cable disconnect (i.e. the video stream is
> stopped -> audio must be stopped also). But if I've understood right,
> there was no similar existing code to be found.

I recently posted a patch on the HDMI CODEC to interface a HDMI
transmitter
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/082745.ht=
ml
and I saw only a few dependencies between the 2 subsystems:

- the CODEC must know the transmitter parameters (DAIs - static -,
  audio constraints - dynamic -),

- the CODEC must alert the transmitter on audio start and stop.

I don't think that stopping audio streaming on HDMI disconnection is
useful. I even let audio streaming start when the HDMI cable is
disconnected.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
