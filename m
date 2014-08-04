From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 04 Aug 2014 06:36:53 +0000
Subject: Re: [PATCH v4] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <53DF2A05.3060207@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="87h5WCtpSfgrwPTiokn44Ut1araeajKNn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406892474-6548-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1406892474-6548-1-git-send-email-decui@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, jasowang@redhat.com, driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, olaf@aepfle.de, apw@canonical.com, plagnioj@jcrosoft.com, haiyangz@microsoft.com, dan.carpenter@oracle.com

--87h5WCtpSfgrwPTiokn44Ut1araeajKNn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/08/14 14:27, Dexuan Cui wrote:
> Currently the VSC has no chance to notify the VSP of the dirty rectangl=
e on VM
> panic because the notification work is done in a workqueue, and in pani=
c() the
> kernel typically ends up in an infinite loop, and a typical kernel conf=
ig has
> CONFIG_PREEMPT_VOLUNTARY=3Dy and CONFIG_PREEMPT is not set, so a contex=
t switch
> can't happen in panic() and the workqueue won't have a chance to run. A=
s a
> result, the VM Connection window can't refresh until it's closed and we=

> re-connect to the VM.
>=20
> We can register a handler on panic_notifier_list: the handler can notif=
y
> the VSC and switch the framebuffer driver to a "synchronous mode", mean=
ing
> the VSC flushes any future framebuffer change to the VSP immediately.
>=20
> v2: removed the MS-TFS line in the commit message
> v3: remove some 'unlikely' markings
> v4: avoid global variables as Tomi Valkeinen suggested
>=20
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 62 +++++++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 59 insertions(+), 3 deletions(-)

Thanks, looks fine to me. Queuing for 3.17.

 Tomi




--87h5WCtpSfgrwPTiokn44Ut1araeajKNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT3yoJAAoJEPo9qoy8lh71IzMP/2iwStdsFdIrQHpt2SBSFL0J
Y9n1/4lPdP6ONkjEeUJHnWabcu5phEi6gfcI9+OiRGsABrDpzEckX9sg1F1LuKJW
ByDNx1v3g+Tk3gq6/ea3OmLVBXSGZrFOgzmQmpvTSwBHA9lHAGwz+PZ4CDtXn0GW
gHK6rnKisJUWStWy55XSZFMV52944M9hLriWP5aM44cJz06HAIdvT8UZalEYdBnn
IxlurE2PP9aVEj0DcWAJs+uSeeCuiLwhLfNH54rfK3BwOmnWjsj7Oj1mn4Vfhztn
ZzehAIv4OcI0MBtu/YCiHbd+40ulq1CDr3R6zZdm4338w8N7GRU9AXj2WpY5ZO3I
s+x+98kLX4W5RwISOXBhdWphtcpqKdrfitOS9rBTxDl3VV2tv4Zs+WEQWmKzzZyL
aFVMVsPmiKLYYMmvCayd+s9CuKma7Q8vK1JdI5OPNMNObaVODZylweddnGVOLSNT
dk7hg0TeZV50wPgZOvdOrM7z0duZ2HLA76KnhYBaKnku596GQu1Oyfz2/xKGdM7L
T2vOr8lqZ/VQNUxyj/92o3/6S4ExKkVUsJ/D7MuS5+zEjVNOr/oKLrbY40ldDipz
Q/S8OlFTejbQbHiiTDWPFBWcjyL20SCx6BQh6ltYnNUTj3FzBLHn/BeZUEiGUN7p
xYxt/rQKH+Rq+EwbHrGw
=Y9f3
-----END PGP SIGNATURE-----

--87h5WCtpSfgrwPTiokn44Ut1araeajKNn--
