From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] fbdev: add connector entries
	for uvesafb
Date: Sat, 23 Jun 2007 11:06:27 -0700
Message-ID: <20070623110627.c911373c.akpm@linux-foundation.org>
References: <20070623105146.GC12623@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I2A2z-0001Fk-K3 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 11:09:21 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I2A2z-0002AB-A6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 11:09:21 -0700
In-Reply-To: <20070623105146.GC12623@spock.one.pl>
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
To: spock@gentoo.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 23 Jun 2007 12:51:46 +0200 Michal Januszewski <spock@gentoo.org> wrote:

> Add connector's idx and val constants for v86d and uvesafb.
> 
> Also change the maximum message size to 4k to allow transfers of VBE
> data blocks from userspace.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> include/linux/connector.h |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 10eb56b..46b2aba 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -36,14 +36,15 @@
>  #define CN_VAL_CIFS                     0x1
>  #define CN_W1_IDX			0x3	/* w1 communication */
>  #define CN_W1_VAL			0x1
> +#define CN_IDX_V86D			0x4
> +#define CN_VAL_V86D_UVESAFB		0x1
>  
> -
> -#define CN_NETLINK_USERS		4
> +#define CN_NETLINK_USERS		5
>  
>  /*
>   * Maximum connector's message size.
>   */
> -#define CONNECTOR_MAX_MSG_SIZE 	1024
> +#define CONNECTOR_MAX_MSG_SIZE 	4096
>  
>  /*
>   * idx and val are unique identifiers which 
> 
> 

Evgeniy, could you please review this?

The need to add these enumerations for unrelated subsystems to connector.h
may get a bit ugly as time passes, but I guess it's OK for now.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
