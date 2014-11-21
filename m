From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 21 Nov 2014 14:36:04 +0000
Subject: Re: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <20141121143604.GF4752@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xkXJwpr35CY/Lc3I"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
 <20141117124721.GQ6414@lukather>
 <CACxGe6vqiC08sP+o3bduGfvUdwRtHm8+_7EdZccJjS86qVKvxQ@mail.gmail.com>
 <20141117155514.GU6414@lukather>
 <CACxGe6tqRS=oCeqbrez86uLLXtQ_C4ETEesNqgxKGb38QOQ8SQ@mail.gmail.com>
In-Reply-To: <CACxGe6tqRS=oCeqbrez86uLLXtQ_C4ETEesNqgxKGb38QOQ8SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2014 at 02:05:48PM +0000, Grant Likely wrote:
> On Mon, Nov 17, 2014 at 3:55 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Nov 17, 2014 at 01:39:18PM +0000, Grant Likely wrote:
> >> On Mon, Nov 17, 2014 at 12:47 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Mon, Nov 17, 2014 at 12:34:46PM +0100, Hans de Goede wrote:
> >> >> If pre-filled framebuffer nodes are used, the firmware may need ext=
ra
> >> >> properties to find the right node. This documents the properties to=
 use
> >> >> for this on sunxi platforms.
> >> >>
> >> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> >> ---
> >> >>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++=
++++++++++++
> >> >>  1 file changed, 33 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/video/simple-=
framebuffer-sunxi.txt
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/video/simple-framebu=
ffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer=
-sunxi.txt
> >> >> new file mode 100644
> >> >> index 0000000..84ca264
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-su=
nxi.txt
> >> >> @@ -0,0 +1,33 @@
> >> >> +Sunxi specific Simple Framebuffer bindings
> >> >> +
> >> >> +This binding documents sunxi specific extensions to the simple-fra=
mebuffer
> >> >> +bindings. The sunxi simplefb u-boot code relies on the devicetree =
containing
> >> >> +pre-populated simplefb nodes.
> >> >> +
> >> >> +These extensions are intended so that u-boot can select the right =
node based
> >> >> +on which pipeline and output is being used. As such they are solel=
y intended
> >> >> +for firmware / bootloader use, and the OS should ignore them.
> >> >> +
> >> >> +Required properties:
> >> >> +- compatible: "sunxi,framebuffer"
> >> >> +- sunxi,pipeline:
> >> >> +  <0> for the de_be0 -> lcdc0 -> output pipeline
> >> >> +  <1> for the de_be1 -> lcdc1 -> output pipeline
> >> >> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"
> >> >> +
> >> >> +Example:
> >> >> +
> >> >> +chosen {
> >> >> +     #address-cells =3D <1>;
> >> >> +     #size-cells =3D <1>;
> >> >> +     ranges;
> >> >> +
> >> >> +     framebuffer@0 {
> >> >> +             compatible =3D "sunxi,framebuffer", "simple-framebuff=
er";
> >> >> +             sunxi,pipeline =3D <0>;
> >> >> +             sunxi,output =3D "hdmi";
> >> >> +             clocks =3D <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43=
>,
> >> >> +                      <&ahb_gates 44>;
> >> >
> >> > If we're going that way, then maybe having to specify clock-names
> >> > would be better in order to know which clock is what?
> >>
> >> I wouldn't go that way with this binding since the driver has no need
> >> to differentiate between the clocks, and driver authors shouldn't be
> >> encouraged to do so. The purpose of the clocks in this node is only
> >> for itemizing dependencies, not for how to configure the clocks.
> >> Firmware shouldn't care at all about the clocks list, it only needs to
> >> find the correct pre-populated node to fill in and enable.
> >
> > Well, if we want to play the "DT as an ABI" stuff, you have no
> > guarantee that in the future, simplefb will still be the driver bound
> > to "sunxi,framebuffer", and that this driver doesn't need to
> > differentiate which clocks it needs to protect and which are not
> > needed. Especially with the combination of the output that you now
> > hardcode.
>=20
> As long as the node claims compatibility with "simple-framebuffer",
> then it must abide by the simple framebuffer rules. It cannot depend
> on the driver having special knowledge about what to do with the
> clocks. It is fine for a driver that understands "sunxi,framebuffer"
> to enable additional features over and above simple-framebuffer,
> providing it doesn't break the vanilla "simple-framebuffer" interface.
>=20
> The simple-framebuffer binding is clear that it will treat the clocks
> as dependencies only.

Isn't the compatible list precisely made to be able to define more
specific behaviours if needed?

If I get a list with "sunxi,framebuffer", "simple-framebuffer", I've
always thought that sunxi,framebuffer was defining exactly what the
device was about, and that simple-framebuffer was only aimed at
providing roughly the same functionnality, possibly with degraded
features, and with a compatible DT bindings.

I don't see how if we require a clock-names list in sunxi,framebuffer
that would break the binding of simple-framebuffer. It's just more
information, that might prove useful in the future.

> > Of course, if now we don't care at all about this ABI thing, it's
> > completely fine for me. But I'll archive this email preciously.
>=20
> I do not in any way mean to say it is okay to break ABI.
>=20
> Also, my comments above are advice that I would give to U-Boot
> authors, not something that should go in the binding. The
> simple-framebuffer binding doesn't need to know about the clock names
> at all, and if the assumption is that firmware will merely enable a
> pre-populated framebuffer node in the tree, then it probably doesn't
> need to parse the clocks property either. However, if it actually is
> better for the U-Boot implementation to have clocks with names in the
> node, then I'm not going to object.

I'm not speaking about u-boot here, but the kernel itself.

What if we want from that pipeline property to enable (or rather keep
enabled) only a few clocks, and not all of them?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb03UAAoJEBx+YmzsjxAgQ20P/jxUNFYnfVaAl/LPwrluqA6M
YhAlpSX1K30W1bGMfpg1PDWmCpkj9GwsodqvxSlB9aVRD/O54yUVgW8aDlfIm/1U
Nk6RoQ5cQkIg07otqPdT/dkxykMf7QHaV+bom1Ck0JM5hhrWXzTAGyn9WIjPbPHP
iD6HHU3vhgK47HCmurF0UqK6tF9NqsqTNXJYq71oUXUbwJqSrREnmN0Ng8j0+oF0
M3QANITd3+0QDJiRzSYf68wV1zPKgebhgONzTDiOZ+1tYdVYiSNxQpKjwM2pRDVu
jqQj6xPdIAtXvriFuhGDXwU3zpbbvBAP2uzyKRn6tuuiZmebhsUjhOi81cziYSRv
O5Yt5+GmqS6QkwuXDfxQvhp+1Rib3zbfU4Xm1vi6MnjxWjGJtQcLSNsK+P+xpdyL
X1NSBJ4sA6LKL4JL1r8sm92Pj5UXA7hjxqgipo8WqED6v1hhLoMkL40A8bK/wPSD
/eRll7i0tD1TdZiXuBj2E4nL1Z2BYIk2ZkZuar5xrMm61agvk0AjuBin8bCDXA3x
s8lsYNWnf2phsTby1qyW0Lo4rtDt7KxhjCp8GviYsztp9DLqekp4RjR2cT0+fhST
aKV3HLpHlMvS135H5iIt9x1T6acg1ZZHq3kZDn/1pCx+EaaAeAc+swiqAf+VPXz2
ZuepcY6fuO5Ul0dSZ2AE
=codj
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
