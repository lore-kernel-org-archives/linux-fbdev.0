From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: drivers/video/nvidia/ compile error with PPC_OF=y, FB_OF=n
Date: Sat, 12 Nov 2005 13:00:35 +0800
Message-ID: <437576F3.7050309@pol.net>
References: <20051112041649.GU5376@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EanVV-0005Sa-5f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 21:00:53 -0800
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EanVQ-000859-Up
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 21:00:53 -0800
Received: by zproxy.gmail.com with SMTP id z3so514946nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Nov 2005 21:00:47 -0800 (PST)
In-Reply-To: <20051112041649.GU5376@stusta.de>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> I got the following compile error in 2.6.14-mm2 that seems to come from 
> Linus' tree:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/video/nvidia/nv_of.o
> drivers/video/nvidia/nv_of.c:33: error: redefinition of 'nvidia_probe_of_connector'
> drivers/video/nvidia/nv_proto.h:51: error: previous definition of 'nvidia_probe_of_connector' was here
> make[3]: *** [drivers/video/nvidia/nv_of.o] Error 1
> 

Yes, akpm already made a fix for this.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
