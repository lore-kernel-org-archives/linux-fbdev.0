From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/5] pxafb: module
	unloading support
Date: Fri, 30 May 2008 21:02:05 -0400
Message-ID: <45a44e480805301802i7cea217fw8ef55be8dccc01b9@mail.gmail.com>
References: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212150530-14941-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080530190453.2e205e1d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2FTy-0002km-2m for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 18:02:06 -0700
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2FTx-0005Jt-Oq
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 18:02:05 -0700
Received: by wf-out-1314.google.com with SMTP id 27so86295wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 May 2008 18:02:05 -0700 (PDT)
In-Reply-To: <20080530190453.2e205e1d.krzysztof.h1@poczta.fm>
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

On Fri, May 30, 2008 at 1:04 PM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Fri, 30 May 2008 08:28:46 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> -static char g_options[256] __devinitdata = "";
>> +static char g_options[256] __initdata = "";
>>
>
> This is not right. The g_options is used by
> the pxafb_probe (below) and pxafb_parse_options
> which are now __devinit.

Ah, I see it now. Will fix.

>> +
>> +             r = platform_get_resource(dev, IORESOURCE_MEM, 0);
>> +             release_mem_region(r->start, r->end - r->start + 1);
>> +
>> +             iounmap(fbi->mmio_base);
>> +
>
> I can be wrong here, but should not the iounmap be done before
> releasing the iomaped region?
>

Yes, I agree with you. I used the same sequence I saw in the
pxafb_probe failout path:

failed_free_res:
        release_mem_region(r->start, r->end - r->start + 1);
failed_free_io:
        iounmap(fbi->mmio_base);

I will reorder both as the correction.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
