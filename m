From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move
	arch-specific bits to	their respective subdirectories
Date: Thu, 17 May 2007 14:13:14 +0800
Message-ID: <1179382394.28568.6.camel@daplas>
References: <464B78BC.4080900@gmail.com>
	<3B9BEEF0-F01D-4FE3-86A8-B58AAAB0B2DC@kernel.crashing.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoZEs-0004xQ-9F for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 23:13:26 -0700
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoZEq-0007zi-Jz
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 23:13:26 -0700
Received: by wr-out-0506.google.com with SMTP id i20so917393wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 23:13:24 -0700 (PDT)
In-Reply-To: <3B9BEEF0-F01D-4FE3-86A8-B58AAAB0B2DC@kernel.crashing.org>
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Wed, 2007-05-16 at 19:54 -0500, Kumar Gala wrote:
> On May 16, 2007, at 4:33 PM, Antonino A. Daplas wrote:
> 
> > Move arch-specific bits of fb_mmap() to their respective  
> > subdirectories
> >

> You don't need a version in asm-ppc since you have one in asm- 
> powerpc.  We are slowly phasing out arch/ppc in favor of arch/powerpc  
> which merges the 32 and 64-bit support.
> 

Okay, thanks.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
