From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 12:17:46 +1100
Message-ID: <1109380667.14993.118.camel@gaston>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de>
	 <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
	 <421FCBF9.1020003@XLsigned.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <421FCBF9.1020003@XLsigned.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Olaf Hering <olh@suse.de>, Kernel Mailing List <linux-kernel@vger.kernel.org>


> This patch has already been posted to linux-fbdev on 2005-02-10 by David Vrabel
> and made me ask
> 	Is there any reason why this has been originally flagged "__init"?
> 	"vesa_modes" is not "__init". That's why I changed "intelfb" to
> 	use "vesa_modes".
> 
> Maybe time has come to decide, if availability of "modedb" outside
> of init functions is more important than freeing (unused) kernel memory.

Well, I wonder why we need that mode db at all ... We should probably
use VESA modes and calculate using the standard formula if the user
requests a mode that isn't in the vesa table... Most monitors will
provide additional detailed timings for non-vesa modes they may
support.

Ben.
