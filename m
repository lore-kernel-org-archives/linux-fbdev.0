From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Fri, 07 Dec 2012 12:53:50 +0000
Subject: Re: [PATCH 2/5] OMAPFB: simplify locking
Message-Id: <20121207125350.GE32230@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
 <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Dec 07, 2012 at 01:55:06PM +0200, Tomi Valkeinen wrote:
> Kernel lock verification code has lately detected possible circular
> locking in omapfb. The exact problem is unclear, but omapfb's current
> locking seems to be overly complex.
>=20
> This patch simplifies the locking in the following ways:
>=20
> - Remove explicit omapfb mem region locking. I couldn't figure out the
>   need for this, as long as we take care to take omapfb lock.

I suppose the idea with that was that you wouldn't need the global
omapfb lock, and also it was an rwsem so it allowed parallel access to
the mem regions, unless the region size was being changed, in which
case it took the write lock. I can't really remember what the reason
for using an rwsem was, but I suppose there was one at the time.

I think the only correctness issue with your patch is that you're
opening up a race between omapfb_mmap and
omapfb_setup_mem/store_size.

--=20
Ville Syrj=E4l=E4
Intel OTC
