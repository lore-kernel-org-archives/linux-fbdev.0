From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Fri, 30 Jun 2017 07:27:29 +0000
Subject: Re: [PATCH RESEND 0/7] Introduce MEDIA_VERSION to end KENREL_VERSION abuse in media
Message-Id: <20170630072729.GC5236@linux-x5ow.site>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170621080812.6817-1-jthumshirn@suse.de>
 <20170624171507.38353b10@vento.lan>
 <20170629094259.GG3808@linux-x5ow.site>
 <20170629100105.6af3b77a@xeon-e3>
In-Reply-To: <20170629100105.6af3b77a@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org

On Thu, Jun 29, 2017 at 10:01:05AM -0700, Stephen Hemminger wrote:
> If you read Linus's comments on version.
> Driver version is meaningless and there is a desire to rip it out of all
> drivers. The reason is that drivers must always behave the same, i.e you
> can't use version to change API/ABI behavior.=20

Indeed this causes more harm than good. We had support calls regarding the
mlx4 driver because of not incremented MODLE_VERSION()s. If we follow your
and Linus' path we shouldn't just get rid of the KERNEL_VERSION() usage
in media and replace it with a new version, but kill all the versioning
stuff out of media (and others) except for maybe the HW version.

> Any upstream driver should never use KERNEL_VERSION().

Exactly my reasoning.

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
