From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/1] Video/Framebuffer: add
 fuctional power management support to Blackfin BF54x LQ043 framebuffer
 driver
Date: Sun, 17 Aug 2008 20:46:23 +0200
Message-ID: <20080817204623.47fd24a1.krzysztof.h1@poczta.fm>
References: <1218791228-12974-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KUnB7-0006as-0s for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Aug 2008 11:40:37 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KUnB5-00069d-KB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Aug 2008 11:40:37 -0700
In-Reply-To: <1218791228-12974-1-git-send-email-cooloney@kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Bryan Wu <cooloney@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Fri, 15 Aug 2008 17:07:08 +0800
Bryan Wu <cooloney@kernel.org> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Fix bug: does nor properply resume after suspend mem
> Fix for PM_SUSPEND_MEM: Save and restore peripheral base and DMA registers
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  drivers/video/bf54x-lq043fb.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Igrzyska z nagrodami! Kliknij>>>> http://link.interia.pl/f1edb 

 	


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
