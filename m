From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 30 Oct 2013 11:19:37 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <20131030111936.GA31208@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
In-Reply-To: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 01:52:57PM +1000, Dave Airlie wrote:
> So we had a sessions at kernel summit to discuss the driver model and
> DT interactions for a display pipeline,
>=20
> we had good attendance from a few sides and I hope to summarise the
> recommendations below,
>=20
> a) Device Tree bindings
>=20
> We should create a top-level virtual device binding that a top level
> driver can bind to, like alsa asoc does.
>=20
> We should separate the CDF device tree model from CDF as a starting
> point and refine it outside of CDF, and produce a set of bindings that
> cover the current drivers we have, exynos, imx, tegra, msm, armada
> etc. This set of bindings should not be tied on CDF being merged or
> anything else.
>=20
> Display pipelines should be modelered in the device tree, but the
> level of detail required for links between objects may be left up to
> the SoC developer, esp wrt tightly coupled SoCs.
>=20
> Externally linked devices like bridges and panels should be explicitly li=
nked.

According to the above, the device tree bindings for simple panels that
I proposed earlier should be fine. However there was so much controversy
involved that I've decided not to make that part of my pull request this
cycle. Also they haven't been reviewed by DT bindings maintainers yes,
so according to our new rules they cannot be merged.

I think Laurent was more or less fine with them too, although he had
some objections to how DSI panels were represented and wanted those to
be sub-nodes of the DSI controller. I'll see if I can come up with
something to address that.

We should probably aim for a common binding for things like DSI.

> b) Driver Model
>=20
> The big thing here is that the device tree description we use should
> not dictate the driver model we use. This is the biggest thing I
> learned, so what does it mean?
>=20
> We aren't required to write a device driver per device tree object.
>=20
> We shouldn't be writing device drivers per device tree object.

I may remember this wrongly, but that's the opposite recommendation that
I got back when I started to work on Tegra DRM.

> For tightly-coupled SoCs where the blocks come from one vendor and are
> reused a lot, a top level driver should use the DT as configuration
> information source for the list of blocks it needs to initialise on
> the card, not as a list of separate drivers. There may be some
> external drivers required and the code should deal with this, like how
> alsa asoc does.
>=20
> To share code between layers we should refactor it into a helper
> library not a separate driver, the kms/v4l/fbdev can use the library.
>=20
> This should allow us to move forward a bit clearer esp with new
> drivers and following these recommendations, and I think porting
> current drivers to a sane model, especially exynos and imx.
>=20
> Now I saw we here but I'm only going to be donating my use of a big
> stick and review abilities to making this happen, but I'm quite
> willing to enforce some of these rules going forward as I think it
> will make life easier.
>=20
> After looking at some of the ordering issues we've had with x86 GPUs
> (which are really just a tightly coupled SoC) I don't want separate
> drivers all having their own init, suspend/resume paths in them as I
> know we'll have to start making special vtable entry points etc to
> solve some random ordering issues that crop up.

Where does that leave the Tegra driver? I've spent a significant amount
of time to get it to some sane state where having multiple subdrivers
are handled fairly nicely (in my opinion). Rewriting all of it isn't
something that I look forward to at all.

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScOtIAAoJEN0jrNd/PrOhFKEP/0HicKXdMRQ+gS65xbxD6FzP
PzSKCZIz0FYHNNFfe6Aj0UwGgjhQexetYqSr0pZnOYp+oT/m0ILwZBEh0YI7cJ9W
n19zoE1m+oSZ1S2Y2IYuDRK6WvSyC5Wp3vX5sOIlUfB43apP7a3y9erQA4Lqsser
fCCMetXkWEkFvOMQkSeokErg/1pZKY5Xuh53sAxZna2xHZkdESElZv96cf9QTwj/
bEbLUafJvn5vVR/JUWho9S4Yhzpuj9P/+m5H6pkuhR5CjgRfn0g5seRb6u4RQXDf
J5eXQbzupZ7GLvJFfIYIL+VNLk9dVXqwENkP1MG5ymJ5pHZKA79pLS7AR8S5Yav8
3asguzJY+AqHivogF0ObAXG1QZxsiQYgSRPF5m3coKrtJemUyXCIrBlSoOgq6Oyz
i3JQSRc9v1v2+Si5ZEh2NudKm5PWRuarz+BqZweIcJeAjeNdOn+Ud/jst21MGZcZ
GNbJrQOCLqhGFRYg4LsX0PyK9au0dV7b7Ed4AmuhrMAPY3puN1LBkKYNa6q3BSzm
90xvIdfmDKUu2o9UAnNZDuCQsWXZRrbTjWgmvlc5z4FvPlY2m1pi4zINSF/1tJoY
KB24Axid3XeTuArX4orsn1e8OvMrjz+W1c3GfisieIyalZ4RxPaN5Edo3SPELj3q
fTVl7m0ACPRU4xacGhrz
=MB+Q
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
