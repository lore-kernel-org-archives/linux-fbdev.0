From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scroll modes
Date: Thu, 01 Dec 2005 08:01:42 +0800
Message-ID: <438E3D66.8080601@gmail.com>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <438E2D8E.2040503@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhbuN-0006vK-9G
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 16:02:43 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhbuM-0001et-UA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 16:02:43 -0800
Received: by zproxy.gmail.com with SMTP id r28so141252nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Nov 2005 16:02:40 -0800 (PST)
In-Reply-To: <438E2D8E.2040503@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Knut Petersen wrote:
> Antonino A. Daplas schrieb:
>=20
>> Knut Petersen wrote:
>> =20
>>
>>> Geert Uytterhoeven wrote:
>>>
>>>  =20
>>>> Ywrap has been working fine with amifb since ages (unless someone
>>>> broke it very
>>>> recently).    =20
>>> We are talking about scrollmode =3D SCROLL_WRAP_MOVE ?
>>>  =20
>>
>> Try this patch.
>>
>> =20
>>
> It doesn=B4t help. I cecked the values for rows and vrows and believe t=
hat
> they are ok.
> To be sure that we are not talking about different things: How _should_
> this mode
> work? If I use ywrap, why is it called scroll_wrap_MOVE? It should not
> be necessary
> to move anything around  when using ywrap ...

You still have to, because the console can ask for a partial scroll.
For example, assume you have a screen of 20 lines, the console can, for
example, ask to scroll rows 5-10 up by 1 line to row 4-9, leave rows 0-3 =
and
11-19 in the same place. So fbcon will adjust the yoffset, but has to mov=
e
rows 0-3 and 11-19 so they appear stationary to the user.

However, if the request for scrolling is a screenful at at time (ie,
move entire screen contents up by 1 line), then I don't think any
bmoves will be called.  Here's a snippet from the fbcon_scroll
(comments are mine):

	if (t > 0) /* if top is at origin, do not move */
		fbcon_bmove(vc, 0, 0, count, 0, t,
			    vc->vc_cols);
	ywrap_up(vc, count); /* adjust yoffset */

	if (vc->vc_rows - b > 0) /* if bottom is at end, do not move */
		fbcon_bmove(vc, b - count, 0, b, 0,
			    vc->vc_rows - b,
			    vc->vc_cols);

Tony

P.S: Ywrapping is very old code, and I think Geert can explain the code
much better than I.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
