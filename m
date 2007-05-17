From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move
	arch-specific bits to their respective subdirectories
Date: Wed, 16 May 2007 19:54:40 -0500
Message-ID: <3B9BEEF0-F01D-4FE3-86A8-B58AAAB0B2DC@kernel.crashing.org>
References: <464B78BC.4080900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoUI8-0008Mx-Cr for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:56:28 -0700
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HoUI7-0006pL-Qc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 17:56:28 -0700
In-Reply-To: <464B78BC.4080900@gmail.com>
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
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>


On May 16, 2007, at 4:33 PM, Antonino A. Daplas wrote:

> Move arch-specific bits of fb_mmap() to their respective  
> subdirectories
>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> Hi all,
>
> Please let me know if there are mistakes with this patch.
>
> Thanks.
>
> Tony
>
>  drivers/video/fbmem.c      |   65 ++++ 
> +---------------------------------------
>  include/asm-alpha/fb.h     |    7 +++++
>  include/asm-arm/fb.h       |   12 ++++++++
>  include/asm-arm26/fb.h     |    7 +++++
>  include/asm-avr32/fb.h     |   14 +++++++++
>  include/asm-blackfin/fb.h  |    7 +++++
>  include/asm-cris/fb.h      |    7 +++++
>  include/asm-frv/fb.h       |    7 +++++
>  include/asm-h8300/fb.h     |    7 +++++
>  include/asm-i386/fb.h      |   13 +++++++++
>  include/asm-ia64/fb.h      |   15 ++++++++++
>  include/asm-m32r/fb.h      |   12 ++++++++
>  include/asm-m68k/fb.h      |   28 +++++++++++++++++++
>  include/asm-m68knommu/fb.h |    7 +++++
>  include/asm-mips/fb.h      |   12 ++++++++
>  include/asm-parisc/fb.h    |   12 ++++++++
>  include/asm-powerpc/fb.h   |   14 +++++++++
>  include/asm-ppc/fb.h       |   14 +++++++++

You don't need a version in asm-ppc since you have one in asm- 
powerpc.  We are slowly phasing out arch/ppc in favor of arch/powerpc  
which merges the 32 and 64-bit support.

>  include/asm-s390/fb.h      |    7 +++++
>  include/asm-sh/fb.h        |   12 ++++++++
>  include/asm-sh64/fb.h      |   12 ++++++++
>  include/asm-sparc/fb.h     |    6 ++++
>  include/asm-sparc64/fb.h   |   15 ++++++++++
>  include/asm-v850/fb.h      |    7 +++++
>  include/asm-x86_64/fb.h    |   13 +++++++++
>  include/asm-xtensa/fb.h    |    7 +++++
>  include/linux/fb.h         |   12 ++++++++
>  27 files changed, 293 insertions(+), 58 deletions(-)


- k

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
