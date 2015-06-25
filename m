From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Thu, 25 Jun 2015 23:11:03 +0000
Subject: Re: [PATCH v5 1/3] video: fbdev: atyfb: clarify ioremap() base and length used
Message-Id: <20150625231103.GB4362@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
 <1435196060-27350-2-git-send-email-mcgrof@do-not-panic.com>
 <20150625230437.GA4362@sci.fi>
 <CAB=NE6V0HGCkpYFghUyyk=+St-494Y8e9PEakF9F7cEB8vpKvA@mail.gmail.com>
In-Reply-To: <CAB=NE6V0HGCkpYFghUyyk=+St-494Y8e9PEakF9F7cEB8vpKvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@elte.hu>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Dave Airlie <airlied@redhat.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, Mathias Krause <minipli@googlemail.com>, Andrzej Hajda <a.hajda@samsung.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>

On Thu, Jun 25, 2015 at 04:06:45PM -0700, Luis R. Rodriguez wrote:
> On Thu, Jun 25, 2015 at 4:04 PM, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
> > it doesn't hurt too much
> > since smem_len gets overwritten later in aty_init().
>=20
> That's the idea, we set it with a default as it will be overwritten
> later anyway.

Maybe toss in a comment? Otherwise it's a bit dishonest and might give
someone the impression that all PCI cards really have 8MB of memory.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
