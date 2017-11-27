From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 27 Nov 2017 17:44:54 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <20171127174454.GA18851@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
In-Reply-To: <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Mon, Nov 27, 2017 at 06:27:08PM +0100, SF Markus Elfring wrote:
> >> Omit an extra message for a memory allocation failure in these functio=
ns.
> =E2=80=A6
> > nak, unlike many others, these message give extra info on which
> > allocation failed, that can be useful.
>=20
> Can a default allocation failure report provide the information
> which you might expect so far?

You should be able to answer that question yourself. And if you are
unable to do so, just do not sent changes pointed by any code analysis
tools.

As a side note, if you look at whole call chain, you'll find quite some
room for optimizations - look how dev and pdev are used. That also applies
to other patches.

Best regards,
	ladis
