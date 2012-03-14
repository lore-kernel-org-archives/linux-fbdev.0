From: Grazvydas Ignotas <notasas@gmail.com>
Date: Wed, 14 Mar 2012 16:33:34 +0000
Subject: Re: [PATCH v2] OMAPDSS: provide default timings functions for panels
Message-Id: <CANOLnOMAg-gdGPCuR1eR39GzNcK0rqFpfx6hiC2ULgPQ5v4qbA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331551631-11420-1-git-send-email-notasas@gmail.com>
	<1331724142.2386.25.camel@deskari>
In-Reply-To: <1331724142.2386.25.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On Wed, Mar 14, 2012 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> Hi,
>
> On Mon, 2012-03-12 at 13:27 +0200, Grazvydas Ignotas wrote:
>> With this we can eliminate some duplicate code in panel drivers.
>> Also lgphilips-lb035q02, nec-nl8048hl11-01b, picodlp and
>> tpo-td043mtea1 gain support of timings control over sysfs.
>
> I don't like this patch.
>
> Panels usually have a single, fixed timing configuration that should be
> used, like the ones you mention above. There's no need to alter the
> timings.

But they often have a range of timings they can tolerate, and that can
be used to alter refresh rate, for example. We do that on pandora to
match graphics drawing rate (or multiples of it) to create a feeling
smoothness.

> But it's true that there's some duplicate code currently in the panel
> drivers. However, adding just simple funcs like you did in this patch
> doesn't work quite properly. There should be locking (for example to
> prevent disabling the panel while timings are being set), and currently
> the locking is panel driver specific.

ok, what about a version of this with .get_timings only then?
This should not need a lock unless panel has a set function, but in
that case panel will be expected to provide safe version of .get and
.set itself.

--=20
Gra=C5=BEvydas
