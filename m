From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [FBDEV]: Core fbcon fixes
Date: Wed, 23 Jun 2004 10:59:41 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088006381.3562.149.camel@gaston>
References: <200406220638.34214.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAIQ-0004sk-9V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:08:22 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdAIP-0004Tl-Qv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:08:21 -0700
In-Reply-To: <200406220638.34214.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-06-21 at 17:39, Antonino A. Daplas wrote:
> This patch fixes the following bugs/regressions for fbcon:
> 
> 1. Initialize and update global arrays used by fbcon during initialization
> and and by set_con2fbmap code.
> 
> 2. Fixed screen corruption (white rectangle) at initial mode setting
> plaguing cards with VGA cores and with VGA console enabled. 
> (vga16fb, however, still shows remnants of previous text if boot logo
> is enabled)
> 
> 3. Improved fbcon_startup/fbcon_init code.  
> 
> 4. Fixed set_con2fbmap code -- should support multiple devices mapped to
> different consoles.

Looks good on a quick overview.

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
