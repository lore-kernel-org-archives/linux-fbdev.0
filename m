From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 05/10] pxafb: add shared
	framebuffer interface
Date: Sun, 15 Jun 2008 02:49:53 -0400
Message-ID: <45a44e480806142349n20ca1d7by594878e3921a28ec@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-6-git-send-email-jayakumar.lkml@gmail.com>
	<20080615082653.e63a25dd.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7m3o-0004Uf-0H for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 23:50:01 -0700
Received: from wf-out-1314.google.com ([209.85.200.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7m3m-0001V6-JK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 23:49:55 -0700
Received: by wf-out-1314.google.com with SMTP id 27so4736488wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 14 Jun 2008 23:49:53 -0700 (PDT)
In-Reply-To: <20080615082653.e63a25dd.krzysztof.h1@poczta.fm>
Content-Disposition: inline
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jun 15, 2008 at 2:26 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Thu, 12 Jun 2008 12:59:16 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> +     ret = pxafb_map_video_memory(fbi, inf);
>> +     if (ret == -ENODEV) {
>> +             dev_err(&dev->dev, "Failed device binding: %d\n", ret);
>> +             ret = -ENODEV;
>
> This line is redundant as the ret is already -ENODEV.

Arr, sorry about that embarrassing mistake. I don't know why I didn't spot it.

>
>> +             goto failed_free_mem;
>> +     } else if (ret) {
>>               dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
>>               ret = -ENOMEM;
>
> Probably, there is no need to change the error code (ret). You can drop this line.
>

Ok. Will do.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
