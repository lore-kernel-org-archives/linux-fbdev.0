From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 5/5] mach-pxa: add am200epd
	support
Date: Sat, 31 May 2008 13:12:32 -0400
Message-ID: <45a44e480805311012n11091448o11c29efc7ed92d2b@mail.gmail.com>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212208915-24544-6-git-send-email-jayakumar.lkml@gmail.com>
	<20080531140303.06bb6386.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2Ud8-0007ZK-KP for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 10:12:34 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2Ud8-0006Pi-AG
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 10:12:34 -0700
Received: by wf-out-1314.google.com with SMTP id 27so277530wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 31 May 2008 10:12:33 -0700 (PDT)
In-Reply-To: <20080531140303.06bb6386.krzysztof.h1@poczta.fm>
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

On Sat, May 31, 2008 at 8:03 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
>> @@ -569,13 +579,16 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>>  {
> (...)
>
>> +     fw = epd_frame_table[epd_dt_index].fw;
>> +     fh = epd_frame_table[epd_dt_index].fh;
>> +     videomemorysize = fw * fh;
>>       videomemory = vmalloc(videomemorysize);
>>       if (!videomemory)
>>               return -ENOMEM;
>
> I suppose the put_module should be done before return (see the whole
> function code).

Ah, yes. Ok, will correct that.

> In order to reduce number of goto labels you can do something
> like this (for allocated pointers):
>
> err_exit:
>    if (pointer)
>        free(pointer)
>   do_something_more
>
> instead
>
> err_exit1:
>  free(pointer)
> err_exit2:
>   do_something_more

Ok. I'll take a look at doing it that way.

>
>>  static int __devexit metronomefb_remove(struct platform_device *dev)
>> @@ -734,14 +764,13 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
>>       if (info) {
>>               struct metronomefb_par *par = info->par;
>>               fb_deferred_io_cleanup(info);
>> -             dma_free_writecombine(&dev->dev, par->metromemsize,
>> -                                     par->metromem, par->metromem_dma);
>>               fb_dealloc_cmap(&info->cmap);
>>               vfree(par->csum_table);
>>               unregister_framebuffer(info);
>
> I am not sure but to release the color map before
> unregistering the framebuffer is probably a mistake.

Agreed. I'll correct that.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
