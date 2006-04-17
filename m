From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] fbdev: Fix return error of fb_write
Date: Mon, 17 Apr 2006 15:45:10 +0100
Message-ID: <1145285110.6199.22.camel@localhost.localdomain>
References: <1145009768.6179.7.camel@localhost.localdomain>
	 <44404401.3030702@gmail.com> <20060414213105.09f0dd8d.akpm@osdl.org>
	 <444086CB.2000700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FVUyg-0001mm-Io
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Apr 2006 07:45:22 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FVUyf-0000Yf-5M
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Apr 2006 07:45:22 -0700
In-Reply-To: <444086CB.2000700@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 2006-04-15 at 13:38 +0800, Antonino A. Daplas wrote:
> Fix return code of fb_write():
> 
> If at least 1 byte was transferred to the device, return number of bytes,
> otherwise:
> 
>     - return -EFBIG - if file offset is past the maximum allowable offset or
>       size is greater than framebuffer length
>     - return -ENOSPC - if size is greater than framebuffer length - offset
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>

I can confirm this fixes the problem I reported, thanks!

Richard



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
