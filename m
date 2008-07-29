From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Subject: Re: [PATCH] sh7760fb: write colormap value to
	hardware.
Date: Tue, 29 Jul 2008 14:41:18 +0900
Message-ID: <488EAD7E.1080804@renesas.com>
References: <486B39E3.60601@renesas.com>
	<20080728180513.GA31478@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNhxu-0002ur-JO for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 22:41:42 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail06.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KNhxt-0002jh-6W
	for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 22:41:42 -0700
In-reply-to: <20080728180513.GA31478@roarinelk.homelinux.net>
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
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Munakata Hisao <munakata.hisao@renesas.com>

Hi, Manuel.

Thank you for your work.
I checked this patch, there was not a problem.

Best regards,
  Nobuhiro

Manuel Lauss wrote:
> The computed color value is never actually written to hardware
> colormap register.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Acked-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
