From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: xxx_check_var
Date: Fri, 10 Jan 2003 02:29:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301100229090.18287-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0212221315451.11715-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0212221315451.11715-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > > Yes, this wrong, and afaik, it's your original port to 2.5 that did that
> > > ;)
> > 
> > Yeap. The idea of check_var is to validate a mode. Note modedb uses just
> > check_var. It is okay to READ the values in your par. You shouldn't alter
> > the values in par.
> 
> Perhaps it makes sense to make the info parameter of fb_check_var() const to
> prevent this from happening?

Easy fix. I can whip up a quick patch for that.
