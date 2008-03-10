From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/6] gxfb: move MSR bit fields into
	gxfb.h
Date: Mon, 10 Mar 2008 13:14:32 -0700
Message-ID: <20080310131432.e4567537.akpm@linux-foundation.org>
References: <20080308204840.47a27236@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYoOU-00012T-Eo for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 13:14:46 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYoOT-0002O5-2P
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 13:14:46 -0700
In-Reply-To: <20080308204840.47a27236@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com

On Sat, 8 Mar 2008 20:48:40 -0500
Andres Salomon <dilinger@queued.net> wrote:

> >From bee7242cf04c4a060b311b11985efb495f308355 Mon Sep 17 00:00:00 2001
> From: Andres Salomon <dilinger@debian.org>
> Date: Mon, 25 Feb 2008 15:29:36 -0500
> Subject: [PATCH] gxfb: move MSR bit fields into gxfb.h
> 
> This continues the gxfb header cleanups.  MSRs are defined in geode.h;
> the specific bits we care about are defined in gxfb.h.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> ---
>  drivers/video/geode/display_gx.h |    3 ---
>  drivers/video/geode/gxfb.h       |   16 ++++++++++++++++
>  drivers/video/geode/gxfb_core.c  |    2 +-
>  drivers/video/geode/video_gx.c   |    4 ++--
>  drivers/video/geode/video_gx.h   |   14 --------------
>  5 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
> index 56e9d2e..ad556d3 100644
> --- a/drivers/video/geode/display_gx.h
> +++ b/drivers/video/geode/display_gx.h
> @@ -16,7 +16,4 @@ int gx_line_delta(int xres, int bpp);
>  
>  extern struct geode_dc_ops gx_dc_ops;
>  
> -/* MSR that tells us if a TFT or CRT is attached */
> -#define GLD_MSR_CONFIG_DM_FP 0x40
> -
>  #endif /* !__DISPLAY_GX1_H__ */

Something has gone wrong here.  The code in current mainline is



extern struct geode_dc_ops gx_dc_ops;

/* MSR that tells us if a TFT or CRT is attached */
#define GLD_MSR_CONFIG   0xC0002001
#define GLD_MSR_CONFIG_DM_FP 0x40

/* Display controller registers */


whereas you're patching something else.


In [1/6] you refer to "the MSR cleanup patch".  I don't know what that is.


Please clean up the changelogs - remove those email headers from the
email-forwarding operation and remove the additional little commentary on
top: if there's actually anything in there which is needed then it should
be integrated into the changelog proper, thanks.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
