From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Fri, 04 Mar 2005 19:54:36 +0100
Message-ID: <4228AEEC.6080202@worldonline.fr>
References: <9e47339105030102003ee47879@mail.gmail.com>	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>	 <9e47339105030210135dbe71ed@mail.gmail.com>	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>	 <9e47339105030320085331555a@mail.gmail.com>	 <4228AC6B.9070503@worldonline.fr> <9e473391050304105022d7394c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7Hxt-0002jZ-L5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:55:57 -0800
Received: from smtp12.wanadoo.fr ([193.252.22.20])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7Hxs-0006VA-AI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:55:57 -0800
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
Cc: James Simmons <jsimmons@pentafluge.infradead.org>

    David Dawes did the original driver. I don't know if he had access=20
to the datasheet but Intel released documentation for i810/i815 and the=20
chips aren't very different.

Jon Smirl a =E9crit:

>On Fri, 04 Mar 2005 19:43:55 +0100, Sylvain Meyer
><sylvain.meyer@worldonline.fr> wrote:
> =20
>
>>Jon Smirl a =E9crit:
>>
>>   =20
>>
>>>Is this why we don't have fbdev drivers
>>>for these chips?
>>>
>>>
>>>
>>>     =20
>>>
>>    There is an intelfb fbdev driver. Not very actively maintained,
>>sorry for that, but i did a port to kernel 2.6 and try to get some spar=
e
>>time to update it. The driver can change modes and i also did a driver
>>for TV-Out, not yet DFP/LFP (not in the kernel for now).
>>   =20
>>
>
>Has Intel released documentation for mode setting on these chips or
>did you reverse engineer it?
>
> =20
>
>>Sylvain
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users=
.
>>Discover which products truly live up to the hype. Start reading now.
>>http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
>>_______________________________________________
>>Linux-fbdev-devel mailing list
>>Linux-fbdev-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>>
>>   =20
>>
>
>
> =20
>





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
