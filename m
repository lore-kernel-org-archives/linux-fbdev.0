From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Feb 2013 11:40:02 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5114E412.5030806@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig6AD41DF01F886D1011BF422C"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron>
In-Reply-To: <3272191.03RiBNfhoM@flatron>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, Daniel Vetter <daniel@ffwll.ch>, Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>, rob@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>, inki.dae@samsung.com, dh09.lee@samsung.com, ville.syrjala@intel.com, s.nawrocki@samsung.com

--------------enig6AD41DF01F886D1011BF422C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-02-03 21:17, Tomasz Figa wrote:
> Hi Laurent,
>=20
> On Saturday 02 of February 2013 11:39:59 Laurent Pinchart wrote:
>> Hi Tomasz,
>>
>> Thank you for your RFC.
>>
>> On Wednesday 30 January 2013 16:38:59 Tomasz Figa wrote:

>>> Changes done to Tomi's edition of CDF:
>>>  - Replaced set_operation_mode, set_pixel_format and set_size video
>>>  source> =20
>>>    operations with get_params display entity operation, as it was
>>>    originally in Laurent's version.
>>>   =20
>>>    We have discussed this matter on the mailing list and decided that=

>>>    it
>>>    would be better to have the source ask the sink for its parameter
>>>    structure and do whatever appropriate with it.
>>
>> Could you briefly outline the rationale behind this ?
>=20
> Display interfaces may be described by an arbitrary number of parameter=
s.=20
> Some will require just video timings, others like DSI will require a=20
> significant number of additional bus-specific ones.
>=20
> Separating all the parameters (all of which are usually set at the same=
=20
> time) into a lot of ops setting single parameter will just add unnecess=
ary=20
> complexity.

I have nothing against combining the parameters that way. I think the
important thing here is just that we have to allow changing of the
parameters, whenever the display device needs that. So the bus
parameters cannot be a one time constant setting.

>> I'm wondering whether get_params could limit us if a device needs to
>> modify parameters at runtime. For instance a panel might need to chang=
e
>> clock frequencies or number of used data lane depending on various
>> runtime conditions. I don't have a real use case here, so it might jus=
t
>> be a bit of over-engineering.
>=20
> Hmm, isn't it in the opposite direction (the user requests the display =

> interface to change, for example, video mode, which in turn reconfigure=
s=20
> the link and requests the panel to update its settings)?

Well, now, that's the question.

Let's consider a simplified case with DSI output from the SoC, and a DSI
panel. If the panel is a rather simple one, you could well call a method
in the API in the DSI output driver, which would do necessary
configuration and inform the panel driver to do any configuration it
needs to do, based on the parameters.

However, in my experience display devices, DSI devices in particular,
are often quite "interesting". If the control of the operation in
question is in the DSI output side, we are limited about what kind of
DSI panels we can use, as the DSI output driver has to know all the
tricks needed to make the panels work.

I'm having hard time trying to explain this, so let's try an example.
Consider the initial powering up of the bus. If the DSI output driver is
in control, something like the following probably happens:

- output driver asks for the parameters from the panel driver
- output driver programs the DSI output according to these parameters
- output driver informs the panel that the bus is now up and running

Then consider a totally invented case, but which perhaps describes the
problem with the above approach: The DSI panel requires the DSI bus
first to be started in HS mode, but with a certain predefined bus speed,
and only one lane used. This predefined bus setup is used to send
configuration commands to the panel hardware, and only after that can
you reconfigure the bus with proper speed and lanes.

That kind of thing is a bit difficult to manage with the DSI output
driver is in control. However, if the DSI panel driver is in control,
it's simple:

- panel driver calls config methods in the DSI output driver, setting
the predefined speed and one lane
- panel driver sends configuration commands to the panel
- panel driver calls config methods in the DSI output driver, setting
the final bus config

>>>    5. Mask of used data lanes (each bit represents single lane).
>>
>> From my experience with MIPI CSI (Camera Serial Interface, similar to
>> DSI) some transceivers can reroute data lanes internally. Is that true=

>> for DSI as well ? In that case we would need a list of data lanes, not=

>> just a mask.
>=20
> Hmm, I don't remember at the moment, will have to look to the=20
> specification. Exynos DSI master doesn't support such feature.

In OMAP you can configure the DSI pins quite freely. We have the
following struct:

struct omap_dsi_pin_config {
	int num_pins;
	/*
	 * pin numbers in the following order:
	 * clk+, clk-
	 * data1+, data1-
	 * data2+, data2-
	 * ...
	 */
	int pins[OMAP_DSS_MAX_DSI_PINS];
};

 Tomi



--------------enig6AD41DF01F886D1011BF422C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRFOQSAAoJEPo9qoy8lh71YdkP/jof2z/2QbV1P0PLxtcOLJ0A
pd+baGugVZTBC8XV6u8X6r2Tmr152VgO7+j+6qElGU4s6JkU3278RC98hCT0g6FV
uq0Ez4kdiPDoRZBijOafZxsxZc2MbgGV3YWKCQXBnJ07TujoMW4R8fq2N1v5ki0V
7qZMwg+bz+RxUBodq7afRlsRkrRkvDP4p+J4+/j4rgBclhdIUSRwSpfxE/cQiPui
WwHtG0quLnEq/JPLMirGcYkf2HG32Spn5VTUmf8IRtTZUns35YBP8istjyJd/56O
ea/rX3edPRRsQ+tMiTBalIRuC0MNFJ1j+DKpFNWL97aCziygdhHw96/RE4lX9eNH
Df7Wvkj+FjAMmW6ibHHValMekssRQ1z9wmmAU1chIjBNuMz/d7A4aLg9pjOeMar1
L/VvV4F+YxB837ZKNMPoX9GF+TBw0Ng0YbcEHq4yXona/A2JoOzy2whTSX74ezmp
9xjIhJdA52O/L9soA6+A4UvhCDCI+SvE0H76OK5ksbVHaXC8qmrnYCBD7QxjmS/Z
DiFaasbIZIJF/CnY60302L0emT4RN8e0uE2vxvElIbowm/t4fsdBnG62Vdxft19D
ChfI54wus++wOLzqExPSLY2XdO4mzX9Tibrko+vZuGPTcS1aoafOsscrw6GJxdwT
yRVpS7MsKYXkXmYf+ytC
=96X/
-----END PGP SIGNATURE-----

--------------enig6AD41DF01F886D1011BF422C--
