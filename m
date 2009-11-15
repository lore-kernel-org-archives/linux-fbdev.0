From: =?iso-8859-2?Q?Ren=E9=20Kola=F8=EDk?= <rene.kolarik@seznam.cz>
Subject: Re: framebuffer general questions
Date: Mon, 16 Nov 2009 00:28:06 +0100 (CET)
Message-ID: <938.2731-16809-9592867-1258327686@seznam.cz>
References: <20091113200759.GA5379@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rene.kolarik@seznam.cz>) id 1N9oW7-0000r1-Uf
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Nov 2009 23:28:23 +0000
Received: from mxh.seznam.cz ([77.75.72.26])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9oW2-0004cL-Ib for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Nov 2009 23:28:23 +0000
In-Reply-To: <20091113200759.GA5379@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Thanks for your answer, but it implied some other questions :-)

You said, that accelerated functions are called from console - so programs =
wich are drawing directly to FB (like QT embedded in my case) have no profi=
t from them? Or do they?

What is actually the best technique of using FB (for achieving the best per=
formance) - should i malloc a piece of RAM, draw to it and then memmove it =
to FB mapped address as a whole frame or draw directly to FB? Or it doesnt =
matter?

When i greped through drivers sources i was expecting that accelerated driv=
ers will use mmap only for registers and that the imageblit function would =
be implemented as some DMA fetching from system memory. But i was wrong, th=
ere are still mmaps to video memory. So i want to ask, if that idea is comp=
letely wrong and why drivers of GPUs use mmap to video mem, when they have =
DMA controller.

Thank you for your time.

Rene

>  ------------ P=F9vodn=ED zpr=E1va ------------
>  Od: Ondrej Zajicek <santiago@crfreenet.org>
>  P=F8edm=ECt: Re: [Linux-fbdev-devel] framebuffer general questions
>  Datum: 13.11.2009 21:06:52
>  ----------------------------------------
>  On Fri, Nov 13, 2009 at 03:11:48PM +0100, Ren=E9 Kola=F8=EDk wrote:
>  > Hi
>  > =

>  > i am trying to customize framebuffer drivers and i have some questions=
...
>  > =

>  > Please can you give me an advice? =

>  > =

>  > 1) If I define my own imageblit function, how do I call it? Or is it c=
alled
>  automatically?
>  =

>  It is called automatically (if it is registered in fb_ops structure)
>  from kernel console. It is not possible to call it from userspace.
>  =

>  > 2) I have gpu connected via pci to cpu. I did mmap and have
>  > framebuffer mapped in for example "uchar * data". I have loop and
>  > iterating through some pixel data and do data[i] =3D pixel[i]. Does th=
is
>  > lead to transmitting via PCI in style - transmit byte ... end ...
>  > transmit byte ... end ... etc?
>  =

>  Probably yes, perhaps there is some write combining according to MTRR
>  registers.
>  =

>  > 3)what is the difference bethween mmap framebuffer and write to mapped
>  > pointer and calling write() to descriptor previously obtained by open(=
)?
>  =

>  The first variant is much faster - video RAM is directly mapped to users=
pace =

>  address space, therefore there is no kernel interaction during writes (in
>  usual fbdev drivers).
>  =

>  -- =

>  Elen sila lumenn' omentielvo
>  =

>  Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
>  OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
>  "To err is human -- to blame it on a computer is even more so."
>  =

>  =

>  =


---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
