From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Feb 2014 10:11:29 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <52FB48D1.7040905@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wEr510kAkEAsMG2G8PHXnHOUGd52WkcVO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com> <1389698184-28761-5-git-send-email-zzhu3@marvell.com> <52F8C96F.7050107@ti.com> <52F998B7.7060203@marvell.com>
In-Reply-To: <52F998B7.7060203-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

--wEr510kAkEAsMG2G8PHXnHOUGd52WkcVO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 05:27, Zhou Zhu wrote:
> On 02/10/2014 08:43 PM, Tomi Valkeinen wrote:

>> How is the panel linked to all this? The nodes above do not refer to t=
he
>> panel.
> We are making panel refer to path, so when panel dev probe, it could
> register to related path.
> The reason we not link from path to panel is our customer sometimes
> asked us to use same image pack (include dts) for different panel types=

> in product. We could only add all these panels in dts and detect panel
> dynamically when boot. So moving panel out and making path not link to
> panel but panel link to path would be more straight forward.

Ok.

>>
>>> +    ...
>>> +    marvell,path =3D <&path1>;
>>> +    ...
>>> +};
>>
>> It's a bit difficult to say much about this, as I have no knowledge
>> about mmp.
>>
>> But I don't quite understand what the pxa988-fb is. Is that some kind =
of
>> virtual device, only used to set up fbdev side? And pxa988-disp is the=

>> actual hardware device?
>>
>> If so, I don't really think pxa988-fb should exist in the DT data at
>> all, as it's not a hardware device.
> Yes, fb is a virtual device for fbdev side.
> In our platforms we may use more than one fb for different paths/output=

> panel or multi overlays on same path for composition. So we need to
> configure fb settings like which path/overlay/dmafetch it connected to
> for one or more fbdev.
> Besides, some more configures like yres_virtual size or fixed fb mem
> reserved rather than allocated which depends on platforms are also
> needed although these features are not upstreamed yet.
> So we put fb as a dt node here for these configures.

Ok.

The device tree data should reflect the hardware. Not the software. So
when thinking what kind of DT data you should have, you should forget
the drivers, and just think on HW terms.

You might want to have a look at CDF (Common Display Framework)
discussions on linux-fbdev list, and the "[PATCHv3 00/41] OMAPDSS: DT
support v3" series I've posted (mostly the .dts parts).

It sounds to me that you'd benefit greatly from the CDF, and even if CDF
is not yet merged (and will probably still take time), I'd very much
recommend trying to create your DT data in such a manner that it would
be in the same direction as what is currently suggested for CDF (or in
the OMAPDSS series).

>> Why isn't there just one node for pxa988-disp, which would contain all=

>> the above information?
> We have moved out fb/panel from path due to several reasons:
> 1. To simplify the node. If moved these nodes in, it might be:
> disp {
>     ...
>     path1 {
>         ...
>         panel-xxx {
>         }
>         panel-yyy {
>         }
>         ...
>         fb0 {
>         }
>         fb1 {
>         }
>     }
>     path2 {
>         ...
>         panel-zzz {
>         }
>         fb3 {
>         }
>     }
> }
> Also due to child node type might be different, we could even not
> directly check child of node. The code would be complex.
> 2. the path of node would be too long and not so common.
> e.g. the panel node in dts would be /soc/axi/disp/path1/panel-xxx, and
> in sysfs, node would be /sys/devices/platform/soc/axi/path1/panel-xxx.
> It would be complex and not compatible for platforms when our
> bootloader/user app doing some operations to these nodes.
> If we moved them out, we could move fb/panel out of soc directory so th=
e
> node would be /panel-xxx or /fb1 and simpler and compatible.

I suggest to first think only about the DT data, and create it
correctly. After that you could think how to create compatibility code
in the driver side, so that the legacy sysfs paths are still usable.

The thing with DT data is that it's quite difficult to make big changes
to it later, without writing possibly complex compatibility
functionality. So in my opinion it's worth it to spend a good deal of
time thinking about good DT bindings from the start.

That said, if the driver and hardware in question is for some old SoC,
that's not going to be used on new boards, and the driver is not going
to be used in any future boards, it might be simpler to just make simple
bindings that work for the known set of boards and displays, and be done
with it.

I don't know if that's the case here or not.

 Tomi



--wEr510kAkEAsMG2G8PHXnHOUGd52WkcVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+0jRAAoJEPo9qoy8lh71Tr8P/j5lGHhGWyN5QbV1WDns37N7
fYxg84wTnm6o8Tmr/RuIX9QgQoNdS1hDOU3Jruzn4Yl6vdmpabXNa6hUSizhJoAf
8iOsJnMBBGMyXjYnqLKoVSi6+xKKTrh1CKdmEkoWLbRvhHsmDjmTeQVHW+CXBTYU
DmXc4tTLe/gsX31qLGoskR2mvhC9ZAJX4+2ZuIR6SKsK66K7pFyPDOFA/HjtrCjJ
h0FlQkuetoMiEKbRGpHwNz+C++tlwYrfbIuagK6LehurgiG19BOvkdgyY3jr5eUk
+29mceP3UxfXV41sKswVCEE4iu5bVSst/Gs97eB2QvsODnOrRkA/XJddFzTiMHi4
fPNqlhOYtV3Zp2R8l2XFXlTtgqqELmtt9q8/DSSM2f23DFMdjxRKzI6OZd+Wekuq
UhUPX4cds24JYg0Jlf8JO0BjvOnbvL1Fh5YZIB+UDeD2l2pVQGrdkaqwAL8F/IOG
CN7gyuXjTf6Z3rp+/KiStPizMXgXqUVMUrmTyDOYMvyhKs4prF+yP5E7Ay8x5FdI
SSd+ooNT3qhht5WjzLMmh6R5l4Jbmmw+brbGJzmBWa0URQBVAz6CLwbgoYB+lwkX
vxq2WNb6Lj67jnMlD+bUXEtPED6I7K6CpxAU2DP7E/GTejCjAcSx3Op5yTtuxxQ+
LlaUqtUqCEuRjgD1IYuU
=aZ65
-----END PGP SIGNATURE-----

--wEr510kAkEAsMG2G8PHXnHOUGd52WkcVO--
