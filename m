From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] logo: move declarations of logos to linux_logo.h
Date: Thu, 13 Dec 2007 20:55:43 +0100
Message-ID: <20071213195543.GA12737@uranus.ravnborg.org>
References: <20071209214027.GG9440@joi> <20071213023111.30ddc487.akpm@linux-foundation.org> <20071213195040.GA8016@joi>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765634AbXLMTyV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071213195040.GA8016@joi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Thu, Dec 13, 2007 at 08:50:46PM +0100, Marcin =C5=9Alusarz wrote:
> On Thu, Dec 13, 2007 at 02:31:11AM -0800, Andrew Morton wrote:
> > On Sun, 9 Dec 2007 22:40:31 +0100 Marcin =C5=9Alusarz <marcin.slusa=
rz@gmail.com> wrote:
> >
> > > logo: move declarations of logos to linux_logo.h
> > >
> > > there was a mismatch between externs in logo.c and code generated=
 by pnmtologo
> > > (on old tree, you need to rm drivers/video/logo/logo_*.c before c=
ompilation)
> >
> > This patch (after I fixed it) keeps on causing trouble: mismatches =
between
> > the header file declarations and the actual definitions of the look=
up
> > tables.  This happens as I apply and unapply the patch.
> >
> > It _shouldn't_ happen, but there would appear to be some missing ma=
kefile
> > rules.  I guess the C files aren't being regenerated when
> > scripts/pnmtologo.c has been altered, so the C files aren't matchin=
g the
> > header which this patch alters.
> Ok, I'll try to fix that.

The kbuild rules around the logo stuff are non-trivial.
Drop me a line (+patch) if you need help.
You may in that case also cc: linux-kbuild@vger.kernel.org.
There are some quite skilled kbuild people hanging out there too.

I may not respond promptly - busy these days (+ christmas)

	Sam
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
