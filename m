From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: The nvidiafb driver is requiring too much
	vmalloc space and other problems.
Date: Fri, 01 Apr 2005 09:10:08 +1000
Message-ID: <1112310608.31848.181.camel@gaston>
References: <a44ae5cd05033014597bb3a2e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DH8pa-0006pj-3Z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 15:12:06 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DH8pY-00060g-8k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 15:12:06 -0800
In-Reply-To: <a44ae5cd05033014597bb3a2e@mail.gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@pol.net>

On Wed, 2005-03-30 at 14:59 -0800, Miles Lane wrote:
> Hello,
> 
> With guidance from Randy Dunlap, it has been determined that
> the nvidiafb driver will fail to operate correctly unless more than
> 128M of memory is provided by using "vmalloc=".  The default 
> kernel configuration provides for 128M, but Randy found that:

 .../...

it's a problem with ioremap of the framebuffer ? (which uses get_vm_area
as well) or is there an actual vmalloc in there ?

In radeonfb, I had to limit the amount of vram actually ioremap'd by the
kernel because of that.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
