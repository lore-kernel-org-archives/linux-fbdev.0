From: Olaf Hering <olh@suse.de>
Subject: Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 01:53:21 +0100
Message-ID: <20050226005321.GA26468@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de> <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

 On Fri, Feb 25, Linus Torvalds wrote:

> 
> 
> On Sat, 26 Feb 2005, Olaf Hering wrote:
> > 
> > modedb can not be __init because fb_find_mode() may get db == NULL.
> > fb_find_mode() is called from modules.
> 
> Ack. Maybe somebody should run the scripts again to check that we don't 
> reference __init data from non-init functions.

sparse doesnt do that, yet? (I never looked at it.)
