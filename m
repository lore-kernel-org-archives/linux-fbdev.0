From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Sun, 12 Sep 2004 16:36:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040912143632.GA31746@pegasos>
References: <20040910111627.GA14811@pegasos> <200409121732.45011.adaplas@hotpop.com> <20040912100407.GB27133@pegasos> <200409121811.01426.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6VRA-0003ox-Az
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 07:34:40 -0700
Received: from smtp8.wanadoo.fr ([193.252.22.23] helo=mwinf0801.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6VR9-0004Q8-KS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 07:34:40 -0700
Content-Disposition: inline
In-Reply-To: <200409121811.01426.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Sven Luther <sven.luther@wanadoo.fr>, adaplas@pol.net

On Sun, Sep 12, 2004 at 06:11:01PM +0800, Antonino A. Daplas wrote:
> On Sunday 12 September 2004 18:04, Sven Luther wrote:
> > On Sun, Sep 12, 2004 at 05:32:44PM +0800, Antonino A. Daplas wrote:
> > > On Sunday 12 September 2004 16:42, Sven Luther wrote:
> > > > Now, another question which has me baffled. In set_par, i set the video
> > > > mode for the card, but i only seem to have access to the bpp, and not
> > > > the actual depth. Since i can distinguish between depth 15 (5551) and
> > > > 16 (5650), as well as between depth 24 (8888) and 30 (AAA2), where do i
> > > > get the information concerning the actual depth used from ?
> > >
> > > var->green.length
> >
> > So, on a 5551 more, i should get :
> >
> >   var->green.length + var->red.length + var->blue.length == 15
> >
> > right ?
> 
> Yes, sorry for being cryptic.  Only if (visual == truecolor ||
> visual == directcolor), otherwise color depth = var->green.length.  If you
> are using at least a 2.6.8 kernel, there is a new helper in
> drivers/video/fbmem.c that you can check out:
> 
> int fb_get_color_depth(struct fb_info *)

Ah, it seems this one didn't make it to 2.6.8, since i don't have such a
function. Will do : 

if (fix->visual == FB_VISUAL_TRUECOLOR || fix->visual == FB_VISUAL_DIRECTCOLOR)
	depth = var->green.length + var->red.length + var->blue.length;
else
	depth = var->green.length

instead. Hope this is ok.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
