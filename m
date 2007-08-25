From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] uvesafb: select connector in Kconfig
Date: Sat, 25 Aug 2007 08:23:41 -0700
Message-ID: <20070825082341.e939e38e.randy.dunlap@oracle.com>
References: <20070825085931.GA9318@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOxV4-0005go-TU for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Aug 2007 08:24:45 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IOxV3-0005Xh-As
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Aug 2007 08:24:34 -0700
In-Reply-To: <20070825085931.GA9318@spock.one.pl>
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
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 25 Aug 2007 10:59:31 +0200 Michal Januszewski wrote:

> Make uvesafb select connector instead of depending on it being already selected.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index f1cc899..e152eed 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -594,7 +594,8 @@ config FB_TGA
>  
>  config FB_UVESA
>  	tristate "Userspace VESA VGA graphics support"
> -	depends on FB && CONNECTOR
> +	depends on FB
> +	select CONNECTOR
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT

There are 2 problems with this.

a.  CONNECTOR depends on NET, but select won't enable NET, so if
NET is not enabled otherwise, CONNECTOR still won't build.
This is a longstanding select/kconfig issue.

b.  CONNECTOR depends on NET, so if select did follow the depends
chain and enable NET, it would be enabling the networking subsystem,
which is something that should not be done quietly.

select should only be used for enabling small library-like code
(if even then).  Avoid it whenever possible.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
