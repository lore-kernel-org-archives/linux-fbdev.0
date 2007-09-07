From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] tdfxfb: checkpatch fixes
Date: Fri, 7 Sep 2007 09:15:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709070911540.5202@anakin>
References: <20070907003228.113352f5.krzysztof.h1@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808512-1777158352-1189149351=:5202"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITYM4-00050a-8B for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 07 Sep 2007 00:34:18 -0700
Received: from adicia.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ITY4K-0000Z2-T5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 07 Sep 2007 00:15:58 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 62C302300FF
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  7 Sep 2007 09:15:52 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 4D3B12300FA
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  7 Sep 2007 09:15:51 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l877FpYW007312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 7 Sep 2007 09:15:51 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l877FpiT007309
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 7 Sep 2007 09:15:51 +0200
In-Reply-To: <20070907003228.113352f5.krzysztof.h1@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808512-1777158352-1189149351=:5202
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Sep 2007, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>=20
> This patch fixes all errors pointed by the checkpatch.pl
> script.
>=20
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>=20
> ---
>=20
> --- linux-2.6.23-mm/drivers/video/tdfxfb.c	2007-09-07 00:24:56.63907304=
2 +0200
> +++ linux-2.6.23/drivers/video/tdfxfb.c	2007-09-07 00:28:13.378284570 +=
0200
> @@ -4,7 +4,7 @@
>   *
>   * Author: Hannu Mallat <hmallat@cc.hut.fi>
>   *
> - * Copyright =A9 1999 Hannu Mallat
> + * Copyright (C) 1999 Hannu Mallat
>   * All rights reserved
>   *
>   * Created      : Thu Sep 23 18:17:43 1999, hmallat

<switching-to-corporate-hat>
The legal departments of some companies allow to use the c-in-circle symb=
ol,
others don't and require the c-between-parentheses, or vice versa.

As I guess checkpatch.pl complained about the presence of a non-UTF-8
character, perhaps it's safest to convert it to the UTF-8 c-in-circle
symbol?
</switching-to-corporate-hat>

> @@ -72,9 +72,9 @@
> =20
>  #undef TDFXFB_DEBUG
>  #ifdef TDFXFB_DEBUG
> -#define DPRINTK(a,b...) printk(KERN_DEBUG "fb: %s: " a, __FUNCTION__ ,=
 ## b)
> +#define DPRINTK(a, b...) printk(KERN_DEBUG "fb: %s: " a, __FUNCTION__ =
, ## b)
>  #else
> -#define DPRINTK(a,b...)
> +#define DPRINTK(a, b...)
>  #endif
> =20
>  #ifdef CONFIG_MTRR

What about an unconditional

| #define DPRINTK(a, b...) pr_debug("fb: %s: " a, __FUNCTION__ , ## b)

That way we'll get printf-format checking even if TDFXFB_DEBUG is not
defined.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---1463808512-1777158352-1189149351=:5202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
---1463808512-1777158352-1189149351=:5202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1463808512-1777158352-1189149351=:5202--
