From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/11] fbcon: Kill compile warning
Date: Wed, 1 Aug 2007 15:41:43 -0700
Message-ID: <20070801154143.613d83da.akpm@linux-foundation.org>
References: <46B03735.9020803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGMtc-0007Iy-CR for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 15:42:24 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGMtc-0008U3-1k
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 15:42:24 -0700
In-Reply-To: <46B03735.9020803@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 01 Aug 2007 15:33:09 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> +static inline void fbcon_map_override(void)
> +{
> +	map_override = 1;
> +}
> +#else
> +#define fbcon_map_override(...) do { } while (0)
> +#endif /* CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY */

It's odd to use a C function in one case and a macro in the other.
Was there a reason to not use plain old static inline?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
