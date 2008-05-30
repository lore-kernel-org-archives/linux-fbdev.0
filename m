From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 2/5] pxafb: add shared
 framebuffer interface
Date: Fri, 30 May 2008 19:10:02 +0200
Message-ID: <20080530191002.3f63cf6f.krzysztof.h1@poczta.fm>
References: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212150530-14941-3-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2859-0005Nb-Uq for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 10:08:00 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2859-0008Le-FN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 10:07:59 -0700
In-Reply-To: <1212150530-14941-3-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, 30 May 2008 08:28:47 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> These changes are to make it possible for a secondary driver to share the
> pxafb framebuffer. The changes include:
> - adding clkdev entry in pxafb_mach_info so that a driver can pass in the
>   correct struct device owner for the LCDCLK.
> - adding custom_xfer_div entry so that a driver can have custom sized
>   transfers. For example, the metronome controller uses 16 bit AMLCD
>   transfers but actually has 3 bit pixels in 8 bit containers.
> - adding extra_video_mem entry so that a driver can tell pxafb of its
>   additional needs.
> - adding share_video_mem/unshare_video_mem callbacks to notify the secondary
>   driver of the framebuffer address, to allow refcounting, and to cleanup on
>   completion.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  arch/arm/mach-pxa/devices.c      |    2 +
>  drivers/video/pxafb.c            |   46 ++++++++++++++++++++++++++++++++-----
>  include/asm-arm/arch-pxa/pxafb.h |    9 +++++++
>  3 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
> index d6c05b6..b72b73a 100644
> --- a/arch/arm/mach-pxa/devices.c
> +++ b/arch/arm/mach-pxa/devices.c

> @@ -1297,6 +1318,8 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
>  		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
>  		if (smemlen > fbi->fb.fix.smem_len)
>  			fbi->fb.fix.smem_len = smemlen;
> +		if (inf->custom_xfer_div)
> +			smemlen /= inf->custom_xfer_div;
>  	}
>  }
>  

This one should be rather:

+		if (inf->custom_xfer_div)
+			fbi->fb.fix.smem_len  /= inf->custom_xfer_div;

Otherwise is does nothing (the function ends here).

Regards,
Krzysztof


----------------------------------------------------------------------
Mucha powraca!
Sprawdz >>> http://link.interia.pl/f1e0d


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
