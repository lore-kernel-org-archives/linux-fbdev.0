From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 03 Feb 2015 02:34:58 +0000
Subject: Re: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Message-Id: <20150203133458.688cbac0@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/2Vvk.WeKEzVYJTtz+E2/vv."
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-6-git-send-email-haokexin@gmail.com>
 <20150201134433.729a2389@canb.auug.org.au>
 <20150201055150.GA6681@pek-khao-d1.corp.ad.wrs.com>
 <20150203022002.GB28170@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20150203022002.GB28170@pek-khao-d1.corp.ad.wrs.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linuxppc-dev@lists.ozlabs.org

--Sig_/2Vvk.WeKEzVYJTtz+E2/vv.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Tue, 3 Feb 2015 10:20:02 +0800 Kevin Hao <haokexin@gmail.com> wrote:
>
> I took a second look at this. It seems that there is a declaration of
> struct device_node in linux/device.h and there is also no access to the
> member of device_node in this driver. So we are safe to not include of.h =
here.
> That is also why I didn't get the build failure for the non-OF archs. :-)

Right.

Seems ok, then.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/2Vvk.WeKEzVYJTtz+E2/vv.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU0DPSAAoJEMDTa8Ir7ZwVhCIP/3ei51yAsWapA0jjh3/FnUbB
xK+wmP72/67a7aZ/TFz/PwU0YjPseg8RQESmKLe0DVkoOLMYMiUbKLcq7xPZr83V
sLDJwmv47LkVSPA1ELlnsqpkmerm2v2tdeBx2KkLdwt6b9ZDQA/u9ydR3n5g1KJX
B3ytkZcZ2EIoqnq+fd/x68loCs3BHZ6HMljr5kZ+6AjZfeyhpctza4wUgep6vDzx
y14seSugKWd5dflcXgbAwexbljnjYziPo89PHXgAbGJi8gTqE7nrMVaa3OOnFOwd
E/TcMSnWCaVOEJUKAP4J2KLoG4xPiJPorxYCI/3ngCKS6BpGvdaooPO6mZ2LWA2G
l1iaCs6tR+fIQCTlvG1yHKy5EcJLQWa/l915oYqsRsZZOH81Li+KaMWT2znrFNPg
JMRhW0TYWqDh6zsWMnXukmSwMhNaCf1jUzT0XyPiiWef38U25ECXP183ZSE3dgon
lblXZskrH6UDW/5vtcd5+poSTwzGPDtKlrqNgjZqXFcYK/SztjPUGjShhU+y4CCt
MGL/X9NNwFZZUbvrPH40SU16OVVcMUJ9hXjhDLpB++88wYFbx1j77jwqzSkewgjq
ACpJlOUTDYMOAg/Yrzx8oSV1gjvNrFldj4XsvjA2GaHv+5yXxlaVebT09hXVXf7d
PaVWenP3qTq57Kopzpxn
=An8u
-----END PGP SIGNATURE-----

--Sig_/2Vvk.WeKEzVYJTtz+E2/vv.--
