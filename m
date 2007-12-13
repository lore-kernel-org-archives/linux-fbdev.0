From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Subject: Re: [PATCH] logo: move declarations of logos to linux_logo.h
Date: Thu, 13 Dec 2007 20:50:46 +0100
Message-ID: <20071213195040.GA8016@joi>
References: <20071209214027.GG9440@joi> <20071213023111.30ddc487.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765566AbXLMTtn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071213023111.30ddc487.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Thu, Dec 13, 2007 at 02:31:11AM -0800, Andrew Morton wrote:
> On Sun, 9 Dec 2007 22:40:31 +0100 Marcin =C5=9Alusarz <marcin.slusarz=
@gmail.com> wrote:
>
> > logo: move declarations of logos to linux_logo.h
> >
> > there was a mismatch between externs in logo.c and code generated b=
y pnmtologo
> > (on old tree, you need to rm drivers/video/logo/logo_*.c before com=
pilation)
>
> This patch (after I fixed it) keeps on causing trouble: mismatches be=
tween
> the header file declarations and the actual definitions of the lookup
> tables.  This happens as I apply and unapply the patch.
>
> It _shouldn't_ happen, but there would appear to be some missing make=
file
> rules.  I guess the C files aren't being regenerated when
> scripts/pnmtologo.c has been altered, so the C files aren't matching =
the
> header which this patch alters.
Ok, I'll try to fix that.

Marcin
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
