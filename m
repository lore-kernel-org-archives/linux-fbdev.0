From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 11:31:29 +0900
Message-ID: <aec7e5c30805291931v23512403qa95554fe1602a1b2@mail.gmail.com>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080529024024.63d726de.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1uOw-0003B3-OQ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 19:31:30 -0700
Received: from yw-out-1718.google.com ([74.125.46.152])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K1uOw-0007Cr-EJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 19:31:30 -0700
Received: by yw-out-1718.google.com with SMTP id 6so2160184ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 29 May 2008 19:31:29 -0700 (PDT)
In-Reply-To: <20080529024024.63d726de.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lethal@linux-sh.org, linux-fbdev-devel@lists.sourceforge.net, linux-sh@vger.kernel.org

On Thu, May 29, 2008 at 6:40 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 29 May 2008 18:24:51 +0900 Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> This patch adds frame buffer support for the LCDC block found in
>> SuperH Mobile processors. The hardware supports up to two LCD panels
>> per LCDC block, and both RGB and SYS interfaces can be used to hook
>> up LCD panels/modules.
>>
>> The device driver is a regular platform driver, so LCD configuration
>> and board specific hooks are passed to the driver using platform data.
>> LCD modules using SYS interface often require special configuration
>> using the SYS bus, and to solve this cleanly the driver provides SYS
>> interface operations to the board code.
>>
>> Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
>> WVGA panels using RGB16 and RGB18 interfaces.
>>
>> ...
>>
>> +     while (lcdc_read(ch->lcdc, _LDSR) & 2)
>> +       ;
>
> Indenting is odd and inconsistent with most of the other zillions of
> busywait loops here (multiple instances)
>
> It might make sense to write a single function to do this busywaiting.
> That function can implement a timeout and can avoid lockups and provide
> useful diagnostics.

Breaking out to a single function and implementing timeout makes
sense. I'll see what I can do.

> Is sh's cpu_relax() a no-op?  Or are we assuming that ioread is a
> suitable substitute?

I simply forgot to use cpu_relax(). =)

I'll fix up the code and post a V2. Thank you for your review!

/ magnus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
