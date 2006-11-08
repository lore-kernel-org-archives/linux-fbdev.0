From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] nvidiafb: fix unreachable code in
	nv10GetConfig
Date: Wed, 8 Nov 2006 12:13:11 -0800
Message-ID: <20061108121311.29dd0bda.akpm@osdl.org>
References: <20061108195511.GK17028@localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhtnS-0000Y9-U0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 12:13:19 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GhtnR-0006Rl-CW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 12:13:18 -0800
In-Reply-To: <20061108195511.GK17028@localdomain>
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
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 13:55:11 -0600
Nathan Lynch <ntl@pobox.com> wrote:

> Fix binary/logical operator typo which leads to unreachable code.
> Noticed while looking at other issues; I don't have the relevant
> hardware to test this.
> 
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> 
> --- linux-2.6-powerpc.git.orig/drivers/video/nvidia/nv_setup.c
> +++ linux-2.6-powerpc.git/drivers/video/nvidia/nv_setup.c
> @@ -262,7 +262,7 @@ static void nv10GetConfig(struct nvidia_
>  #endif
>  
>  	dev = pci_find_slot(0, 1);
> -	if ((par->Chipset && 0xffff) == 0x01a0) {
> +	if ((par->Chipset & 0xffff) == 0x01a0) {
>  		int amt = 0;
>  
>  		pci_read_config_dword(dev, 0x7c, &amt);

That looks like a pretty significant bug.  It'll cause the kernel to
potentially map the wrong amount of memory for all cards except the
NV_ARCH_04 type.  Has been there for over a year though.  hmm..

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
