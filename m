From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: The nvidiafb driver is requiring too much
 vmalloc space and other problems.
Date: Thu, 31 Mar 2005 15:18:26 -0800
Message-ID: <424C8542.9020607@osdl.org>
References: <a44ae5cd05033014597bb3a2e@mail.gmail.com> <1112310608.31848.181.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DH8vn-0007Kx-Vd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 15:18:31 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DH8vl-0001o4-Td
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 31 Mar 2005 15:18:31 -0800
In-Reply-To: <1112310608.31848.181.camel@gaston>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@pol.net>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-30 at 14:59 -0800, Miles Lane wrote:
> 
>>Hello,
>>
>>With guidance from Randy Dunlap, it has been determined that
>>the nvidiafb driver will fail to operate correctly unless more than
>>128M of memory is provided by using "vmalloc=".  The default 
>>kernel configuration provides for 128M, but Randy found that:
> 
> 
>  .../...
> 
> it's a problem with ioremap of the framebuffer ? (which uses get_vm_area
> as well) or is there an actual vmalloc in there ?

It's ioremap of the frame buffer -- 128 MB being requested and it
fails if the default 128 MB kernel vmalloc area size is used.

> In radeonfb, I had to limit the amount of vram actually ioremap'd by the
> kernel because of that.

I guess that Tony will know what to do when he sees this....

-- 
~Randy


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
