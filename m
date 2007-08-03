From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] tdfxfb: mtrr support (2nd revision)
Date: Fri, 03 Aug 2007 05:24:51 +0200
Message-ID: <46b2a00372bf9@wp.pl>
References: <20070729230653.d5dd086b.krzysztof.h1@wp.pl><1185750991.9324.14.camel@daplas><20070731115557.50b9b933.krzysztof.h1@wp.pl>
	<Pine.LNX.4.64.0708021952550.5150@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGnmc-0001uD-SK for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 20:24:58 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1IGnmb-0004tS-DC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 20:24:58 -0700
Received: from poczta-10.free.wp-sa.pl (HELO localhost) ([10.1.1.28])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 3 Aug 2007 05:24:51 +0200
In-reply-to: <20070729230653.d5dd086b.krzysztof.h1@wp.pl><1185750991.9324.14.camel@daplas><20070731115557.50b9b933.krzysztof.h1@wp.pl>
	<Pine.LNX.4.64.0708021952550.5150@anakin>
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Dnia 2-08-2007 o godz. 19:56 Geert Uytterhoeven napisa=B3(a):
> On Tue, 31 Jul 2007, Krzysztof Helt wrote:
> >  =

> > +	default_par->mtrr_handle =3D -1;
> > +	if (!nomtrr)
> > +		default_par->mtrr_handle =3D
> > +			mtrr_add(tdfx_fix.smem_start, tdfx_fix.smem_len,
> > +				 MTRR_TYPE_WRCOMB, 1);
> > +
> =

> ... but everything works nicely, because no callers of =

mttr_{add,del}()
> check for actual errors ;-)
> =

>

Actually, there is an indirect check. The mttr handle is freed =

only if mtrr_add returned no error value. That's why the mtrr_add =

"dummy" must return an error.

I agree, that I do not print any message that inform about =

failure of mtrr_add, but any other fb driver does not, either. I =

think the message does not make any sense (as the CPU may be not =

able to handle this - early x86 - or the mttr is disable in =

config - require more ifdefs for messages).

Regards,
Krzysztof

----------------------------------------------------
06.10.07. Sensation White, Hala Ludowa, Wroc=B3aw =

Wyst=B1pi=B1: Michael Burian, Angelo Mike & John Hetmond,
Sebastian Ingrosso, David Guetta, Markus Schulz, Sander Van Doorn.
Ostatnia pula bilet=F3w: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.=
wp.pl%2Fas%2Fwhites.html&sid=3D1245



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
