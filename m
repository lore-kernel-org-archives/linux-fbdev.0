From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] [PATCH 04/15] ps3vram: Replace mutex by spinlock
 + list
Date: Mon, 11 May 2009 16:20:20 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905111615460.302@vixen.sonytel.be>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com> <1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
 <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com> <20090510190505.GA23535@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754027AbZEKOUe@vger.kernel.org>
In-Reply-To: <20090510190505.GA23535@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="ks_c_5601-1987"
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>, linux-kernel@vger.kernel.org

On Sun, 10 May 2009, Christoph Hellwig wrote:
> On Fri, May 08, 2009 at 04:01:13PM +0200, Geert Uytterhoeven wrote:
> > Remove the mutex serializing access to the cache.
> > Instead, queue up new requests on a list if the driver is busy.
>=20
> This should use the bio list helpers moved into bio.h in commit
> 8f3d8ba20e67991b531e9c0227dcd1f99271a32c

Ah, those didn't exist at the time of my previous submission ;-)

Like this?
Note that I had to introduce bio_list_peek(), as bio_list_pop() makes t=
he list
empty, and I cannot do that until the request has been processed.

I'll split of the introduction of bio_list_peek() in a separate patch a=
nd will
merge the rest in my earlier patches, if this is what you want.

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index abda565..aac51a2 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -81,7 +81,7 @@ struct ps3vram_priv {
 	struct ps3vram_cache cache;
=20
 	spinlock_t lock;	/* protecting list of bios */
-	struct bio *tail;
+	struct bio_list list;
 };
=20
=20
@@ -579,11 +579,8 @@ static struct bio *ps3vram_do_bio(struct ps3_syste=
m_bus_device *dev,
=20
 out:
 	spin_lock_irq(&priv->lock);
-	next =3D bio->bi_next;
-	if (!next)
-		priv->tail =3D NULL;
-	else
-		bio->bi_next =3D NULL;
+	bio_list_pop(&priv->list);
+	next =3D bio_list_peek(&priv->list);
 	spin_unlock_irq(&priv->lock);
=20
 	bio_endio(bio, error);
@@ -594,20 +591,18 @@ static int ps3vram_make_request(struct request_qu=
eue *q, struct bio *bio)
 {
 	struct ps3_system_bus_device *dev =3D q->queuedata;
 	struct ps3vram_priv *priv =3D dev_get_drvdata(&dev->core);
+	int busy;
=20
 	dev_dbg(&dev->core, "%s\n", __func__);
=20
 	spin_lock_irq(&priv->lock);
-	if (priv->tail) {
-		priv->tail->bi_next =3D bio;
-		priv->tail =3D bio;
-		spin_unlock_irq(&priv->lock);
-		return 0;
-	}
-
-	priv->tail =3D bio;
+	busy =3D !bio_list_empty(&priv->list);
+	bio_list_add(&priv->list, bio);
 	spin_unlock_irq(&priv->lock);
=20
+	if (busy)
+		return 0;
+
 	do {
 		bio =3D ps3vram_do_bio(dev, bio);
 	} while (bio);
@@ -632,6 +627,7 @@ static int __devinit ps3vram_probe(struct ps3_syste=
m_bus_device *dev)
 	}
=20
 	spin_lock_init(&priv->lock);
+	bio_list_init(&priv->list);
 	dev_set_drvdata(&dev->core, priv);
=20
 	/* Allocate XDR buffer (1MiB aligned) */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7b214fd..618bb7d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -590,6 +590,11 @@ static inline void bio_list_merge_head(struct bio_=
list *bl,
 	bl->head =3D bl2->head;
 }
=20
+static inline struct bio *bio_list_peek(struct bio_list *bl)
+{
+	return bl->head;
+}
+
 static inline struct bio *bio_list_pop(struct bio_list *bl)
 {
 	struct bio *bio =3D bl->head;

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
