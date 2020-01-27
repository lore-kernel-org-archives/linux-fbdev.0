From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Mon, 27 Jan 2020 11:59:01 +0000
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
Message-Id: <20200127115901.GC13686@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200125195506.GA16638@brightrain.aerifal.cx>
 <20200126071724.GA3520745@kroah.com>
 <CAMuHMdU32gF89zz86WH3AqkoPK7hdSjWMexJ1aLU9woe0qF0YA@mail.gmail.com>
In-Reply-To: <CAMuHMdU32gF89zz86WH3AqkoPK7hdSjWMexJ1aLU9woe0qF0YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Rich Felker <dalias@libc.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, DRI Development <dri-devel@lists.freedesktop.org>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Jan 27, 2020 at 11:40:24AM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
>=20
> On Sun, Jan 26, 2020 at 8:44 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jan 25, 2020 at 02:55:06PM -0500, Rich Felker wrote:
> > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > --
> >
> > I know I don't accept patches without any changelog text, don't know
> > about other subsystem maintainers...
>=20
> FTR, I do, iff the one-line summary says everything that needs to be said.
>=20
> What's the point in writing a full paragraph like:
>=20
>    Currently the foo driver does not support the bar device.
>    As users may want to use the bar device, it makes perfect sense
>    to add support for the bar device to the foo driver.
>    Hence add support for the bar device to the foo driver.
>=20
> if this doesn't add any value on top of the one-line summary?

At least it allows one to reply to *something*. If there's just a
subject line you have zero quoted context for the reply apart from
the patch itself. So rather confusing if you want to comment on
the overall thing rather than on any specific changes in the diff.


The other bad commit message style I dislike is the:

"Subject: Do something...

 ...because whatever."

As if the subject was a part of the first sentence of the commit
message. Often makes replies even more confusing since now you
have just a part of the sentece quoted.

I do understand why new people make this mistake though; There
should probably be a more explicit indication that the first
line is the subject when editing the commit message.

--=20
Ville Syrj=E4l=E4
Intel
