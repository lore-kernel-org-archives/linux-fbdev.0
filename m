From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 16:15:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030403141530.GA8858@iliana>
References: <4E5C514B42@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E5C514B42@vcnet.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 03:55:48PM +0200, Petr Vandrovec wrote:
> On  3 Apr 03 at 15:48, Sven Luther wrote:
> > 
> > Ideally, the EDID reading would be done just after the user request an
> > output mapping change for the first time, and then stored privately to
> > each output. mode changes and such would be done after the output has
> > been assigned only, and you would have the EDID by then. You could even
> > reread it regularly, in case the monitor is hot swapped or something such.
> 
> Read is not enough. If you have connected one /dev/fbx to two monitors,
> you must find highest common denominator for them, and use this one.

Err, i don't understand this ? Do you mean you are outputing to two
monitors at the same time ?

If that is so maybe you mean, speaking in graphic card terminology, and
not in fbdev one, that you are sharing one common framebuffer between
two outputs, right, possibly doing mirroring tricks or something such ?

If that is so, then it is ok still, since you would do the EDID read and
the mode setting at the moment you activate the video output. At this
time, you know what monitor is attached (since you can probe it) and can
check the mode with respect of what you know is possible. The main point
here is to do the mode setting based on what the ouptu can support, not
on what the fbdev thinks is right.

Friendly,

Sven Luther
