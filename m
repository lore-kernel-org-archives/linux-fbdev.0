From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Dreamcast framebuffer updates.
Date: Sat, 17 May 2003 21:51:03 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030517215102.A21395@infradead.org>
References: <Pine.LNX.4.44.0305172138420.19598-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19H8eX-0002vF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 17 May 2003 13:51:38 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305172138420.19598-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Sat, May 17, 2003 at 09:39:41PM +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, May 17, 2003 at 09:39:41PM +0100, James Simmons wrote:
>  #ifdef CONFIG_MTRR
> -  #include <asm/mtrr.h>
> +#include <asm/mtrr.h>
>  #endif

how can CONFIG_MTRR ever be set for sh?



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
