From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 20 Mar 2012 21:06:12 +0000
Subject: Re: Howto consolidate xgifb (staging) with sisfb
Message-Id: <20120320210612.GA5817@ultra.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203200002.40429.PeterHuewe@gmx.de>
In-Reply-To: <201203200002.40429.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

On Tue, Mar 20, 2012 at 12:02:39AM +0100, Peter H=FCwe wrote:
> I'm currently trying to improve the xgifb driver from staging a bit and m=
y=20
> final goal is to probably merge this driver with the sis driver (as both =
card=20
> families seem to have a lot in common).
>=20
> However I'm a little bit unsure how to proceed here.

I would first continue deleting unused dead code and definitions from the
staging driver. We have already removed maybe 10000 lines of code without
a loss of functionality, and I believe there is still more work to do.

Then with the remaining code, we could start thinking how to consolidate
the stuff with sisfb. Or even with the other fb drivers, I don't think
stuff like bpp_to_var is specific to these two drivers.

And once xgifb is cleaned up, the partial XGI support would be dropped
from sisfb.

A.
