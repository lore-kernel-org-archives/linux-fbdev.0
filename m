From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: linux- 2.6.18-rc3 undefined reference to
 `fb_register_client'
Date: Mon, 31 Jul 2006 08:04:12 +0800
Message-ID: <44CD48FC.8070701@gmail.com>
References: <200607301817.39411.toralf.foerster@gmx.de>
	<44CD4721.20909@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7LGf-0001Sv-NA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Jul 2006 17:04:21 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7LGe-0003c5-Av
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Jul 2006 17:04:21 -0700
Received: by py-out-1112.google.com with SMTP id d42so445893pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 30 Jul 2006 17:04:19 -0700 (PDT)
In-Reply-To: <44CD4721.20909@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, toralf.foerster@gmx.de, linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:
> Toralf F=F6rster wrote:
>> During compile tests of different .configs I got :
>> ...
>>
>>   AR      arch/i386/lib/lib.a
>>   GEN     .version
>>   CHK     include/linux/compile.h
>>   UPD     include/linux/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> drivers/built-in.o: In function `backlight_device_register':
>> : undefined reference to `fb_register_client'
>> drivers/built-in.o: In function `backlight_device_unregister':
>> : undefined reference to `fb_unregister_client'
>> make: *** [.tmp_vmlinux1] Error 1
>>
> =

> Try this patch:
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6=
.18-rc2-mm1/broken-out/fbdev-statically-link-the-framebuffer-notification-f=
unctions.patch
> =

> Andrew,
> =

> Maybe this patch should go to mainline?

Oh, you already sent it.  Thanks.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
