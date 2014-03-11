From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Mar 2014 08:04:21 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <531EC385.7090001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EjPfR4KKiesLcOXvUWTKHkpMfXNWmGNWb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<1393604717.3802.61.camel@paszta.hi.pengutronix.de>	<CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>	<531EAF8F.2040400@ti.com>
 <CAMuHMdWqt4M5OEXp8y_DR8UEA8GPxJg99cz-HcmMPQB+h+Rh0A@mail.gmail.com>
In-Reply-To: <CAMuHMdWqt4M5OEXp8y_DR8UEA8GPxJg99cz-HcmMPQB+h+Rh0A@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--EjPfR4KKiesLcOXvUWTKHkpMfXNWmGNWb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/03/14 10:00, Geert Uytterhoeven wrote:
> On Tue, Mar 11, 2014 at 7:39 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 10/03/14 23:45, Rob Herring wrote:
>>> I like this proposal over the others. Although, would dual link be a
>>
>> I don't like inferring the information. With the above, you can't find=

>> out that the DVI connector has digital and analog support before all t=
he
>> drivers are loaded.
>>
>>> single endpoint or 2 endpoints? How would you differentiate that?
>>
>> Hmm, well endpoints for a single port are exclusive. So it's either a
>> single port and a single endpoint, or two ports and two endpoints. I
>> think dual link has to be single port & endpoint, as the TMDS links ne=
ed
>> to be driven together as a single bus.
>>
>> And dual-link is not really "two links". DVI dual-link means 1 clock
>> lane and 6 data lanes, compared to 1 clock lane and 3 data lanes for
>> single-link.
>=20
> What about having a property for the number of data lanes?

That was already suggested by Philipp in this thread. I don't see
anything wrong with that, but I don't really see benefit either.
"dual-link" is a standard term for 6 data lanes for the DVI connector.
And the choices are 3 or 6 data lanes, nothing else.

 Tomi



--EjPfR4KKiesLcOXvUWTKHkpMfXNWmGNWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHsOGAAoJEPo9qoy8lh71DocQAI+cuB/snvGKiV9WN6qdgeFZ
1mXXzTI0SMSQPG1gqcbuqcdOdHZzpXNUNGfdH79tc5kG8/ZYt5E2PIFHz+/FO2ah
ZQ4hUk3KLnSYWexTh/6EmjpHliNkZK7FQ2IXXEBrXf2bq97XHeUK4c3v6uLm4kUS
TfsADbtMvyJLne82YJ0azZ6Nft231X+qpLZyN2KFMjKP8EJoNkveGuFoO9/mDY8e
Ry4XfsSGtN3VuUoXbvMnXbtaj7m5wOVxkoWNEenbH1/cr3kUQ/IS2DNJVBXm5Cc4
d2M8rQCLjfkRjk2vdoeV9YcAEFoS6tu5ArQIEDZx8/rCAzIWF1BzXCith9STWahv
HjqrXQckUcXL4LEhyl40MVUDw2JOhGyh5xXng8qTW42WLwb1mQt1AeLxckBsEpKz
JdPKUn+zTeIoacT25sy11iFN8dmJx/z5QOFoVyKK0eIQFcA0NLlaWlk29CbnG+3N
QxHZNXjl3BmQGMk7BmjRPlIetP2motfLOJdrY7z3k7O6a0VNVRVEidZV1zKPCFJb
CQRR/8J9RhqBqBtBOl6tLrrUY7RVaf2oC5L6168qTgb/kHr4ytHg5dSNKMA+ZBOD
uY3lrv1Y/mYO3HVj2kC9oy2Y7xYYpPG+kNTJfJvB3kZCyPnKjOn0c3LMzHwrvNq0
LzhIjoXz9nQbgW1kYamD
=7SrH
-----END PGP SIGNATURE-----

--EjPfR4KKiesLcOXvUWTKHkpMfXNWmGNWb--
