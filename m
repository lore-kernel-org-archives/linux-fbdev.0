From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH][trivial] matroxfb_maven remove pointless semicolons
 after label
Date: Sun, 20 Mar 2005 20:34:23 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0503202033000.2508@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503201737250.2501@dragon.hyggekrogen.localhost>
 <20050320191728.GF32717@vana.vc.cvut.cz>
Mime-Version: 1.0
In-Reply-To: <20050320191728.GF32717@vana.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, 20 Mar 2005, Petr Vandrovec wrote:

> On Sun, Mar 20, 2005 at 05:41:01PM +0100, Jesper Juhl wrote:
> > 
> > Having a semicolon at the end as in  labelname:;  is pointless, remove.
> 
> As long as I'm maintainer of this code, I prefer to leave them here.
> 							Petr Vandrovec
> 
No problem. As you say, you're the maintainer. I just spotted them and 
made the patch, it's ofcourse entirely up to you if you want to apply it 
or not :-)

-- 
Jesper Juhl
