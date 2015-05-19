From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 19 May 2015 21:52:29 +0000
Subject: Re: [PATCH v2 2/3] fbcon: use the cursor blink interval provided by vt
Message-Id: <20150519215228.GA27163@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.11.1502252319330.276@localhost>
 <20150226220243.GC9935@amd>
 <alpine.LNX.2.11.1502271905580.4212@localhost>
 <alpine.LNX.2.11.1502271911380.4248@localhost>
 <20150325111949.GA24230@kroah.com>
 <alpine.DEB.2.11.1503261341260.2164@local>
 <alpine.DEB.2.11.1503261354550.2411@local>
 <CAMAWPa-6ZbE5cDkEZq0XpYa2pHcnf3qweSSVHAXhfhUAUCbKcA@mail.gmail.com>
 <20150519214011.GA27047@ulmo.nvidia.com>
 <CAMAWPa88E2pfViKLXjxWHuT4ZkVhzYt_BsXGePzc-70ZrEmJFA@mail.gmail.com>
In-Reply-To: <CAMAWPa88E2pfViKLXjxWHuT4ZkVhzYt_BsXGePzc-70ZrEmJFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scot Doyle <lkml14-enLWO88E2pdl57MIdRCFDg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Daniel Stone <daniel-rLtY4a/8tF1rovVCs/uTlw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 02:45:19PM -0700, Kevin Hilman wrote:
> On Tue, May 19, 2015 at 2:40 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, May 19, 2015 at 02:15:41PM -0700, Kevin Hilman wrote:
> >> On Thu, Mar 26, 2015 at 6:56 AM, Scot Doyle <lkml14@scotdoyle.com> wro=
te:
> >> > vt now provides a cursor blink interval via vc_data. Use this
> >> > interval instead of the currently hardcoded 200 msecs. Store it in
> >> > fbcon_ops to avoid locking the console in cursor_timer_handler().
> >> >
> >> > Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
> >> > Acked-by: Pavel Machek <pavel@ucw.cz>
> >>
> >> This patch hit next-20150519 in the form of commit 27a4c827c34a
> >> (fbcon: use the cursor blink interval provided by vt) and has caused
> >> boot failure on a handful of ARM platforms when booting a MMC root
> >> filesystem.  This error was spotted by the kernelci.org bot on
> >> exynos5800-peach-pi[1] and Thierry and Daniel (Cc'd) have seen it on
> >> some tegra platforms too.
> >>
> >> Thierry spotted this commit as a potential cause, and both Daniel and
> >> I have reverted and boot tested on exynos5 and tegra respectively and
> >> the boot panics disappear.
> >
> > FWIW, if I apply the below on top of next-20150519 things seem to be
> > back to normal as well:
> >
> > diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbco=
n.c
> > index 05b1d1a71ef9..658c34bb9076 100644
> > --- a/drivers/video/console/fbcon.c
> > +++ b/drivers/video/console/fbcon.c
> > @@ -1310,8 +1310,9 @@ static void fbcon_cursor(struct vc_data *vc, int =
mode)
> >                 return;
> >
> >         ops->cur_blink_jiffies =3D msecs_to_jiffies(vc->vc_cur_blink_ms=
);
> > -       fbcon_del_cursor_timer(info);
> > -       if (!(vc->vc_cursor_type & 0x10))
> > +       if (vc->vc_cursor_type & 0x10)
> > +               fbcon_del_cursor_timer(info);
> > +       else
> >                 fbcon_add_cursor_timer(info);
> >
> >         ops->cursor_flash =3D (mode =3D=3D CM_ERASE) ? 0 : 1;
>=20
> Applying this on next-20150519 makes my exynos board happily boot again a=
s well.
>=20
> Tested-by: Kevin Hilman <khilman@linaro.org>

Excellent. Greg, Scot, any opinions on whether or not this is the right
thing to do? It restores a bit that looks suspiciously like it snuck in
in the original (at least it isn't documented in the commit message).

Greg, feel free to squash this in if everybody agrees this is good to
go. If you prefer a patch on top let me know and I'll come up with a
proper commit message.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVW7CZAAoJEN0jrNd/PrOh8wEQALWur4RDTV40RqkQFtqxfXf4
mVicTMEs+O0xp7xOXpt5Aq6a5ikL02jJDXmRBHx8v8Eq0xDXuz7ZDbZmOrAsl8zq
qofrElDxmopJLnS5yl7up4mqyCByOZjpV/+SH3HoRAM/brOfO9IqPDqeiuooyYfH
pBW55MfWRllpLJeegs8ADXnpnjzRyZY9T9hlJJjmbgYQQ4R9FV/UYXAEYGmt3UPI
l6ddK4NjLNBQi1HzB/UYtbgPWWFO47eQ5vuRw1gG26to+0Ko5eOqhEqo9xcNxMma
awybWU2fzAb7xX+vVAt24yGEWjArHRnEIdiuoT76sYV7JCrjh11Enb4jrQ5zgJHs
BWvoiqqAyJGNpyp1Gvr3yvmqrSHvFTMlPoHAU4CYFbqoJdHjmEP0VdHgYM+wQY9K
EpnxhcvYRbtCmJ1orUBVsxDfVw1x5LWRPR76hbvKcrmJoZUlEkuwFmDaKAbkzdkK
TY78P2Ymmu1CpXZn2b48C2fuy1eruDjKVZLkuB3ONol8grldlEW+2sHUCTQXvML3
Y+mBDr7KbZUv7aqlFdYXEyQB72ZHwh0/kHAjWAHqjGzuRlFz1vMsrrlg1GlcgvuM
qwXM2KExWLBWujg/WcWt4JOzYz0Y7G0JzkkjfipdMdFGqSNUFqFuX5LgNFVtKR/M
hPgmsnpk/9llf0uWDnL/
=FyBE
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
