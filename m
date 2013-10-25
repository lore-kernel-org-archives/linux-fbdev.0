From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 25 Oct 2013 12:29:26 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131025122925.GA24720@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <3278905.VOXO7bPE7e@avalon>
 <526999DA.7080409@wwwdotorg.org>
 <1580941.z2CDo8WmRF@avalon>
In-Reply-To: <1580941.z2CDo8WmRF@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 01:33:11PM +0200, Laurent Pinchart wrote:
> Hi Stephen,
>=20
> On Thursday 24 October 2013 23:06:18 Stephen Warren wrote:
> > On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
> > > On Sunday 20 October 2013 23:07:36 Stephen Warren wrote:
> > >> On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
> > >> ...
> > >>=20
> > >>>> As I said, anything that really needs a CDF binding to work
> > >>>> likely isn't "simple" anymore, therefore a separate driver can
> > >>>> easily be justified.
> > >>>=20
> > >>> The system as a whole would be more complex, but the panel could be
> > >>> the same. We can't have two drivers for the same piece of hardware
> > >>> in the DT world, as there will be a single compatible string and no
> > >>> way to choose between the drivers (unlike the board code world that
> > >>> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> > >>> and live happily with that ever after).
> > >>=20
> > >> That's not true. We can certainly define two different compatible
> > >> values for a piece of HW if we have to. We can easily control whether
> > >> they are handled by the same or different drivers in the OS.
> > >=20
> > > From an implementation point of view, sure. But from a conceptual poi=
nt of
> > > view, that would make the DT bindings pretty Linux-specific, with a
> > > description of what the operating system should do instead of a
> > > description of what the hardware looks like. My understanding is that
> > > we've tried pretty hard in the past not to open that Pandora's box.
> > >=20
> > > The case I'm mostly concerned about would be two different compatibil=
ity
> > > strings to select whether the device should be handled by a KMS or V4L
> > > driver. I don't think that's a good idea.
> >=20
> > I wouldn't think of the two compatible values as selecting different
> > specific Linux drivers, but rather they simply describe the HW in
> > different levels of detail. The fact that if we know a certain level of
> > detail about the HW means that Linux can and does create a KMS driver
> > rather than a V4L2 driver seems like a detail that's completely hidden
> > inside the OS.
>=20
> I expect the same level of details to be needed on both the KMS and V4L s=
ides.=20
> Taking the example of the ADV7511 HDMI transmitter, the only change in th=
e DT=20
> bindings between KMS and V4L would be the compatible string. "adi,adv7511=
-v4l"=20
> and "adi,adv7511-kms" is an option that I don't really like. Renaming -v4=
l and=20
> -kms to different names wouldn't fundamentally change the problem.

I think that we're doing something fundamentally wrong if we use the
same device (with the same functionality) in two different subsystems.
If the device is used to display something, shouldn't we be moving the
driver to DRM?

Thierry

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSamQlAAoJEN0jrNd/PrOh83oQALFKmoEV8XvaUyN+Z80HklaF
vE8kHsoZ5eScFPyadLsXR17/Oi2fOPkCQYqlaW44Cn/obENgcNKkvH5Lt4RbNU8U
3al2kXhpkdxoJ4ByYmozG1WPKO3QUpdQx4YjmOeX+bFc0DcBw7H7WHH6/EYa9H7S
XgUfe599u8szrHDkyar6QvPgYA1QeJGy6vcam/VOlBiuoO+AUhggC3+NQTxvDDyM
UAAiDZ6M4MICSaEYfmc8/TiFxgdIuswH9eQJl/GyxOwcSsTO79Ek6zKqQ+9gksrW
giLIZhfHpCikQRgALsfXtwBo9+9+9JlckG+XD+G0PxFh4Xx9+kZkOsvgxLyBovVn
tG1pZZBErM8IVtPyxMI2j/EQeWPYSg113Ky+8K12/zQEX2IGsHtqgIhO5xs0Y6lD
14nRbNmVN2AI2Lm1teAIQhOakoxXevCO7eGE4AzcXLZrfOK9eu253fmjlDG1gcGI
x8FGETiJ09WpgrnceF529JtzwQosezDkox78EHzw2zaos3jac5IPtSnb1YHnoKvH
1bqdCqgsJQuTANrJceo8wmMeCSGa/quwYHZ+FdWSOsnzXEjmpOpwkOo1BB9a9yLe
Gfc2N5JMQjf+o95bWGJdGG4t8lID5fBgfpdqPHJ9npEa9yq1wBH5Spdpp1/KjN8h
1L4KSyHY/5TbHYHTIwjs
=VZL4
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
