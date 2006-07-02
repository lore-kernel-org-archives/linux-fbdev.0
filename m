From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pnxrgbfb: Remove tty.h from #include
Date: Mon, 03 Jul 2006 07:19:40 +0800
Message-ID: <44A8548C.5020902@gmail.com>
References: <44A740C9.2060107@gmail.com>
	<acd2a5930607021056h85dbf20y2db8d6a1b8d12d1b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FxBET-00081F-0J for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Jul 2006 16:20:05 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FxBEE-0002Y2-T1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Jul 2006 16:20:03 -0700
Received: by py-out-1112.google.com with SMTP id d42so1289435pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 02 Jul 2006 16:19:48 -0700 (PDT)
In-Reply-To: <acd2a5930607021056h85dbf20y2db8d6a1b8d12d1b@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>

Vitaly Wool wrote:
> On 7/2/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Framebuffer drivers should have no dependencies on the tty layer.
>>
> <snip>
>> @@ -18,7 +18,6 @@ #include <linux/kernel.h>
>>  #include <linux/errno.h>
>>  #include <linux/string.h>
>>  #include <linux/mm.h>
>> -#include <linux/tty.h>
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/delay.h>
> 
> Ok, agreed, thanks for pointing that out.

This actually depends on a just-recently submitted cleanup patch,
removing dependencies on tty and vt. So #include <linux/tty.h> was
the correct thing to do a few -mm versions ago :-)

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
