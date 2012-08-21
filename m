From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Aug 2012 07:44:29 +0000
Subject: Re: [PATCH v4 1/3] Runtime Interpreted Power Sequences
Message-Id: <1345535069.4085.7.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-DqQcqcJZ3QuxHhqjuHRu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
	 <1345097337-24170-2-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1345097337-24170-2-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <leelakrishna.a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-DqQcqcJZ3QuxHhqjuHRu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-08-16 at 15:08 +0900, Alexandre Courbot wrote:

> +Problem
> +-------
> +One very common board-dependent code is the out-of-driver code that is u=
sed to
> +turn a device on or off. For instance, SoC boards very commonly use a GP=
IO
> +(abstracted to a regulator or not) to control the power supply of a back=
light,
> +disabling it when the backlight is not used in order to save power. The =
GPIO
> +that should be used, however, as well as the exact power sequence that m=
ay
> +also involve other resources, is board-dependent and thus unknown of the=
 driver.
> +
> +This was previously addressed by having hooks in the device's platform d=
ata that
> +are called whenever the state of the device might reflect a power change=
. This
> +approach, however, introduces board-dependant code into the kernel and i=
s not
> +compatible with the device tree.

I've been having the same problems on OMAP display related code, but the
problem has always been fixable by just having the driver to use a
common framework to do the job (a framework which may not have existed
at the time). The problems have never been board specific in the end,
but device specific.

Can you describe your particular HW problem a bit more? In the backlight
case, what exactly requires the delays and the sequence you show in the
example to enable/disable the backlight?

 Tomi


--=-DqQcqcJZ3QuxHhqjuHRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQMzxdAAoJEPo9qoy8lh71lwwP/0uNfoQ7aOpM+/q8cOSwLxRV
FqU1xzMzaW/6gtjgjIq+RJXuJHjUwZQPEnqBION6zjaxc5t0nbVxLnH8b534OOSC
POj/tQSvb27MSpV1d90CqWVASySuOS3fJyQWq+3JwlhfYf21JjaN8OSJoi9wnKgF
9oPGGoQMg5IOBhgb/lVm/xwJuMky2YQblJuzPfx/MPvATsHz9qSs2AfabjjwKhBP
X+ft+3KecV0J2RnCUBOuZkP+dLU62vNmri/kE1r1xzAGpx+X9eMxyYTGTyAE27/P
kHqBex0S6Nf2wt1eo1tKRf0CyzAvQh0+aB107RACT97utNSP+dR+OepDXOjYAMTC
g1PZtVsdDq8VcSsRKjz0k0tEkYhd2VkSeq/qSlxBiM4Im8PiT2ZaepGHWcX2zJN2
LomBI0yV8u3gbizYR1cWCUzGPQK90K9hVt/fSDY0Abl3lzvlmgSIDTov7aKYZbQo
cvO1OCL7Yx606Y7X0YwX+0YGuQDxVu+xpTC6onSrIaURH0Vrp8rkmnJygInDBwsz
QgsGqOOij8hopNOF5GgMtgIR6crsoyeezxLZKKFccGBrWIogekmIU1xV5mK+TpyE
wiKzzGdFad4YZm5Pe5Lz/MVmqAa0/vgEe8s9mfpC3RhxNjqzfd9sNGSJQy42rar5
ns1eRlqzqieoLKJQyefj
=6AEd
-----END PGP SIGNATURE-----

--=-DqQcqcJZ3QuxHhqjuHRu--

