From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [RFC: 2.6 patch] i386: EXPORT_SYMBOL(screen_info) even #ifndef
 CONFIG_VT
Date: Wed, 02 Nov 2005 08:43:44 +0800
Message-ID: <43680BC0.70805@pol.net>
References: <20051101152207.GT8009@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EX6jO-0000Eu-Nu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Nov 2005 16:43:58 -0800
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EX6jL-0005ek-V8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Nov 2005 16:43:58 -0800
Received: by zproxy.gmail.com with SMTP id s1so8602nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Nov 2005 16:43:51 -0800 (PST)
In-Reply-To: <20051101152207.GT8009@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Adrian Bunk wrote:
> The folllowing modules require screen_info but don't depend
> on CONFIG_VT:
> - vga16fb.ko
> - intelfb.ko
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Ok with me.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
