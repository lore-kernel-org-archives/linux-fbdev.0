From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Mar 2014 09:33:42 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <5316EF76.1050304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0xOVUFIIuv3GvCmvkSjEO1DfUWxSAfJoi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com>	<1389698184-28761-5-git-send-email-zzhu3@marvell.com>	<20140217143736.GC19308@e106331-lin.cambridge.arm.com> <CAJATT-5sQc7vsUhoFKdDnstqjj2R_yQ+Wk1NRf20UTM4-ndMSA@mail.gmail.com>
In-Reply-To: <CAJATT-5sQc7vsUhoFKdDnstqjj2R_yQ+Wk1NRf20UTM4-ndMSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Zhou Zhu <zzhu84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lisa Du <cldu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, huangyh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org

--0xOVUFIIuv3GvCmvkSjEO1DfUWxSAfJoi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/03/14 13:28, Zhou Zhu wrote:
> Hi, Tomi and Mark,
>=20
> On Mon, Feb 17, 2014 at 10:37 PM, Mark Rutland <mark.rutland@arm.com> w=
rote:
>>
>> On Tue, Jan 14, 2014 at 11:16:24AM +0000, Zhou Zhu wrote:
>>> add device tree support for mmp fb/controller
>>> the description of DT config is at
>>> Documentation/devicetree/bindings/fb/mmp-disp.txt
>>>
>>> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>>> ---
>>>  Documentation/devicetree/bindings/fb/mmp-disp.txt |   60 ++++++++
>>>  drivers/video/mmp/fb/mmpfb.c                      |   73 ++++++----
>>>  drivers/video/mmp/hw/mmp_ctrl.c                   |  160 +++++++++++=
+++++-----
>>>  3 files changed, 235 insertions(+), 58 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt=

>=20
>=20
> Thank you very much for your review! I am trying to update the code
> according to your comments.
>=20
> We have reviewed the dts and removed many software settings and
> not-used settings - for example, we unpacked path-config/link-config
> and removed some configures that we will never change.
> Also we removed fb settings which is considered as software.
>=20
> Would you please give us some feedbacks if we adjust our dts into follo=
w style?
> As there might be big changes on the code structures, I would update
> the code after this dts layout is considered as "right".
>=20
> mmp-disp@d420b000 {
>     compatible =3D "marvell,mmp-disp";
>     reg =3D <0xd420b000 0x1fc>;
>     interrupts =3D <0 41 0x4>;
>=20
>     internal-connections {
>         pipe1: pn-path {
>         input =3D "panel-graphic"; //panel-graphic is the overlay name =
in spec.
>         output =3D &parallel;
>         }
>     }
>     ports{
>         parallel: parallel {
>             marvell,rbswap;
>             marvell,spi;
>         }
>     }
>     status =3D "okay";
> }
>=20
> panel-xxx {
>     properties;
>     connection =3D &parallel;
> }

I would recommend using the same style that is used in the OMAP DSS, imx
drm and exynos patches that are introducing DT support. They use ports
and endpoints as defined in:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/devicetree/bindings/media/video-interfaces.txt

with the addition of a simplified endpoint format, where the 'port' node
is not required.

To give an idea what it could look like, I've modified your example
above. It's just a rough example, you should study and think how it best
fits for mmp.

You could use the same format for the internal connections also, but I
didn't touch that. I think internal connections can as well be
configured separately, in a custom format, because there's no need for
external components to connect to the internal links.

mmp-disp@d420b000 {
    compatible =3D "marvell,mmp-disp";
    reg =3D <0xd420b000 0x1fc>;
    interrupts =3D <0 41 0x4>;

    internal-connections {
        pipe1: pn-path {
        input =3D "panel-graphic";
        output =3D &disp_out;
        }
    }

	disp_out: endpoint {
		remote-endpoint =3D <&panel_in>;
		marvell,rbswap;
		marvell,spi;
	};

    status =3D "okay";
}

panel-xxx {
	properties;

	panel_in: endpoint {
		remote-endpoint =3D <&disp_out>;
	};
};

 Tomi



--0xOVUFIIuv3GvCmvkSjEO1DfUWxSAfJoi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFu92AAoJEPo9qoy8lh711ccP/0e2c3zsoPKPFYjodRmAwBfo
TvGTuKvTo4UOgAfHP1WJ0TpfSGpHm3EUdAj3itGSGn8VUaWoiRmaiWKCjH6D32IQ
Ce7VtsZYETRsyBXUAWNDv7xrlUNYfn0t1NO1MEw37UIWRY4qvjnj4klGf/dqUKrG
WBkbXjuIFdtTeYsh/eGgQKeu6gNvHBbUqlQn9ptDFgQ/X3jyZ1GkfIJufD4fFRX4
ncy65MmhYtLlgYEJSoheZK90je8N9wvs4QYGfz/Am9KL++Eqkxn+0QaQ1aJClHVQ
5Vk2pHAGY7hx4pZVCXGbGl0DCuWceEmITGP3O3jra9PRrD0W1tHYiRFVhS1jDtjF
s8+9vyUAmBQVlaH+Wg1vNZUBhWUcrjJzDnm7xf/81PflN0VM5m2pb0720iftGF6x
mF/LEbRkjpDcbOcBp9tWm+pgB2Q4d+Jfrib0nxWBunUfZw1paVl6eGOpH8AKU78M
ela04/Q7tnK8YadyJ1OelCP/2I+UEwEvuUI9SL46TP8aLtbmrQs+vpofuGSPzaHK
OQ7qx/lN4ouUbRx9MVGYyN9n1JX4/DqBX0ibm4c1sg4qoie9qBFM/foAMOzD0YI6
IptkVdsNLLr9ItqTyJoC82v+RZOR3fmyG7PPf9hQquCVCyM9dR5OQi4MdBNR9l8O
U0shVUKKpRHeoQ1Xefzf
=xNMM
-----END PGP SIGNATURE-----

--0xOVUFIIuv3GvCmvkSjEO1DfUWxSAfJoi--
