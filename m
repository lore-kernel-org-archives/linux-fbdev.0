From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Feb 2013 13:04:09 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <5114F7C9.4040803@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig7F5E0FBDE07FD479A756435E"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com> <4292748.rtElrP8BXd@avalon> <3272191.03RiBNfhoM@flatron> <5114E412.5030806@ti.com> <5114F224.6010201@stericsson.com>
In-Reply-To: <5114F224.6010201@stericsson.com>
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Figa <t.figa@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, Daniel Vetter <daniel@ffwll.ch>, "rob@ti.com" <rob@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "dh09.lee@samsung.com" <dh09.lee@samsung.com>, "ville.syrjala@intel.com" <ville.syrjala@intel.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>

--------------enig7F5E0FBDE07FD479A756435E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-08 14:40, Marcus Lorentzon wrote:

> I agree, but I think it should be
> setup->enable->video_on->video_off->disable->setup->...
> I don't think there is any interface parameters that should be changed
> while link is enabled. And if there are, they should be identified and
> split out into a separate operation.

Hmm. At least on OMAP and DSI video mode, it is possible to change at
least timings on the fly. But yes, generally the link has to be disabled
first before changing any parameters.

>> In OMAP you can configure the DSI pins quite freely. We have the
>> following struct:
>>
>> struct omap_dsi_pin_config {
>>     int num_pins;
>>     /*
>>      * pin numbers in the following order:
>>      * clk+, clk-
>>      * data1+, data1-
>>      * data2+, data2-
>>      * ...
>>      */
>>     int pins[OMAP_DSS_MAX_DSI_PINS];
>> };
>>
> Do you reroute after boot? Or is this just "board/product setup". We
> have some pinmuxing as well and DPhy sharing, but we have never used it=

> after init/boot. If not runtime, I think this could be put in DT config=

> for product instead of under dynamic control from panel.

The pin config with the struct above is done later, when the panel
driver configures the DSI bus. So in OMAP we have two distinct things
that need to be configured:

- The actual pin muxing, i.e. selecting the functions for pin N on the
OMAP package. The functions for a single pin could be for example GPIO
70, DSI DX0, UART1_CTS, etc. This is normally done once during board init=
=2E

- DSI pin configuration in the display subsystem. This is used to map
the pins to DSI functions. I.e. DSI DX0 pin is mapped to DATA1+. This is
done by the DSS driver, when the panel driver gives it the parameters.

So the first muxing basically assigns the pin to DSI in general, and
then DSI will internally route the pin to a an actual DSI function.

Whether the muxing needs to changed during runtime... I'm not sure. On
OMAP the DSI pin config also tells how many lanes are used. So if a DSI
panel would first want to use only one lane, and later change it to n
lanes, we'd need this kind of function.

I think it conceptually fits better if the pin config data is passed to
the panel via DT data, and the panel then gives the config to the DSI
master. It's just a part of the DSI bus parameters, like, say, clock
speed or whether to use HS or LP. That way the DT node for the panel
contains the information about the panel. (versus having pin config data
in the DSI master, in which case the DSI master's node contains data
about a specific DSI panel).

 Tomi



--------------enig7F5E0FBDE07FD479A756435E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRFPfJAAoJEPo9qoy8lh7161EQAIWodopaAKzL6CssdmIMWmNw
oFQxsYzf2KPBs9DJyFn46A76NuG4ln3hPu77O3q7FB2EDJr+PGqbYk62E2d512Tm
Dh4xk1bM9QwXL8gUKK9ztVFHTVXuQCh43wY2FUOFSIOrsyxN4UlgNKICy07BWHRJ
xk3UAoYkefDlKClRfYC+qpOM+ti1gwq8fDk4M8aiMiAopGJ5+T6PsZeuh0Q4cXoY
FEe0QEefc4LXvchnBCXkQHyBFzntuHdry7AwlFmSC04/2zeplUGpCnMRf8pyIFkf
F4kyVSq2cDAgG6QXkVjRzd543v/DXKDIvGs7eBryDKb3u+udnIBm1GSSQVg9hGoX
u/RaplIFa+QRU0+EsOFUAEFx5e041V8aYjk0kh4+YrWwh4I7GVN5yqR4po3VhPuJ
FH17q0UBGtcEpV+FBExGKjacJmysqwNTYfOTd8TlTk/zbld2x89qWMq+0IIA5Qwp
Rjr1mEdQ7PCPXX4GAzMOoPgq8xxShyqnuXIL3HXrpJy+F/9vwLd9PytcHfuSVMAR
3uVKv0nz2YaFJLFXRZxQaqsNDQz3HyusqmjrZGupWUnVbs7zjg8YXnICJooJNPyy
hTiSxna3Pm90YrpZZSHuARafJGkDQKB+Nw4146C88HP8RLp+y+u79NtX2uKgx5xb
XMcTny7j8GAwj5I5SRnZ
=geuz
-----END PGP SIGNATURE-----

--------------enig7F5E0FBDE07FD479A756435E--
