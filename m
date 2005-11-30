From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: scroll modes
Date: Wed, 30 Nov 2005 23:54:06 +0100
Message-ID: <438E2D8E.2040503@t-online.de>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ehapm-00034E-Mh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 14:53:54 -0800
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ehapk-0006iJ-9f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 14:53:54 -0800
In-Reply-To: <438E0E23.2000203@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Antonino A. Daplas schrieb:

>Knut Petersen wrote:
> =20
>
>>Geert Uytterhoeven wrote:
>>
>>   =20
>>
>>>Ywrap has been working fine with amifb since ages (unless someone
>>>broke it very
>>>recently).=20
>>>     =20
>>>
>>We are talking about scrollmode =3D SCROLL_WRAP_MOVE ?
>>   =20
>>
>
>Try this patch.
>
> =20
>
It doesn=B4t help. I cecked the values for rows and vrows and believe tha=
t=20
they are ok.
To be sure that we are not talking about different things: How _should_=20
this mode
work? If I use ywrap, why is it called scroll_wrap_MOVE? It should not=20
be necessary
to move anything around  when using ywrap ...

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
