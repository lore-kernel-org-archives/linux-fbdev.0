From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 09:40:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030403074013.GA3642@iliana>
References: <418DE32AA8@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <418DE32AA8@vcnet.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, adaplas@pol.net

On Thu, Apr 03, 2003 at 03:07:33AM +0100, Petr Vandrovec wrote:
> On  2 Apr 03 at 22:55, James Simmons wrote:
> 
> > It doesn't need a struct pci_dev in this case. It is possible to get this 
> > info from the i2c bus but I never seen any drivers do this. What data would
> > we have to pass in get the EDID inforamtion? So the question is how 
> > generic will get_EDID end up being or will we have to have driver specfic 
> > hooks since I don't pitcure i2c approaches being the same for each video 
> > card. Petr didn't you attempt this with the matrox driver at one time?
> 
> Yes, matroxfb provides one i2c (DDC) bus for each output videocard has.
> I ended with only this support (and userspace EDID parser) as i2c was
> initialized loong after framebuffer at that time... Now when i2c is usable
> when fbdev initializes, it looks much better.
> 
> Only get_EDID interface I need is one which gets i2c bus as argument. But
> I have no idea how I should handle situation where you have connected
> two different monitors to both crtc1 outputs... Like 50Hz PAL TV &
> 60+Hz VGA monitor. Currently it is user responsibility to resolve such
> situation...

Is the EDID reading stuff not done per head ?

Friendly,

Sven Luther
