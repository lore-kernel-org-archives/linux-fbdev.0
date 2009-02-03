From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] atyfb: fix CONFIG_ namespace
	violations
Date: Wed, 4 Feb 2009 01:58:58 +0200
Message-ID: <20090203235858.GD22401@sci.fi>
References: <200901310909.n0V99XIZ021497@imap1.linux-foundation.org> <4984AC40.8030708@oracle.com> <20090131121008.eb7f5ddd.akpm@linux-foundation.org> <20090202150002.05838fed.randy.dunlap@oracle.com> <Pine.LNX.4.64.0902030907350.15898@anakin> <20090203110631.GB22401@sci.fi> <4988C3E6.5010508@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752776AbZBCX7T@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4988C3E6.5010508@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, Feb 03, 2009 at 02:23:34PM -0800, Randy Dunlap wrote:
> Ville Syrj=E4l=E4 wrote:
> > On Tue, Feb 03, 2009 at 09:09:38AM +0100, Geert Uytterhoeven wrote:
> >> On Mon, 2 Feb 2009, Randy Dunlap wrote:
> >>> --- linux-2.6.29-rc3-git3.orig/drivers/video/aty/atyfb_base.c
> >>> +++ linux-2.6.29-rc3-git3/drivers/video/aty/atyfb_base.c
> >>> @@ -135,7 +135,7 @@
> >>>  #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
> >>>  defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BAC=
KLIGHT)
> >>>  static const u32 lt_lcd_regs[] =3D {
> >>> -	CONFIG_PANEL_LG,
> >>> +	CNFG_PANEL_LG,
> >> These were the official names as used in the ATI docs. After these=
 changes, you
> >> can no longer easily grep for them.
> >>
> >> Perhaps it's better to prefix everything with ATI_? yes, I know it=
's more work
> >> (for the writer), but we want to optimize for the reader, right?
>=20
> Everything??  not just the CONFIG_* namespace violations?
>=20
> [If so,] Potentially 3600 changes just in 3 header files, then all of
> the corresponding .c files.  No thanks.

That does seem quite a bit of work. But even if you change only the
CONFIG_ violations I'd say adding a prefix is preferable to changing
the register name in a way that makes it more difficult to look it up
in the chip documentation.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
