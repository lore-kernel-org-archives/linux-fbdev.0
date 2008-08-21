From: "Jorge Marques Pelizzoni" <jpeliz@icmc.usp.br>
Subject: Re: newbie: fb specs and indirect VRAM access
Date: Thu, 21 Aug 2008 10:49:23 -0300 (BRT)
Message-ID: <56111.200.178.190.130.1219326563.squirrel@mail2.icmc.usp.br>
References: <47858.200.178.190.130.1219177894.squirrel@mail2.icmc.usp.br>   
	<34825.200.178.190.130.1219322627.squirrel@mail2.icmc.usp.br>   
	<Pine.LNX.4.64.0808211453330.31396@anakin>   
	<45a44e480808210609h3dadb6bdo7512eb720f54f49f@mail.gmail.com>   
	<Pine.LNX.4.64.0808211520300.31396@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWAY1-0005JU-94 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 06:49:57 -0700
Received: from mail.icmc.usp.br ([143.107.231.3] helo=mail2.icmc.usp.br)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KWAXz-0007IZ-P2
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 06:49:57 -0700
Received: from mail2.icmc.usp.br (mail2 [143.107.231.3])
	by mail2.icmc.usp.br (Postfix) with ESMTP id 310D351CC
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 21 Aug 2008 10:49:23 -0300 (BRT)
In-Reply-To: <Pine.LNX.4.64.0808211520300.31396@anakin>
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
To: linux-fbdev-devel@lists.sourceforge.net

Thank you all for your replies!

Jaya, that's exactly my case: an ARM7, with no MMU. If possible - and very
briefly - could you so much as cite the other possibilities you envision
so I can research them?

Thanks in advance.

Cheers,

Jorge.

Geert Uytterhoeven escreveu:
> On Thu, 21 Aug 2008, Jaya Kumar wrote:
>> On Thu, Aug 21, 2008 at 8:54 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Thu, 21 Aug 2008, Jorge Marques Pelizzoni wrote:
>> >> Jorge Marques Pelizzoni escreveu:
>> >> > I am considering implementing a frame buffer device for a mobile
>> platform
>> >> > (LPC2400 on uCLinux) that, as far as I can tell, seems to lack
one.
>> Well,
>
>> > linux/Documentation/fb/deferred_io.txt
>> One note about this. If you're using LPC2400, I think that's an ARM7.
TDMI so no MMU which I think matches your mention of uclinux.
>> Unfortunately, defio has a dependency on MMU. There are other
>> possibilities to achieve the same effect but I'm not familiar with the
2400 and I'm not sure if it can do it.
>
> Oops, sorry, didn't notice that part. Yes, it depends on the presence of
a MMU.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
But
> when I'm talking to journalists I just say "programmer" or something
like
> that.
> 							    -- Linus Torvalds
>


Jorge M. Pelizzoni
ICMC - Universidade de S=E3o Paulo

call me at http://www.jaxtr.com/jpeliz





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
