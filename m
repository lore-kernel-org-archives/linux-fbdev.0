From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 0/5] am200epd, pxafb,
	metronomefb changes v2
Date: Sat, 31 May 2008 03:04:05 -0400
Message-ID: <45a44e480805310004g14087d4asfdf356dffdb26ab3@mail.gmail.com>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
	<20080531084125.ae345e14.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2L8J-0001zh-JD for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 00:04:07 -0700
Received: from wf-out-1314.google.com ([209.85.200.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2L8I-0003Y6-82
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 00:04:07 -0700
Received: by wf-out-1314.google.com with SMTP id 27so149328wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 31 May 2008 00:04:06 -0700 (PDT)
In-Reply-To: <20080531084125.ae345e14.krzysztof.h1@poczta.fm>
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

On Sat, May 31, 2008 at 2:41 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> Also, if the am200epd changes are less then say 40% of the original
> driver I would prefer to see an incremental patch, not replacement of
> the driver as it is not clear what was changed.
>

Agreed. If I look at the changes manually:

$ wc -l /home/jaya/kernelwork/mainline/linux-2.6/drivers/video/am200epd.c
295 /home/jaya/kernelwork/mainline/linux-2.6/drivers/video/am200epd.c

$ diff -Naur /home/jaya/kernelwork/mainline/linux-2.6/drivers/video/am200epd.c
arch/arm/mach-pxa/am200epd.c | diffstat
 am200epd.c |  346 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 199 insertions(+), 147 deletions(-)

It feels like a full replacement. I couldn't figure out how to do an
incremental patch because the original version is
drivers/video/am200epd.c which uses raw LCDC register writes (which is
no longer compatible because of the regs changes from pxafb) whereas
the new version is arch/arm/mach-pxa/am200epd.c which hooks into pxafb
and does not touch LCDC registers.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
