From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [PATCH 7/11] radeonfb: eliminate bad
	section references
Date: Wed, 09 Mar 2005 18:35:08 +0000
Message-ID: <1110393308.5997.2.camel@atlantis.netenviron.com>
References: <20050309100825.0d77ded8.rddunlap@osdl.org>
	 <20050309102315.0c181db7.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D961U-0001h7-H0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:35:08 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D961T-0006Pd-36
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 10:35:08 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 2085982
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  9 Mar 2005 13:35:05 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id A38028D
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  9 Mar 2005 13:35:04 -0500 (EST)
In-Reply-To: <20050309102315.0c181db7.rddunlap@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-03-09 at 10:23 -0800, Randy.Dunlap wrote:
> Fix radeonfb section references by changing __initdata
>   to __devinitdata.
> 
> Error: ./drivers/video/radeonfb.o .text refers to 0000000000002037 R_X86_64_PC32     .init.data+0x0000000000000003
> Error: ./drivers/video/radeonfb.o .text refers to 0000000000002491 R_X86_64_PC32     .init.data
> Error: ./drivers/video/radeonfb.o .text refers to 0000000000002870 R_X86_64_PC32     .init.data+0x000000000000000c
> Error: ./drivers/video/radeonfb.o .text refers to 0000000000002a21 R_X86_64_PC32     .init.data+0xfffffffffffffffb
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
> 
> diffstat:=
>  drivers/video/radeonfb.c |    8 ++++----

This is the old radenfb driver? Wouldn't you want to fix the one in
drivers/video/aty instead?

-- 
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
