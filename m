From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.11-rc5
Date: Fri, 25 Feb 2005 16:49:19 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de>
Mime-Version: 1.0
In-Reply-To: <20050226004137.GA25539@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net



On Sat, 26 Feb 2005, Olaf Hering wrote:
> 
> modedb can not be __init because fb_find_mode() may get db == NULL.
> fb_find_mode() is called from modules.

Ack. Maybe somebody should run the scripts again to check that we don't 
reference __init data from non-init functions.

		Linus
