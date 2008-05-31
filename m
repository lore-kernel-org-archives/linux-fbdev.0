From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 5/5] mach-pxa: add am200epd
	support
Date: Sat, 31 May 2008 20:36:33 +0800
Message-ID: <45a44e480805310536q78a80c5ai5a24db78dbcbda49@mail.gmail.com>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212208915-24544-6-git-send-email-jayakumar.lkml@gmail.com>
	<20080531140303.06bb6386.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2QK4-0001ql-Fl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 05:36:36 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2QK3-0003Uf-2l
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 05:36:36 -0700
Received: by py-out-1112.google.com with SMTP id n24so168766pyh.20
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 31 May 2008 05:36:34 -0700 (PDT)
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

On Sat, May 31, 2008 at 8:03 PM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
>
> Then probably you should also break this patch into two pieces:
> - changes which prepare existing stuff for a new driver but do
> not break existing things (like export pxa_device_fb)
> - the new driver itself (much smaller then)

Ok. I will try to do that.

>> +
>> +#define DEBUG 1
>
> You have left the debug code enabled. If it is intentional it is ok.

Yes, I wanted to keep it there for a few releases to help debug when
any problems arise.

>
>> +static int am200_init_gpio_regs(struct metronomefb_par *par)
>> +{
>
> Many functions have metronomefb_par parameter, but do not use it.
> You can remove the parameter for now.

If it's okay, I'd like to keep it because there are some features
supported in the E-Ink controllers that I haven't implemented yet.
Passing par around is intended to make that possible in future.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
