From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Updating Documentation/fb/vesafb.txt
Date: Sat, 05 Aug 2006 20:48:04 +0800
Message-ID: <44D49384.9060701@gmail.com>
References: <200608050902.20163.phreak@gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9LZf-0000Ko-Qp for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 Aug 2006 05:48:15 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G9LZe-0007t8-C1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 Aug 2006 05:48:15 -0700
Received: by py-out-1112.google.com with SMTP id c31so493456pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 Aug 2006 05:48:13 -0700 (PDT)
In-Reply-To: <200608050902.20163.phreak@gentoo.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: phreak@gentoo.org
Cc: trivial@kernel.org, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Christian Heim wrote:
> Hello Antonino,
> 
> +    | 640x480  800x600  1024x768 1280x1024 1600x1200
> +----+-----------------------------------------------
> +256 |  0x301    0x303    0x305    0x307     0x???   
> +32k |  0x310    0x313    0x316    0x319     0x373   
> +64k |  0x311    0x314    0x317    0x31A     0x374   
> +16M |  0x312    0x315    0x318    0x31B     0x375   
>  
>  To enable one of those modes you have to specify "vga=ask" in the
>  lilo.conf file and rerun LILO. Then you can type in the desired

This is not correct. VESA did not define 1600x1200 as part of
its DVT standard. And starting with VBE 2.0, VESA is not going to
define new mode ID's. Thus the mode ID that you get for 1600x1200 may
be unique only for your particular hardware/Video BIOS.

You may use X's 'vesa' driver to get a list of modes that your
BIOS supports. It will be written to /var/log/X*.0.log.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
