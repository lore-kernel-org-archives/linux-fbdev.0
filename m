From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Fri, 04 Mar 2005 19:50:59 +0100
Message-ID: <4228AE13.8050202@worldonline.fr>
References: <9e47339105030102003ee47879@mail.gmail.com>	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>	 <9e47339105030210135dbe71ed@mail.gmail.com>	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>	 <9e47339105030320085331555a@mail.gmail.com>	 <Pine.LNX.4.56.0503041823590.4067@pentafluge.infradead.org> <9e47339105030410482d4d957@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7HuO-0002N2-Tr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:52:20 -0800
Received: from smtp12.wanadoo.fr ([193.252.22.20])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7HuN-0002Hm-EE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:52:20 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@www.infradead.org>, James Simmons <jsimmons@pentafluge.infradead.org>

      Axel Buttchereit did a patch to implement it. It should be in the=20
latest mm tree.

Jon Smirl a =E9crit:

>On Fri, 4 Mar 2005 18:26:57 +0000 (GMT), James Simmons
><jsimmons@www.infradead.org> wrote:
> =20
>
>>>Doesn't the i830/i915/etc require a user space helper to change modes
>>>since that part of the chip spec hasn't been released? The user space
>>>helper would use Int10 VBIOS calls to list and set the modes. I
>>>haven't worked with these chips, so this is just based off from what
>>>has been posted to dri-devel. Is this why we don't have fbdev drivers
>>>for these chips?
>>>     =20
>>>
>>drivers/intel/*.[ch]
>>
>>No user space helper there.
>>
>>
>>   =20
>>
>What about the i915? We don't seem to have a fbdev driver for it yet.
>
>
> =20
>





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
