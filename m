From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: intelfb stack usage
Date: Sun, 19 Dec 2004 17:16:47 +0100
Message-ID: <41C5A96F.1090705@worldonline.fr>
References: <41C330B6.8040504@osdl.org> <200412180814.30855.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cg3lw-0000Xa-Cr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Dec 2004 08:19:04 -0800
Received: from smtp9.wanadoo.fr ([193.252.22.22])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cg3lm-00051F-TU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Dec 2004 08:19:04 -0800
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
Cc: "Randy.Dunlap" <rddunlap@osdl.org>

        If you can do it, thanks. I won't have any time until next year.

Sylvain

Antonino A. Daplas a =E9crit:

>On Saturday 18 December 2004 03:17, Randy.Dunlap wrote:
> =20
>
>>In 2.6.10-rc3-bk6, intelfb_set_par() has the distinction of being
>>the largest stack user as determined by 'make checkstack':
>>
>>objdump -d vmlinux $(find . -name '*.ko') | \
>>perl /mnt/src/linux-2610-rc3-bk6/scripts/checkstack.pl i386
>>0x00001317 intelfb_set_par:				2404
>>
>>because it has this large struct on the stack:
>>	struct intelfb_hwstate hw;
>>(almost 2400 bytes)
>>
>>Any suggestions for how to alleviate this large stack usage?
>>
>> From a quick look, this is called from fb_ioctl() to fb_set_var()
>>to fb_set_par().
>>fb_ioctl() does acquire_console_sem(), so using kmalloc()
>>here would need to use GFP_ATOMIC...
>>I can do that if it's desired & acceptable.
>>   =20
>>
>
>Using kmalloc() should be acceptable.  I'll CC the author.
>
>Tony
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.=20
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
> =20
>





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
