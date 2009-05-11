From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 04/15] ps3vram: Replace mutex by spinlock + list
Date: Mon, 11 May 2009 08:38:06 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905110836500.14263@vixen.sonytel.be>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com> <20090508160544.28189203.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754524AbZEKGiW@vger.kernel.org>
In-Reply-To: <20090508160544.28189203.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="ks_c_5601-1987"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, jim@jtan.com

On Fri, 8 May 2009, Andrew Morton wrote:
> On Fri,  8 May 2009 16:01:13 +0200
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>=20
> > +static int ps3vram_make_request(struct request_queue *q, struct bi=
o *bio)
> > +{
> > +	struct ps3_system_bus_device *dev =3D q->queuedata;
> > +	struct ps3vram_priv *priv =3D dev->core.driver_data;
> > +
> > +	dev_dbg(&dev->core, "%s\n", __func__);
> > +
> > +	spin_lock_irq(&priv->lock);
> > +	if (priv->tail) {
> > +		priv->tail->bi_next =3D bio;
> > +		priv->tail =3D bio;
> > +		spin_unlock_irq(&priv->lock);
> > +		return 0;
                ^^^^^^^^
> > +	}
> > +
> > +	priv->tail =3D bio;
> > +	spin_unlock_irq(&priv->lock);
> > +
> > +	do {
> > +		bio =3D ps3vram_do_bio(dev, bio);
> > +	} while (bio);
>=20
> Is there something which prevents two threads of control from walking
> the same list at the same time?

Sure: only the thread who adds the first request to the empty list will=
 walk
the list later.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
