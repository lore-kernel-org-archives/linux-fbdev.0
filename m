From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 15:12:58 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825151255.GA14967@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com>
In-Reply-To: <53FB47B8.2090104@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 04:27:04PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 08/25/2014 04:23 PM, jonsmirl@gmail.com wrote:
> > On Mon, Aug 25, 2014 at 10:16 AM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> >> On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> >>> On 08/25/2014 03:39 PM, Thierry Reding wrote:
> >>>> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >>>>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >>>>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >>>>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >>>>>> [...]
> >>>>>>>> If not, perhaps the clock driver should force the clock to be
> >>>>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> >>>>>>>
> >>>>>>> I'm sorry, but I'm not going to take any code that will do that i=
n our
> >>>>>>> clock driver.
> >>>>>>>
> >>>>>>> I'm not going to have a huge list of ifdef depending on configura=
tion
> >>>>>>> options to know which clock to enable, especially when clk_get sh=
ould
> >>>>>>> have the consumer device as an argument.
> >>>>>>
> >>>>>> Are you saying is that you want to solve a platform-specific probl=
em by
> >>>>>> pushing code into simple, generic drivers so that your platform co=
de can
> >>>>>> stay "clean"?
> >>>>>
> >>>>> Are you saying that this driver would become "dirty" with such a pa=
tch?
> >>>>
> >>>> Yes. Others have said the same and even provided alternative solutio=
ns
> >>>> on how to solve what's seemingly a platform-specific problem in a
> >>>> platform-specific way.
> >>>
> >>> This is not platform specific, any platform with a complete clock dri=
ver
> >>> will suffer from the same problem (the clock driver disabling unclaim=
ed
> >>> ahb gates, and thus killing the video output) if it wants to use simp=
lefb
> >>> for early console support.
> >>
> >> It is platform specific in that your platform may require certain cloc=
ks
> >> to remain on. The next platform may require power domains to remain on
> >> during boot and yet another one may rely on regulators to stay on duri=
ng
> >> boot. By your argument simplefb will need to be taught to handle pretty
> >> much every type of resource that the kernel has.
> >=20
> > Why can't simplefb be a driver library that is called from a device
> > specific device driver that only claims the clocks (or regulators)?
> > Then build all of these device specific drivers into the generic ARM
> > kernel. They will be quite small since all they do is claim the clocks
> > (or regulator).  Maybe we can even figure out some protocol for
> > removing the unused ones from memory later.
> >=20
> > Later during the boot process the device specific driver can load its
> > KMS code which has also been implemented as a driver library. Maybe
> > use E_PROBE_DEFER to do this. Match on the device ID, claim the
> > clocks, defer until the full KMS library can be loaded.
>=20
> There is no need for all this complexity, all that is needed is for the
> simplefb driver to be thought to claim + enable any clocks listed in
> its dt node.

Out of curiosity, how does this work in practice? How does the
bootloader create this entry? Does it scan the DT to see which clocks
the real hardware device references and then simply copies them to the
simplefb node?

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+1J3AAoJEN0jrNd/PrOh72YP/AuGb/1WsyO8G1vR8hq30t4u
JDILi4eoa3O0Z5F9EGSh/AkldDpuQb2EfKi+vjgubEgT7CXrKfiftmKRJEDf65Ju
+912tJ/9IvxZdNuJ5Mv0n0tkwEJm3JzSGNQAqElsoqw+25BXl9IVkZPITy5c3pQ9
WKg9aUt9KtxtvUxci+Z98yEFmsgxTCoBiwpdseN0+JmwUgoS19Ukqi4hBY83uzli
zamj7CcPL7wB7FbVDaSbTUNfQTaF7JweGrVdrSeH3HWSMEz+UvYqEXCkd3wOoIF+
BYUWjvu7OwqjgALVWulJi1btAWf52LKhCG7ycjUJ+fI/o3XnNzIorfBOi/zWHkJM
AVgEAGaDIORTnXS5b98snylT5J/S652X7dJ4TGSqu9FPTUkccn/IFBlE33mTQ9ny
wcz5AZ+GW9+ZzSim1pHMLCX+3e2FLWVDw5GR4r9fvHwkscKakRpWLyDtgL4pJKzT
v0v6JPXZu75LLgmPSoNAz3DRruVf+mfwJabLixFDWGYEdqL+W7TPnPs9Iw3EPOe5
WF5eSg+zzE2kPruvAD9DgO2BStlQOgXoQIupGEfpBeZLKHz+2IFSDCB7HUuloPqz
TfYMVWxAELe2JSebBGkqPDW+s3VB83MwcyxXhg+LLYDdaTJITikn4j+DaFEEL31W
d+72ZdZnG8wYIXRatC2K
=k8LA
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
