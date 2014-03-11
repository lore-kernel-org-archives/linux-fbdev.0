From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Mar 2014 06:39:11 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <531EAF8F.2040400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="U3bV4otFdFfvT2UMbSeXkLuqSiFbTkPIi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<1393604717.3802.61.camel@paszta.hi.pengutronix.de>
 <CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>
In-Reply-To: <CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>
To: Rob Herring <robherring2@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--U3bV4otFdFfvT2UMbSeXkLuqSiFbTkPIi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/03/14 23:45, Rob Herring wrote:

> I like this proposal over the others. Although, would dual link be a

I don't like inferring the information. With the above, you can't find
out that the DVI connector has digital and analog support before all the
drivers are loaded.

> single endpoint or 2 endpoints? How would you differentiate that?

Hmm, well endpoints for a single port are exclusive. So it's either a
single port and a single endpoint, or two ports and two endpoints. I
think dual link has to be single port & endpoint, as the TMDS links need
to be driven together as a single bus.

And dual-link is not really "two links". DVI dual-link means 1 clock
lane and 6 data lanes, compared to 1 clock lane and 3 data lanes for
single-link.

> The port node seems a bit pointless.

There's another thread discussing the ports and endpoints.

The port node represents, for example, the pins for the connection for
that device. And an endpoint-endpoint link represents wires between two
ports.

 Tomi



--U3bV4otFdFfvT2UMbSeXkLuqSiFbTkPIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHq+TAAoJEPo9qoy8lh71yuQP/1mQsdM2LxHap7o5dWfHHBO3
iSu3sIKKNo+Pe58SiVzzK4FmezI6tHPRUb/tHJLCI3+c/v75R1H5NDCtDkV8WK/B
TY0WWY88N1sLPwA2LqJUrnWQ9xwIANKpYsNslnYSjthDYwrtAVJPRgGIj6PsqDwm
TYPCKpwGGHV9B+EoiMHkL33WzbacThsPf32JqO9eXOOhrzG1yj9rcXYc79srNTYt
bDc1UEhWnQIheYG/g0fHCNDN+38VoGUXujjM1EV7fZtqmnFl4DOM2v1rF9k6MS17
U9uv5uT7tgrZxU8axny8Pza1sbzPlkEBx488ampeaRVljJbJRcWqYpGVAzk5G/Ul
nC07UClE6CPn1K/Njj/1R5eWwVUaM2ZBAGKiiVR0+c4roMNifMUuViffbMw0RxuH
ITQLLSVsVstCzJw52URcdMZLQGGSDF3OgTAtIvDzJE7FGtuVTaqUeohawAxLM2By
OMgYhXfIDy5u5YkWeAVufdm+864+7fNRmtAxnmcmq3CcFkwbUsqmrxVuQcdnwR4T
C5kRXfj2xXPKW2oYBZVoC94c3Ie0QVr+3FZC5/OXUCo/cztC6/rnLG3qJC0wHH8m
uuxI5cKpZ/1nd7IirKbjKjRQGmWO2R/JW9L+PDErWKOAWX5SYMx9BDZHYCk4r4t8
GlC7SsHNmTBhcc95ZWoM
=IvkU
-----END PGP SIGNATURE-----

--U3bV4otFdFfvT2UMbSeXkLuqSiFbTkPIi--
