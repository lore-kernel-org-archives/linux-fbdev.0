From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 15:41:47 +0800
Message-ID: <200502261541.49187.adaplas@hotpop.com>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050226004137.GA25539@suse.de> <1109380389.15026.112.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109380389.15026.112.camel@gaston>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 26 February 2005 09:13, Benjamin Herrenschmidt wrote:
> On Sat, 2005-02-26 at 01:41 +0100, Olaf Hering wrote:
> > modedb can not be __init because fb_find_mode() may get db == NULL.
> > fb_find_mode() is called from modules.
>
> Ahhh, good catch ! I though that was fixed long ago, looks like I was
> wrong.

The 2.4 fix was for fb_find_mode to always return 640x480 if modular.
There's no fix yet for 2.6 except for the patch which is already in the mm
tree, which is for fb_find_mode() to always fail if driver is compiled as a
module. (patch below).

Both fixes will still crash if fb_find_mode() is called again, so this
function is really designed to be called only once.

As for the other patch that removes the __init from modedb, some of the
developers might disagree. 

Olaf,

Can you send me your EDID block?  You can use read-edid.  Your monitor
may have a fixable EDID and can be a candidate for the broken display
database.

Tony
