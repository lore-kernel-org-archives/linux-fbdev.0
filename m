From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 18:21:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030403162123.GA17123@iliana>
References: <4E5C514B42@vcnet.vc.cvut.cz> <20030403141530.GA8858@iliana> <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Petr Vandrovec <VANDROVE@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 03, 2003 at 04:21:14PM +0100, Alan Cox wrote:
> On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > Read is not enough. If you have connected one /dev/fbx to two monitors,
> > > you must find highest common denominator for them, and use this one.
> > 
> > Err, i don't understand this ? Do you mean you are outputing to two
> > monitors at the same time ?
> 
> I think you mean lowest common denominator.
> 
> > If that is so maybe you mean, speaking in graphic card terminology, and
> > not in fbdev one, that you are sharing one common framebuffer between
> > two outputs, right, possibly doing mirroring tricks or something such ?
> 
> Classic example is a SiS 6326 driving monitor and TV. You need to keep
> the display to TV acceptable ranges.

You mean, driving both display with the same ramdac ?

Friendly,

Sven Luther
