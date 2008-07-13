From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: do not update when the console
	is blanked
Date: Sat, 12 Jul 2008 22:11:20 -0700
Message-ID: <20080712221120.5356df22.akpm@linux-foundation.org>
References: <4877732A.5030106@eu.citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KHtrx-0007bn-6f for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 22:11:33 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KHtrv-00031K-IO
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jul 2008 22:11:32 -0700
In-Reply-To: <4877732A.5030106@eu.citrix.com>
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
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

(cc linux-fbdev-devel)

On Fri, 11 Jul 2008 15:50:18 +0100 Stefano Stabellini <stefano.stabellini@eu.citrix.com> wrote:

> Hi all,
> vt.c DO_UPDATE macro checks if the console is visible but doesn't check if
> the console is blanked.
> In fact updating fbcon while the console is blanked is not only unnecessary
> but can even cause screen corruption.
> Therefore I am adding a simple check on console_blanked in DO_UPDATE.
> 
> Signed-off-by: stefano.stabellini@eu.citrix.com
> 
> ---
> 
> diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> index 935f1c2..8d4bd3c 100644
> --- a/drivers/char/vt.c
> +++ b/drivers/char/vt.c
> @@ -261,7 +261,7 @@ static void notify_update(struct vc_data *vc)
>  #ifdef VT_BUF_VRAM_ONLY
>  #define DO_UPDATE(vc)	0
>  #else
> -#define DO_UPDATE(vc)	CON_IS_VISIBLE(vc)
> +#define DO_UPDATE(vc)	(CON_IS_VISIBLE(vc) && !console_blanked)
>  #endif
>  
>  static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
> 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
