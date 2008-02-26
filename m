From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbcon: replace mono_col macro with
	static inline
Date: Tue, 26 Feb 2008 09:18:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802260917410.5158@anakin>
References: <1203963237.5582.4.camel@brick>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JTv0v-00036B-AV for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 00:18:13 -0800
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JTv0t-0002zy-Mj
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 00:18:13 -0800
In-Reply-To: <1203963237.5582.4.camel@brick>
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
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>

On Mon, 25 Feb 2008, Harvey Harrison wrote:
> Use __u32 for max_len to match the declaration of length in the
> struct fb_bitfield.
> 
> Suppresses sparse shadowed variable warnings from the nested max()
> macros:
> drivers/video/console/fbcon.h:130:8: warning: symbol '_x' shadows an earlier one
> drivers/video/console/fbcon.h:130:8: originally declared here
> drivers/video/console/fbcon.h:130:8: warning: symbol '_x' shadows an earlier one
> drivers/video/console/fbcon.h:130:8: originally declared here
> drivers/video/console/fbcon.h:130:8: warning: symbol '_y' shadows an earlier one
> drivers/video/console/fbcon.h:130:8: originally declared here
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/video/console/fbcon.h |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
> index 3706307..51a6bf4 100644
> --- a/drivers/video/console/fbcon.h
> +++ b/drivers/video/console/fbcon.h
> @@ -104,10 +104,14 @@ struct fbcon_ops {
>  #define attr_blink(s) \
>  	((s) & 0x8000)
>  	
> -#define mono_col(info)							\
> -	(~(0xfff << (max((info)->var.green.length,			\
> -			 max((info)->var.red.length,			\
> -			     (info)->var.blue.length)))) & 0xff)
> +
> +static inline int mono_col(struct fb_info *info)
                              ^^^^^^^^^^^^^^^^^^^^
const struct fb_info *info?

> +{
> +	__u32 max_len;
> +	max_len = max(info->var.green.length, info->var.red.length);
> +	max_len = max(info->var.blue.length, max_len);
> +	return ~(0xfff << (max_len & 0xff));
> +}
>  
>  static inline int attr_col_ec(int shift, struct vc_data *vc,
>  			      struct fb_info *info, int is_fg)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
