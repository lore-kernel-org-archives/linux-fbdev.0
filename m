From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Thu, 3 Mar 2005 10:12:11 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503031011150.21362@node2.an-vo.com>
References: <9e473391050301215019081bce@mail.gmail.com>
 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com> <1109806955.5610.129.camel@gaston>
 <Pine.LNX.4.62.0503022003090.17679@node2.an-vo.com> <1109816602.5610.153.camel@gaston>
 <Pine.LNX.4.62.0503022159440.17679@node2.an-vo.com> <20050303075559.GA7469@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1676125732-1109862731=:21362"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6s0d-0002jo-Fy
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 07:13:03 -0800
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43] helo=ylpvm12.prodigy.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6s0H-0001cF-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 07:13:00 -0800
Received: from pimout5-ext.prodigy.net (pimout5-ext.prodigy.net [207.115.63.73])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j23FCRxh030537
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 3 Mar 2005 10:12:31 -0500
In-Reply-To: <20050303075559.GA7469@sci.fi>
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
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1676125732-1109862731=:21362
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

>>>> With which part ? ;)
>>>
>>> On having a small stub module that does just IRQs ... I think the base
>>> module should be the fbdev (mode setting etc...)
>>
>> Oh, but I was not suggesting that. I just meant that interrupt handling
>> code is self-contained and can easily serve several consumers.
>
> I'm with you here. And the same should IMHO hold for DMA handling. And fo=
r
> memory management of course.

With one refinement - the DMA code would need to be a customer of IRQ=20
code..

                      best

                        Vladimir Dergachev

>
> --=20
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>
---1463811584-1676125732-1109862731=:21362--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
