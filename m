From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Fri, 04 Mar 2005 20:48:08 +0100
Message-ID: <4228BB78.2090703@XLsigned.net>
References: <9e47339105030102003ee47879@mail.gmail.com>	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>	 <9e47339105030210135dbe71ed@mail.gmail.com>	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>	 <9e47339105030320085331555a@mail.gmail.com>	 <Pine.LNX.4.56.0503041823590.4067@pentafluge.infradead.org> <9e47339105030410482d4d957@mail.gmail.com> <4228AE13.8050202@worldonline.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7ImY-0005fy-4w
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 11:48:18 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D7ImW-0007lM-7P
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 11:48:18 -0800
In-Reply-To: <4228AE13.8050202@worldonline.fr>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@www.infradead.org>, James Simmons <jsimmons@pentafluge.infradead.org>, sylvain.meyer@worldonline.fr


Sylvain Meyer wrote:
>      Axel Buttchereit did a patch to implement it. It should be in the
> latest mm tree.
>=20
> Jon Smirl a =C3=A9crit:
>=20
>> On Fri, 4 Mar 2005 18:26:57 +0000 (GMT), James Simmons
>> <jsimmons@www.infradead.org> wrote:
>> =20
>>
>>>> Doesn't the i830/i915/etc require a user space helper to change mode=
s
>>>> since that part of the chip spec hasn't been released? The user spac=
e
>>>> helper would use Int10 VBIOS calls to list and set the modes. I
>>>> haven't worked with these chips, so this is just based off from what
>>>> has been posted to dri-devel. Is this why we don't have fbdev driver=
s
>>>> for these chips?
>>>>    =20
>>>
>>> drivers/intel/*.[ch]
>>>
>>> No user space helper there.
>>>
>>>
>>>  =20
>>
>> What about the i915? We don't seem to have a fbdev driver for it yet.
>>

It is (intelfb-...). Including Tony's corresponding "modehelper" kernel-c=
onfig
patch and -- since 2.6.11-rc5-mm1 -- with an additional patch from Andrew
that fixes some compiler warnings (missing type casts).

The driver is still not complete (no hardware cursor, ...) but it
does its job pretty good (at least on my machine).

Only a few changes are required to add support for i915 and they
can all easily be derived from the xorg/xfree-driver that already
(fully) supports the chipset.

Obviously there is someone at xfree/xorg that is either a "hell of a hack=
er"
or in the position to access the required documentation from intel.
Or both.

:-) Axel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
