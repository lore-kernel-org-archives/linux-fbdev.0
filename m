From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH 7/11] radeonfb: eliminate bad	section
 references
Date: Wed, 09 Mar 2005 10:59:03 -0800
Message-ID: <422F4777.3060405@osdl.org>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>	 <20050309102315.0c181db7.rddunlap@osdl.org> <1110393308.5997.2.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D96Og-0003Bi-6e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:59:06 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D96Of-0002dE-Dq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:59:05 -0800
Received: from [172.20.1.49] (fw.osdl.org [65.172.181.6])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j29Ix3qi015164
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Mar 2005 10:59:04 -0800
In-Reply-To: <1110393308.5997.2.camel@atlantis.netenviron.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Torgeir Veimo wrote:
> On Wed, 2005-03-09 at 10:23 -0800, Randy.Dunlap wrote:
> 
>>Fix radeonfb section references by changing __initdata
>>  to __devinitdata.
>>
>>Error: ./drivers/video/radeonfb.o .text refers to 0000000000002037 R_X86_64_PC32     .init.data+0x0000000000000003
>>Error: ./drivers/video/radeonfb.o .text refers to 0000000000002491 R_X86_64_PC32     .init.data
>>Error: ./drivers/video/radeonfb.o .text refers to 0000000000002870 R_X86_64_PC32     .init.data+0x000000000000000c
>>Error: ./drivers/video/radeonfb.o .text refers to 0000000000002a21 R_X86_64_PC32     .init.data+0xfffffffffffffffb
>>
>>Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
>>
>>diffstat:=
>> drivers/video/radeonfb.c |    8 ++++----
> 
> 
> This is the old radenfb driver? Wouldn't you want to fix the one in
> drivers/video/aty instead?

That was in patch 2/11.  The goal was to fix all of them (until they
are removed from kernel tree :).

-- 
~Randy


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
