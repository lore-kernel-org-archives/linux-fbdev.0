From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 11/25] framebuffer: move ioctl32 code to fbmem.c
Date: Sun, 06 Nov 2005 08:16:26 +0800
Message-ID: <436D4B5A.2040303@pol.net>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162714.961205000@b551138y.boeblingen.de.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYYD7-0006ZA-Ix
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Nov 2005 16:16:37 -0800
Received: from xproxy.gmail.com ([66.249.82.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EYYD6-0004zW-9d
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Nov 2005 16:16:37 -0800
Received: by xproxy.gmail.com with SMTP id h29so145107wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 05 Nov 2005 16:16:35 -0800 (PST)
In-Reply-To: <20051105162714.961205000@b551138y.boeblingen.de.ibm.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-fbdev-devel@lists.sourceforge.net

Arnd Bergmann wrote:
> The frame buffer layer already had some code dealing with
> compat ioctls, this patch moves over the remaining code
> from fs/compat_ioctl.c

This is fine with me.

Tony


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
