From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Fix fb.h breaking compilation of userspace programs
Date: Sun, 5 Sep 2004 05:42:34 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409050542.35195.adaplas@hotpop.com>
References: <20040904163516.GA23640@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3iIz-0006No-24
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 14:42:41 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C3iIw-0005GO-Ex
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 14:42:40 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C8E3872A0A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  4 Sep 2004 21:42:25 +0000 (UTC)
In-Reply-To: <20040904163516.GA23640@spock.one.pl>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Michal Januszewski <spock@gentoo.org>

On Sunday 05 September 2004 00:35, Michal Januszewski wrote:
> Hi,
>
> The latest changes introduced to the fb structs in linux/fb.h make
> compilation of userspace programs break with:
>
> include/linux/fb.h:305: error: field `modelist' has incomplete type
>
> This is caused by struct list_head not being seen from userspace. The
> attached patch is a possible fix for this problem.

Thanks.  Instead of making struct list_head visible to userspace,  I'll just 
move modelist out of struct fb_monspecs.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
