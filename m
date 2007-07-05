From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] EFI framebuffer on EFI X86_64
Date: Thu, 5 Jul 2007 20:17:57 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC22597BC@pdsmsx415.ccr.corp.intel.com>
References: <Pine.LNX.4.64.0707041850500.10749@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0823838091=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I6QHh-0001pK-1J for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jul 2007 05:18:09 -0700
Received: from mga02.intel.com ([134.134.136.20])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I6QHf-0001dM-NQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jul 2007 05:18:08 -0700
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0707041850500.10749@anakin>
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
To: geert@linux-m68k.org
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

--===============0823838091==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

>From: geert@linux-m68k.org [mailto:geert@linux-m68k.org]
>Sent: 2007=C4=EA7=D4=C25=C8=D5 0:54
>To: Huang, Ying
>Cc: Linux Frame Buffer Device Development
>Subject: Re: [Linux-fbdev-devel] [PATCH] EFI framebuffer on EFI X86_64
>
>On Wed, 4 Jul 2007, Huang, Ying wrote:
>> diff -uprN -X linux-2.6.21-orig/Documentation/dontdiff
>> linux-2.6.21-orig/drivers/video/efifb.c
>> linux-2.6.21-uefi-finaltest4/drivers/video/efifb.c
>
>Your mail client seems to corrupt whitespace...

Sorry, will be more careful next time.

>> +       //size_total =3D screen_info.lfb_size * 65536;
>
>Please don't use C++-style comments. You can use scripts/checkpatch.pl
>to perform some basic style checks on your patches.

Ok, will check with scripts/checkpatch.pl firstly next time.

>> +#ifndef __i386__
>> +       //screen_info.imacpm_seg =3D 0;
>> +#endif
>
>Superfluous block?
>
Will delete next time.

Best Regards,
Huang, Ying


--===============0823838091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0823838091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0823838091==--
