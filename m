From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Feature Freeze?
Date: Thu, 6 Mar 2003 08:03:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030306070343.GA24575@casa.fluido.as>
References: <Pine.LNX.4.44.0303051829450.27760-100000@phoenix.infradead.org> <1046913396.1227.176.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=mail.fluido.as ident=mail)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qpQQ-0004oM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 23:04:19 -0800
Content-Disposition: inline
In-Reply-To: <1046913396.1227.176.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

	Subject: Re: [Linux-fbdev-devel] Feature Freeze?
	Date: gio, mar 06, 2003 at 09:18:07 +0800

Quoting Antonino Daplas (adaplas@pol.net):

> > > > 2. console resizing using fbset (besides stty)?
> > > 
> > > Nice, if it's not too much work.
> > 
> > :-( I hope to improve fbcon to handle this.
> >  
> 
> If you're really against using fbset to resize the console, then the
> first step is to protect the console from the "dangers" of fbset. 
> Secondly, we can have fbcon_resize() validate the mode instead of just
> blindly calling fb_set_var().  If it's not valid, then it can also fetch
> a working mode for it.  The user can then fine tune the timings using
> fbset afterwards.
> 
> 
> So, do we allow fbcon to handle mode validating and fetching, or do we
> just leave all this to fbdev? At least let's bring out some ideas on how
> to go about doing this.  Having a working idea, even if dumb, should
> interest other developers in contributing. 

I see there currently is much activity on the list. I would like to
present the point of view of a heavy framebuffer user: I write
multimedia code for artists, and I generally generate video via the
framebuffer layer, and trusted old matrox cards (from the Millennium
II to the G550). The general process is:

- open the framebuffer unit
- FBIOGET_VSCREENINFO
- change the appropriate values in fb_var_screeninfo
- FBIOPUT_VSCREENINFO
- mmap
- happily write pixels to the memory area

This, multiplied for all the video heads that I use within the same
program (up to 5 per PC, up to now, *including* the console screen -
in this case I control the machine from a network connection).

I am especially in need to change the BPP value (often using 16BPP
mode), and in a couple of occasions (the latest 2 weeks ago) I had to
feed the output of old G200's to large monitors who are only capable
of TV resolution. This means setting the framebuffer to 768x576 (PAL)
and *interlaced*. The framebuffer model that still survives in 2.4
allows me to obtain all this. 

I am not much familiar with all the terminology that is used for the
new layer. Actually, this framebuffer revolution is what keeps me from
enjoying (!) the kernel bleeding edge, as I used to do since almost 10
years ago. 

Can I poll the list's huge knowledge to find out if and how I can
obtain the same result with the new layer?

Thanks a lot in advance...

Carlo 

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
