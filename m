From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: Re: [PATCH] - video/tridentfb.c warning fix.
Date: Thu, 22 Apr 2004 15:08:42 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040422150842.7c011dd7.lcapitulino@prefeitura.sp.gov.br>
References: <20040419162807.7ba9c5ec.lcapitulino@prefeitura.sp.gov.br>
	<Pine.GSO.4.58.0404200955320.21445@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGibt-0007mE-On
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 11:07:41 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGibt-0002Xd-C1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 11:07:41 -0700
In-Reply-To: <Pine.GSO.4.58.0404200955320.21445@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: akpm@osdl.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net


 Hi Geert,

Em Tue, 20 Apr 2004 09:56:17 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> escreveu:

| On Mon, 19 Apr 2004, Luiz Fernando N. Capitulino wrote:
| > diff -X dontdiff -Nparu a/drivers/video/Kconfig a~/drivers/video/Kconfig
| > --- a/drivers/video/Kconfig	2004-04-16 20:03:09.000000000 -0300
| > +++ a~/drivers/video/Kconfig	2004-04-16 20:04:24.000000000 -0300
| > @@ -772,6 +772,14 @@ config FB_TRIDENT
| >  	  To compile this driver as a module, choose M here: the
| >  	  module will be called tridentfb.
| >
| > +config FB_TRIDENT_ACCEL
| > +	bool "Trident Acceleration functions (EXPERIMENTAL)"
| > +	depends on FB_TRIDENT
| 
| Didn't notice this before: if you want it to be experimental, it should depend
| on FB_TRIDENT && EXPERIMENTAL

 oops. :-)

 I saw that Andrew merged the patches in -mm tree. I will wait it in linus
tree to fix that.

PS: Sorry for the delay, I were in another city.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
