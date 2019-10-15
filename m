From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Tue, 15 Oct 2019 11:48:43 +0000
Subject: Re: [PATCH v2 14/15] staging/mgakms: Import matroxfb driver source code
Message-Id: <20191015114843.GB4104@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191014140416.28517-15-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-15-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, airlied@linux.ie, gregkh@linuxfoundation.org, michel@daenzer.net, corbet@lwn.net, malat@debian.org, dri-devel@lists.freedesktop.org, sean@poorly.run

On Mon, Oct 14, 2019 at 04:04:15PM +0200, Thomas Zimmermann wrote:
> Only code is being copied, no functional changes are made.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/staging/mgakms/g450_pll.c         |  539 +++++a

...

Personally I would start from scratch. In fact some years (*cough*
decade) ago I did just that and started writing a new driver for
matrox stuff. Unfortunately I ran out of steam after figuring out
most of the interesting hardware quirks and whatnot, so I never
finished it. The end result is that it still runs in userspace
but kinda looks like a kernel driver if you squint a bit.

Anyways, I just slapped a MIT license on it  dumped the whole
thing here:
https://gitlab.com/syrjala/mga
The development history was, shall we say, not really useful
so I just squashed it.

You, or someone else, might find it interesting. I think in
terms of hardware support it's a superset of any other driver,
apart from the blob.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
