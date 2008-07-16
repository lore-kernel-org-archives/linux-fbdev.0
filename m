From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 4/5] metronomefb: convert
	printk to dev_dbg/err messages
Date: Wed, 16 Jul 2008 15:09:19 +0800
Message-ID: <f17812d70807160009q1754fa66k8e89ff4287800a28@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-5-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ18b-0001G9-DM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:09:21 -0700
Received: from rv-out-0708.google.com ([209.85.198.244])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ18a-0002Fs-2a
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:09:21 -0700
Received: by rv-out-0708.google.com with SMTP id f25so4492647rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 00:09:19 -0700 (PDT)
In-Reply-To: <1215955587-20367-5-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This patch converts the printk messages in metronomefb to dev_dbg/err type
> messages.
>

This is always a good thing to do :)

> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

With the removal of "#define DEBUG 1",

Acked-by: Eric Miao <eric.miao@marvell.com>

> ---
>  drivers/video/metronomefb.c |   49 +++++++++++++++++++-----------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index cc4c038..8ccd113 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -18,6 +18,8 @@
>  * is provided as am200epd.c
>  *
>  */
> +#define DEBUG 1
> +

Don't leave DEBUG in the final patch please.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
